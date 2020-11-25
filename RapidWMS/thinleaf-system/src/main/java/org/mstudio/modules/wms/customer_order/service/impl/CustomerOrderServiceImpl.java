package org.mstudio.modules.wms.customer_order.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.NumberUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import cn.hutool.poi.excel.sax.handler.RowHandler;
import com.itextpdf.barcodes.Barcode128;
import com.itextpdf.io.font.PdfEncodings;
import com.itextpdf.kernel.events.Event;
import com.itextpdf.kernel.events.IEventHandler;
import com.itextpdf.kernel.events.PdfDocumentEvent;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.geom.Rectangle;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfPage;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.canvas.PdfCanvas;
import com.itextpdf.kernel.pdf.xobject.PdfFormXObject;
import com.itextpdf.kernel.utils.PdfMerger;
import com.itextpdf.layout.Canvas;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.borders.Border;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Image;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.HorizontalAlignment;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.layout.property.UnitValue;
import lombok.extern.slf4j.Slf4j;
import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.system.repository.UserRepository;
import org.mstudio.modules.wms.common.MultiOperateResult;
import org.mstudio.modules.wms.common.WmsUtil;
import org.mstudio.modules.wms.customer.service.CustomerService;
import org.mstudio.modules.wms.customer.service.impl.CustomerServiceImpl;
import org.mstudio.modules.wms.customer.service.object.CustomerDTO;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.customer_order.domain.*;
import org.mstudio.modules.wms.customer_order.repository.CustomerOrderItemRepository;
import org.mstudio.modules.wms.customer_order.repository.CustomerOrderRepository;
import org.mstudio.modules.wms.customer_order.repository.CustomerOrderStockRepository;
import org.mstudio.modules.wms.customer_order.service.CustomerOrderService;
import org.mstudio.modules.wms.customer_order.service.handler.GeneralHandler;
import org.mstudio.modules.wms.customer_order.service.handler.HtmlHandler;
import org.mstudio.modules.wms.customer_order.service.handler.Kingdee2Handler;
import org.mstudio.modules.wms.customer_order.service.handler.KingdeeHandler;
import org.mstudio.modules.wms.customer_order.service.mapper.CustomerOrderMapper;
import org.mstudio.modules.wms.customer_order.service.object.*;
import org.mstudio.modules.wms.goods.domain.Goods;
import org.mstudio.modules.wms.goods.repository.GoodsRepository;
import org.mstudio.modules.wms.goods.service.impl.GoodsServiceImpl;
import org.mstudio.modules.wms.kpi.Object.OrderSales;
import org.mstudio.modules.wms.operate_snapshot.repository.OperateSnapshotRepository;
import org.mstudio.modules.wms.operate_snapshot.service.OperateSnapshotService;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.mstudio.modules.wms.pack.repository.PackRepository;
import org.mstudio.modules.wms.pack.service.impl.PackServiceImpl;
import org.mstudio.modules.wms.stock.domain.Stock;
import org.mstudio.modules.wms.stock.dto.AddDTO;
import org.mstudio.modules.wms.stock.dto.ReduceForOrderItemDTO;
import org.mstudio.modules.wms.stock.dto.ReduceForOrderStockDTO;
import org.mstudio.modules.wms.stock.service.StockService;
import org.mstudio.modules.wms.stock_flow.domain.StockFlow;
import org.mstudio.modules.wms.stock_flow.repository.StockFlowRepository;
import org.mstudio.modules.wms.stock_flow.service.StockFlowService;
import org.mstudio.modules.wms.stock_flow.service.impl.StockFlowServiceImpl;
import org.mstudio.modules.wms.stock_flow.service.object.StockFlowDTO;
import org.mstudio.modules.wms.ware_position.service.object.WarePositionDTO;
import org.mstudio.modules.wms.ware_zone.service.WareZoneService;
import org.mstudio.modules.wms.ware_zone.service.object.WareZoneVO;
import org.mstudio.utils.FileUtil;
import org.mstudio.utils.PageUtil;
import org.mstudio.utils.StringUtils;
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
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;

import static org.mstudio.utils.SecurityContextHolder.getUserDetails;

/**
 * @author Macrow
 * @date 2019-02-22
 */

@Slf4j
@Service
public class CustomerOrderServiceImpl implements CustomerOrderService {

    public static final String CACHE_NAME = "CustomerOrder";

    @Value("${upload.path}")
    private String uploadPath;

    @Value("${excel.export-max-count}")
    private Integer maxCount;

    @Value("${rapidWMS.print_extra_info}")
    private Boolean printExtraInfo;

    @Autowired
    private CustomerOrderRepository customerOrderRepository;
    
    @Autowired
    private CustomerOrderMapper customerOrderMapper;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private StockService stockService;

    @Autowired
    private GoodsRepository goodsRepository;

    @Autowired
    private StockFlowRepository stockFlowRepository;

    @Autowired
    private CustomerOrderItemRepository customerOrderItemRepository;

    @Autowired
    private CustomerOrderStockRepository customerOrderStockRepository;

    @Autowired
    private OperateSnapshotRepository operateSnapshotRepository;

    @Autowired
    private OperateSnapshotService operateSnapshotService;

    @Autowired
    private CustomerOrderService customerOrderService;

    @Autowired
    private WareZoneService wareZoneService;

    @Autowired
    private StockFlowService stockFlowService;

    @Autowired
    private PackRepository packRepository;

