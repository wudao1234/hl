package org.mstudio.modules.wms.operate_snapshot.repository;

import org.mstudio.modules.wms.operate_snapshot.domain.OperateSnapshot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
* @author Macrow
* @date 2019-02-22
*/
public interface OperateSnapshotRepository extends JpaRepository<OperateSnapshot, Long>, JpaSpecificationExecutor {
}