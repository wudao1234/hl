package org.mstudio.modules.wms.operate_snapshot.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.customer_order.service.object.CustomerOrderVO;
import org.mstudio.modules.wms.pack.service.object.PackVO;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class OperateSnapshotDTO extends BaseObject {

    private CustomerOrderVO customerOrder;

    private PackVO pack;

    private String operation;

    private String operator;

}