package org.mstudio.modules.wms.address_area.service;

import org.mstudio.modules.wms.address_area.domain.AddressArea;
import org.mstudio.modules.wms.address_area.service.object.AddressAreaDTO;
import org.mstudio.modules.wms.address_area.service.object.AddressAreaVO;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
* @author Macrow
* @date 2019-07-09
*/

public interface AddressAreaService {

    AddressAreaDTO findById(Long id);

    AddressAreaDTO create(AddressArea resources);

    AddressAreaVO update(Long Id, AddressArea resources);

    void delete(Long id);

    Object queryAll(String search, Pageable pageable);

    List<AddressAreaVO> getAllList();

}