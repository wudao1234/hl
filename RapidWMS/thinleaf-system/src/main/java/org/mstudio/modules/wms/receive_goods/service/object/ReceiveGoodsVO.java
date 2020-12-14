package org.mstudio.modules.wms.receive_goods.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoodsType;

import java.sql.Timestamp;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class ReceiveGoodsVO extends BaseObject {

    private CustomerVO customer;

    private String flowSn;

    private ReceiveGoodsType receiveGoodsType;

    private Boolean isAudited;

    private Boolean isUnload;

    private Timestamp auditTime;

    private String description;

    private String creator;

    private String auditor;

}