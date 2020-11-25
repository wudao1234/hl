package org.mstudio.modules.wms.stock.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrderItem;

import java.util.Date;

/**
 * @author Macrow
 * @date 2020/8/30
 */
@Data
@AllArgsConstructor
@Builder
public class ReduceForOrderItemDTO {
    private CustomerOrderItem orderItem;
    private Date expireDateMin;
    private Date expireDateMax;
    private String targetWareZones;
    private Boolean fetchAll;
    private JwtUser user;
    private Long customerId;
    private Boolean usePackCount;
    private String stockFlowDescription;
}
