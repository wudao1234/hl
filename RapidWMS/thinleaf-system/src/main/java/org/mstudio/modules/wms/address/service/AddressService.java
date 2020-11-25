package org.mstudio.modules.wms.address.service;

import org.mstudio.modules.wms.address.domain.Address;
import org.mstudio.modules.wms.address.service.object.AddressDTO;
import org.mstudio.modules.wms.address.service.object.AddressVO;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

/**
* @author Macrow
* @date 2019-04-24
*/

public interface AddressService {

    Map queryAll(Boolean exportExcel, String addressTypeFilter, String search, Pageable pageable);

    byte[] exportExcelData(List<AddressVO> address);

    AddressVO create(Address resource);

    AddressVO update(Long id, Address resource);

    void delete(Long id);

    AddressDTO findById(Long id);

    List<AddressVO> getAllList();

}