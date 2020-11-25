package org.mstudio.modules.wms.customer_order.service.handler;

import cn.hutool.core.util.StrUtil;
import cn.hutool.poi.excel.sax.handler.RowHandler;
import lombok.extern.slf4j.Slf4j;
import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.common.WmsUtil;
import org.mstudio.modules.wms.customer.domain.Customer;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrderItem;
import org.mstudio.modules.wms.customer_order.domain.OrderStatus;
import org.mstudio.modules.wms.customer_order.service.CustomerOrderService;
import org.mstudio.modules.wms.common.MultiOperateResult;

import java.math.BigDecimal;
import java.util.*;

/**
 * @author Macrow
 * @date 2019-03-26
 */

@Slf4j
public class KingdeeHandler implements RowHandler {

    private MultiOperateResult result;
    private Customer customer;
    private CustomerOrderService orderService;
    private List<CustomerOrderItem> orderItems;
    private CustomerOrder order = null;
    private String type;
    private String targetWareZone;
    private Boolean useNewAutoIncreaseSn;
    private String sn;
    private Date expireDateMin;
    private Date expireDateMax;
    private Boolean fetchAll;
    private Boolean fetchStocks;
    private int itemSortOrder = 1;

    private final static int ORDER_DATE = 5;
    private final static int ORDER_SN = 3;
    private final static int ORDER_SN2 = 2;
    private final static int ORDER_CLIENT_NAME = 0;
    private final static int ORDER_CLIENT_STORE = 1;
    private final static int ORDER_CLIENT_ADDRESS = 1;
    private final static int ORDER_OPERATOR = 4;
    // private final static int ORDER_DESCRIPTION = ?;

    private final static int GOODS_NAME = 10;
    private final static int GOODS_SN = 9;
    private final static int GOODS_PACK_COUNT = 11;
    private final static int GOODS_QUANTITY = 13;
    private final static int GOODS_PRICE = 17;

    public KingdeeHandler(MultiOperateResult result, CustomerOrderService orderService, Customer customer, String targetWareZone, Boolean useNewAutoIncreaseSn, Date expireDateMin, Date expireDateMax, Boolean fetchAll, Boolean fetchStocks, String sn) {
        this.result = result;
        this.customer = customer;
        this.orderService = orderService;
        this.targetWareZone = targetWareZone;
        this.useNewAutoIncreaseSn = useNewAutoIncreaseSn;
        this.type = customer.getShortNameEn();
        this.expireDateMin = expireDateMin;
        this.expireDateMax = expireDateMax;
        this.fetchAll = fetchAll;
        this.fetchStocks = fetchStocks;
        this.sn = sn;
    }

    @Override
    synchronized public void handle(int i, int i1, List<Object> list) {
        //log.info("[{}] [{}] {}", i, i1, list);

        // 第一行
        if (i1 == 0) {
            if (useNewAutoIncreaseSn) {
                sn = WmsUtil.ORDER_SN_START;
            } else {
                sn = orderService.getLastAutoIncreaseSn(customer.getId()).replace(type, "");
            }
            return;
        }
        // 最后一行，保存
        if (list.get(0) != null && list.get(0).toString().contains("合计") || (list.get(ORDER_CLIENT_NAME) == null && list.get(GOODS_NAME) == null)) {
            order.setCustomerOrderItems(orderItems);
            try {
                orderService.create(order, false, fetchStocks);
                result.addSucceed();
            } catch (BadRequestException e) {
                result.addFailed();
            }

            return;
        }

        // 单个订单开始的标志
        if (WmsUtil.isValidDateInKingdeeExcel(list.get(ORDER_DATE))) {
            // 订单循环中，上一个订单保存
            if (order != null) {
                order.setCustomerOrderItems(orderItems);
                try {
                    orderService.create(order, false, fetchStocks);
                    result.addSucceed();
                } catch (BadRequestException e) {
                    result.addFailed();
                }
                itemSortOrder = 1;
            }
            order = new CustomerOrder();
            orderItems = new ArrayList<>();
            order.setOwner(customer);
            order.setUsePackCount(false);
            order.setTargetWareZones(targetWareZone);
            order.setClientOrderSn(list.get(ORDER_SN).toString());
            order.setClientOrderSn2(list.get(ORDER_SN2).toString());
            order.setClientName(list.get(ORDER_CLIENT_NAME).toString());
            order.setClientOperator(list.get(ORDER_OPERATOR) == null ? "" : list.get(ORDER_OPERATOR).toString());
            // order.setDescription(list.get(ORDER_DESCRIPTION).toString());

            // 以下两项信息暂时由订货点名称填入
            order.setClientAddress(list.get(ORDER_CLIENT_ADDRESS) == null ? "" : list.get(ORDER_CLIENT_ADDRESS).toString());
            order.setClientStore(list.get(ORDER_CLIENT_STORE) == null ? "" : list.get(ORDER_CLIENT_STORE).toString());
            order.setExpireDateMin(expireDateMin);
            order.setExpireDateMax(expireDateMax);
            order.setFetchAll(fetchAll);
            order.setFlowSn(WmsUtil.generateSnowFlakeId());
            order.setIsActive(true);
            order.setOrderStatus(OrderStatus.INIT);
            sn = WmsUtil.getNewSn(type, sn, false);
            order.setAutoIncreaseSn(sn);
        }
        // 每单行循环
        CustomerOrderItem orderItem = new CustomerOrderItem();
        orderItem.setSortOrder(itemSortOrder++);
        orderItem.setName(list.get(GOODS_NAME).toString());
        orderItem.setSn(list.get(GOODS_SN).toString());
        orderItem.setPackCount(WmsUtil.getFirstNumbersFromString(list.get(GOODS_PACK_COUNT) == null ? "0" : list.get(GOODS_PACK_COUNT).toString()));
        orderItem.setQuantityInitial(new Long(StrUtil.removeAll(list.get(GOODS_QUANTITY).toString(), ".0")));
        orderItem.setPrice(new BigDecimal(list.get(GOODS_PRICE).toString()));
        orderItems.add(orderItem);
    }

}
