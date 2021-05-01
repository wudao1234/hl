package org.mstudio.modules.wms.customer_order.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.customer_order.domain.OrderStatus;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class SimpleCustomerOrderVO extends BaseObject {


    private String printTitle;

    private String description;

    private String clientName;

    private String clientStore;

    private String clientAddress;

    private Boolean fetchAll;

    private Date expireDateMin;

    private Date expireDateMax;

    private String clientOrderSn;

    private String clientOrderSn2;

    private String clientOperator;

    private String flowSn;

    private String autoIncreaseSn;

    private BigDecimal totalPriceInitial;

    private BigDecimal totalPrice;

    private OrderStatus orderStatus;

    private Boolean isActive;

    private String cancelDescription;

    private String completeDescription;

    private BigDecimal completePrice;

    private Boolean isSatisfied;

    private Boolean isPrinted;

    private String targetWareZones;

    private Boolean usePackCount;

    private Timestamp signTime;

}