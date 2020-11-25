package org.mstudio.modules.wms.ware_zone.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.ware_zone.domain.WareZone;
import org.mstudio.modules.wms.ware_zone.service.object.WareZoneDTO;
import org.mstudio.modules.wms.ware_zone.service.object.WareZoneVO;
import org.springframework.stereotype.Component;

import java.util.List;

/**
* @author Macrow
* @date 2019-02-22
*/

@Component
@Mapper(componentModel = "spring",uses = {},unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface WareZoneMapper extends EntityMapper<WareZoneDTO, WareZone> {

    WareZoneVO toVO(WareZone wareZone);

    List<WareZoneVO> toVOList(List<WareZone> wareZones);

}