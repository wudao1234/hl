package org.mstudio.modules.wms.dispatch.service.mapper;


import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.dispatch.domain.DispatchPiece;
import org.mstudio.modules.wms.dispatch.service.object.DispatchPieceDTO;
import org.springframework.stereotype.Component;

@Component
@Mapper(componentModel = "spring",uses = {},unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface DispatchPieceMapper extends EntityMapper<DispatchPieceDTO, DispatchPiece> {
}
