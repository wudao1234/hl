package org.mstudio.modules.wms.goods.service.object;

import lombok.Data;

/**
 * @author Macrow
 * @date 2019-05-08
 */

@Data
public class GoodsExcelObj {

    private Long index;

    private String name;

    private String sn;

    private Float price;

    private Float returnPrice;

    private String unit;

    private String monthsOfWarranty;

    private Integer packCount;

    private String description;

    private String goodsType;

    private String customerName;

    private Long stockCount;

}
