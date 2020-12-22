package org.mstudio.modules.wms.car.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.car.domain.CarCost;
import org.mstudio.modules.wms.car.service.object.CarCostDTO;
import org.springframework.stereotype.Component;

/**
* @author lfj
*/

@Component
@Mapper(componentModel = "spring",unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface CarCostMapper extends EntityMapper<CarCostDTO, CarCost> {

}