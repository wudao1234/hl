package org.mstudio.modules.wms.stock_flow.service.object;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author Macrow
 * @date 2019-05-07
 */

@Data
public class OrderStockFlowExcelObj {

    private Long index;

    private String customerName;

    private Date createTime;

    private String name;

    private String sn;

    private Long quantity;

    private BigDecimal price;

    private String expireDate;

    private Integer packCount;

    private String unit;

    private String operator;

    private String description;

    private String wareZoneInName;

    private String warePositionInName;

    private String wareZoneOutName;

    private String warePositionOutName;

}
