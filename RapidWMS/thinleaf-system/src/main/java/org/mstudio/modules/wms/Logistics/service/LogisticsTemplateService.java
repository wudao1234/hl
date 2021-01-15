package org.mstudio.modules.wms.Logistics.service;

import org.mstudio.modules.wms.Logistics.domain.LogisticsTemplate;
import org.mstudio.modules.wms.Logistics.service.object.LogisticsTemplateDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
* @author Macrow
* @date 2019-07-09
*/

public interface LogisticsTemplateService {

    LogisticsTemplate findById(Long id);

    LogisticsTemplate create(LogisticsTemplate resources);

    LogisticsTemplate update(Long Id, LogisticsTemplate resources);

    void delete(Long id);

    Object queryAll(String search, Pageable pageable);

    List<LogisticsTemplate> getAllList();

    List<LogisticsTemplateDTO> fetchGroupAll();
}