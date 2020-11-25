package org.mstudio.modules.wms.customer_order.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

import java.math.BigDecimal;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class CustomerOrderItemVO extends BaseObject {

    private Integer sortOrder;

    private String name;

    private String sn;

    private Integer packCount;

    private BigDecimal price;

    private Long quantityInitial;

    private Long quantity;

    private String description;

    private Long quantityLeft;

}