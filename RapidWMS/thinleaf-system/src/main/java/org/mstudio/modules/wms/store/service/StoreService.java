package org.mstudio.modules.wms.store.service;

import org.mstudio.modules.wms.store.domain.Store;
import org.mstudio.modules.wms.store.service.object.StoreDTO;
import org.mstudio.modules.wms.store.service.object.StoreVO;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

/**
* @author Macrow
* @date 2019-09-28
*/

public interface StoreService {

    Map queryAll(Boolean exportExcel, String search, Pageable pageable);

    byte[] exportExcelData(List<StoreVO> stores);

    StoreVO create(Store resource);

    StoreVO update(Long id, Store resource);

    void delete(Long id);

    StoreDTO findById(Long id);

    List<StoreVO> getAllList();

}