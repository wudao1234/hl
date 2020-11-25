package org.mstudio.modules.system.service.mapper;

import org.mstudio.modules.system.domain.Menu;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.system.service.dto.MenuDTO;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

/**
 *
 * @date 2018-12-17
 */
@Mapper(componentModel = "spring",uses = {},unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface MenuMapper extends EntityMapper<MenuDTO, Menu> {

}
