package org.mstudio.modules.wms.address.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.address.domain.Address;
import org.mstudio.modules.wms.address.service.object.AddressDTO;
import org.mstudio.modules.wms.address.service.object.AddressVO;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author Macrow
 * @date 2019-04-24
 */

@Component
@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AddressMapper extends EntityMapper<AddressDTO, Address> {

    AddressVO toVO(Address address);

    List<AddressVO> toVOList(List<Address> addressList);

}