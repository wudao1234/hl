package org.mstudio.modules.wms.goods.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import lombok.extern.slf4j.Slf4j;
import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.system.service.UserService;
import org.mstudio.modules.system.service.dto.UserDTO;
import org.mstudio.modules.wms.customer.service.impl.CustomerServiceImpl;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.goods.domain.Goods;
import org.mstudio.modules.wms.goods.repository.GoodsRepository;
import org.mstudio.modules.wms.goods.service.GoodsService;
import org.mstudio.modules.wms.goods.service.mapper.GoodsMapper;
import org.mstudio.modules.wms.goods.service.object.GoodsDTO;
import org.mstudio.modules.wms.goods.service.object.GoodsExcelObj;
import org.mstudio.modules.wms.goods.service.object.GoodsVO;
import org.mstudio.modules.wms.goods_type.repository.GoodsTypeRepository;
import org.mstudio.modules.wms.goods_type.service.impl.GoodsTypeServiceImpl;
import org.mstudio.modules.wms.kpi.Object.TopUnSales;
import org.mstudio.modules.wms.stock.service.StockService;
import org.mstudio.modules.wms.stock_flow.service.StockFlowService;
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
import java.util.stream.Collectors;

import static org.mstudio.utils.SecurityContextHolder.getUserDetails;

/**
 * @author Macrow
 * @date 2019-02-22
 */

