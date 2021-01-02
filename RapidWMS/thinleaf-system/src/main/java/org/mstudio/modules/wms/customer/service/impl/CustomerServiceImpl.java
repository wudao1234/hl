package org.mstudio.modules.wms.customer.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import org.mstudio.exception.BadRequestException;
import org.mstudio.exception.EntityExistException;
import org.mstudio.modules.system.service.UserService;
import org.mstudio.modules.system.service.dto.UserDTO;
import org.mstudio.modules.system.service.dto.UserVO;
import org.mstudio.modules.wms.customer.domain.Customer;
import org.mstudio.modules.wms.customer.repository.CustomerRepository;
import org.mstudio.modules.wms.customer.service.CustomerService;
import org.mstudio.modules.wms.customer.service.mapper.CustomerMapper;
import org.mstudio.modules.wms.customer.service.object.CustomerDTO;
import org.mstudio.modules.wms.customer.service.object.CustomerExcelObj;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.customer_order.service.CustomerOrderService;
import org.mstudio.modules.wms.goods.service.GoodsService;
import org.mstudio.utils.PageUtil;
import org.mstudio.utils.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.Caching;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.io.ByteArrayOutputStream;
import java.util.*;

import static org.mstudio.modules.wms.common.WmsUtil.getSearchString;

