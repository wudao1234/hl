package org.mstudio.modules.wms.receive_goods.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoodsPiece;
import org.mstudio.modules.wms.receive_goods.service.object.ReceiveGoodsPieceDTO;
import org.springframework.stereotype.Component;

/**
 * @author Macrow
 * @date 2019-02-22
 */

@Component
@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ReceiveGoodsPieceMapper extends EntityMapper<ReceiveGoodsPieceDTO, ReceiveGoodsPiece> {

}