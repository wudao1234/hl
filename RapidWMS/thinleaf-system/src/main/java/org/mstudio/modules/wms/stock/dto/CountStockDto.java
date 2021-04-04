package org.mstudio.modules.wms.stock.dto;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

@Data
public class CountStockDto extends BaseObject {
    private String customerName;

    private String sn;

    private String name;

    private Integer packCount;

    private Long quantity;

    private Long currentQuantity;

    private Integer monthsOfWarranty;

    private String warePositionName;
}
