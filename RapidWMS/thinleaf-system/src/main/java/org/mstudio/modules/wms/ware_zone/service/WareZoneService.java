package org.mstudio.modules.wms.ware_zone.service;

import org.mstudio.modules.wms.ware_zone.domain.WareZone;
import org.mstudio.modules.wms.ware_zone.service.object.WareZoneDTO;
import org.mstudio.modules.wms.ware_zone.service.object.WareZoneVO;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

/**
* @author Macrow
* @date 2019-02-22
*/

public interface WareZoneService {

    WareZoneVO findById(Long id);

    WareZoneVO create(WareZone resources);

    void update(Long Id, WareZone resources);

    void delete(Long id);

    Map queryAll(Boolean exportExcel, String search, Pageable pageable);

    byte[] exportExcelData(List<WareZoneVO> wareZones);

    List<WareZoneVO> getAllList();

    List<WareZoneDTO> getTree();

    List<WareZoneVO> getListByIds(String[] ids);

}