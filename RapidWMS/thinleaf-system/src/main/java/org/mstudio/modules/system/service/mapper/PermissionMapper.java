package org.mstudio.modules.system.service.mapper;

import org.mstudio.modules.system.domain.Permission;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.system.service.dto.PermissionDTO;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

/**
 *
 * @date 2018-11-23
 */
@Mapper(componentModel = "spring",unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface PermissionMapper extends EntityMapper<PermissionDTO, Permission> {

}