@Slf4j
@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class GoodsServiceImpl implements GoodsService {

    public static final String CACHE_NAME = "Goods";
    public static final String CACHE_NAME_UNSALE = "UnSaleGoods";

    @Value("${excel.export-max-count}")
    private Integer maxCount;

    @Autowired
    GoodsRepository goodsRepository;

    @Autowired
    GoodsTypeRepository goodsTypeRepository;

    @Autowired
    GoodsMapper goodsMapper;

    @Autowired
    StockService stockService;

    @Autowired
    UserService userService;

    @Autowired
    StockFlowService stockFlowService;

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Map queryAll(Set<CustomerVO> customers, Boolean exportExcel, String goodsTypeFilter, String goodsCustomerFilter, String search, Pageable pageable) {
        Specification<Goods> spec = new Specification<Goods>() {
            @Override
            public Predicate toPredicate(Root<Goods> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();

                if (goodsTypeFilter != null && !"".equals(goodsTypeFilter)) {
                    String[] goodsTypeIds = goodsTypeFilter.split(",");
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("goodsType").get("id"));
                    Arrays.stream(goodsTypeIds).forEach(id -> in.value(Long.valueOf(id)));
                    predicates.add(in);
                }

                if (goodsCustomerFilter != null && !"".equals(goodsTypeFilter)) {
                    String[] goodsCustomerIds = goodsCustomerFilter.split(",");
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("customer").get("id"));
                    Arrays.stream(goodsCustomerIds).forEach(id -> in.value(Long.valueOf(id)));
                    predicates.add(in);
                }

                if (search != null) {
                    predicates.add(criteriaBuilder.or(
                            criteriaBuilder.like(root.get("name").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("sn").as(String.class), "%" + search + "%")
                    ));
                }

                // 查询权限内的客户库存
                if (!customers.isEmpty()) {
                    List<Long> customerIdList = customers.stream().map(customer -> Long.valueOf(customer.getId())).collect(Collectors.toList());
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("customer").get("id"));
                    customerIdList.forEach(id -> in.value(id));
                    predicates.add(in);
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
        Page<Goods> page = goodsRepository.findAll(spec, newPageable);
        return PageUtil.toPage(page.map(goodsMapper::toDto).map(goodsDTO -> {
            goodsDTO.setStockCount(stockService.countByGoodsId(Long.valueOf(goodsDTO.getId())));
            return goodsDTO;
        }));
    }

    @Override
    @Cacheable(value = CACHE_NAME, key = "'CountByGoodType' + #p0")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Integer countByGoodsTypeId(Long id) {
        return goodsRepository.countByGoodsTypeId(id);
    }

    @Override
    @Cacheable(value = CACHE_NAME, key = "'CountByCustomer' + #p0")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Integer countByCustomerId(Long id) {
        return goodsRepository.countByCustomerId(id);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public GoodsDTO findById(Long id) {
        Optional<Goods> goods = goodsRepository.findById(id);
        ValidationUtil.isNull(goods, "Goods", "id", id);
        return goodsMapper.toDto(goods.get());
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = GoodsTypeServiceImpl.CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerServiceImpl.CACHE_NAME, allEntries = true),
    })
    synchronized public GoodsDTO create(Goods resources) {
        Optional<Goods> optionalGoods = goodsRepository.findByCustomerIdAndSnAndPackCount(resources.getCustomer().getId(),resources.getSn(), resources.getPackCount());
        if (optionalGoods.isPresent()) {
            throw new BadRequestException("该商品已经存在");
        }
        return goodsMapper.toDto(goodsRepository.save(resources));
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = GoodsTypeServiceImpl.CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerServiceImpl.CACHE_NAME, allEntries = true)
    })
    synchronized public GoodsVO update(Long id, Goods resources) {
        Optional<Goods> optionalGoods = goodsRepository.findById(id);
        if (!optionalGoods.isPresent()) {
            throw new BadRequestException("该商品不存在");
        }
        Optional<Goods> optionalExistGoods = goodsRepository.findByCustomerIdAndSnAndPackCount(resources.getCustomer().getId(),resources.getSn(), resources.getPackCount());
        if(optionalExistGoods.isPresent() && !optionalExistGoods.get().getId().equals(id)) {
            throw new BadRequestException("该商品已经存在");
        }
        resources.setId(id);
        return goodsMapper.toVO(goodsRepository.save(resources));
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = GoodsTypeServiceImpl.CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerServiceImpl.CACHE_NAME, allEntries = true)
    })
    synchronized public void delete(Long id) {
        goodsRepository.deleteById(id);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public byte[] exportExcelData(List<GoodsDTO> goods) {
        List<GoodsExcelObj> rows = CollUtil.newArrayList();
        for (int i = 0; i < goods.size(); i++) {
            GoodsExcelObj excelObj = new GoodsExcelObj();
            excelObj.setIndex(Long.valueOf(i + 1));
            excelObj.setName(goods.get(i).getName());
            excelObj.setSn(goods.get(i).getSn());
            excelObj.setPrice(goods.get(i).getPrice());
            excelObj.setReturnPrice(goods.get(i).getReturnPrice());
            excelObj.setUnit(goods.get(i).getUnit());
            Integer months = goods.get(i).getMonthsOfWarranty();
            int year = months / 12;
            int month = months % 12;
            String monthsOfWarranty = month + "月";
            if (year >= 1) {
                if (month == 0) {
                    monthsOfWarranty = year + "年";
                } else {
                    monthsOfWarranty = year + "年" + monthsOfWarranty;
                }
            }
            excelObj.setMonthsOfWarranty(monthsOfWarranty);
            excelObj.setPackCount(goods.get(i).getPackCount());
            excelObj.setDescription(goods.get(i).getDescription());
            excelObj.setGoodsType(goods.get(i).getGoodsType().getName());
            excelObj.setCustomerName(goods.get(i).getCustomer().getName());
            excelObj.setStockCount(goods.get(i).getStockCount());
            rows.add(excelObj);
        }

        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
        ExcelWriter writer = ExcelUtil.getBigWriter();
        writer.addHeaderAlias("index", "#");
        writer.addHeaderAlias("name", "商品名称");
        writer.addHeaderAlias("sn", "商品条码");
        writer.addHeaderAlias("price", "商品价格");
        writer.addHeaderAlias("returnPrice", "退货价格");
        writer.addHeaderAlias("unit", "单位");
        writer.addHeaderAlias("monthsOfWarranty", "质保时长");
        writer.addHeaderAlias("packCount", "商品规格");
        writer.addHeaderAlias("description", "商品说明");
        writer.addHeaderAlias("goodsType", "商品类别");
        writer.addHeaderAlias("customerName", "客户名称");
        writer.addHeaderAlias("stockCount", "库存数量");
        writer.write(rows, true);
        writer.flush(outByteStream);
        writer.close();
        return outByteStream.toByteArray();
    }

    @Override
    @Cacheable(value = CACHE_NAME_UNSALE, key = "#p0 + '-' + #p1")
    public List<TopUnSales> queryUnSales(Date startDate, Date endDate, String customerId) {
        JwtUser jwtUser = (JwtUser) getUserDetails();
        UserDTO user = userService.findById(jwtUser.getId());
        Set<CustomerVO> customers = user.getCustomers();
        if (customers.isEmpty() || customers.stream().map(CustomerVO::getId).noneMatch(id -> id.equals(customerId))) {
            return new ArrayList<>();
        } else {
            List<TopUnSales> topUnSales = new ArrayList<>();
            List<Goods> goodsList = goodsRepository.findAllByCustomerId(customerId);
            goodsList.forEach(goods -> topUnSales.add(new TopUnSales(goods.getName(), goods.getSn(), goods.getPrice(), stockService.countByGoodsId(goods.getId()), stockFlowService.countSalesByGoodsIdBetween(goods.getId(), startDate, endDate))));
            topUnSales.sort(Comparator.comparing(TopUnSales::getSaleCount));
            return topUnSales;
        }
    }

}