    @Autowired
    private UserRepository userRepository;

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(readOnly = true)
    public Map queryAll(Set<CustomerVO> customers, Boolean exportExcel, Boolean isPrintedFilter, String isSatisfiedFilter, String customerFilter, String orderStatusFilter, String receiveTypeFilter, Boolean isActiveFilter, String startDate, String endDate, String search, Pageable pageable) {
        return query(customers, exportExcel, isPrintedFilter, isSatisfiedFilter, customerFilter, orderStatusFilter, receiveTypeFilter, isActiveFilter, startDate, endDate, search, pageable);
    }

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(readOnly = true)
    public Map listForPack(String customerFilter, String search, Pageable pageable) {
        return query(null, false, null, null, customerFilter, String.valueOf(OrderStatus.CONFIRM.getIndex()), null, true, null, null, search, pageable);
    }

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(readOnly = true)
    public Map listForComplete(Set<CustomerVO> customers, Boolean exportExcel, String customerFilter, String packTypeFilter, String receiveTypeFilter, String startDate, String endDate, String search, Pageable pageable) {
        Specification<CustomerOrder> spec = new Specification<CustomerOrder>() {
            @Override
            public Predicate toPredicate(Root<CustomerOrder> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();

                if (customerFilter != null && !"".equals(customerFilter)) {
                    String[] customerIds = customerFilter.split(",");
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("owner").get("id"));
                    Arrays.stream(customerIds).forEach(id -> in.value(Long.valueOf(id)));
                    predicates.add(in);
                }

                if (packTypeFilter != null && !"".equals(packTypeFilter)) {
                    String[] packTypeIds = packTypeFilter.split(",");
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("pack").get("packType"));
                    Arrays.stream(packTypeIds).forEach(id -> in.value(Long.valueOf(id)));
                    predicates.add(in);
                }

                String orderStatusFilter = String.valueOf(OrderStatus.COMPLETE.getIndex());
                if (orderStatusFilter != null && !"".equals(orderStatusFilter)) {
                    String[] orderStatus = orderStatusFilter.split(",");
                    CriteriaBuilder.In<Integer> in = criteriaBuilder.in(root.get("orderStatus"));
                    Arrays.stream(orderStatus).forEach(id -> in.value(Integer.parseInt(id)));
                    predicates.add(in);
                }

                if (receiveTypeFilter != null && !"".equals(receiveTypeFilter)) {
                    String[] receiveTypes = receiveTypeFilter.split(",");
                    CriteriaBuilder.In<Integer> in = criteriaBuilder.in(root.get("receiveType"));
                    Arrays.stream(receiveTypes).forEach(id -> in.value(Integer.parseInt(id)));
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

                if (customers != null && !customers.isEmpty()) {
                    List<Long> customerIdList = customers.stream().map(customer -> Long.valueOf(customer.getId())).collect(Collectors.toList());
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("owner").get("id"));
                    customerIdList.forEach(id -> in.value(id));
                    predicates.add(in);
                }

                if (search != null) {
                    predicates.add(criteriaBuilder.or(
                            criteriaBuilder.like(root.get("printTitle").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("clientName").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("clientStore").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("clientAddress").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("clientOrderSn").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("clientOrderSn2").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("clientOperator").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("flowSn").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("autoIncreaseSn").as(String.class), "%" + search + "%"),
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

        // 默认按照创建的时间顺序、自定义编号排列
        Sort sort = pageable.getSort()
                .and(new Sort(Sort.Direction.DESC, "id"))
                .and(new Sort(Sort.Direction.DESC, "autoIncreaseSn"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        if (exportExcel) {
            newPageable = PageRequest.of(0, maxCount, sort);
        }
        Page<CustomerOrder> page = customerOrderRepository.findAll(spec, newPageable);
        return PageUtil.toPage(page.map(customerOrderMapper::toVO));
    }

    @Override
    @Transactional(readOnly = true)
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public CustomerOrderDTO findById(Long id) {
        CustomerOrder order = getCustomerOrder(id);
        CustomerOrderDTO orderDTO = customerOrderMapper.toDto(order);
        if (order.getTargetWareZones() != null && !order.getTargetWareZones().isEmpty()) {
            List<WareZoneVO> wareZones = wareZoneService.getListByIds(order.getTargetWareZones().split(","));
            orderDTO.setTargetWareZoneList(wareZones);
        }
        return orderDTO;
    }

    @Override
    @Transactional(readOnly = true)
    @Cacheable(value = CACHE_NAME, key = "#p0 + '_withQuantityLeft'")
    public CustomerOrderDTO findByIdAndQueryQuantityLeft(Long id) {
        CustomerOrderDTO orderDTO = findById(id);
        Long customerId = Long.valueOf(orderDTO.getOwner().getId());
        List<CustomerOrderItemVO> customerOrderItems = orderDTO.getCustomerOrderItems();
        List<CustomerOrderStockVO> customerOrderStocks = orderDTO.getCustomerOrderStocks();
        orderDTO.setCustomerOrderItems(customerOrderItems.stream().peek(
                item -> {
                    Optional<Goods> goodsOptional = goodsRepository.findByCustomerIdAndSnAndPackCount(customerId, item.getSn(), item.getPackCount());
                    if (goodsOptional.isPresent()) {
                        item.setQuantityLeft(Long.valueOf(stockService.countByGoodsId(goodsOptional.get().getId())));
                    } else {
                        // 该商品在系统库存中未找到
                        item.setQuantityLeft(0L);
                    }
                }).collect(Collectors.toList()));
        orderDTO.setCustomerOrderStocks(customerOrderStocks.stream().peek(
                stock -> {
                    stock.setQuantityLeft(stockService.countByGoodsIdAndWarePositionIdAndExpireTime(Long.valueOf(stock.getGoods().getId()), Long.valueOf(stock.getWarePosition().getId()), stock.getExpireDate()));
                }).collect(Collectors.toList()));
        return orderDTO;
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerServiceImpl.CACHE_NAME, allEntries = true),
            @CacheEvict(value = GoodsServiceImpl.CACHE_NAME_UNSALE, allEntries = true)
    })
    @Transactional(rollbackFor = Exception.class)
    public CustomerOrderDTO create(CustomerOrder resource, Boolean useNewAutoIncreaseSn, Boolean fetchStocks) {

        if (resource.getOwner().getId() == null) {
            throw new BadRequestException("无效订单，订单没有指定所属客户");
        }

        List<CustomerOrderItem> orderItems = getSafeOrderItems(resource);
        List<CustomerOrderStock> orderStocks = getSafeOrderStocks(resource);

        if (orderItems.isEmpty() && orderStocks.isEmpty()) {
            throw new BadRequestException("无效订单，订单没有指定出库商品");
        }

        if (resource.getClientOrderSn() != null && !resource.getClientOrderSn().isEmpty() && resource.getClientOrderSn2() != null && !resource.getClientOrderSn2().isEmpty()) {
            // 2019.10.16 客户订单 单据号 相同，被认为重复创建
            Optional<CustomerOrder> optionalExistOrder = customerOrderRepository.findTopByClientOrderSn2AndIsActiveAndOwnerId(resource.getClientOrderSn2(), true, resource.getOwner().getId());
            if (optionalExistOrder.isPresent()) {
                throw new BadRequestException("该客户的订单已经导入，或客户订单号、客户单据号重复");
            }
        }

        // 先保存订单，以防止有错误提前生成子项
        resource.setDescription(resource.getDescription());
        resource.setIsActive(true);
        resource.setIsPrinted(false);
        resource.setOrderStatus(OrderStatus.INIT);
        resource.setUserCreator(userRepository.findByUsername(getUserDetails().getUsername()));
        // 根据需求生成自增的流水号
        String sn;
        CustomerDTO customer = customerService.findById(resource.getOwner().getId());
        resource.setFlowSn(customer.getShortNameEn() + WmsUtil.generateSnowFlakeId());
        if (StrUtil.isEmptyOrUndefined(resource.getAutoIncreaseSn())) {
            sn = WmsUtil.getNewSn(customer.getShortNameEn(), getLastAutoIncreaseSn(Long.valueOf(customer.getId())), useNewAutoIncreaseSn);
            resource.setAutoIncreaseSn(sn);
        }
        if (StrUtil.isEmptyOrUndefined(resource.getTargetWareZones())) {
            resource.setTargetWareZones(null);
        }
        //打印标题不填写的话，默认为客户名称
        if (resource.getPrintTitle() == null || resource.getPrintTitle().isEmpty()) {
            resource.setPrintTitle(customer.getName());
        }
        CustomerOrder order = customerOrderRepository.save(resource);

        BigDecimal totalPrice = BigDecimal.ZERO;

        for (CustomerOrderItem item : orderItems) {
            item.setCustomerOrder(order);
            totalPrice = totalPrice.add(item.getPrice().multiply(BigDecimal.valueOf(item.getQuantityInitial())));
        }
        customerOrderItemRepository.saveAll(orderItems);

        for (CustomerOrderStock item : orderStocks) {
            item.setCustomerOrder(order);
            totalPrice = totalPrice.add(item.getPrice().multiply(BigDecimal.valueOf(item.getQuantityInitial())));
        }
        customerOrderStockRepository.saveAll(orderStocks);

        // 生成订单式暂时不计算总价，在匹配出库时再计算总价
        // order.setTotalPrice(totalPrice);
        order.setCustomerOrderItems(orderItems);
        order.setCustomerOrderStocks(orderStocks);
        order = customerOrderRepository.save(order);

        operateSnapshotService.create(OrderStatus.INIT.getName(), order);

        order.setCustomerOrderItems(orderItems);
        order.setCustomerOrderStocks(orderStocks);
        if (fetchStocks != null && fetchStocks) {
            customerOrderService.fetchStocks(order);
        }
        order.setCustomerOrderItems(orderItems);
        order.setCustomerOrderStocks(orderStocks);
        return customerOrderMapper.toDto(order);
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerServiceImpl.CACHE_NAME, allEntries = true),
            @CacheEvict(value = GoodsServiceImpl.CACHE_NAME_UNSALE, allEntries = true)
    })
    @Transactional(rollbackFor = Exception.class)
    synchronized public void update(Long id, CustomerOrder resource, Boolean useNewAutoIncreaseSn, Boolean fetchStocks) {
        CustomerOrder order = getCustomerOrder(id);
        if (!order.getId().equals(resource.getId())) {
            throw new BadRequestException("指定的ID有误");
        }

        if (!Arrays.asList(OrderStatus.INIT, OrderStatus.FETCH_STOCK, OrderStatus.CONFIRM).contains(order.getOrderStatus())) {
            throw new BadRequestException("只能编辑未打包状态下的订单");
        }

        List<CustomerOrderItem> orderItems = order.getCustomerOrderItems();
        List<CustomerOrderStock> orderStocks = order.getCustomerOrderStocks();
        customerOrderItemRepository.deleteAll(orderItems);
        customerOrderStockRepository.deleteAll(orderStocks);

        order.setPrintTitle(resource.getPrintTitle());
        //打印标题不填写的话，默认为客户名称
        if (resource.getPrintTitle() == null || resource.getPrintTitle().isEmpty()) {
            resource.setPrintTitle(resource.getOwner().getName());
        }
        order.setDescription(resource.getDescription());
        order.setExpireDateMin(resource.getExpireDateMin());
        order.setExpireDateMax(resource.getExpireDateMax());
        order.setFetchAll(resource.getFetchAll());
        order.setClientName(resource.getClientName());
        order.setClientAddress(resource.getClientAddress());
        order.setClientStore(resource.getClientStore());
        order.setClientOrderSn(resource.getClientOrderSn());
        order.setClientOrderSn2(resource.getClientOrderSn2());
        order.setClientOperator(resource.getClientOperator());
        if (StrUtil.isEmptyOrUndefined(resource.getAutoIncreaseSn())) {
            CustomerDTO customer = customerService.findById(resource.getOwner().getId());
            String sn = WmsUtil.getNewSn(customer.getShortNameEn(), getLastAutoIncreaseSn(Long.valueOf(customer.getId())), useNewAutoIncreaseSn);
            resource.setAutoIncreaseSn(sn);
        }
        order.setAutoIncreaseSn(resource.getAutoIncreaseSn());
        order.setTargetWareZones(resource.getTargetWareZones().isEmpty() ? null : resource.getTargetWareZones());
        orderItems = resource.getCustomerOrderItems().stream()
                .peek(item -> item.setCustomerOrder(order)).collect(Collectors.toList());
        orderStocks = resource.getCustomerOrderStocks().stream()
                .peek(item -> item.setCustomerOrder(order)).collect(Collectors.toList());
        orderItems = customerOrderItemRepository.saveAll(orderItems);
        orderStocks = customerOrderStockRepository.saveAll(orderStocks);
        order.setCustomerOrderItems(orderItems);
        order.setCustomerOrderStocks(orderStocks);
        customerOrderRepository.save(order);

        operateSnapshotService.create("修改订单", order);

        // 修改订单时，先返还所有出库的商品，再把之前的所有流水全部作废并删除，然后记录新的流水
        if (Arrays.asList(OrderStatus.FETCH_STOCK, OrderStatus.CONFIRM).contains(order.getOrderStatus())) {
            returnStock(order);
        }

        if (fetchStocks != null && fetchStocks) {
            customerOrderService.fetchStocks(order);
        }
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerServiceImpl.CACHE_NAME, allEntries = true)
    })
    @Transactional(rollbackFor = Exception.class)
    synchronized public void delete(Long id) {
        CustomerOrder order = getCustomerOrder(id);
        if (order.getOrderStatus() != OrderStatus.INIT && order.getOrderStatus() != OrderStatus.CANCEL) {
            throw new BadRequestException("只能删除初始状态或者已废除的订单");
        } else {
            customerOrderItemRepository.deleteAll(order.getCustomerOrderItems());
            customerOrderStockRepository.deleteAll(order.getCustomerOrderStocks());
            operateSnapshotRepository.deleteAll(order.getOperateSnapshots());
            customerOrderRepository.delete(order);
        }
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = StockFlowServiceImpl.CACHE_NAME, allEntries = true)
    })
    @Transactional(rollbackFor = Exception.class)
    synchronized public void fetchStocks(CustomerOrder order) {
        if (order.getOrderStatus() != OrderStatus.INIT) {
            throw new BadRequestException("订单已经匹配出货，请勿重复匹配!");
        }
        List<CustomerOrderItem> orderItems = order.getCustomerOrderItems();
        List<CustomerOrderStock> orderStocks = order.getCustomerOrderStocks();
        if (orderItems.isEmpty() && orderStocks.isEmpty()) {
            throw new BadRequestException("无效订单，订单没有指定出库商品");
        }

        Boolean isOrderItemsSatisfied = true;
        Boolean isOrderStocksSatisfied = true;
        JwtUser user = (JwtUser) getUserDetails();
        for (CustomerOrderItem orderItem : orderItems) {
            // 因基础数据不一致，目前暂时不计算规格匹配，否则无法匹配出库
            isOrderItemsSatisfied = stockService.reduceForOrderItem(new ReduceForOrderItemDTO(orderItem, order.getExpireDateMin(), order.getExpireDateMax(), order.getTargetWareZones(), order.getFetchAll(), user, order.getOwner().getId(), order.getUsePackCount(), order.getDescription())) && isOrderItemsSatisfied;
        }
        for (CustomerOrderStock stockItem : orderStocks) {
            isOrderStocksSatisfied = stockService.reduceForOrderStock(new ReduceForOrderStockDTO(stockItem, order.getFetchAll(), user, order.getDescription())) && isOrderStocksSatisfied;
        }

        BigDecimal totalPrice = BigDecimal.ZERO;
        for (CustomerOrderItem item : orderItems) {
            if (item.getPrice() != null && item.getQuantity() != null) {
                BigDecimal itemTotalPrice = item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity().intValue()));
                totalPrice = totalPrice.add(itemTotalPrice);
            }
        }
        for (CustomerOrderStock item : orderStocks) {
            if (item.getPrice() != null && item.getQuantity() != null) {
                BigDecimal itemTotalPrice = item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity().intValue()));
                totalPrice = totalPrice.add(itemTotalPrice);
            }
        }

        if (totalPrice == null) {
            totalPrice = BigDecimal.ZERO;
        }
        order.setTotalPrice(totalPrice);
        Boolean isFinalSatisfied = isOrderItemsSatisfied && isOrderStocksSatisfied;
        order.setIsSatisfied(isFinalSatisfied);
        order.setOrderStatus(OrderStatus.FETCH_STOCK);
        customerOrderRepository.save(order);
        operateSnapshotService.create(OrderStatus.FETCH_STOCK.getName(), user.getUsername(), order);

        if (!isFinalSatisfied && order.getFetchAll()) {
            returnStock(order);
        }
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    synchronized public void gatherGoods(CustomerOrder order) {
        if (order.getOrderStatus() == OrderStatus.FETCH_STOCK) {
            order.setOrderStatus(OrderStatus.GATHERING_GOODS);
            order.setUserGathering(userRepository.findByUsername(getUserDetails().getUsername()));
            customerOrderRepository.save(order);
            operateSnapshotService.create(OrderStatus.GATHERING_GOODS.getName(), order);
        } else {
            throw new BadRequestException("订单状态错误");
        }
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    synchronized public void gatherGoods(Long id) {
        gatherGoods(getCustomerOrder(id));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    synchronized public void unGatherGoods(CustomerOrder order) {
        if (order.getOrderStatus() == OrderStatus.GATHERING_GOODS) {
            order.setOrderStatus(OrderStatus.FETCH_STOCK);
            order.setUserGathering(null);
            customerOrderRepository.save(order);
            operateSnapshotService.create("取消分拣", order);
        } else {
            throw new BadRequestException("订单状态错误");
        }
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    synchronized public void unGatherGoods(Long id) {
        unGatherGoods(getCustomerOrder(id));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    synchronized public void completeGatherGoods(Long id) {
        CustomerOrder order = getCustomerOrder(id);
        if (order.getOrderStatus() == OrderStatus.GATHERING_GOODS) {
            JwtUser user = (JwtUser) getUserDetails();
            if (user.getId().equals(order.getUserGathering().getId())) {
                order.setOrderStatus(OrderStatus.GATHER_GOODS);
                customerOrderRepository.save(order);
                operateSnapshotService.create(OrderStatus.GATHER_GOODS.getName(), order);
            } else {
                throw new BadRequestException("确认分拣与开始分拣必须是同一人");
            }
        } else {
            throw new BadRequestException("订单状态错误");
        }
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    synchronized public void unCompleteGatherGoods(CustomerOrder order) {
        // 此处直接跳过正在分拣，回到订单匹配的状态
        if (order.getOrderStatus() == OrderStatus.GATHER_GOODS) {
            order.setOrderStatus(OrderStatus.FETCH_STOCK);
            order.setUserGathering(null);
            customerOrderRepository.save(order);
            operateSnapshotService.create("取消分拣", order);
        } else {
            throw new BadRequestException("订单状态错误");
        }
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    public void unCompleteGatherGoods(Long id) {
        unCompleteGatherGoods(getCustomerOrder(id));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    synchronized public void confirm(CustomerOrder order) {
        if (order.getOrderStatus() == OrderStatus.GATHER_GOODS) {
            order.setOrderStatus(OrderStatus.CONFIRM);
            customerOrderRepository.save(order);
            operateSnapshotService.create(OrderStatus.CONFIRM.getName(), order);
        } else {
            throw new BadRequestException("订单状态错误");
        }
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    synchronized public void confirm(Long id) {
        confirm(getCustomerOrder(id));
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = PackServiceImpl.CACHE_NAME, allEntries = true)
    })
    @Transactional(rollbackFor = Exception.class)
    synchronized public void complete(CustomerOrderCompleteDTO customerOrderCompleteDTO) {
        Optional<CustomerOrder> orderOptional = customerOrderRepository.findById(customerOrderCompleteDTO.getId());
        if (!orderOptional.isPresent()) {
            throw new BadRequestException("该订单不存在，请复查ID");
        }
        CustomerOrder order = orderOptional.get();
        if (!order.getOrderStatus().equals(OrderStatus.CLIENT_SIGNED)) {
            throw new BadRequestException("只能操作用户签收状态下的订单");
        }
        order.setCompletePrice(customerOrderCompleteDTO.getCompletePrice());
        order.setCompleteDescription(customerOrderCompleteDTO.getCompleteDescription());
        order.setOrderStatus(OrderStatus.COMPLETE);
        order.setReceiveType(customerOrderCompleteDTO.getReceiveType());
        order = customerOrderRepository.save(order);
        operateSnapshotService.create(OrderStatus.COMPLETE.getName(), order);
        updatePackReceiveType(order);
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = PackServiceImpl.CACHE_NAME, allEntries = true)
    })
    @Transactional(rollbackFor = Exception.class)
    synchronized public void updateComplete(CustomerOrderCompleteDTO customerOrderCompleteDTO) {
        Optional<CustomerOrder> orderOptional = customerOrderRepository.findById(customerOrderCompleteDTO.getId());
        if (!orderOptional.isPresent()) {
            throw new BadRequestException("该订单不存在，请复查ID");
        }
        CustomerOrder order = orderOptional.get();
        if (!order.getOrderStatus().equals(OrderStatus.COMPLETE)) {
            throw new BadRequestException("只能操作回执完成状态下的订单");
        }
        order.setCompletePrice(customerOrderCompleteDTO.getCompletePrice());
        order.setReceiveType(customerOrderCompleteDTO.getReceiveType());
        order.setCompleteDescription(customerOrderCompleteDTO.getCompleteDescription());
        order = customerOrderRepository.save(order);
        operateSnapshotService.create("更新回执信息", order);
        updatePackReceiveType(order);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    synchronized public void unConfirm(CustomerOrder order) {
        if (order.getOrderStatus() == OrderStatus.CONFIRM) {
            order.setOrderStatus(OrderStatus.GATHER_GOODS);
            customerOrderRepository.save(order);
            operateSnapshotService.create("取消确认", order);
        } else {
            throw new BadRequestException("订单状态错误");
        }
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    synchronized public void unConfirm(Long id) {
        unConfirm(getCustomerOrder(id));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    synchronized public void cancel(CustomerOrder order, String cancelDescription) {
        // 只能取消未打包状态下的订单
        if (order.getOrderStatus().getIndex() < OrderStatus.PACKAGE.getIndex()) {
            returnStockAndSaveOperateSnapshot(order, OrderStatus.CANCEL, OrderStatus.CANCEL.getName(), cancelDescription);
            stockFlowRepository.deleteAllByCustomerOrderId(order.getId());
        } else {
            throw new BadRequestException("订单状态错误");
        }
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    @Transactional(rollbackFor = Exception.class)
    synchronized public void cancel(Long id, String description) {
        cancel(getCustomerOrder(id), description);
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = StockFlowServiceImpl.CACHE_NAME, allEntries = true)
    })
    @Transactional(rollbackFor = Exception.class)
    synchronized public void returnStock(CustomerOrder order) {
        if (order.getOrderStatus() == OrderStatus.FETCH_STOCK || order.getOrderStatus() == OrderStatus.GATHER_GOODS || order.getOrderStatus() == OrderStatus.CONFIRM) {
            returnStockAndSaveOperateSnapshot(order, OrderStatus.INIT, "回退商品", null);
            stockFlowRepository.deleteAllByCustomerOrderId(order.getId());
            List<CustomerOrderItem> orderItems = order.getCustomerOrderItems();
            List<CustomerOrderStock> orderStocks = order.getCustomerOrderStocks();
            orderItems = orderItems.stream().peek(item -> {
                item.setQuantity(null);
            }).collect(Collectors.toList());
            orderStocks = orderStocks.stream().peek(item -> {
                item.setQuantity(null);
            }).collect(Collectors.toList());
            customerOrderItemRepository.saveAll(orderItems);
            customerOrderStockRepository.saveAll(orderStocks);
        } else {
            throw new BadRequestException("订单状态错误");
        }
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = StockFlowServiceImpl.CACHE_NAME, allEntries = true)
    })
    @Transactional(rollbackFor = Exception.class)
    synchronized public void returnStock(Long id) {
        returnStock(getCustomerOrder(id));
    }

    @Override
    @Transactional(readOnly = true)
    @Cacheable(value = CACHE_NAME, key = "'CountByCustomer' + #p0")
    public Integer countByOwnerId(Long id) {
        return customerOrderRepository.countByOwnerId(id);
    }

    @Override
    @Transactional(readOnly = true)
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    public Integer countByCreateTimeBetween(Date startDate, Date endDate) {
        return customerOrderRepository.countByCreateTimeBetween(startDate, endDate);
    }

    @Override
    @Transactional(readOnly = true)
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    public Integer countByOrderStatus(OrderStatus orderStatus) {
        return customerOrderRepository.countByOrderStatus(orderStatus);
    }

    @Override
    @Transactional(readOnly = true)
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    public Integer countByOrderStatusAndUpdateTimeBetween(OrderStatus orderStatus, Date startDate, Date endDate) {
        return customerOrderRepository.countByOrderStatusAndUpdateTimeBetween(orderStatus, startDate, endDate);
    }

    @Override
    @Transactional(readOnly = true)
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    public BigDecimal countTotalPriceByCreateTimeBetween(Date startDate, Date endDate) {
        List<CustomerOrder> orders = customerOrderRepository.findByCreateTimeBetweenAndIsActive(startDate, endDate, true);
        BigDecimal totalPrice = BigDecimal.ZERO;
        for (int i = 0; i < orders.size(); i++) {
            totalPrice = totalPrice.add(orders.get(i).getTotalPrice());
        }
        return totalPrice;
    }

    @Override
    @Transactional(readOnly = true)
    @Cacheable(value = CACHE_NAME, key = "'queryOrderSales:' + #type + ':' + #date")
    public List<OrderSales> queryOrderSales(String type, String date) {
        Date startDate, endDate, calculateDate;
        List<CustomerOrder> orders;
        Integer orderCount, nameCount;
        BigDecimal orderPrice;
        List<OrderSales> orderSales = new ArrayList<>();
        Date queryDate = DateUtil.parseDate(date);
        switch (type) {
            case "today":
                startDate = DateUtil.beginOfDay(queryDate);
                endDate = DateUtil.offsetSecond(DateUtil.endOfDay(queryDate), 1);
                orders = customerOrderRepository.findByCreateTimeBetweenAndIsActive(startDate, endDate, true);
                nameCount = 0;
                while ((calculateDate = DateUtil.offsetHour(startDate, 1)).before(endDate)) {
                    nameCount++;
                    orderCount = 0;
                    orderPrice = BigDecimal.ZERO;
                    for (int i = 0; i < orders.size(); i++) {
                        Date orderCreateTime = orders.get(i).getCreateTime();
                        if (orderCreateTime.after(startDate) && orderCreateTime.before(calculateDate)) {
                            orderCount += 1;
                            orderPrice = orderPrice.add(orders.get(i).getTotalPrice());
                        }
                    }
                    orderSales.add(new OrderSales(nameCount + "点", orderPrice));
                    startDate = calculateDate;
                }
                break;
            case "week":
                startDate = DateUtil.beginOfWeek(queryDate);
                endDate = DateUtil.offsetSecond(DateUtil.endOfWeek(queryDate), 1);
                orders = customerOrderRepository.findByCreateTimeBetweenAndIsActive(startDate, endDate, true);
                while ((calculateDate = DateUtil.offsetDay(startDate, 1)).before(endDate)) {
                    orderCount = 0;
                    orderPrice = BigDecimal.ZERO;
                    for (int i = 0; i < orders.size(); i++) {
                        Date orderCreateTime = orders.get(i).getCreateTime();
                        if (orderCreateTime.after(startDate) && orderCreateTime.before(calculateDate)) {
                            orderCount += 1;
                            orderPrice = orderPrice.add(orders.get(i).getTotalPrice());
                        }
                    }
                    orderSales.add(new OrderSales("星期" + (DateUtil.dayOfWeek(startDate) == 1 ? "日" : (DateUtil.dayOfWeek(startDate) - 1)), orderPrice));
                    startDate = calculateDate;
                }
                break;
            case "month":
                startDate = DateUtil.beginOfMonth(queryDate);
                endDate = DateUtil.offsetSecond(DateUtil.endOfMonth(queryDate), 1);
                orders = customerOrderRepository.findByCreateTimeBetweenAndIsActive(startDate, endDate, true);
                while ((calculateDate = DateUtil.offsetDay(startDate, 1)).before(endDate)) {
                    orderCount = 0;
                    orderPrice = BigDecimal.ZERO;
                    for (int i = 0; i < orders.size(); i++) {
                        Date orderCreateTime = orders.get(i).getCreateTime();
                        if (orderCreateTime.after(startDate) && orderCreateTime.before(calculateDate)) {
                            orderCount += 1;
                            orderPrice = orderPrice.add(orders.get(i).getTotalPrice());
                        }
                    }
                    orderSales.add(new OrderSales(DateUtil.dayOfMonth(startDate) + "日", orderPrice));
                    startDate = calculateDate;
                }
                break;
            case "year":
                startDate = DateUtil.beginOfYear(queryDate);
                endDate = DateUtil.offsetSecond(DateUtil.endOfYear(queryDate), 1);
                orders = customerOrderRepository.findByCreateTimeBetweenAndIsActive(startDate, endDate, true);
                while ((calculateDate = DateUtil.offsetMonth(startDate, 1)).before(endDate)) {
                    orderCount = 0;
                    orderPrice = BigDecimal.ZERO;
                    for (int i = 0; i < orders.size(); i++) {
                        Date orderCreateTime = orders.get(i).getCreateTime();
                        if (orderCreateTime.after(startDate) && orderCreateTime.before(calculateDate)) {
                            orderCount += 1;
                            orderPrice = orderPrice.add(orders.get(i).getTotalPrice());
                        }
                    }
                    orderSales.add(new OrderSales((DateUtil.month(startDate) + 1) + "月", orderPrice));
                    startDate = calculateDate;
                }
                break;
            default:
                return null;
        }
        return orderSales;
    }

    @Override
    @Transactional(readOnly = true)
    synchronized public String getLastAutoIncreaseSn(Long customerId) {
        Optional<CustomerOrder> optionalCustomerOrder = customerOrderRepository.findTopByOwnerIdOrderByIdDesc(customerId);
        if (optionalCustomerOrder.isPresent()) {
            return optionalCustomerOrder.get().getAutoIncreaseSn();
        } else {
            return WmsUtil.ORDER_SN_BASE;
        }
    }

    @Override
    @Transactional(readOnly = true)
    public byte[] exportExcelData(List<CustomerOrderVO> orders) {
        List<CustomerOrderExcelObj> rows = CollUtil.newArrayList();
        for (int i = 0; i < orders.size(); i++) {
            CustomerOrderExcelObj excelObj = new CustomerOrderExcelObj();
            excelObj.setIndex(Long.valueOf(i + 1));
            if (orders.get(i).getIsSatisfied() == null) {
                excelObj.setIsSatisfied("未匹配");
            } else if (orders.get(i).getIsSatisfied()) {
                excelObj.setIsSatisfied("全匹配");
            } else {
                excelObj.setIsSatisfied("部分匹配");
            }
            excelObj.setStatus(orders.get(i).getOrderStatus().getName());
            excelObj.setPrintTitle(orders.get(i).getPrintTitle());
            excelObj.setCustomerName(orders.get(i).getOwner().getName());
            excelObj.setClientName(orders.get(i).getClientName());
            excelObj.setClientAddress(orders.get(i).getClientAddress());
            excelObj.setClientStore(orders.get(i).getClientStore());
            excelObj.setClientOrderSn(orders.get(i).getClientOrderSn());
            excelObj.setClientOrderSn2(orders.get(i).getClientOrderSn2());
            excelObj.setClientOperator(orders.get(i).getClientOperator());
            excelObj.setDescription(orders.get(i).getDescription());
            excelObj.setTotalPrice(orders.get(i).getTotalPrice());
            excelObj.setCreateTime(orders.get(i).getCreateTime());
            excelObj.setSignTime(orders.get(i).getSignTime());
            excelObj.setFlowSn(orders.get(i).getFlowSn());
            excelObj.setAutoIncreaseSn(orders.get(i).getAutoIncreaseSn());
            excelObj.setCancelDescription(orders.get(i).getCancelDescription());
            excelObj.setCompleteDescription(orders.get(i).getCompleteDescription());
            excelObj.setCompletePrice(orders.get(i).getCompletePrice());
            excelObj.setReceiveType(orders.get(i).getReceiveType() != null ? orders.get(i).getReceiveType().getName() : "未知");
            excelObj.setPackTypeName(orders.get(i).getPack() != null ? orders.get(i).getPack().getPackType().getName() : "未打包");
            excelObj.setUserCreatorName(orders.get(i).getUserCreator() != null ? orders.get(i).getUserCreator().getUsername() : "");
            excelObj.setUserGatheringName(orders.get(i).getUserGathering() != null ? orders.get(i).getUserGathering().getUsername() : "");
            excelObj.setUserSendingName(orders.get(i).getUserSending() != null ? orders.get(i).getUserSending().getUsername() : "");
            rows.add(excelObj);
        }

        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
        ExcelWriter writer = ExcelUtil.getBigWriter();
        writer.addHeaderAlias("index", "#");
        writer.addHeaderAlias("isSatisfied", "是否全匹配");
        writer.addHeaderAlias("status", "订单状态");
        writer.addHeaderAlias("printTitle", "打印标题");
        writer.addHeaderAlias("customerName", "客户名称");
        writer.addHeaderAlias("clientName", "订单客户名");
        writer.addHeaderAlias("clientAddress", "订单客户地址");
        writer.addHeaderAlias("clientStore", "订单客户门店");
        writer.addHeaderAlias("clientOrderSn", "客户订单号");
        writer.addHeaderAlias("clientOrderSn2", "客户单据号");
        writer.addHeaderAlias("clientOperator", "客户订单操作员");
        writer.addHeaderAlias("autoIncreaseSn", "自定递增号");
        writer.addHeaderAlias("flowSn", "流水号");
        writer.addHeaderAlias("description", "备注");
        writer.addHeaderAlias("createTime", "创建日期");
        writer.addHeaderAlias("signTime", "签收日期");
        writer.addHeaderAlias("totalPrice", "订单总价");
        writer.addHeaderAlias("completePrice", "订单回执金额");
        writer.addHeaderAlias("packTypeName", "订单打包类型");
        writer.addHeaderAlias("userCreatorName", "制单人");
        writer.addHeaderAlias("userGatheringName", "拣货人");
        writer.addHeaderAlias("userSendingName", "派送人");
        writer.addHeaderAlias("completeDescription", "订单完成说明");
        writer.addHeaderAlias("cancelDescription", "订单取消说明");
        writer.addHeaderAlias("receiveType", "签收类型");
        writer.write(rows, true);
        writer.flush(outByteStream);
        writer.close();
        return outByteStream.toByteArray();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    synchronized public MultiOperateResult importKingdee(CustomerOrderImporterDTO customerOrderImporterDTO) {
        MultiOperateResult result = new MultiOperateResult();
        String path = FileUtil.getUploadPath(uploadPath);
        Long[] wareZones = customerOrderImporterDTO.getWareZone();
        String targetWareZone = (wareZones != null && wareZones.length > 0) ? StringUtils.join(wareZones, ",") : null;
        Arrays.asList(customerOrderImporterDTO.getUploadFileList()).forEach(file -> {
            String fileName = path + file;
            MultiOperateResult innerResult = importByFile(
                    customerOrderImporterDTO.getCustomer(),
                    fileName,
                    OrderImportType.KINGDEE,
                    targetWareZone,
                    customerOrderImporterDTO.getUseNewAutoIncreaseSn(),
                    customerOrderImporterDTO.getFetchStocks(),
                    customerOrderImporterDTO.getOrderExpireDateMin(),
                    customerOrderImporterDTO.getOrderExpireDateMax(),
                    customerOrderImporterDTO.getFetchAll());
            result.addResult(innerResult);
        });
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    synchronized public MultiOperateResult importKingdee2(CustomerOrderImporterDTO customerOrderImporterDTO) {
        MultiOperateResult result = new MultiOperateResult();
        String path = FileUtil.getUploadPath(uploadPath);
        Long[] wareZones = customerOrderImporterDTO.getWareZone();
        String targetWareZone = (wareZones != null && wareZones.length != 0) ? StringUtils.join(wareZones, ",") : null;
        Arrays.asList(customerOrderImporterDTO.getUploadFileList()).forEach(file -> {
            String fileName = path + file;
            MultiOperateResult innerResult = importByFile(
                    customerOrderImporterDTO.getCustomer(),
                    fileName,
                    OrderImportType.KINGDEE2,
                    targetWareZone,
                    customerOrderImporterDTO.getUseNewAutoIncreaseSn(),
                    customerOrderImporterDTO.getFetchStocks(),
                    customerOrderImporterDTO.getOrderExpireDateMin(),
                    customerOrderImporterDTO.getOrderExpireDateMax(),
                    customerOrderImporterDTO.getFetchAll());
            result.addResult(innerResult);
        });
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    synchronized public MultiOperateResult importGeneral(CustomerOrderImporterDTO customerOrderImporterDTO) {
        MultiOperateResult result = new MultiOperateResult();
        String path = FileUtil.getUploadPath(uploadPath);
        Long[] wareZones = customerOrderImporterDTO.getWareZone();
        String targetWareZone = (wareZones != null && wareZones.length != 0) ? StringUtils.join(wareZones, ",") : null;
        Arrays.asList(customerOrderImporterDTO.getUploadFileList()).forEach(file -> {
            String fileName = path + file;
            MultiOperateResult innerResult = importByFile(
                    customerOrderImporterDTO.getCustomer(),
                    fileName,
                    OrderImportType.GENERAL,
                    targetWareZone,
                    customerOrderImporterDTO.getUseNewAutoIncreaseSn(),
                    customerOrderImporterDTO.getFetchStocks(),
                    customerOrderImporterDTO.getOrderExpireDateMin(),
                    customerOrderImporterDTO.getOrderExpireDateMax(),
                    customerOrderImporterDTO.getFetchAll());
            result.addResult(innerResult);
        });
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    synchronized public MultiOperateResult importHtml(CustomerOrderImporterDTO customerOrderImporterDTO) {
        MultiOperateResult result = new MultiOperateResult();
        String path = FileUtil.getUploadPath(uploadPath);
        String targetWareZone = null;
        if (customerOrderImporterDTO.getWareZone() != null && customerOrderImporterDTO.getWareZone().length > 0) {
            targetWareZone = StringUtils.join(customerOrderImporterDTO.getWareZone(), ",");
        }
        final String targetWareZoneVar = targetWareZone;
        Arrays.asList(customerOrderImporterDTO.getUploadFileList()).stream().forEach(file -> {
            String fileName = path + file;
            MultiOperateResult innerResult = importByFile(
                    customerOrderImporterDTO.getCustomer(),
                    fileName,
                    OrderImportType.HTML,
                    targetWareZoneVar,
                    customerOrderImporterDTO.getUseNewAutoIncreaseSn(),
                    customerOrderImporterDTO.getFetchStocks(),
                    customerOrderImporterDTO.getOrderExpireDateMin(),
                    customerOrderImporterDTO.getOrderExpireDateMax(),
                    customerOrderImporterDTO.getFetchAll());
            result.addResult(innerResult);
        });
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public MultiOperateResult batchFetchStocks(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        Arrays.stream(customerOrderMultipleOperateDTO.getIds()).forEach(id -> {
            Optional<CustomerOrder> optionalCustomerOrder = customerOrderRepository.findById(id);
            if (!optionalCustomerOrder.isPresent()) {
                result.addFailed();
            } else {
                CustomerOrder order = optionalCustomerOrder.get();
                List<CustomerOrderItem> orderItems = customerOrderItemRepository.findAllByCustomerOrderId(id);
                List<CustomerOrderStock> orderStocks = customerOrderStockRepository.findAllByCustomerOrderId(id);
                order.setCustomerOrderItems(orderItems);
                order.setCustomerOrderStocks(orderStocks);
                try {
                    customerOrderService.fetchStocks(order);
                    result.addSucceed();
                } catch (BadRequestException e) {
                    result.addFailed();
                }
            }
        });
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public MultiOperateResult batchCancel(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        Arrays.stream(customerOrderMultipleOperateDTO.getIds()).forEach(id -> {
            Optional<CustomerOrder> optionalCustomerOrder = customerOrderRepository.findById(id);
            if (optionalCustomerOrder.isPresent()) {
                customerOrderService.cancel(optionalCustomerOrder.get(), customerOrderMultipleOperateDTO.getCancelDescription());
                result.addSucceed();
            } else {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public MultiOperateResult batchDelete(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        Arrays.stream(customerOrderMultipleOperateDTO.getIds()).forEach(id -> {
            try {
                customerOrderService.delete(id);
                result.addSucceed();
            } catch (BadRequestException e) {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public MultiOperateResult batchGatherGoods(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        Arrays.stream(customerOrderMultipleOperateDTO.getIds()).forEach(id -> {
            Optional<CustomerOrder> optionalCustomerOrder = customerOrderRepository.findById(id);
            if (optionalCustomerOrder.isPresent()) {
                try {
                    customerOrderService.gatherGoods(optionalCustomerOrder.get());
                    result.addSucceed();
                } catch (BadRequestException e) {
                    result.addFailed();
                }
            } else {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public MultiOperateResult batchUnGatherGoods(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        Arrays.stream(customerOrderMultipleOperateDTO.getIds()).forEach(id -> {
            Optional<CustomerOrder> optionalCustomerOrder = customerOrderRepository.findById(id);
            if (optionalCustomerOrder.isPresent()) {
                try {
                    customerOrderService.unGatherGoods(optionalCustomerOrder.get());
                    result.addSucceed();
                } catch (BadRequestException e) {
                    result.addFailed();
                }
            } else {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public MultiOperateResult batchCompleteGatherGoods(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        Arrays.stream(customerOrderMultipleOperateDTO.getIds()).forEach(id -> {
            try {
                customerOrderService.completeGatherGoods(id);
                result.addSucceed();
            } catch (BadRequestException e) {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public MultiOperateResult batchUnCompleteGatherGoods(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        Arrays.stream(customerOrderMultipleOperateDTO.getIds()).forEach(id -> {
            Optional<CustomerOrder> optionalCustomerOrder = customerOrderRepository.findById(id);
            if (optionalCustomerOrder.isPresent()) {
                try {
                    customerOrderService.unCompleteGatherGoods(optionalCustomerOrder.get());
                    result.addSucceed();
                } catch (BadRequestException e) {
                    result.addFailed();
                }
            } else {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public MultiOperateResult batchConfirm(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        Arrays.stream(customerOrderMultipleOperateDTO.getIds()).forEach(id -> {
            Optional<CustomerOrder> optionalCustomerOrder = customerOrderRepository.findById(id);
            if (optionalCustomerOrder.isPresent()) {
                try {
                    customerOrderService.confirm(optionalCustomerOrder.get());
                    result.addSucceed();
                } catch (BadRequestException e) {
                    result.addFailed();
                }
            } else {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public MultiOperateResult batchUnConfirm(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        Arrays.stream(customerOrderMultipleOperateDTO.getIds()).forEach(id -> {
            Optional<CustomerOrder> optionalCustomerOrder = customerOrderRepository.findById(id);
            if (optionalCustomerOrder.isPresent()) {
                try {
                    customerOrderService.unConfirm(optionalCustomerOrder.get());
                    result.addSucceed();
                } catch (BadRequestException e) {
                    result.addFailed();
                }
            } else {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public MultiOperateResult batchReturnStock(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        Arrays.stream(customerOrderMultipleOperateDTO.getIds()).forEach(id -> {
            Optional<CustomerOrder> optionalCustomerOrder = customerOrderRepository.findById(id);
            if (optionalCustomerOrder.isPresent()) {
                CustomerOrder order = optionalCustomerOrder.get();
                // fix lazy load no session error
                List<CustomerOrderItem> orderItems = customerOrderItemRepository.findAllByCustomerOrderId(order.getId());
                List<CustomerOrderStock> orderStocks = customerOrderStockRepository.findAllByCustomerOrderId(order.getId());
                order.setCustomerOrderItems(orderItems);
                order.setCustomerOrderStocks(orderStocks);
                try {
                    customerOrderService.returnStock(order);
                    result.addSucceed();
                } catch (BadRequestException e) {
                    result.addFailed();
                }
            } else {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    @Transactional(readOnly = true)
    public byte[] batchPrint(String orderIds, Boolean isOriginal) throws IOException {
        String[] ids = orderIds.split(",");
        List<ByteArrayOutputStream> allData = new ArrayList<>();

        for (int i = 0; i < ids.length; i++) {
            Long id = Long.valueOf(ids[i]);
            Optional<CustomerOrder> orderOptional = customerOrderRepository.findById(Long.valueOf(ids[i]));
            if (!orderOptional.isPresent()) {
                throw new BadRequestException("指定的订单ID有错误");
            }
            CustomerOrder order = orderOptional.get();
            if (order.getClientOrderSn() == null) {
                order.setClientOrderSn("未填写");
            }
            if (order.getClientOrderSn2() == null) {
                order.setClientOrderSn2("未填写");
            }
            if (order.getClientAddress() == null) {
                order.setClientAddress("未填写");
            }
            if (order.getClientOperator() == null) {
                order.setClientOperator("未填写");
            }
            ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
            PdfDocument pdfDocument = new PdfDocument(new PdfWriter(outByteStream));
            PdfFont font = PdfFontFactory.createFont(FileUtil.getRootPath() + "/fonts/simsun.ttf", PdfEncodings.IDENTITY_H, true);
            PageXofY event = new PageXofY(pdfDocument, font);
            pdfDocument.addEventHandler(PdfDocumentEvent.END_PAGE, event);
            Document document = new Document(pdfDocument, PageSize.A5.rotate());
            document.setMargins(0, 0, 0, 0);

            Table tableHeader = new Table(6);
            tableHeader.setWidth(UnitValue.createPercentValue(100));
            tableHeader.setFontSize(11f);
            tableHeader.addCell(new Cell(1, 4).add(new Paragraph(order.getPrintTitle() + "销售单").setFont(font).setFontSize(20f)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true).setBorder(Border.NO_BORDER));
            Barcode128 barcode128 = new Barcode128(pdfDocument);
            barcode128.setCode(order.getFlowSn());
            barcode128.setSize(11f);
            tableHeader.addCell(new Cell(1, 2).add(new Image(barcode128.createFormXObject(null, null, pdfDocument)).setHorizontalAlignment(HorizontalAlignment.RIGHT)).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableHeader.addCell(new Cell().add(new Paragraph("购物单位:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableHeader.addCell(new Cell(1, 2).add(new Paragraph(order.getClientName()).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableHeader.addCell(new Cell().add(new Paragraph("门店:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableHeader.addCell(new Cell(1, 2).add(new Paragraph(order.getClientStore()).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableHeader.addCell(new Cell().add(new Paragraph("客户订单号:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableHeader.addCell(new Cell().add(new Paragraph(order.getClientOrderSn()).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableHeader.addCell(new Cell().add(new Paragraph("客户单据号:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableHeader.addCell(new Cell().add(new Paragraph(order.getClientOrderSn2()).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableHeader.addCell(new Cell().add(new Paragraph("制单时间:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableHeader.addCell(new Cell().add(new Paragraph(DateUtil.format(order.getCreateTime(), "yyyy-MM-dd")).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableHeader.addCell(new Cell().add(new Paragraph("客户制单人:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableHeader.addCell(new Cell().add(new Paragraph(order.getClientOperator()).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableHeader.addCell(new Cell().add(new Paragraph("打印时间:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableHeader.addCell(new Cell().add(new Paragraph(DateUtil.format(new Date(), "yyyy-MM-dd")).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableHeader.addCell(new Cell().add(new Paragraph("制单人:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableHeader.addCell(new Cell().add(new Paragraph(order.getUserCreator().getUsername()).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));

            Table table = new Table(printExtraInfo ? 11 : 7);
            table.setWidth(UnitValue.createPercentValue(100));
            table.setFontSize(11f);

            table.addHeaderCell(new Cell(1, 11).add(tableHeader).setBorder(Border.NO_BORDER));

            table.addHeaderCell(new Cell().add(new Paragraph("#").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
            table.addHeaderCell(new Cell().add(new Paragraph("商品条码").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
            table.addHeaderCell(new Cell().add(new Paragraph("商品名称").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
            if (printExtraInfo) {
                table.addHeaderCell(new Cell().add(new Paragraph("质保日期").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true).setWidth(55f));
            }
            table.addHeaderCell(new Cell().add(new Paragraph("规").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
            table.addHeaderCell(new Cell().add(new Paragraph("单").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
            table.addHeaderCell(new Cell().add(new Paragraph("数").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
            if (printExtraInfo) {
                table.addHeaderCell(new Cell().add(new Paragraph("单价").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
                table.addHeaderCell(new Cell().add(new Paragraph("金额").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
            }
            table.addHeaderCell(new Cell().add(new Paragraph("库位").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true).setWidth(40f));
            if (printExtraInfo) {
                table.addHeaderCell(new Cell().add(new Paragraph("拣货").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true).setWidth(40f));
            }

            List<StockFlowDTO> stockFlows = stockFlowService.queryAllByOrderId(id);
            // fix lazy load no session error
            List<CustomerOrderItem> orderItems = customerOrderItemRepository.findAllByCustomerOrderId(order.getId());
            List<CustomerOrderStock> orderStocks = customerOrderStockRepository.findAllByCustomerOrderId(order.getId());

            List<CustomerOrderItem> orderItemsNotSatisfied = orderItems.stream().filter(item -> item.getQuantity() < item.getQuantityInitial()).collect(Collectors.toList());
            List<CustomerOrderStock> orderStocksNotSatisfied = orderStocks.stream().filter(stock -> stock.getQuantity() < stock.getQuantityInitial()).collect(Collectors.toList());

            orderItemsNotSatisfied.forEach(item -> {
                StockFlowDTO stockFlow = new StockFlowDTO();
                stockFlow.setSn(item.getSn());
                stockFlow.setName(item.getName());
                stockFlow.setExpireDate(null);
                stockFlow.setPackCount(item.getPackCount());
                stockFlow.setUnit("");
                // 设置为负数，以便打印时判断
                stockFlow.setQuantity(item.getQuantity() - item.getQuantityInitial());
                stockFlow.setPrice(item.getPrice());
                WareZoneVO wareZone = new WareZoneVO();
                wareZone.setName("");
                WarePositionDTO warePosition = new WarePositionDTO();
                warePosition.setName("");
                warePosition.setWareZone(wareZone);
                stockFlow.setWarePositionOut(warePosition);
                stockFlows.add(stockFlow);
            });

            orderStocksNotSatisfied.forEach(stock -> {
                StockFlowDTO stockFlow = new StockFlowDTO();
                stockFlow.setSn(stock.getGoods().getSn());
                stockFlow.setName(stockFlow.getGoods().getName());
                stockFlow.setExpireDate(stock.getExpireDate());
                stockFlow.setPackCount(stock.getGoods().getPackCount());
                stockFlow.setUnit(stock.getGoods().getUnit());
                // 设置为负数，以便打印时判断
                stockFlow.setQuantity(stock.getQuantity() - stock.getQuantityInitial());
                stockFlow.setPrice(stock.getPrice());
                WareZoneVO wareZone = new WareZoneVO();
                wareZone.setName("");
                WarePositionDTO warePosition = new WarePositionDTO();
                warePosition.setName("");
                warePosition.setWareZone(wareZone);
                stockFlow.setWarePositionOut(warePosition);
                stockFlows.add(stockFlow);
            });

            final List<StockFlowDTO> stockFlowPrint = new ArrayList<>();

            if(isOriginal) {
                AtomicReference<String> sn = new AtomicReference<>();
                orderItems.forEach(item -> {
                    sn.set(null);
                    stockFlows.forEach(stockFlow -> {
                        if (stockFlow.getSn().trim().equals(item.getSn().trim())) {
                            stockFlowPrint.add(stockFlow);
                            sn.set(stockFlow.getSn());
                        }
                    });
                    stockFlows.removeIf(flow -> flow.getSn().trim().equals(sn.toString().trim()));
                });
                orderStocks.forEach(stock -> {
                    sn.set(null);
                    stockFlows.forEach(stockFlow -> {
                        if (stockFlow.getSn().trim().equals(stock.getGoods().getSn().trim())) {
                            stockFlowPrint.add(stockFlow);
                            sn.set(stockFlow.getSn());
                        }
                    });
                    stockFlows.removeIf(flow -> flow.getSn().trim().equals(sn.toString().trim()));
                });
                // 订单应该都排序完毕，出现此错误说明排序算法有问题
                if (!stockFlows.isEmpty()) {
                    throw new BadRequestException("打印订单出错，请联系管理员！");
                }
            } else {
                stockFlowPrint.addAll(stockFlows);
            }

            int allCount = 0;

            for (int j = 0; j < stockFlowPrint.size(); j++) {
                StockFlowDTO stockFlow = stockFlowPrint.get(j);
                table.addCell(new Cell().add(new Paragraph(String.valueOf(j + 1)).setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
                table.addCell(new Cell().add(new Paragraph(stockFlow.getSn()).setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
                table.addCell(new Cell().add(new Paragraph(stockFlow.getName()).setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
                if (printExtraInfo) {
                    table.addCell(new Cell().add(new Paragraph(stockFlow.getExpireDate() != null ? DateUtil.format(stockFlow.getExpireDate(), "yyyy-MM-dd") : "").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
                }
                table.addCell(new Cell().add(new Paragraph(String.valueOf(stockFlow.getPackCount())).setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
                table.addCell(new Cell().add(new Paragraph(stockFlow.getUnit()).setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
                table.addCell(new Cell().add(new Paragraph(String.valueOf(stockFlow.getQuantity() > 0 ? stockFlow.getQuantity() : "")).setFont(font)).setTextAlignment(TextAlignment.RIGHT).setKeepTogether(true));
                if (printExtraInfo) {
                    table.addCell(new Cell().add(new Paragraph(NumberUtil.decimalFormat("###,##0.00", stockFlow.getPrice().doubleValue())).setFont(font)).setTextAlignment(TextAlignment.RIGHT).setKeepTogether(true));
                }
                if (stockFlow.getQuantity() > 0) {
                    allCount += stockFlow.getQuantity();
                    if (printExtraInfo) {
                        table.addCell(new Cell().add(new Paragraph(NumberUtil.decimalFormat("###,##0.00", stockFlow.getPrice().multiply(BigDecimal.valueOf(stockFlow.getQuantity())).doubleValue())).setFont(font)).setTextAlignment(TextAlignment.RIGHT).setKeepTogether(true));
                    }
                    //table.addCell(new Cell().add(new Paragraph(stockFlow.getWarePositionOut().getWareZone().getName() + "/" + stockFlow.getWarePositionOut().getName()).setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
                    table.addCell(new Cell().add(new Paragraph(stockFlow.getWarePositionOut().getName()).setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
                    if (printExtraInfo) {
                        if (stockFlow.getPackCount().equals(0)) {
                            table.addCell(new Cell().add(new Paragraph("").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
                        } else {
                            table.addCell(new Cell().add(new Paragraph(stockFlow.getQuantity() / stockFlow.getPackCount() + "件" + stockFlow.getQuantity() % stockFlow.getPackCount() + "个").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
                        }
                    }
                } else {
                    table.addCell(new Cell(1, printExtraInfo ? 3 : 1).add(new Paragraph("缺少数量：" + (0L - stockFlow.getQuantity())).setFont(font).setFontSize(11f)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));
                }
            }

            if (printExtraInfo) {
                table.addCell(new Cell(1, 9).add(new Paragraph(
                        "合计数量：" + NumberUtil.decimalFormat("###,##0", allCount) + " / 合计金额： " + NumberUtil.decimalFormat("###,##0.00", order.getTotalPrice().doubleValue())).setFont(font).setFontSize(11f)).setTextAlignment(TextAlignment.RIGHT).setKeepTogether(true));
            } else {
                table.addCell(new Cell(1, 6).add(new Paragraph(
                        "合计数量：" + NumberUtil.decimalFormat("###,##0", allCount)).setFont(font).setFontSize(11f)).setTextAlignment(TextAlignment.RIGHT).setKeepTogether(true));
            }
            table.addCell(new Cell(1, printExtraInfo ? 2 : 1).add(new Paragraph("").setFont(font)).setTextAlignment(TextAlignment.CENTER).setKeepTogether(true));

            Table tableFooter = new Table(6);
            tableFooter.setWidth(UnitValue.createPercentValue(100));
            tableFooter.setFontSize(11f);
            tableFooter.addCell(new Cell().add(new Paragraph("拣货人:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableFooter.addCell(new Cell().add(new Paragraph("              ").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableFooter.addCell(new Cell().add(new Paragraph("复核人:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableFooter.addCell(new Cell().add(new Paragraph("              ").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableFooter.addCell(new Cell().add(new Paragraph("收货人:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableFooter.addCell(new Cell().add(new Paragraph("              ").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableFooter.addCell(new Cell().add(new Paragraph("备注:").setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            tableFooter.addCell(new Cell(1, 5).add(new Paragraph(order.getDescription() == null ? "" : order.getDescription()).setFont(font)).setTextAlignment(TextAlignment.LEFT).setKeepTogether(true).setBorder(Border.NO_BORDER));
            table.addFooterCell(new Cell(0, 11).add(tableFooter).setBorder(Border.NO_BORDER));

            document.add(table);
            event.writeTotal(pdfDocument);
            document.close();
            pdfDocument.close();
            allData.add(outByteStream);
        }

        Arrays.asList(ids).forEach(stringId -> {
            Long id = Long.valueOf(stringId);
            Optional<CustomerOrder> optionalCustomerOrder = customerOrderRepository.findById(id);
            if (optionalCustomerOrder.isPresent()) {
                CustomerOrder order = optionalCustomerOrder.get();
                order.setIsPrinted(true);
                customerOrderRepository.save(order);
            }
        });

        ByteArrayOutputStream output = new ByteArrayOutputStream();
        PdfDocument pdfAll = new PdfDocument(new PdfWriter(output));
        PdfMerger merger = new PdfMerger(pdfAll);

        for (int i=0; i<allData.size(); i++) {
            PdfDocument pdf = new PdfDocument(new PdfReader(new ByteArrayInputStream(allData.get(i).toByteArray())));
            merger.merge(pdf, 1, pdf.getNumberOfPages());
            pdf.close();
        }
        pdfAll.close();

        return output.toByteArray();
    }

    private void returnStockAndSaveOperateSnapshot(CustomerOrder order, OrderStatus orderStatus, String operation, String cancelDescription) {
        List<StockFlow> stockFlows = stockFlowRepository.findAllByCustomerOrderIdOrderByWarePositionOut(order.getId());
        JwtUser user = (JwtUser) getUserDetails();
        stockFlows.forEach(stockFlow -> {
            Stock newStock = new Stock();
            newStock.setWarePosition(stockFlow.getWarePositionOut());
            newStock.setGoods(stockFlow.getGoods());
            newStock.setExpireDate(stockFlow.getExpireDate());
            newStock.setQuantity(stockFlow.getQuantity());
            // 设置StockFlowType为null从而不产生流水
            stockService.add(new AddDTO(newStock, null, null, order, user.getUsername(), "", BigDecimal.valueOf(0)));
        });
        order.setOrderStatus(orderStatus);
        order.setIsSatisfied(null);
        if (orderStatus == OrderStatus.CANCEL) {
            order.setIsActive(false);
        }
        order.setTotalPrice(BigDecimal.ZERO);
        if (cancelDescription != null) {
            order.setCancelDescription(cancelDescription);
        }
        customerOrderRepository.save(order);
        operateSnapshotService.create(operation, user.getUsername(), order);
    }

    private List<CustomerOrderItem> getSafeOrderItems(CustomerOrder order) {
        List<CustomerOrderItem> orderItems = order.getCustomerOrderItems();
        if (orderItems == null) {
            orderItems = new ArrayList<>();
        }
        return orderItems;
    }

    private List<CustomerOrderStock> getSafeOrderStocks(CustomerOrder order) {
        List<CustomerOrderStock> orderStocks = order.getCustomerOrderStocks();
        if (orderStocks == null) {
            orderStocks = new ArrayList<>();
        }
        return orderStocks;
    }

    private Map query(Set<CustomerVO> customers, Boolean exportExcel, Boolean isPrintedFilter, String isSatisfiedFilter, String customerFilter, String orderStatusFilter, String receiveTypeFilter, Boolean isActiveFilter, String startDate, String endDate, String search, Pageable pageable) {
        Specification<CustomerOrder> spec = new Specification<CustomerOrder>() {
            @Override
            public Predicate toPredicate(Root<CustomerOrder> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();

                if (isPrintedFilter != null) {
                    predicates.add(criteriaBuilder.equal(root.get("isPrinted").as(Boolean.class), isPrintedFilter));
                }

                if (isSatisfiedFilter != null) {
                    if (StrUtil.equalsIgnoreCase(isSatisfiedFilter, "true")) {
                        predicates.add(criteriaBuilder.isTrue(root.get("isSatisfied")));
                    } else if (StrUtil.equalsIgnoreCase(isSatisfiedFilter, "false")) {
                        predicates.add(criteriaBuilder.isFalse(root.get("isSatisfied")));
                    } else if (StrUtil.equalsIgnoreCase(isSatisfiedFilter, "undefined")) {
                        predicates.add(criteriaBuilder.isNull(root.get("isSatisfied")));
                    }
                }

                if (customerFilter != null && !"".equals(customerFilter)) {
                    String[] customerIds = customerFilter.split(",");
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("owner").get("id"));
                    Arrays.stream(customerIds).forEach(id -> in.value(Long.valueOf(id)));
                    predicates.add(in);
                }

                if (orderStatusFilter != null && !"".equals(orderStatusFilter)) {
                    String[] orderStatus = orderStatusFilter.split(",");
                    CriteriaBuilder.In<Integer> in = criteriaBuilder.in(root.get("orderStatus"));
                    Arrays.stream(orderStatus).forEach(id -> in.value(Integer.parseInt(id)));
                    predicates.add(in);
                }

                if (receiveTypeFilter != null && !"".equals(receiveTypeFilter)) {
                    String[] receiveTypes = receiveTypeFilter.split(",");
                    CriteriaBuilder.In<Integer> in = criteriaBuilder.in(root.get("receiveType"));
                    Arrays.stream(receiveTypes).forEach(id -> in.value(Integer.parseInt(id)));
                    predicates.add(in);
                }

                if (isActiveFilter != null) {
                    predicates.add(criteriaBuilder.equal(root.get("isActive").as(Boolean.class), isActiveFilter));
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

                if (customers != null && !customers.isEmpty()) {
                    List<Long> customerIdList = customers.stream().map(customer -> Long.valueOf(customer.getId())).collect(Collectors.toList());
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("owner").get("id"));
                    customerIdList.forEach(id -> in.value(id));
                    predicates.add(in);
                }

                if (search != null) {
                    predicates.add(criteriaBuilder.or(
                            criteriaBuilder.like(root.get("printTitle").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("clientName").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("clientStore").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("clientAddress").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("clientOrderSn").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("clientOrderSn2").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("clientOperator").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("flowSn").as(String.class), "%" + search + "%"),
                            criteriaBuilder.like(root.get("autoIncreaseSn").as(String.class), "%" + search + "%"),
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

        // 默认按照创建的时间顺序、自定义编号排列
        Sort sort = pageable.getSort()
                .and(new Sort(Sort.Direction.DESC, "id"))
                .and(new Sort(Sort.Direction.DESC, "autoIncreaseSn"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        if (exportExcel) {
            newPageable = PageRequest.of(0, maxCount, sort);
        }
        Page<CustomerOrder> page = customerOrderRepository.findAll(spec, newPageable);
        return PageUtil.toPage(page.map(customerOrderMapper::toVO));
    }

    private MultiOperateResult importByFile(Long customerId, String fileName, OrderImportType orderImportType, String targetWareZone, Boolean useNewAutoIncreaseSn, Boolean fetchStocks, Date expireDateMin, Date expireDateMax, Boolean fetchAll) {
        MultiOperateResult result = new MultiOperateResult();
        switch (orderImportType) {
            case KINGDEE:
                RowHandler KingdeeHandler;
                KingdeeHandler = new KingdeeHandler(result, this, customerService.findCustomerById(customerId), targetWareZone, useNewAutoIncreaseSn, expireDateMin, expireDateMax, fetchAll, fetchStocks, getLastAutoIncreaseSn(customerId));
                WmsUtil.handleExcelFile(fileName, KingdeeHandler);
                break;
            case KINGDEE2:
                RowHandler Kingdee2Handler;
                Kingdee2Handler = new Kingdee2Handler(result, this, customerService.findCustomerById(customerId), targetWareZone, useNewAutoIncreaseSn, expireDateMin, expireDateMax, fetchAll, fetchStocks, getLastAutoIncreaseSn(customerId));
                WmsUtil.handleExcelFile(fileName, Kingdee2Handler);
                break;
            case HTML:
                HtmlHandler htmlHandler = new HtmlHandler(result, this, customerService.findCustomerById(customerId), targetWareZone, useNewAutoIncreaseSn, expireDateMin, expireDateMax, fetchAll, fetchStocks, getLastAutoIncreaseSn(customerId));
                try {
                    htmlHandler.handleHtmlFile(fileName);
                } catch (IOException e) {
                    e.printStackTrace();
                    throw new BadRequestException("文件操作发生错误，请刷新页面重新导入");
                }
                break;
            case GENERAL:
                RowHandler generalHandler;
                generalHandler = new GeneralHandler(result, this, customerService.findCustomerById(customerId), targetWareZone, useNewAutoIncreaseSn, expireDateMin, expireDateMax, fetchAll, fetchStocks, getLastAutoIncreaseSn(customerId));
                WmsUtil.handleExcelFile(fileName, generalHandler);
                break;
            default:
                throw new BadRequestException("参数错误");
        }
        FileUtil.del(fileName);
        return result;
    }

    private CustomerOrder getCustomerOrder(Long id) {
        Optional<CustomerOrder> optionalCustomerOrder = customerOrderRepository.findById(id);
        if (!optionalCustomerOrder.isPresent()) {
            throw new BadRequestException("订单的ID有误");
        }
        return optionalCustomerOrder.get();
    }

    private void updatePackReceiveType(CustomerOrder order) {
        Pack pack = order.getPack();
        List<CustomerOrder> packOrders = pack.getOrders();
        if (packOrders.stream().allMatch(packOrder -> packOrder.getOrderStatus().equals(OrderStatus.COMPLETE))) {
            List<ReceiveType> receiveTypes = packOrders.stream().map(CustomerOrder::getReceiveType).collect(Collectors.toList());
            if (receiveTypes.stream().anyMatch(Objects::isNull)) {
                //throw new BadRequestException("订单参数有误，无法更新打包信息，请确保此订单所在打包里的订单都已经正确回执!");
                //手工修正错误
                packOrders.forEach(innerOrder -> {
                    if (innerOrder.getReceiveType() == null) {
                        innerOrder.setReceiveType(ReceiveType.ALL_SEND);
                        customerOrderRepository.save(innerOrder);
                    }
                });
            }
            ReceiveType packReceiveType;
            if (receiveTypes.stream().allMatch(ReceiveType.ALL_SEND::equals)) {
                packReceiveType = ReceiveType.ALL_SEND;
            } else {
                if (receiveTypes.stream().allMatch(ReceiveType.ALL_REJECT::equals)) {
                    packReceiveType = ReceiveType.ALL_REJECT;
                } else {
                    packReceiveType = ReceiveType.PARTIAL_REJECT;
                }
            }
            pack.setReceiveType(packReceiveType);
            pack.setPackStatus(OrderStatus.COMPLETE);
            pack = packRepository.save(pack);
            operateSnapshotService.create(OrderStatus.COMPLETE.getName(), pack);
        }
    }

    protected static class PageXofY implements IEventHandler {
        protected PdfFormXObject placeholder;
        protected float side = 20;
        protected float x = 570;
        protected float y = 25;
        protected float space = 4.5f;
        protected float descent = 3;
        protected PdfFont font;
        public PageXofY(PdfDocument pdf, PdfFont font) {
            placeholder = new PdfFormXObject(new Rectangle(0, 0, side, side));
            this.font = font;
        }
        @Override
        public void handleEvent(Event event) {
            PdfDocumentEvent docEvent = (PdfDocumentEvent) event;
            PdfDocument pdf = docEvent.getDocument();
            PdfPage page = docEvent.getPage();
            int pageNumber = pdf.getPageNumber(page);
            Rectangle pageSize = page.getPageSize();
            PdfCanvas pdfCanvas = new PdfCanvas(
                    page.getLastContentStream(), page.getResources(), pdf);
            Canvas canvas = new Canvas(pdfCanvas, pdf, pageSize);
            canvas.setFont(font);
            canvas.setFontSize(10);
            Paragraph p = new Paragraph()
                    .add("第").add(String.valueOf(pageNumber)).add("页/总页数");
            canvas.showTextAligned(p, x, y, TextAlignment.RIGHT);
            pdfCanvas.addXObject(placeholder, x + space, y - descent);
            pdfCanvas.release();
        }
        public void writeTotal(PdfDocument pdf) {
            Canvas canvas = new Canvas(placeholder, pdf);
            canvas.setFont(font);
            canvas.setFontSize(10);
            canvas.showTextAligned(String.valueOf(pdf.getNumberOfPages()),
                    0, descent, TextAlignment.LEFT);
        }
    }
}