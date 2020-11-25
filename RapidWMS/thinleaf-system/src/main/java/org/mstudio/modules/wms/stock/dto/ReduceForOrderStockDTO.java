package org.mstudio.modules.wms.stock.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrderStock;

/**
 * @author Macrow
 * @date 2020/8/30
 */
@Data
@AllArgsConstructor
@Builder
public class ReduceForOrderStockDTO {
    private CustomerOrderStock orderStock;
    private Boolean fetchAll;
    private JwtUser user;
    private String description;
}
