package org.mstudio.modules.wms.pack.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.mstudio.modules.wms.pack.service.object.PackDTO;
import org.mstudio.modules.wms.pack.service.object.PackInfoVO;
import org.mstudio.modules.wms.pack.service.object.PackVO;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author Macrow
 * @date 2019-04-24
 */

@Component
@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface PackMapper extends EntityMapper<PackDTO, Pack> {

    PackVO toVO(Pack pack);

    List<PackVO> toVOList(List<Pack> packList);

    PackInfoVO toInfoVO(Pack pack);

    List<PackInfoVO> toInfoVOList(List<Pack> packList);

}