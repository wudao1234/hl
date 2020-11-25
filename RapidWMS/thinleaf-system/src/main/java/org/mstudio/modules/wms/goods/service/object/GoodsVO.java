package org.mstudio.modules.wms.goods.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

/**
 * @author Macrow
 * @date 2019-02-22
 */

@Data
public class GoodsVO extends BaseObject {

    private String name;

    private String description;

    private String sn;

    private Integer monthsOfWarranty;

    private Integer packCount;

    private String unit;

    private Float price;

    private Float returnPrice;

}