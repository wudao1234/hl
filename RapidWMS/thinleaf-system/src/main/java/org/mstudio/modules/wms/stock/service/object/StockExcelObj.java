package org.mstudio.modules.wms.stock.service.object;

import lombok.Data;

/**
 * @author Macrow
 * @date 2019-05-07
 */

@Data
public class StockExcelObj {

    private Long index;

    private String goodsName;

    private String warePositionName;

    private String wareZoneName;

    private String goodsSn;

    private float goodsPrice;

    private String monthsOfWarranty;

    private Integer goodsPackCount;

    private String goodsUnit;

    private String expireDate;

    private Long quantity;

    private String goodsTypeName;

    private String customerName;

    private String isActive;
}
