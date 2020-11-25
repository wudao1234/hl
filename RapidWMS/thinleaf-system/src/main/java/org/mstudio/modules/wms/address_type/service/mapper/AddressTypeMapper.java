package org.mstudio.modules.wms.address_type.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.address_type.domain.AddressType;
import org.mstudio.modules.wms.address_type.service.object.AddressTypeDTO;
import org.mstudio.modules.wms.address_type.service.object.AddressTypeVO;
import org.springframework.stereotype.Component;

import java.util.List;

/**
* @author Macrow
* @date 2019-07-09
*/

@Component
@Mapper(componentModel = "spring",uses = {},unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AddressTypeMapper extends EntityMapper<AddressTypeDTO, AddressType> {

    AddressTypeVO toVO(AddressType goodsType);

    List<AddressTypeVO> toVOList(List<AddressType> goodsTypes);

}