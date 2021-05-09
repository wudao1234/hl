package org.mstudio.modules.wms.pack.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.itextpdf.barcodes.Barcode128;
import com.itextpdf.io.font.PdfEncodings;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.*;
import com.itextpdf.layout.property.AreaBreakType;
import com.itextpdf.layout.property.HorizontalAlignment;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.layout.property.UnitValue;
import lombok.extern.slf4j.Slf4j;
import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.system.repository.UserRepository;
import org.mstudio.modules.wms.Logistics.domain.LogisticsDetail;
import org.mstudio.modules.wms.Logistics.domain.LogisticsTemplate;
import org.mstudio.modules.wms.Logistics.service.LogisticsDetailService;
import org.mstudio.modules.wms.Logistics.service.object.LogTemTypeEnum;
import org.mstudio.modules.wms.common.MultiOperateResult;
import org.mstudio.modules.wms.common.WmsUtil;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrderPage;
import org.mstudio.modules.wms.customer_order.domain.OrderStatus;
import org.mstudio.modules.wms.customer_order.domain.ReceiveType;
import org.mstudio.modules.wms.customer_order.repository.CustomerOrderPageRepository;
import org.mstudio.modules.wms.customer_order.repository.CustomerOrderRepository;
import org.mstudio.modules.wms.customer_order.service.impl.CustomerOrderServiceImpl;
import org.mstudio.modules.wms.customer_order.service.object.CustomerOrderVO;
import org.mstudio.modules.wms.customer_order.service.object.SimpleCustomerOrderVO;
import org.mstudio.modules.wms.operate_snapshot.repository.OperateSnapshotRepository;
import org.mstudio.modules.wms.operate_snapshot.service.OperateSnapshotService;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.mstudio.modules.wms.pack.domain.PackItem;
import org.mstudio.modules.wms.pack.domain.PackType;
import org.mstudio.modules.wms.pack.repository.PackItemRepository;
import org.mstudio.modules.wms.pack.repository.PackRepository;
import org.mstudio.modules.wms.pack.service.PackService;
import org.mstudio.modules.wms.pack.service.mapper.PackMapper;
import org.mstudio.modules.wms.pack.service.object.PackDTO;
import org.mstudio.modules.wms.pack.service.object.PackExcelObj;
import org.mstudio.modules.wms.pack.service.object.PackMultipleOperateDTO;
import org.mstudio.modules.wms.pack.service.object.PackVO;
import org.mstudio.modules.wms.pick_match.repository.PickMatchRepository;
import org.mstudio.modules.wms.pick_match.service.PickMatchService;
import org.mstudio.modules.wms.stock_flow.domain.StockFlow;
import org.mstudio.modules.wms.stock_flow.repository.StockFlowRepository;
import org.mstudio.modules.wms.stock_flow.service.mapper.StockFlowMapper;
import org.mstudio.modules.wms.stock_flow.service.object.StockFlowVO;
import org.mstudio.utils.FileUtil;
import org.mstudio.utils.PageUtil;
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
import javax.persistence.criteria.Join;
import javax.persistence.criteria.JoinType;
import javax.persistence.criteria.Predicate;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.*;
import java.util.stream.Collectors;

import static org.mstudio.utils.SecurityContextHolder.getUserDetails;

/**
 * @author Macrow
 * @date 2019-04-24
 */

@Slf4j
@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, noRollbackFor = BadRequestException.class)
public class PackServiceImpl implements PackService {

    public static final String CACHE_NAME = "Pack";

    private static final String PACK_SN_PREFIX = "PK";

    @Value("${upload.picture}")
    private String picturePath;

    @Value("${excel.export-max-count}")
    private Integer maxCount;

    @Value("${rapidWMS.logo_name}")
    private String logoName;

    @Autowired
    private PackRepository packRepository;

    @Autowired
    private PackMapper packMapper;

    @Autowired
    private CustomerOrderRepository customerOrderRepository;

    @Autowired
    private OperateSnapshotService operateSnapshotService;

    @Autowired
    private OperateSnapshotRepository operateSnapshotRepository;

    @Autowired
    private PackService packService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PackItemRepository packItemRepository;

    @Autowired
    private StockFlowMapper stockFlowMapper;

    @Autowired
    private StockFlowRepository stockFlowRepository;

    @Autowired
    private PickMatchService pickMatchService;

    @Autowired
    private PickMatchRepository pickMatchRepository;

    @Autowired
    private CustomerOrderPageRepository customerOrderPageRepository;

    @Autowired
    LogisticsDetailService logisticsDetailService;


    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
//    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    public Map queryAll(Boolean exportExcel, Boolean isPrintedFilter, Boolean isPackagedFilter, String customerFilter, String addressTypeFilter, String packTypeFilter, String receiveTypeFilter, String packStatusFilter, String userNameFilter, String startDate, String endDate, String search, String searchAddress, String searchOrderSn, Pageable pageable) {
        Specification<Pack> spec = (root, criteriaQuery, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();

            if (isPrintedFilter != null) {
                predicates.add(criteriaBuilder.equal(root.get("isPrinted").as(Boolean.class), isPrintedFilter));
            }

            if (isPackagedFilter != null) {
                predicates.add(criteriaBuilder.equal(root.get("isPackaged").as(Boolean.class), isPackagedFilter));
            }

            if (customerFilter != null && !"".equals(customerFilter)) {
                String[] customerIds = customerFilter.split(",");
                CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("customer").get("id"));
                Arrays.stream(customerIds).forEach(id -> in.value(Long.valueOf(id)));
                predicates.add(in);
            }

