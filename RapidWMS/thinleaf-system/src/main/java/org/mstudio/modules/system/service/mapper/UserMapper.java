package org.mstudio.modules.system.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.system.service.dto.UserDTO;
import org.mstudio.modules.system.service.dto.UserVO;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 *
 * @date 2018-11-23
 */

@Component
@Mapper(componentModel = "spring",uses = {RoleMapper.class},unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface UserMapper extends EntityMapper<UserDTO, User> {

    UserVO toVO(User user);

    List<UserVO> toVOList(List<User> users);

}
