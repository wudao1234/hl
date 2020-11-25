package org.mstudio.modules.wms.operate_snapshot.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class OperateSnapshotVO extends BaseObject {

    private String operation;

    private String operator;

}