package org.mstudio.modules.wms.stock_flow.service.object;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author Macrow
 * @date 2019-05-07
 */

@Data
public class OrderStockFlowForOrderExcelObj {

    private Long index;

    private String customerName;

    private String orderFlowSn;

    private String orderClientOrderSn;

    private String orderClientOrderSn2;

    private String autoIncreaseSn;

    private String orderClientName;

    private String orderClientAddress;

    private String orderClientStore;

    private Date createTime;

    private String name;

    private String sn;

    private Long quantity;

    private BigDecimal price;

    private BigDecimal totalPrice;

    private String expireDate;

    private Integer packCount;

    private String unit;

    private String operator;

    private String description;

    private String wareZoneOutName;

    private String warePositionOutName;

}
