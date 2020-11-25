package org.mstudio.modules.wms.receive_goods.service.object;

import lombok.Data;

/**
 * @author Macrow
 * @date 2019-10-02
 */

@Data
public class ReceiveGoodsExcelObj {

    private Long index;

    private String customerName;

    private String flowSn;

    private String receiveGoodsType;

    private String createTime;

    private String creator;

    private String isAudited;

    private String auditTime;

    private String auditor;

    private String description;

}
