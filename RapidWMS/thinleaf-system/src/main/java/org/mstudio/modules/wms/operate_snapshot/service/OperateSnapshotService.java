package org.mstudio.modules.wms.operate_snapshot.service;

import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.operate_snapshot.service.object.OperateSnapshotDTO;
import org.mstudio.modules.wms.pack.domain.Pack;

/**
* @author Macrow
* @date 2019-02-22
*/

public interface OperateSnapshotService {

    OperateSnapshotDTO findById(Long id);

    OperateSnapshotDTO create(String operation, String operator, CustomerOrder order);

    OperateSnapshotDTO create(String operation, CustomerOrder order);

    OperateSnapshotDTO create(String operation, String operator, Pack pack);

    OperateSnapshotDTO create(String operation, Pack pack);

    void delete(Long id);

}