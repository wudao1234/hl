package org.mstudio.modules.wms.stock_flow.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.goods.domain.Goods;
import org.mstudio.modules.wms.kpi.Object.TopSales;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoods;
import org.mstudio.modules.wms.stock_flow.domain.StockFlow;
import org.mstudio.modules.wms.stock_flow.domain.StockFlowType;
import org.mstudio.modules.wms.stock_flow.repository.StockFlowRepository;
import org.mstudio.modules.wms.stock_flow.service.StockFlowService;
import org.mstudio.modules.wms.stock_flow.service.mapper.StockFlowMapper;
import org.mstudio.modules.wms.stock_flow.service.object.OrderStockFlowExcelObj;
import org.mstudio.modules.wms.stock_flow.service.object.OrderStockFlowForOrderExcelObj;
import org.mstudio.modules.wms.stock_flow.service.object.StockFlowDTO;
import org.mstudio.modules.wms.ware_position.domain.WarePosition;
import org.mstudio.utils.PageUtil;
import org.mstudio.utils.ValidationUtil;
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
import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

/**
* @author Macrow
* @date 2019-02-22
*/

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class StockFlowServiceImpl implements StockFlowService {

    public static final String CACHE_NAME = "StockFlow";

    @Value("${excel.export-max-count}")
    private Integer maxCount;

    @Autowired
    private StockFlowRepository stockFlowRepository;

    @Autowired
    private StockFlowMapper stockFlowMapper;

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    public Map queryAll(Set<CustomerVO> customers, Boolean exportExcel, String flowOperateTypeFilter, String customerFilter, String wareZoneInFilter, String wareZoneOutFilter, String startDate, String endDate, String search, String searchWarePositionIn, String searchWarePositionOut, Pageable pageable) {
        Specification<StockFlow> spec = new Specification<StockFlow>() {
            @Override
            public Predicate toPredicate(Root<StockFlow> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();

                if (flowOperateTypeFilter != null && !"".equals(flowOperateTypeFilter)) {
                    String[] operateTypes = flowOperateTypeFilter.split(",");
                    CriteriaBuilder.In<Integer> in = criteriaBuilder.in(root.get("flowOperateType"));
                    Arrays.stream(operateTypes).forEach(id -> in.value(Integer.parseInt(id)));
                    predicates.add(in);
                }

                if (customerFilter != null && !"".equals(customerFilter)) {
                    String[] customerIds = customerFilter.split(",");
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("goods").get("customer").get("id"));
                    Arrays.stream(customerIds).forEach(id -> in.value(Long.valueOf(id)));
                    predicates.add(in);
                }

                if (wareZoneInFilter != null && !"".equals(wareZoneInFilter)) {
                    String[] wareZoneInIds = wareZoneInFilter.split(",");
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("warePositionIn").get("wareZone").get("id"));
                    Arrays.stream(wareZoneInIds).forEach(id -> in.value(Long.valueOf(id)));
                    predicates.add(in);
                }

                if (wareZoneOutFilter != null && !"".equals(wareZoneOutFilter)) {
                    String[] wareZoneOutIds = wareZoneOutFilter.split(",");
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("warePositionOut").get("wareZone").get("id"));
                    Arrays.stream(wareZoneOutIds).forEach(id -> in.value(Long.valueOf(id)));
                    predicates.add(in);
                }

                if (startDate != null && endDate != null) {
                    Date start = DateUtil.parse(startDate);
                    Date end = DateUtil.parse(endDate);
                    // 必须在结束日期基础上加上一天，第二天凌晨0点作为结束时间点
                    Calendar c = Calendar.getInstance();
                    c.setTime(end);
                    c.add(Calendar.DAY_OF_MONTH, 1);
                    end = c.getTime();
                    predicates.add(criteriaBuilder.between(root.get("createTime").as(Date.class), start, end));
                }

                if (search != null) {
                    predicates.add(criteriaBuilder.or(
                            criteriaBuilder.like(root.get("name").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("sn").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("description").as(String.class), "%" + search + "%")
                    ));
                }

                if (searchWarePositionIn != null) {
                    predicates.add(criteriaBuilder.or(
                            criteriaBuilder.like(root.get("warePositionIn").get("name").as(String.class), "%" + searchWarePositionIn + "%")
                    ));
                }

                if (searchWarePositionOut != null) {
                    predicates.add(criteriaBuilder.or(
                            criteriaBuilder.like(root.get("warePositionOut").get("name").as(String.class), "%" + searchWarePositionOut + "%")
                    ));
                }

                // 查询权限内的客户库存
                if (!customers.isEmpty()) {
                    List<Long> customerIdList = customers.stream().map(customer -> Long.valueOf(customer.getId())).collect(Collectors.toList());
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("goods").get("customer").get("id"));
                    customerIdList.forEach(in::value);
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
        // 库存流水默认按照时间顺序排列
        Sort sort = pageable.getSort().and(new Sort(Sort.Direction.DESC, "id"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        if (exportExcel) {
            newPageable = PageRequest.of(0, maxCount, sort);
        }
        Page<StockFlow> page = stockFlowRepository.findAll(spec, newPageable);
        return PageUtil.toPage(page.map(stockFlowMapper::toDto));
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    public Map queryForOrders(Set<CustomerVO> customers, Boolean exportExcel, String customerFilter, String wareZoneOutFilter, String startDate, String endDate, String search, String searchWarePositionOut, Pageable pageable) {
        Specification<StockFlow> spec = new Specification<StockFlow>() {
            @Override
            public Predicate toPredicate(Root<StockFlow> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();

                predicates.add(criteriaBuilder.equal(root.get("flowOperateType"), StockFlowType.OUT_ORDER_FIT));

                if (customerFilter != null && !"".equals(customerFilter)) {
                    String[] customerIds = customerFilter.split(",");
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("customerOrder").get("owner").get("id"));
                    Arrays.stream(customerIds).forEach(id -> in.value(Long.valueOf(id)));
                    predicates.add(in);
                }

                if (wareZoneOutFilter != null && !"".equals(wareZoneOutFilter)) {
                    String[] wareZoneOutIds = wareZoneOutFilter.split(",");
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("warePositionOut").get("wareZone").get("id"));
                    Arrays.stream(wareZoneOutIds).forEach(id -> in.value(Long.valueOf(id)));
                    predicates.add(in);
                }

                if (startDate != null && endDate != null) {
                    Date start = DateUtil.parse(startDate);
                    Date end = DateUtil.parse(endDate);
                    // 必须在结束日期基础上加上一天，第二天凌晨0点作为结束时间点
                    Calendar c = Calendar.getInstance();
                    c.setTime(end);
                    c.add(Calendar.DAY_OF_MONTH, 1);
                    end = c.getTime();
                    predicates.add(criteriaBuilder.between(root.get("createTime").as(Date.class), start, end));
                }

                if (search != null) {
                    predicates.add(criteriaBuilder.or(
                            criteriaBuilder.like(root.get("name").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("sn").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("customerOrder").get("flowSn").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("customerOrder").get("clientOrderSn").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("customerOrder").get("autoIncreaseSn").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("customerOrder").get("clientName").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("customerOrder").get("description").as(String.class), "%" + search + "%")
                    ));
                }

                if (searchWarePositionOut != null) {
                    predicates.add(criteriaBuilder.or(
                            criteriaBuilder.like(root.get("warePositionOut").get("name").as(String.class), "%" + searchWarePositionOut + "%")
                    ));
                }

                // 查询权限内的客户库存
                if (!customers.isEmpty()) {
                    List<Long> customerIdList = customers.stream().map(customer -> Long.valueOf(customer.getId())).collect(Collectors.toList());
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("customerOrder").get("owner").get("id"));
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
        // 库存流水默认按照时间顺序排列
        Sort sort = pageable.getSort().and(new Sort(Sort.Direction.DESC, "id"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        if (exportExcel) {
            newPageable = PageRequest.of(0, maxCount, sort);
        }
        Page<StockFlow> page = stockFlowRepository.findAll(spec, newPageable);
        return PageUtil.toPage(page.map(stockFlowMapper::toDto));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    synchronized public void create(StockFlowType stockFlowType, String goodsSn, String goodsName, Long quantity, BigDecimal price, Date expireDate, Integer packCount, String unit, CustomerOrder order, ReceiveGoods receiveGoods, Goods goods, WarePosition warePositionIn, WarePosition warePositionOut, String operator, String description) {
        StockFlow flow = new StockFlow();
        flow.setFlowOperateType(stockFlowType);
        flow.setSn(goodsSn);
        flow.setName(goodsName);
        flow.setQuantity(quantity);
        flow.setPrice(price);
        flow.setExpireDate(expireDate);
        flow.setPackCount(packCount);
        flow.setUnit(unit);
        flow.setCustomerOrder(order);
        flow.setReceiveGoods(receiveGoods);
        flow.setGoods(goods);
        flow.setWarePositionIn(warePositionIn);
        flow.setWarePositionOut(warePositionOut);
        flow.setOperator(operator);
        flow.setDescription(description);
        stockFlowRepository.save(flow);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "'queryAllByOrderId' + #p0")
    public List<StockFlowDTO> queryAllByOrderId(Long orderId) {
        List<StockFlow> stockFlows = stockFlowRepository.findAllByCustomerOrderIdOrderByWarePositionOut(orderId);
        stockFlows.sort((a, b) -> a.getWarePositionOut().getName().compareToIgnoreCase(b.getWarePositionOut().getName()));
        return stockFlowMapper.toDto(stockFlows);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "'queryAllByReceiveGoodsId' + #p0")
    public List<StockFlowDTO> queryAllByReceiveGoodsId(Long receiveGoodsId) {
        List<StockFlow> stockFlows = stockFlowRepository.findAllByReceiveGoodsIdOrderByCreateTimeDesc(receiveGoodsId);
        return stockFlowMapper.toDto(stockFlows);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public StockFlowDTO findById(Long id) {
        Optional<StockFlow> stockFlowItem = stockFlowRepository.findById(id);
        ValidationUtil.isNull(stockFlowItem, "StockFlow", "id", id);
        return stockFlowMapper.toDto(stockFlowItem.get());
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void delete(Long id) {
        stockFlowRepository.deleteById(id);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "'queryTopSales:' + #p0")
    public List<TopSales> queryTopSales(String type) {
        Date startDate, endDate;
        List<StockFlow> stockFlows;
        List<TopSales> topSalesList = new ArrayList<>();
        switch (type) {
            case "today":
                startDate = DateUtil.beginOfDay(DateUtil.date());
                endDate = DateUtil.endOfDay(DateUtil.date());
                stockFlows = stockFlowRepository.findAllByCreateTimeBetweenAndFlowOperateTypeOrderBySn(startDate, endDate, StockFlowType.OUT_ORDER_FIT);
                break;
            case "week":
                startDate = DateUtil.beginOfWeek(DateUtil.date());
                endDate = DateUtil.offsetSecond(DateUtil.endOfWeek(DateUtil.date()), 1);
                stockFlows = stockFlowRepository.findAllByCreateTimeBetweenAndFlowOperateTypeOrderBySn(startDate, endDate, StockFlowType.OUT_ORDER_FIT);
                break;
            case "month":
                startDate = DateUtil.beginOfMonth(DateUtil.date());
                endDate = DateUtil.offsetSecond(DateUtil.endOfMonth(DateUtil.date()), 1);
                stockFlows = stockFlowRepository.findAllByCreateTimeBetweenAndFlowOperateTypeOrderBySn(startDate, endDate, StockFlowType.OUT_ORDER_FIT);
                break;
            case "year":
                startDate = DateUtil.beginOfYear(DateUtil.date());
                endDate = DateUtil.offsetSecond(DateUtil.endOfYear(DateUtil.date()), 1);
                stockFlows = stockFlowRepository.findAllByCreateTimeBetweenAndFlowOperateTypeOrderBySn(startDate, endDate, StockFlowType.OUT_ORDER_FIT);
                break;
            default:
                return topSalesList;
        }
        TopSales topSales = null;
        for (int i = 0; i <= stockFlows.size(); i++) {
            if (i == stockFlows.size()) {
                if (topSales != null) {
                    topSalesList.add(topSales);
                }
            } else {
                StockFlow stockFlow = stockFlows.get(i);
                BigDecimal totalPrice = stockFlow.getPrice().multiply(BigDecimal.valueOf(stockFlow.getQuantity()));
                if (i == 0) {
                    topSales = new TopSales(stockFlow.getName(), stockFlow.getSn(), totalPrice);
                } else {
                    if (topSales.getSn().equals(stockFlow.getSn())) {
                        topSales.setTotalPrice(topSales.getTotalPrice().add(totalPrice));
                    } else {
                        topSalesList.add(topSales);
                        topSales = new TopSales(stockFlow.getName(), stockFlow.getSn(), totalPrice);
                    }
                }
            }
        }
        topSalesList.sort(Comparator.comparing(TopSales::getTotalPrice));
        Collections.reverse(topSalesList);
        return topSalesList.subList(0, topSalesList.size() > 10 ? 10 : topSalesList.size());
    }

    @Override
    @Cacheable(value = CACHE_NAME, key = "'countSalesByGoodsIdBetween' + #p0 + '-' + #p1 + '-' + #p2")
    public Long countSalesByGoodsIdBetween(Long goodsId, Date startDate, Date endDate) {
        return stockFlowRepository.countByGoodsIdAndFlowOperateTypeAndCreateTimeBetween(goodsId, StockFlowType.OUT_ORDER_FIT, startDate, endDate);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public byte[] exportExcelDataForOrder(List<StockFlowDTO> stockFlows) {
        List<OrderStockFlowForOrderExcelObj> rows = CollUtil.newArrayList();
        for (int i = 0; i < stockFlows.size(); i++) {
            OrderStockFlowForOrderExcelObj excelObj = new OrderStockFlowForOrderExcelObj();
            excelObj.setIndex(Long.valueOf(i + 1));
            excelObj.setCustomerName(stockFlows.get(i).getGoods().getCustomer().getName());
            excelObj.setOrderFlowSn(stockFlows.get(i).getCustomerOrder().getFlowSn());
            excelObj.setOrderClientOrderSn(stockFlows.get(i).getCustomerOrder().getClientOrderSn());
            excelObj.setOrderClientOrderSn2(stockFlows.get(i).getCustomerOrder().getClientOrderSn2());
            excelObj.setAutoIncreaseSn(stockFlows.get(i).getCustomerOrder().getAutoIncreaseSn());
            excelObj.setOrderClientName(stockFlows.get(i).getCustomerOrder().getClientName());
            excelObj.setOrderClientAddress(stockFlows.get(i).getCustomerOrder().getClientAddress());
            excelObj.setOrderClientStore(stockFlows.get(i).getCustomerOrder().getClientStore());
            excelObj.setCreateTime(stockFlows.get(i).getCreateTime());
            excelObj.setName(stockFlows.get(i).getName());
            excelObj.setSn(stockFlows.get(i).getSn());
            excelObj.setQuantity(stockFlows.get(i).getQuantity());
            excelObj.setPrice(stockFlows.get(i).getPrice());
            excelObj.setTotalPrice(stockFlows.get(i).getPrice().multiply(BigDecimal.valueOf(stockFlows.get(i).getQuantity())));
            excelObj.setExpireDate(DateUtil.format(stockFlows.get(i).getExpireDate(), "yyyy-MM-dd"));
            excelObj.setPackCount(stockFlows.get(i).getPackCount());
            excelObj.setUnit(stockFlows.get(i).getUnit());
            excelObj.setOperator(stockFlows.get(i).getOperator());
            excelObj.setWareZoneOutName(stockFlows.get(i).getWarePositionOut().getWareZone().getName());
            excelObj.setWarePositionOutName(stockFlows.get(i).getWarePositionOut().getName());
            excelObj.setDescription(stockFlows.get(i).getCustomerOrder().getDescription());
            rows.add(excelObj);
        }

        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
        ExcelWriter writer = ExcelUtil.getBigWriter();
        writer.addHeaderAlias("index", "#");
        writer.addHeaderAlias("customerName", "客户名称");
        writer.addHeaderAlias("orderFlowSn", "订单流水号");
        writer.addHeaderAlias("orderClientOrderSn", "客户订单号");
        writer.addHeaderAlias("orderClientOrderSn2", "客户单据号");
        writer.addHeaderAlias("autoIncreaseSn", "自定义编号");
        writer.addHeaderAlias("orderClientName", "订单客户名称");
        writer.addHeaderAlias("orderClientAddress", "订单客户地址");
        writer.addHeaderAlias("orderClientStore", "订单客户门店");
        writer.addHeaderAlias("createTime", "时间");
        writer.addHeaderAlias("name", "商品名称");
        writer.addHeaderAlias("sn", "商品条码");
        writer.addHeaderAlias("quantity", "数量");
        writer.addHeaderAlias("price", "单价");
        writer.addHeaderAlias("totalPrice", "小计");
        writer.addHeaderAlias("expireDate", "过期日");
        writer.addHeaderAlias("packCount", "规格");
        writer.addHeaderAlias("unit", "单位");
        writer.addHeaderAlias("operator", "操作人");
        writer.addHeaderAlias("wareZoneOutName", "出库库区");
        writer.addHeaderAlias("warePositionOutName", "出库库位");
        writer.addHeaderAlias("description", "订单备注");

        writer.write(rows, true);
        writer.flush(outByteStream);
        writer.close();
        return outByteStream.toByteArray();
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public byte[] exportExcelData(List<StockFlowDTO> stockFlows) {
        List<OrderStockFlowExcelObj> rows = CollUtil.newArrayList();
        for (int i = 0; i < stockFlows.size(); i++) {
            OrderStockFlowExcelObj excelObj = new OrderStockFlowExcelObj();
            StockFlowDTO stockFlow = stockFlows.get(i);
            excelObj.setIndex(Long.valueOf(i + 1));
            excelObj.setCustomerName(stockFlow.getGoods().getCustomer().getName());
            excelObj.setCreateTime(stockFlow.getCreateTime());
            excelObj.setName(stockFlow.getName());
            excelObj.setSn(stockFlow.getSn());
            excelObj.setQuantity(stockFlow.getQuantity());
            excelObj.setPrice(stockFlow.getPrice());
            excelObj.setExpireDate(DateUtil.format(stockFlow.getExpireDate(), "yyyy-MM-dd"));
            excelObj.setPackCount(stockFlow.getPackCount());
            excelObj.setUnit(stockFlow.getUnit());
            excelObj.setOperator(stockFlow.getOperator());
            excelObj.setDescription(stockFlow.getDescription());
            if (stockFlow.getWarePositionIn() != null) {
                excelObj.setWareZoneInName(stockFlow.getWarePositionIn().getWareZone().getName());
                excelObj.setWarePositionInName(stockFlow.getWarePositionIn().getName());
            }
            if (stockFlow.getWarePositionOut() != null) {
                excelObj.setWareZoneOutName(stockFlow.getWarePositionOut().getWareZone().getName());
                excelObj.setWarePositionOutName(stockFlow.getWarePositionOut().getName());
            }
            rows.add(excelObj);
        }

        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
        ExcelWriter writer = ExcelUtil.getBigWriter();
        writer.addHeaderAlias("index", "#");
        writer.addHeaderAlias("customerName", "客户名称");
        writer.addHeaderAlias("createTime", "时间");
        writer.addHeaderAlias("name", "商品名称");
        writer.addHeaderAlias("sn", "商品条码");
        writer.addHeaderAlias("quantity", "数量");
        writer.addHeaderAlias("price", "单价");
        writer.addHeaderAlias("expireDate", "过期日");
        writer.addHeaderAlias("packCount", "规格");
        writer.addHeaderAlias("unit", "单位");
        writer.addHeaderAlias("operator", "操作人");
        writer.addHeaderAlias("wareZoneInName", "入库库区");
        writer.addHeaderAlias("warePositionInName", "入库库位");
        writer.addHeaderAlias("wareZoneOutName", "出库库区");
        writer.addHeaderAlias("warePositionOutName", "出库库位");
        writer.addHeaderAlias("description", "备注");

        writer.write(rows, true);
        writer.flush(outByteStream);
        writer.close();
        return outByteStream.toByteArray();
    }

}