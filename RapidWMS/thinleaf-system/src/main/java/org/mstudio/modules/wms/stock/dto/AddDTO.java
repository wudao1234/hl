package org.mstudio.modules.wms.stock.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoods;
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
public class AddDTO {
    private Stock resource;
    private StockFlowType stockFlowType;
    private ReceiveGoods receiveGoods;
    private CustomerOrder customerOrder;
    private String userName;
    private String description;
    private BigDecimal price;
}
