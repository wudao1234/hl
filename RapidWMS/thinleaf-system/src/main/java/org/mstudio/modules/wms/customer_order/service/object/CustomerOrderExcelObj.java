package org.mstudio.modules.wms.customer_order.service.object;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author Macrow
 * @date 2019-04-28
 */

@Data
public class CustomerOrderExcelObj {

    private Long index;

    private String isSatisfied;

    private String status;

    private String printTitle;

    private String customerName;

    private String clientName;

    private String clientAddress;

    private String clientStore;

    private String clientOrderSn;

    private String clientOrderSn2;

    private String clientOperator;

    private String description;

    private BigDecimal totalPrice;

    private Date createTime;

    private Date signTime;

    private String flowSn;

    private String autoIncreaseSn;

    private String cancelDescription;

    private String completeDescription;

    private BigDecimal completePrice;

    private String packTypeName;

    private String userCreatorName;

    private String userGatheringName;

    private String userSendingName;

    private String receiveType;

}
