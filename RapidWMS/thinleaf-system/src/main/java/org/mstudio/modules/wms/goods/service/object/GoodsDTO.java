package org.mstudio.modules.wms.goods.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.goods_type.service.object.GoodsTypeVO;


/**
 * @author Macrow
 * @date 2019-02-22
 */

@Data
public class GoodsDTO extends BaseObject {

    private String name;

    private String description;

    private String sn;

    private Float price;

    private Float returnPrice;

    private String unit;

    private Integer monthsOfWarranty;

    private Integer packCount;

    private GoodsTypeVO goodsType;

    private CustomerVO customer;

    private Long stockCount;

}