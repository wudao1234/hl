package org.mstudio.modules.wms.customer_order.service.object;

import lombok.Data;
import org.mstudio.modules.wms.customer_order.domain.ReceiveType;

import java.io.Serializable;
import java.math.BigDecimal;

/**
* @author Macrow
* @date 2019-07-05
*/

@Data
public class CustomerOrderCompleteDTO implements Serializable {

    private Long id;

    private BigDecimal completePrice;

    private String completeDescription;

    private ReceiveType receiveType;

}