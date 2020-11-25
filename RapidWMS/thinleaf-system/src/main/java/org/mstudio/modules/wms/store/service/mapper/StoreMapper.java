package org.mstudio.modules.wms.store.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.store.domain.Store;
import org.mstudio.modules.wms.store.service.object.StoreDTO;
import org.mstudio.modules.wms.store.service.object.StoreVO;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author Macrow
 * @date 2019-09-28
 */

@Component
@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface StoreMapper extends EntityMapper<StoreDTO, Store> {

    StoreVO toVO(Store store);

    List<StoreVO> toVOList(List<Store> storeList);

}