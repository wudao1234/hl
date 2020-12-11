package org.mstudio.modules.wms.ware_position.service;

import org.mstudio.modules.wms.ware_position.domain.WarePosition;
import org.mstudio.modules.wms.ware_position.service.object.WarePositionDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

/**
* @author Macrow
* @date 2019-02-22
*/

public interface WarePositionService {

    WarePositionDTO findById(Long id);

    WarePositionDTO create(WarePosition resources);

    void update(Long Id, WarePosition resources);

    void delete(Long id);

    Map queryAll(Boolean exportExcel, String wareZoneFilter, String search, Pageable pageable);

    byte[] exportExcelData(List<WarePositionDTO> warePositions);

    Map spare(String name, Pageable pageable);
}