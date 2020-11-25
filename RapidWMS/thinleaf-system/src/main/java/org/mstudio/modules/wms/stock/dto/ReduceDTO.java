package org.mstudio.modules.wms.stock.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrderStock;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoodsItem;
import org.mstudio.modules.wms.stock.domain.Stock;
import org.mstudio.modules.wms.stock_flow.domain.StockFlowType;

import java.math.BigDecimal;

/**
 * @author Macrow
 * @date 2020/8/30
 */
@Data
@AllArgsConstructor
@Builder
public class ReduceDTO {
    private Stock resources;
    private StockFlowType stockFlowType;
    private Boolean fetchAll;
    private BigDecimal price;
    private CustomerOrder order;
    private JwtUser user;
    private CustomerOrderStock orderStock;
    private ReceiveGoodsItem receiveGoodsItem;
    private String stockFlowDescription;
}
