package org.mstudio.modules.wms.address.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.address.domain.Address;
import org.mstudio.modules.wms.address.repository.AddressRepository;
import org.mstudio.modules.wms.address.service.AddressService;
import org.mstudio.modules.wms.address.service.mapper.AddressMapper;
import org.mstudio.modules.wms.address.service.object.AddressDTO;
import org.mstudio.modules.wms.address.service.object.AddressExcelObj;
import org.mstudio.modules.wms.address.service.object.AddressVO;
import org.mstudio.modules.wms.address_type.domain.AddressType;
import org.mstudio.modules.wms.address_type.repository.AddressTypeRepository;
import org.mstudio.utils.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.io.ByteArrayOutputStream;
import java.util.*;

/**
 * @author Macrow
 * @date 2019-04-24
 */

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class AddressServiceImpl implements AddressService {

    private static final String CACHE_NAME = "Address";

    @Value("${excel.export-max-count}")
    private Integer maxCount;

    @Autowired
    private AddressRepository addressRepository;

    @Autowired
    private AddressMapper addressMapper;

    @Autowired
    private AddressTypeRepository addressTypeRepository;

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Map queryAll(Boolean exportExcel, String addressTypeFilter, String search, Pageable pageable) {
        Specification<Address> spec = new Specification<Address>() {
            @Override
            public Predicate toPredicate(Root<Address> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();

                if (addressTypeFilter != null && !"".equals(addressTypeFilter)) {
                    String[] addressTypeIds = addressTypeFilter.split(",");
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("addressType").get("id"));
                    Arrays.stream(addressTypeIds).forEach(id -> in.value(Long.valueOf(id)));
                    predicates.add(in);
                }

                if (search != null) {
                    predicates.add(criteriaBuilder.or(
                            criteriaBuilder.like(root.get("name").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("contact").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("phone").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("description").as(String.class), "%" + search + "%")
                    ));
                }

                if (predicates.size() != 0) {
                    Predicate[] p = new Predicate[predicates.size()];
                    return criteriaBuilder.and(predicates.toArray(p));
                } else {
                    return null;
                }
            }
        };

        // 默认按照创建的时间顺序排列
        Sort sort = pageable.getSort().and(new Sort(Sort.Direction.DESC, "id"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        if (exportExcel) {
            newPageable = PageRequest.of(0, maxCount, sort);
        }
        Page<Address> page = addressRepository.findAll(spec, newPageable);
        return PageUtil.toPage(page.map(addressMapper::toVO));
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public byte[] exportExcelData(List<AddressVO> addres) {
        List<AddressExcelObj> rows = CollUtil.newArrayList();
        for (int i = 0; i < addres.size(); i++) {
            AddressExcelObj excelObj = new AddressExcelObj();
            excelObj.setIndex(Long.valueOf(i + 1));
            excelObj.setName(addres.get(i).getName());
            excelObj.setAddressTypeName(addres.get(i).getAddressType().getName());
            excelObj.setContact(addres.get(i).getContact());
            excelObj.setPhone(addres.get(i).getPhone());
            excelObj.setDescription(addres.get(i).getDescription());
            rows.add(excelObj);
        }

        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
        ExcelWriter writer = ExcelUtil.getBigWriter();
        writer.addHeaderAlias("index", "#");
        writer.addHeaderAlias("name", "地址");
        writer.addHeaderAlias("addressTypeName", "地址类别");
        writer.addHeaderAlias("contact", "联系人");
        writer.addHeaderAlias("phone", "联系电话");
        writer.addHeaderAlias("description", "说明");
        writer.write(rows, true);
        writer.flush(outByteStream);
        writer.close();
        return outByteStream.toByteArray();
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public AddressVO create(Address resource) {
        if (resource.getAddressType() == null || resource.getAddressType().getId() == null) {
            throw new BadRequestException("指定的地址类别有错误");
        }
        Optional<AddressType> optionalAddressType = addressTypeRepository.findById(resource.getAddressType().getId());
        if (optionalAddressType.isPresent()) {
            resource.setAddressType(optionalAddressType.get());
            return addressMapper.toVO(addressRepository.save(resource));
        } else {
            throw new BadRequestException("指定的地址类别有错误");
        }
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public AddressVO update(Long id, Address resource) {
        Optional<Address> optionalAddress = addressRepository.findById(id);
        if (!optionalAddress.isPresent()) {
            throw new BadRequestException("指定的ID有误");
        }
        Address address = optionalAddress.get();
        if (!address.getId().equals(resource.getId())) {
            throw new BadRequestException("指定的ID有误");
        }

        return addressMapper.toVO(addressRepository.save(resource));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void delete(Long id) {
        Optional<Address> optionalAddress = addressRepository.findById(id);
        if (!optionalAddress.isPresent()) {
            throw new BadRequestException(" 地址不存在 ID=" + id);
        }
        Address address = optionalAddress.get();
        addressRepository.delete(address);
    }

    @Override
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public AddressDTO findById(Long id) {
        Optional<Address> optionalAddress = addressRepository.findById(id);
        if (!optionalAddress.isPresent()) {
            throw new BadRequestException(" 地址不存在 ID=" + id);
        }
        return addressMapper.toDto(optionalAddress.get());
    }

    @Override
    @Cacheable(value = CACHE_NAME)
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public List<AddressVO> getAllList() {
        return addressMapper.toVOList(addressRepository.findAll());
    }

}