package org.mstudio.modules.wms.customer_order.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.goods.service.object.GoodsVO;
import org.mstudio.modules.wms.ware_position.service.object.WarePositionDTO;

import java.math.BigDecimal;
import java.util.Date;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class CustomerOrderStockVO extends BaseObject {

    private Integer sortOrder;

    private WarePositionDTO warePosition;

    private GoodsVO goods;

    private Date expireDate;

    private BigDecimal price;

    private Long quantityInitial;

    private Long quantity;

    private String description;

    private Long quantityLeft;

}