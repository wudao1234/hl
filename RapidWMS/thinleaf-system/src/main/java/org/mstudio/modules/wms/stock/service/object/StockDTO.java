package org.mstudio.modules.wms.stock.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.goods.service.object.GoodsDTO;
import org.mstudio.modules.wms.ware_position.service.object.WarePositionDTO;

import java.util.Date;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class StockDTO extends BaseObject {

    private WarePositionDTO warePosition;

    private GoodsDTO goods;

    private Date expireDate;

    private Long quantity;

    private Boolean isActive;

    private Double quantityGuarantee;

}