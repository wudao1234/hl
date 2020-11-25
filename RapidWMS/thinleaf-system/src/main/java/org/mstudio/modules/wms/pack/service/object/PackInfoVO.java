package org.mstudio.modules.wms.pack.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.customer_order.domain.OrderStatus;
import org.mstudio.modules.wms.customer_order.domain.ReceiveType;
import org.mstudio.modules.wms.pack.domain.PackType;

import java.math.BigDecimal;

/**
* @author Macrow
* @date 2019-04-24
*/

@Data
public class PackInfoVO extends BaseObject {

    private PackType packType;

    private OrderStatus packStatus;

    private String flowSn;

    private Integer packages;

    private BigDecimal totalPrice;

    private Boolean isPrinted;

    private String signedPhoto;

    private Boolean isActive;

    private String cancelDescription;

    private String completeDescription;

    private String trackingNumber;

    private String description;

    private Boolean isPackaged;

    private ReceiveType receiveType;

}