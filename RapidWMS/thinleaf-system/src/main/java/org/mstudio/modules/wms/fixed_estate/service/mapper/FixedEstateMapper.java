package org.mstudio.modules.wms.fixed_estate.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.fixed_estate.domain.FixedEstate;
import org.mstudio.modules.wms.fixed_estate.service.object.FixedEstateDTO;
import org.springframework.stereotype.Component;

/**
* @author Macrow
* @date 2019-07-09
*/

@Component
@Mapper(componentModel = "spring",unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface FixedEstateMapper extends EntityMapper<FixedEstateDTO, FixedEstate> {

}