package org.mstudio.modules.wms.operate_snapshot.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.operate_snapshot.domain.OperateSnapshot;
import org.mstudio.modules.wms.operate_snapshot.service.object.OperateSnapshotDTO;
import org.springframework.stereotype.Component;

/**
* @author Macrow
* @date 2019-02-22
*/

@Component
@Mapper(componentModel = "spring",uses = {},unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface OperateSnapshotMapper extends EntityMapper<OperateSnapshotDTO, OperateSnapshot> {

}