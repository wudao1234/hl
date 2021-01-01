package org.mstudio.modules.wms.receive_goods.service.object;

import lombok.Data;
import org.mstudio.modules.system.service.dto.UserDTO;
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
public class ReceiveGoodsItemDTO extends BaseObject {

    private GoodsVO goods;

    private UserDTO unloadUser;

    private UserDTO receiveUser;

    private WarePositionDTO warePosition;

    private Long quantityInitial;

    private Long packagesInitial;

    private Long packages;

    private Long quantity;

    private Long quantityCancelFetch;

    private Date expireDate;

    private BigDecimal price;

    private String description;

}