/**
 * @author Macrow
 * @date 2019-02-22
 */

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class CustomerServiceImpl implements CustomerService {

    public static final String CACHE_NAME = "Customer";

    @Value("${excel.export-max-count}")
    private Integer maxCount;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private CustomerOrderService customerOrderService;

    @Autowired
    private UserService userService;

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Map queryAll(Boolean exportExcel, String search, Pageable pageable) {

        Page<Customer> page;

        // 默认按照创建的时间顺序排列
        Sort sort = pageable.getSort().and(new Sort(Sort.Direction.DESC, "id"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        if (exportExcel) {
            newPageable = PageRequest.of(0, maxCount, sort);
        }

        if (search == null || search.isEmpty()) {
            page = customerRepository.findAll(newPageable);
        } else {
            page = customerRepository.findByNameLikeOrShortNameEnLike(newPageable, getSearchString(search), getSearchString(search));
        }
        return PageUtil.toPage(page.map(customerMapper::toDto).map(customerDTO -> {
            customerDTO.setGoodsCount(goodsService.countByCustomerId(Long.valueOf(customerDTO.getId())));
            customerDTO.setOrdersCount(customerOrderService.countByOwnerId(Long.valueOf(customerDTO.getId())));
            return customerDTO;
        }));
    }

    @Override
    @Cacheable(value = CACHE_NAME, key = "'AllList'")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public List<CustomerVO> getAllList() {
        return customerMapper.toVOList(customerRepository.findAll());
    }

    @Override
    @Cacheable(value = CACHE_NAME, key = "'ListByUserId' + #p0")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Set<CustomerVO> getListByUserId(Long id) {
        UserDTO user = userService.findById(id);
        return user.getCustomers();
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "'findCustomerById' + #p0")
    public Customer findCustomerById(Long id) {
        Optional<Customer> optionalCustomer = customerRepository.findById(id);
        return optionalCustomer.isPresent() ? optionalCustomer.get() : null;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public CustomerDTO findById(Long id) {
        Optional<Customer> customer = customerRepository.findById(id);
        ValidationUtil.isNull(customer, "Customer", "id", id);
        CustomerDTO customerDTO = customerMapper.toDto(customer.get());
        customerDTO.setGoodsCount(goodsService.countByCustomerId(Long.valueOf(customerDTO.getId())));
        customerDTO.setOrdersCount(customerOrderService.countByOwnerId(Long.valueOf(customerDTO.getId())));
        return customerDTO;
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "'findByName' + #p0")
    public CustomerDTO findByName(String name) {
        Optional<Customer> optionalCustomer = customerRepository.findByName(name);
        if (optionalCustomer.isPresent()) {
            return customerMapper.toDto(optionalCustomer.get());
        } else {
            throw new BadRequestException("没找到对应客户");
        }
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = "user", allEntries = true),
    })
    synchronized public CustomerDTO create(Customer resource) {
        if (customerRepository.findByName(resource.getName()).isPresent()) {
            throw new EntityExistException(Customer.class, "name", resource.getName());
        }

        if (customerRepository.findByShortNameEn(resource.getShortNameEn()).isPresent()) {
            throw new EntityExistException(Customer.class, "shortNameEn", resource.getShortNameEn());
        }

        if (customerRepository.findByShortNameCn(resource.getShortNameCn()).isPresent()) {
            throw new EntityExistException(Customer.class, "shortNameCn", resource.getShortNameCn());
        }

        return customerMapper.toDto(customerRepository.save(resource));
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = "user", allEntries = true),
    })
    synchronized public CustomerDTO update(Long id, Customer resource) {
        Optional<Customer> customerOptional = customerRepository.findById(id);
        ValidationUtil.isNull(customerOptional, "Customer", "id", resource.getId());

        Customer customer = customerOptional.get();

        Optional<Customer> customer1 = customerRepository.findByName(resource.getName());
        Optional<Customer> customer2 = customerRepository.findByShortNameEn(resource.getShortNameEn());
        Optional<Customer> customer3 = customerRepository.findByShortNameCn(resource.getShortNameCn());

        if (customer1.isPresent() && !customer.getId().equals(customer1.get().getId())) {
            throw new EntityExistException(Customer.class, "名称", resource.getName());
        }

        if (customer2.isPresent() && !customer.getId().equals(customer1.get().getId())) {
            throw new EntityExistException(Customer.class, "英文简称", resource.getShortNameEn());
        }

        if (customer3.isPresent() && !customer.getId().equals(customer1.get().getId())) {
            throw new EntityExistException(Customer.class, "中文简称", resource.getShortNameCn());
        }

        Customer result = customerRepository.save(resource);
        return customerMapper.toDto(result);
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = "user", allEntries = true),
    })
    public void delete(Long id) {
        customerRepository.deleteById(id);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public byte[] exportExcelData(List<CustomerDTO> customers) {
        List<CustomerExcelObj> rows = CollUtil.newArrayList();
        for (int i = 0; i < customers.size(); i++) {
            CustomerExcelObj excelObj = new CustomerExcelObj();
            excelObj.setIndex(Long.valueOf(i + 1));
            excelObj.setName(customers.get(i).getName());
            excelObj.setShortNameEn(customers.get(i).getShortNameEn());
            excelObj.setShortNameCn(customers.get(i).getShortNameCn());
            excelObj.setGoodsCount(customers.get(i).getGoodsCount());
            excelObj.setOrdersCount(customers.get(i).getOrdersCount());
            rows.add(excelObj);
        }

        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
        ExcelWriter writer = ExcelUtil.getBigWriter();
        writer.addHeaderAlias("index", "#");
        writer.addHeaderAlias("name", "客户名称");
        writer.addHeaderAlias("shortNameEn", "客户简称");
        writer.addHeaderAlias("goodsCount", "客户商品数量");
        writer.addHeaderAlias("ordersCount", "客户订单数量");
        writer.write(rows, true);
        writer.flush(outByteStream);
        writer.close();
        return outByteStream.toByteArray();
    }

    @Override
    public List<UserVO> getUsersById(Long id) {
        Customer customer = findCustomerById(id);
        List<UserVO> users = new ArrayList<>();
        customer.getUsers().forEach(user ->
                users.add(new UserVO(
                        user.getId(),
                        user.getUsername(),
                        user.getAvatar(),
                        user.getEmail(),
                        user.getEnabled(),
                        user.getCreateTime(),
                        user.getNum()
                )));
        return users;
    }

}