            if (addressTypeFilter != null && !"".equals(addressTypeFilter)) {
                String[] addressTypeIds = addressTypeFilter.split(",");
                CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("address").get("addressType").get("id"));
                Arrays.stream(addressTypeIds).forEach(id -> in.value(Long.valueOf(id)));
                predicates.add(in);
            }

            if (packTypeFilter != null && !"".equals(packTypeFilter)) {
                String[] packType = packTypeFilter.split(",");
                CriteriaBuilder.In<Integer> in = criteriaBuilder.in(root.get("packType"));
                Arrays.stream(packType).forEach(id -> in.value(Integer.parseInt(id)));
                predicates.add(in);
            }

            if (receiveTypeFilter != null && !"".equals(receiveTypeFilter)) {
                String[] receiveType = receiveTypeFilter.split(",");
                CriteriaBuilder.In<Integer> in = criteriaBuilder.in(root.get("receiveType"));
                Arrays.stream(receiveType).forEach(id -> in.value(Integer.parseInt(id)));
                predicates.add(in);
            }

            if (packStatusFilter != null && !"".equals(packStatusFilter)) {
                String[] packStatus = packStatusFilter.split(",");
                CriteriaBuilder.In<Integer> in = criteriaBuilder.in(root.get("packStatus"));
                Arrays.stream(packStatus).forEach(id -> in.value(Integer.parseInt(id)));
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
                        criteriaBuilder.like(root.get("flowSn").as(String.class), "%" + search + "%"),
                        criteriaBuilder.like(root.get("description").as(String.class), "%" + search + "%"),
                        criteriaBuilder.like(root.get("user").get("username").as(String.class), "%" + search + "%")
                ));
            }

            if (searchAddress != null) {
                predicates.add(criteriaBuilder.or(
                        criteriaBuilder.like(root.get("address").get("name").as(String.class), "%" + searchAddress + "%"),
                        criteriaBuilder.like(root.get("address").get("contact").as(String.class), "%" + searchAddress + "%"),
                        criteriaBuilder.like(root.get("address").get("phone").as(String.class), "%" + searchAddress + "%")
                ));
            }

            if (searchOrderSn != null) {
                Join<Pack, CustomerOrderPage> joinOrders = root.joinList("customerOrderPages", JoinType.INNER);
                predicates.add(criteriaBuilder.or(
                        criteriaBuilder.like(joinOrders.get("customerOrder").get("clientOrderSn"), "%" + searchOrderSn + "%"),
                        criteriaBuilder.like(joinOrders.get("customerOrder").get("clientOrderSn2"), "%" + searchOrderSn + "%")
                ));
            }

            if (userNameFilter != null) {
                predicates.add(criteriaBuilder.equal(root.get("user").get("username").as(String.class), userNameFilter));
            }

            if (predicates.size() != 0) {
                Predicate[] p = new Predicate[predicates.size()];
                return criteriaBuilder.and(predicates.toArray(p));
            } else {
                return null;
            }
        };

        // 默认按照创建的时间顺序排列
        Sort sort = pageable.getSort().and(new Sort(Sort.Direction.DESC, "id"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        if (exportExcel) {
            newPageable = PageRequest.of(0, maxCount, sort);
        }
        Page<Pack> page = packRepository.findAll(spec, newPageable);
        return PageUtil.toPage(page.map(packMapper::toVO));
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
//    @Cacheable(value = CACHE_NAME, key = "#p0")
    public PackDTO findById(Long id) {
        Optional<Pack> optionalPack = packRepository.findById(id);
        if (!optionalPack.isPresent()) {
            throw new BadRequestException("打包不存在 ID=" + id);
        }
        Pack p = optionalPack.get();
        PackDTO packDTO = packMapper.toDto(p);
        packDTO.getCustomerOrderPages().forEach(customerOrderPageVO -> {
            Optional<CustomerOrderPage> optional = p.getCustomerOrderPages().stream().filter(
                    innerP -> innerP.getId().equals(Long.valueOf(customerOrderPageVO.getId())))
                    .findFirst();
            if (optional.isPresent()) {
                CustomerOrder customerOrder = optional.get().getCustomerOrder();
                SimpleCustomerOrderVO simpleCustomerOrderVO = new SimpleCustomerOrderVO();
                BeanUtil.copyProperties(customerOrder, simpleCustomerOrderVO);
                customerOrderPageVO.setSimpleCustomerOrder(simpleCustomerOrderVO);
            }
        });
        return packDTO;
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerOrderServiceImpl.CACHE_NAME, allEntries = true)
    })
    synchronized public PackDTO create(Pack resource) {
        // todo 新增打包 server
        resource.setFlowSn(PACK_SN_PREFIX + WmsUtil.generateSnowFlakeId());
        resource.setPackStatus(OrderStatus.PACKAGE);
        resource.setIsPrinted(false);
        resource.setIsPackaged(false);
        resource.setIsActive(true);
        resource.setTotalPrice(resource.getCustomerOrderPages().stream().map(CustomerOrderPage::getTotalPrice).reduce(BigDecimal.ZERO, BigDecimal::add));
        // 检查打包中所有订单的状态是否符合要求
        confirmOrdersStatus(resource.getCustomerOrderPages(), OrderStatus.CONFIRM);
        resource.getCustomerOrderPages().forEach(page -> {
            CustomerOrder o = customerOrderRepository.findByCustomerOrderPagesId(page.getId());
            page.setCustomerOrder(o);
        });
        Pack pack = packRepository.save(resource);
        operateSnapshotService.create(OrderStatus.PACKAGE.getName(), pack);
        List<CustomerOrderPage> pages = attachCustomerOrderPages(pack, resource.getCustomerOrderPages());
        pack.setCustomerOrderPages(pages);
        // 判断 更新CustomerOrder 状态
        updateOrderStatusByPages(pages, OrderStatus.PACKAGE);

        return packMapper.toDto(pack);
    }

    /**
     * 判断 更新CustomerOrder 状态
     *
     * @param pages
     */
    private void updateOrderStatusByPages(List<CustomerOrderPage> pages, OrderStatus status) {
        List<CustomerOrder> orders = new ArrayList<>();
        List<CustomerOrder> finalOrders = orders;
        pages.forEach(p -> {
            CustomerOrder o = customerOrderRepository.findByCustomerOrderPagesId(p.getId());
            finalOrders.add(o);
        });
        orders = orders.stream().distinct().collect(Collectors.toList());
        orders.forEach(o -> {
            boolean b = o.getCustomerOrderPages().stream().anyMatch(p ->
                    status.equals(p.getOrderStatus()));
            o.setOrderStatus(b ? status : o.getOrderStatus());
            if (OrderStatus.CLIENT_SIGNED.equals(status) && b) {
                o.setSignTime(new Timestamp((new Date()).getTime()));

            }
            customerOrderRepository.save(o);
        });
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerOrderServiceImpl.CACHE_NAME, allEntries = true)
    })
    synchronized public PackDTO update(Long id, Pack resource) {
        if (resource.getCustomerOrderPages().isEmpty()) {
            throw new BadRequestException("打包必须包含至少一个订单");
        }
        Optional<Pack> optionalPack = packRepository.findById(id);
        if (!optionalPack.isPresent()) {
            throw new BadRequestException("指定的ID有误");
        }
        Pack pack = optionalPack.get();
        if (!pack.getId().equals(resource.getId())) {
            throw new BadRequestException("指定的ID有误");
        }
        if (pack.getPackStatus() != OrderStatus.PACKAGE) {
            throw new BadRequestException("只能在打包状态下进行修改");
        }

        List<CustomerOrderPage> oldOrders = pack.getCustomerOrderPages();
        List<CustomerOrderPage> newOrders = resource.getCustomerOrderPages();

        List<CustomerOrderPage> detachOrders = oldOrders.stream().filter(
                order -> newOrders.stream().noneMatch(innerOrder -> innerOrder.getId().equals(order.getId()))).collect(Collectors.toList());
        List<CustomerOrderPage> attachOrders = newOrders.stream().filter(
                order -> oldOrders.stream().noneMatch(innerOrder -> innerOrder.getId().equals(order.getId()))).collect(Collectors.toList());

        // 检查打包中所有订单的状态是否符合要求
        confirmOrdersStatus(detachOrders, pack.getPackStatus());
        confirmOrdersStatus(attachOrders, OrderStatus.CONFIRM);

        detachOrders(detachOrders);

        // 修改暂时不考虑改变创建人
        pack.setCustomer(resource.getCustomer());
        pack.setAddress(resource.getAddress());
        pack.setDescription(resource.getDescription());
        pack.setPackages(resource.getPackages());
        pack.setPackType(resource.getPackType());
        pack.setTrackingNumber(resource.getTrackingNumber());
        packItemRepository.deleteAll(pack.getPackItems());
        pack.setPackItems(null);
        pack.setIsPackaged(false);
        packRepository.save(pack);

        operateSnapshotService.create("修改打包", pack);
        attachCustomerOrderPages(pack, attachOrders);

        return packMapper.toDto(pack);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public List<StockFlowVO> getStockFlows(Long id) {
        Optional<Pack> optionalPack = packRepository.findById(id);
        if (!optionalPack.isPresent()) {
            throw new BadRequestException("指定的ID有误");
        }
        List<StockFlow> stockFlows = getStockFLows(optionalPack.get());
        return stockFlowMapper.toVOList(stockFlows);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void sendingByMeAndFlowSn(String flowSn) {
        Long userId = userRepository.findByUsername(getUserDetails().getUsername()).getId();
        Optional<Pack> optionalPack = packRepository.findByFlowSn(flowSn);
        if (!optionalPack.isPresent()) {
            throw new BadRequestException("条码有误，没有找到对应的打包");
        }
        Pack pack = optionalPack.get();
        if (pack.getPackStatus().equals(OrderStatus.SENDING)) {
            throw new BadRequestException("该打包已经被" + pack.getUser().getUsername() + "认领派送");
        }
        if (pack.getPackStatus().equals(OrderStatus.CLIENT_SIGNED)) {
            throw new BadRequestException("该打包已经被" + pack.getUser().getUsername() + "认领派送，并已签收");
        }
        if (pack.getPackStatus().equals(OrderStatus.COMPLETE)) {
            throw new BadRequestException("该打包已经被" + pack.getUser().getUsername() + "认领派送，并已签收，确认回执");
        }
        packService.sending(pack.getId(), userId, true);
    }

    @Override
    @Cacheable(value = CACHE_NAME, key = "'listSendingPacksGroupByUsers'")
    public List<PackVO> listSendingPacksGroupByUsers() {
        List<Pack> packs = packRepository.findByPackStatus(OrderStatus.SENDING);
        packs.sort((a, b) -> {
            return a.getUser().getId().compareTo(b.getUser().getId());
        });
        return packMapper.toVOList(packs);
    }

    @Override
    @Cacheable(value = CACHE_NAME, key = "'listSendingPacksByUserId-' + #p0")
    public List<PackVO> listSendingPacksByUserId(Long id) {
        List<Pack> packs = packRepository.findByPackStatusAndUserId(OrderStatus.SENDING, id);
        return packMapper.toVOList(packs);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public PackDTO packages(Long id, List<PackItem> packItems) {
        Optional<Pack> optionalPack = packRepository.findById(id);
        if (!optionalPack.isPresent()) {
            throw new BadRequestException("指定的ID有误");
        }
        Pack pack = optionalPack.get();
        if (pack.getPackStatus() != OrderStatus.PACKAGE) {
            throw new BadRequestException("只能在打包状态下进行分装");
        }

        List<StockFlow> stockFlowsCopy = new ArrayList<>();
        getStockFLows(pack).forEach(stockFlow -> {
            StockFlow newStockFlow = new StockFlow();
            newStockFlow.setQuantity(stockFlow.getQuantity());
            newStockFlow.setExpireDate(stockFlow.getExpireDate());
            newStockFlow.setSn(stockFlow.getSn());
            stockFlowsCopy.add(newStockFlow);
        });

        final Integer maxNumber = pack.getPackages();
        List<String> allNumber = new ArrayList<>();
        for (int i = 1; i <= maxNumber; i++) {
            allNumber.add(String.valueOf(i));
        }
        packItems = packItems.stream().peek(item -> item.setId(null)).collect(Collectors.toList());
        packItems.forEach(packItem -> {
            allNumber.remove(String.valueOf(packItem.getNumber()));
            if (packItem.getNumber() > maxNumber) {
                throw new BadRequestException("指定打包号大于实际打包数量");
            }
            for (int i = 0; i < stockFlowsCopy.size(); i++) {
                StockFlow stockFlow = stockFlowsCopy.get(i);
                if (stockFlow.getSn().equals(packItem.getSn()) && stockFlow.getExpireDate().equals(packItem.getExpireDate())) {
                    if (packItem.getQuantity() > stockFlow.getQuantity()) {
                        throw new BadRequestException("打包商品数量多于实际出货数量");
                    }
                    if (packItem.getQuantity().equals(stockFlow.getQuantity())) {
                        stockFlowsCopy.remove(i);
                    }
                    if (packItem.getQuantity() < (stockFlow.getQuantity())) {
                        Long quantityLeft = stockFlow.getQuantity() - packItem.getQuantity();
                        stockFlow.setQuantity(quantityLeft);
                        stockFlowsCopy.remove(i);
                        stockFlowsCopy.add(stockFlow);
                    }
                    break;
                }
            }
        });
        if (!allNumber.isEmpty()) {
            String numberString = "";
            for (int i = 0; i < allNumber.size(); i++) {
                numberString += allNumber.get(i) + ",";
            }
            numberString = numberString.substring(0, numberString.length() - 1);
            throw new BadRequestException(numberString + "打包未提供商品数据");
        }
        if (!stockFlowsCopy.isEmpty()) {
            throw new BadRequestException("打包商品数量与实际出货数量不符");
        }

        packItemRepository.deleteAll(pack.getPackItems());
        packItems = packItems.stream().peek(item -> {
            item.setId(null);
            item.setPack(pack);
        }).collect(Collectors.toList());
        packItemRepository.saveAll(packItems);
        pack.setIsPackaged(true);
        pack.setPackItems(packItems);
        packRepository.save(pack);
        operateSnapshotService.create("商品分包", pack);
        return packMapper.toDto(pack);
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerOrderServiceImpl.CACHE_NAME, allEntries = true)
    })
    synchronized public void delete(Long id) {
        Optional<Pack> optionalPack = packRepository.findById(id);
        if (!optionalPack.isPresent()) {
            throw new BadRequestException("打包不存在ID=" + id);
        } else {
            Pack pack = optionalPack.get();
            if (pack.getPackStatus() != OrderStatus.PACKAGE && pack.getPackStatus() != OrderStatus.CANCEL) {
                throw new BadRequestException("只能在打包或者已经作废状态下进行删除");
            } else {
                detachOrders(pack.getCustomerOrderPages());
                pickMatchRepository.deleteAll(pack.getPickMatch());
                operateSnapshotRepository.deleteAll(pack.getOperateSnapshots());
                packItemRepository.deleteAll(pack.getPackItems());
                packRepository.delete(pack);
            }
        }
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerOrderServiceImpl.CACHE_NAME, allEntries = true)
    })
    synchronized public void sending(Long id, Long sendingUserId, Boolean sendingByMe) {
        // todo 派送
        Optional<Pack> optionalPack = packRepository.findById(id);
        Optional<User> optionalUser = userRepository.findById(sendingUserId);
        if (!optionalPack.isPresent()) {
            throw new BadRequestException("打包不存在ID=" + id);
        } else if (!optionalUser.isPresent()) {
            throw new BadRequestException("指定的用户不存在ID=" + sendingUserId);
        } else if (optionalPack.get().getPackStatus() != OrderStatus.PACKAGE) {
            throw new BadRequestException("只能派送整理打包状态下的打包");
        } else {
            Pack pack = optionalPack.get();
            pack.setPackStatus(OrderStatus.SENDING);
            pack.setUser(optionalUser.get());
            pack = packRepository.save(pack);
            String operateName = OrderStatus.SENDING.getName();
            if (!sendingByMe) {
                operateName += "（指定 " + optionalUser.get().getUsername() + " 派送）";
            }
            operateSnapshotService.create(operateName, pack);
            List<CustomerOrderPage> orders = pack.getCustomerOrderPages();
            updateOrderStatus(orders, OrderStatus.SENDING, userRepository.findById(sendingUserId).get());
            // 判断 更新CustomerOrder 状态
            updateOrderStatusByPages(orders, OrderStatus.SENDING);

        }
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerOrderServiceImpl.CACHE_NAME, allEntries = true)
    })
    synchronized public void returnPack(Long id) {
        Optional<Pack> optionalPack = packRepository.findById(id);
        if (!optionalPack.isPresent()) {
            throw new BadRequestException("打包不存在ID=" + id);
        } else if (optionalPack.get().getPackStatus() != OrderStatus.SENDING) {
            throw new BadRequestException("只能回退派送状态下的打包");
        } else {
            Pack pack = optionalPack.get();
            pack.setPackStatus(OrderStatus.PACKAGE);
            pack.setUser(null);
            packRepository.save(pack);
            operateSnapshotService.create("退回重发", pack);
        }
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerOrderServiceImpl.CACHE_NAME, allEntries = true)
    })
    synchronized public void signed(Long id, String signedPhoto) {
        // todo 签收 - APP
        Optional<Pack> optionalPack = packRepository.findById(id);
        if (!optionalPack.isPresent()) {
            throw new BadRequestException("打包不存在ID=" + id);
        } else if (optionalPack.get().getPackStatus() != OrderStatus.SENDING) {
            throw new BadRequestException("只能签收派送状态下的打包");
        } else {
            Pack pack = optionalPack.get();
            pack.setPackStatus(OrderStatus.CLIENT_SIGNED);
            String photoFileUrl = null;
            if (signedPhoto != null) {
                String[] tmp = signedPhoto.split(",");
                photoFileUrl = Arrays.stream(tmp).map(item -> "/" + picturePath + "/" + item).collect(Collectors.joining(","));
            }
            pack.setSignedPhoto(photoFileUrl);
            packRepository.save(pack);
            operateSnapshotService.create(OrderStatus.CLIENT_SIGNED.getName(), pack);
            updateOrderStatus(pack.getCustomerOrderPages(), OrderStatus.CLIENT_SIGNED, null);
            // 判断 更新CustomerOrder 状态
            updateOrderStatusByPages(pack.getCustomerOrderPages(), OrderStatus.CLIENT_SIGNED);

            // 拣配 复核计算
            pickMatchService.create(pack);

            // 物流结算
            if (PackType.TRANSFER.equals(pack.getPackType())) {
                LogisticsDetail ld = new LogisticsDetail();
                LogisticsTemplate lt = pack.getLogisticsTemplate();

                ld.setProvince(pack.getAddress().getName().split("-")[0]);
                ld.setBill(pack.getFlowSn());
                ld.setPiece((float) pack.getPackages());
                ld.setRenew(lt.getRenew());
                ld.setRealityWeight(pack.getRealityWeight());
                ld.setComputeWeight(pack.getWeight());
                ld.setProtectPrice(lt.getProtectPrice());
                if (LogTemTypeEnum.NUM.getIndex() == lt.getType()) {
                    ld.setRenewNum(pack.getPackages() - lt.getFirst());
                } else if (LogTemTypeEnum.WEIGHT.getIndex() == lt.getType()) {
                    ld.setRenewNum(pack.getWeight() - lt.getFirst());
                } else {
                    ld.setRenewNum(pack.getSize() - lt.getFirst());
                }
                ld.setName(lt.getName());
                ld.setFirst(lt.getFirst());
                ld.setFirstPrice(lt.getFirstPrice());
                ld.setRenewPrice(lt.getRenewPrice());
                ld.setAddress(pack.getAddress().getName());
                ld.setCustomer(pack.getCustomer().getName());
                ld.setRemark(pack.getDescription());
                float totalPrice = ld.getFirstPrice() + ld.getProtectPrice();
                if (ld.getRenewNum() > 0) {
                    totalPrice += (ld.getRenewPrice() * ld.getRenewNum() / ld.getRenew());
                }
                ld.setTotalPrice(Math.round(totalPrice));
                logisticsDetailService.create(ld, pack.getLogisticsTemplate().getId());
            }

            // 配送结算

        }
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerOrderServiceImpl.CACHE_NAME, allEntries = true)
    })
    public void complete(Long id, ReceiveType receiveType) {
        Optional<Pack> optionalPack = packRepository.findById(id);
        if (!optionalPack.isPresent()) {
            throw new BadRequestException("打包不存在ID=" + id);
        } else if (optionalPack.get().getPackStatus() != OrderStatus.CLIENT_SIGNED) {
            throw new BadRequestException("只能确认回执已经签收的打包");
        } else {
            Pack pack = optionalPack.get();
            pack.setPackStatus(OrderStatus.COMPLETE);
            pack.setReceiveType(receiveType);
            packRepository.save(pack);
            operateSnapshotService.create(OrderStatus.COMPLETE.getName(), pack);
        }
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerOrderServiceImpl.CACHE_NAME, allEntries = true)
    })
    public void updateComplete(Long id, ReceiveType receiveType) {
        Optional<Pack> optionalPack = packRepository.findById(id);
        if (!optionalPack.isPresent()) {
            throw new BadRequestException("打包不存在ID=" + id);
        } else if (optionalPack.get().getPackStatus() != OrderStatus.COMPLETE) {
            throw new BadRequestException("只能更新确认回执的打包");
        } else {
            Pack pack = optionalPack.get();
            pack.setReceiveType(receiveType);
            packRepository.save(pack);
            operateSnapshotService.create("更新回执", pack);
        }
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerOrderServiceImpl.CACHE_NAME, allEntries = true)
    })
    public void changeSignedPhoto(Long id, String signedPhoto) {
        Optional<Pack> optionalPack = packRepository.findById(id);
        if (!optionalPack.isPresent()) {
            throw new BadRequestException("打包不存在ID=" + id);
        } else if (optionalPack.get().getPackStatus() != OrderStatus.CLIENT_SIGNED || optionalPack.get().getPackStatus() != OrderStatus.COMPLETE) {
            throw new BadRequestException("只能操作已经签收后的打包");
        } else {
            Pack pack = optionalPack.get();
            FileUtil.deletePicture(pack.getSignedPhoto());
            String photoFileUrl = signedPhoto != null ? "/" + picturePath + "/" + signedPhoto : null;
            pack.setSignedPhoto(photoFileUrl);
            packRepository.save(pack);
            operateSnapshotService.create("更新快照", pack);
        }
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerOrderServiceImpl.CACHE_NAME, allEntries = true)
    })
    synchronized public void cancel(Long id, String cancelDescription) {
        Optional<Pack> optionalPack = packRepository.findById(id);
        if (!optionalPack.isPresent()) {
            throw new BadRequestException("打包不存在ID=" + id);
        } else {
            Pack pack = optionalPack.get();
            detachOrders(pack.getCustomerOrderPages());
            pack.setIsActive(false);
            pack.setPackStatus(OrderStatus.CANCEL);
            pack.setCancelDescription(cancelDescription);
            packItemRepository.deleteAll(pack.getPackItems());
            pack.setIsPackaged(false);
            pack.setPackItems(null);
            operateSnapshotService.create("打包作废", pack);
            packRepository.save(pack);
        }
    }

    @Override
    public MultiOperateResult batchDelete(PackMultipleOperateDTO packMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        Arrays.stream(packMultipleOperateDTO.getIds()).forEach(id -> {
            try {
                packService.delete(id);
                result.addSucceed();
            } catch (BadRequestException e) {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    public MultiOperateResult batchCancel(PackMultipleOperateDTO packMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        Arrays.stream(packMultipleOperateDTO.getIds()).forEach(id -> {
            try {
                packService.cancel(id, packMultipleOperateDTO.getCancelDescription());
                result.addSucceed();
            } catch (BadRequestException e) {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    public MultiOperateResult batchSending(PackMultipleOperateDTO packMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        Arrays.stream(packMultipleOperateDTO.getIds()).forEach(id -> {
            try {
                packService.sending(id, packMultipleOperateDTO.getSendingUserId(), false);
                result.addSucceed();
            } catch (BadRequestException e) {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = CustomerOrderServiceImpl.CACHE_NAME, allEntries = true)
    })
    public MultiOperateResult sendingByMe(PackMultipleOperateDTO packMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        Arrays.stream(packMultipleOperateDTO.getIds()).forEach(id -> {
            try {
                packService.sending(id, packMultipleOperateDTO.getSendingUserId(), true);
                result.addSucceed();
            } catch (BadRequestException e) {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    public MultiOperateResult batchReturnPack(PackMultipleOperateDTO packMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        Arrays.stream(packMultipleOperateDTO.getIds()).forEach(id -> {
            try {
                packService.returnPack(id);
                result.addSucceed();
            } catch (BadRequestException e) {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    public MultiOperateResult batchSigned(PackMultipleOperateDTO packMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        String photoURL = packMultipleOperateDTO.getUploadFileList().length > 0 ? String.join(",", packMultipleOperateDTO.getUploadFileList()) : null;
        Arrays.stream(packMultipleOperateDTO.getIds()).forEach(id -> {
            try {
                packService.signed(id, photoURL);
                result.addSucceed();
            } catch (BadRequestException e) {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    public MultiOperateResult batchComplete(PackMultipleOperateDTO packMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        ReceiveType receiveType = packMultipleOperateDTO.getReceiveType();
        Arrays.stream(packMultipleOperateDTO.getIds()).forEach(id -> {
            try {
                packService.complete(id, receiveType);
                result.addSucceed();
            } catch (BadRequestException e) {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    public MultiOperateResult batchUpdateComplete(PackMultipleOperateDTO packMultipleOperateDTO) {
        MultiOperateResult result = new MultiOperateResult();
        ReceiveType receiveType = packMultipleOperateDTO.getReceiveType();
        Arrays.stream(packMultipleOperateDTO.getIds()).forEach(id -> {
            try {
                packService.updateComplete(id, receiveType);
                result.addSucceed();
            } catch (BadRequestException e) {
                result.addFailed();
            }
        });
        return result;
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public byte[] batchPrint(String packIds) throws IOException {
        // todo 打印打包
        String[] ids = packIds.split(",");
        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
        PdfDocument pdfDocument = new PdfDocument(new PdfWriter(outByteStream));
        Document document = new Document(pdfDocument, PageSize.B8.rotate());
        PdfFont font = PdfFontFactory.createFont(FileUtil.getRootPath() + "/fonts/simsun.ttf", PdfEncodings.IDENTITY_H, true);
        document.setMargins(2f, 2f, 2f, 2f);
        for (int i = 0; i < ids.length; i++) {
            PackDTO pack = packService.findById(Long.valueOf(ids[i]));
            int packages = pack.getPackages();
            if (i > 0) {
                document.add(new AreaBreak(AreaBreakType.NEXT_PAGE));
            }
            for (int j = 1; j <= packages; j++) {
                if (j > 1) {
                    document.add(new AreaBreak(AreaBreakType.NEXT_PAGE));
                }
                Table table = new Table(2);
                table.setWidth(UnitValue.createPercentValue(100));
                table.setHeight(UnitValue.createPercentValue(100));
                table.setFontSize(15f);
                table.addCell(new Cell().add(new Paragraph(logoName).setFont(font)).setTextAlignment(TextAlignment.CENTER));
                String text = packages + "-" + j;
                if (j == 1) {
                    text += "（内含单据）";
                }

                table.addCell(new Cell().add(new Paragraph(pack.getAddress().getPhone()).setFont(font)).setTextAlignment(TextAlignment.CENTER).setBold());
                table.addCell(new Cell().add(new Paragraph(text).setFont(font)).setTextAlignment(TextAlignment.CENTER)).setFontSize(10);
                table.addCell(new Cell().add(new Paragraph(pack.getAddress().getName()).setFont(font)).setTextAlignment(TextAlignment.CENTER).setBold());
                Barcode128 barcode128 = new Barcode128(pdfDocument);
                barcode128.setCode(pack.getFlowSn());
                table.addCell(new Cell(1, 2).add(new Image(barcode128.createFormXObject(null, null, pdfDocument)).setHorizontalAlignment(HorizontalAlignment.CENTER)));
                document.add(table);
            }
        }
        document.close();
        pdfDocument.close();
        Arrays.asList(ids).forEach(id -> {
            Optional<Pack> optionalPack = packRepository.findById(Long.valueOf(id));
            if (optionalPack.isPresent()) {
                Pack pack = optionalPack.get();
                pack.setIsPrinted(true);
                packRepository.save(pack);
            }
        });
        return outByteStream.toByteArray();
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public byte[] exportExcelData(List<PackVO> packs) {
        List<PackExcelObj> rows = CollUtil.newArrayList();
        for (int i = 0; i < packs.size(); i++) {
            PackExcelObj excelObj = new PackExcelObj();
            excelObj.setIndex(Long.valueOf(i + 1));
            excelObj.setCustomerName(packs.get(i).getCustomer().getName());
            if (packs.get(i).getAddress() == null) {
                excelObj.setAddressName(" ");
                excelObj.setAddressContact(" ");
                excelObj.setAddressPhone(" ");
            } else {
                excelObj.setAddressName(packs.get(i).getAddress().getName());
                excelObj.setAddressContact(packs.get(i).getAddress().getContact());
                excelObj.setAddressPhone(packs.get(i).getAddress().getPhone());
            }
            excelObj.setPackType(packs.get(i).getPackType().getName());
            excelObj.setSendUserName(packs.get(i).getUser() != null ? packs.get(i).getUser().getUsername() : "未指定");
            excelObj.setPackStatus(packs.get(i).getPackStatus().getName());
            excelObj.setFlowSn(packs.get(i).getFlowSn());
            excelObj.setPackages(packs.get(i).getPackages());
            excelObj.setTotalPrice(packs.get(i).getTotalPrice());
            excelObj.setIsActive(packs.get(i).getIsActive() ? "正常" : "作废");
            excelObj.setDescription(packs.get(i).getDescription());
            excelObj.setReceiveType(packs.get(i).getReceiveType() != null ? packs.get(i).getReceiveType().getName() : "未知");
            List<CustomerOrderVO> orders = packs.get(i).getOrders();
            String clientSn = "";
            String clientSn2 = "";
            String orderCreateTime = "";
            for (int j = 0; j < orders.size(); j++) {
                if (j > 0) {
                    clientSn += " , ";
                    clientSn2 += " , ";
                    orderCreateTime += " , ";
                }
                clientSn += orders.get(j).getClientOrderSn() == null ? "" : orders.get(j).getClientOrderSn();
                clientSn2 += orders.get(j).getClientOrderSn2() == null ? "" : orders.get(j).getClientOrderSn2();
                orderCreateTime += orders.get(j).getCreateTime() == null ? "" : DateUtil.format(orders.get(j).getCreateTime(), "yyyy-MM-dd");
            }
            excelObj.setOrderClientSn(clientSn);
            excelObj.setOrderClientSn2(clientSn2);
            excelObj.setOrderCreateTime(orderCreateTime);

            rows.add(excelObj);
        }

        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
        ExcelWriter writer = ExcelUtil.getBigWriter();
        writer.addHeaderAlias("index", "#");
        writer.addHeaderAlias("customerName", "客户名称");
        writer.addHeaderAlias("addressName", "送货地址");
        writer.addHeaderAlias("addressContact", "联系人");
        writer.addHeaderAlias("addressPhone", "联系电话");
        writer.addHeaderAlias("packType", "打包类型");
        writer.addHeaderAlias("sendUserName", "派送负责人");
        writer.addHeaderAlias("packStatus", "打包状态");
        writer.addHeaderAlias("flowSn", "打包流水号");
        writer.addHeaderAlias("packages", "打包数量");
        writer.addHeaderAlias("totalPrice", "打包总价");
        writer.addHeaderAlias("isActive", "打包状态");
        writer.addHeaderAlias("description", "备注");
        writer.addHeaderAlias("receiveType", "用户签收类型");
        writer.addHeaderAlias("packReceiveType", "打包签收状态");
        writer.addHeaderAlias("orderClientSn", "客户订单号");
        writer.addHeaderAlias("orderClientSn2", "客户单据号");
        writer.addHeaderAlias("orderCreateTime", "订单制单时间");

        writer.write(rows, true);
        writer.flush(outByteStream);
        writer.close();
        return outByteStream.toByteArray();
    }

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    public Integer countByCreateTimeBetween(Date startDate, Date endDate) {
        return packRepository.countByCreateTimeBetween(startDate, endDate);
    }

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    public Integer countDetailByPackStatus(OrderStatus orderStatus) {
        List<Pack> packs = packRepository.findByPackStatus(orderStatus);
        Integer count = 0;
        for (int i = 0; i < packs.size(); i++) {
            count += packs.get(i).getPackages();
        }
        return count;
    }

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    public Integer countByPackStatus(OrderStatus orderStatus) {
        return packRepository.countByPackStatus(orderStatus);
    }

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    public Integer countDetailByCreateTimeBetween(Date startDate, Date endDate) {
        List<Pack> packs = packRepository.findByCreateTimeBetween(startDate, endDate);
        Integer count = 0;
        for (int i = 0; i < packs.size(); i++) {
            count += packs.get(i).getPackages();
        }
        return count;
    }

    private List<CustomerOrder> attachOrders(Pack pack, List<CustomerOrder> orders) {
        orders.forEach(order -> {
            if (!order.getOrderStatus().equals(OrderStatus.CONFIRM)) {
                throw new BadRequestException("打包的订单中，流水号为" + order.getFlowSn() + "的订单已被打包或者没准备好");
            }
//            order.setPack(pack);
            order.setOrderStatus(OrderStatus.PACKAGE);
            operateSnapshotService.create(OrderStatus.PACKAGE.getName(), order);
        });
        return customerOrderRepository.saveAll(orders);
    }

    private List<CustomerOrderPage> attachCustomerOrderPages(Pack pack, List<CustomerOrderPage> pages) {
        pages.forEach(page -> {
            if (!page.getOrderStatus().equals(OrderStatus.CONFIRM)) {
                throw new BadRequestException("打包的订单页中，流水号为" + page.getFlowSn() + "的订单已被打包或者没准备好");
            }
            page.setPack(pack);
            page.setOrderStatus(OrderStatus.PACKAGE);
            operateSnapshotService.create(OrderStatus.PACKAGE.getName(), page.getCustomerOrder());
        });
        return customerOrderPageRepository.saveAll(pages);
    }

    private List<CustomerOrderPage> detachOrders(List<CustomerOrderPage> orders) {
        orders.forEach(order -> {
            if (order.getOrderStatus().getIndex() < OrderStatus.PACKAGE.getIndex()) {
                throw new BadRequestException("打包的订单页中，流水号为" + order.getFlowSn() + "的订单已被取消打包");
            }
            order.setPack(null);
            order.setOrderStatus(OrderStatus.CONFIRM);
            operateSnapshotService.create("取消打包", order.getCustomerOrder());
            order.getCustomerOrder().setOrderStatus(OrderStatus.CONFIRM);
        });
        return customerOrderPageRepository.saveAll(orders);
    }

    private void updateOrderStatus(List<CustomerOrderPage> orders, OrderStatus status, User userSending) {
        orders.forEach(order -> {
            order.setOrderStatus(status);
            if (userSending != null) {
                order.setUserSending(userSending);
            }
            operateSnapshotService.create(status.getName(), order.getCustomerOrder());
        });
        customerOrderPageRepository.saveAll(orders);


    }

    private List<StockFlow> getStockFLows(Pack pack) {
        List<StockFlow> stockFlowsOrigin = new ArrayList<>();
        pack.getCustomerOrderPages().forEach(order -> stockFlowsOrigin.addAll(stockFlowRepository.findAllByCustomerOrderPageIdOrderByWarePositionOut(order.getId())));

        List<StockFlow> stockFlowsResultList = new ArrayList<>();
        stockFlowsOrigin.forEach(stockFlow -> {
            Boolean update = false;
            for (int i = 0; i < stockFlowsResultList.size(); i++) {
                StockFlow stockFlowResult = stockFlowsResultList.get(i);
                if (stockFlowResult.getSn().equals(stockFlow.getSn()) && stockFlowResult.getExpireDate().equals(stockFlow.getExpireDate())) {
                    Long quantityNew = stockFlowResult.getQuantity() + stockFlow.getQuantity();
                    stockFlowResult.setQuantity(quantityNew);
                    stockFlowsResultList.remove(i);
                    stockFlowsResultList.add(i, stockFlowResult);
                    update = true;
                    break;
                }
            }
            if (!update) {
                stockFlowsResultList.add(stockFlow);
            }
        });
        return stockFlowsResultList;
    }

    private void confirmOrdersStatus(List<CustomerOrderPage> orders, OrderStatus status) {
        orders.forEach(order -> {
            Optional<CustomerOrderPage> optionalCustomerOrder = customerOrderPageRepository.findById(order.getId());
            if (optionalCustomerOrder.isPresent()) {
                CustomerOrderPage customerOrder = optionalCustomerOrder.get();
                if (!customerOrder.getOrderStatus().equals(status)) {
                    throw new BadRequestException("打包中订单的状态有误");
                }
            } else {
                throw new BadRequestException("打包中订单的ID有误");
            }
        });
    }

}