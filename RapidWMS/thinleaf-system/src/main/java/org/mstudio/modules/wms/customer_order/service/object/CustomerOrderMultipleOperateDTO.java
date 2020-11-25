package org.mstudio.modules.wms.customer_order.service.object;

import lombok.Data;
import org.mstudio.modules.wms.customer_order.domain.ReceiveType;

import java.io.Serializable;

/**
* @author Macrow
* @date 2019-04-11
*/

@Data
public class CustomerOrderMultipleOperateDTO implements Serializable {

    private Long[] ids;

    private String operate;

    private String cancelDescription;

    private ReceiveType receiveType;

}