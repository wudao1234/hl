package org.mstudio.modules.wms.address_area.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.address_area.domain.AddressArea;
import org.mstudio.modules.wms.address_area.service.object.AddressAreaDTO;
import org.mstudio.modules.wms.address_area.service.object.AddressAreaVO;
import org.springframework.stereotype.Component;

import java.util.List;

/**
* @author Macrow
* @date 2019-07-09
*/

@Component
@Mapper(componentModel = "spring",uses = {},unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AddressAreaMapper extends EntityMapper<AddressAreaDTO, AddressArea> {

    AddressAreaVO toVO(AddressArea goodsType);

    List<AddressAreaVO> toVOList(List<AddressArea> goodsTypes);

}