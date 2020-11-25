package org.mstudio.modules.wms.address_type.service;

import org.mstudio.modules.wms.address_type.domain.AddressType;
import org.mstudio.modules.wms.address_type.service.object.AddressTypeDTO;
import org.mstudio.modules.wms.address_type.service.object.AddressTypeVO;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
* @author Macrow
* @date 2019-07-09
*/

public interface AddressTypeService {

    AddressTypeDTO findById(Long id);

    AddressTypeDTO create(AddressType resources);

    AddressTypeVO update(Long Id, AddressType resources);

    void delete(Long id);

    Object queryAll(String search, Pageable pageable);

    List<AddressTypeVO> getAllList();

}