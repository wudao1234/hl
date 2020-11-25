package org.mstudio.modules.wms.stock_flow.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.customer_order.service.object.CustomerOrderVO;
import org.mstudio.modules.wms.goods.service.object.GoodsDTO;
import org.mstudio.modules.wms.receive_goods.service.object.ReceiveGoodsVO;
import org.mstudio.modules.wms.stock_flow.domain.StockFlowType;
import org.mstudio.modules.wms.ware_position.service.object.WarePositionDTO;

import java.math.BigDecimal;
import java.util.Date;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class StockFlowDTO extends BaseObject {

    private StockFlowType flowOperateType;

    private String sn;

    private String name;

    private Long quantity;

    private BigDecimal price;

    private Date expireDate;

    private Integer packCount;

    private String unit;

    private String operator;

    private String description;

    private CustomerOrderVO customerOrder;

    private ReceiveGoodsVO receiveGoods;

    private GoodsDTO goods;

    private WarePositionDTO warePositionIn;

    private WarePositionDTO warePositionOut;

}