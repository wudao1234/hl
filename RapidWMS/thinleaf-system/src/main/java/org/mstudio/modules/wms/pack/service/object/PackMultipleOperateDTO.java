package org.mstudio.modules.wms.pack.service.object;

import lombok.Data;
import org.mstudio.modules.wms.customer_order.domain.ReceiveType;

import java.io.Serializable;

/**
* @author Macrow
* @date 2019-04-11
*/

@Data
public class PackMultipleOperateDTO implements Serializable {

    private Long[] ids;

    private String operate;

    private Long sendingUserId;

    private String cancelDescription;

    private String completeDescription;

    private String[] uploadFileList;

    private ReceiveType receiveType;

}