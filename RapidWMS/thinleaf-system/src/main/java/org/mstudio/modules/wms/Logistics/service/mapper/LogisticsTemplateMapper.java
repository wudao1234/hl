package org.mstudio.modules.wms.Logistics.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.Logistics.domain.LogisticsTemplate;
import org.mstudio.modules.wms.Logistics.service.object.LogisticsTemplateDTO;
import org.springframework.stereotype.Component;

/**
* @author Macrow
* @date 2019-07-09
*/

@Component
@Mapper(componentModel = "spring",uses = {},unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface LogisticsTemplateMapper extends EntityMapper<LogisticsTemplateDTO, LogisticsTemplate> {

}