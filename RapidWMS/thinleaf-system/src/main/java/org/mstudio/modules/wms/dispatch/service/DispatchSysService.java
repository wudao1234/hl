package org.mstudio.modules.wms.dispatch.service;

import org.mstudio.modules.wms.address_type.domain.AddressType;
import org.mstudio.modules.wms.address_type.service.object.AddressTypeDTO;
import org.mstudio.modules.wms.address_type.service.object.AddressTypeVO;
import org.mstudio.modules.wms.dispatch.domain.DispatchSys;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
* @author Macrow
* @date 2019-07-09
*/

public interface DispatchSysService {

    DispatchSys findById(Long id);

    DispatchSys create(DispatchSys resources);

    DispatchSys update(Long Id, DispatchSys resources);

    void delete(Long id);

    Object queryAll(String search, Pageable pageable);

    List<DispatchSys> getAllList();

}