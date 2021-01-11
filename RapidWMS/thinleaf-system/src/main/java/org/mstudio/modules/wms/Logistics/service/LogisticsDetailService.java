package org.mstudio.modules.wms.Logistics.service;

import org.mstudio.modules.wms.Logistics.domain.LogisticsDetail;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
* @author Macrow
* @date 2019-07-09
*/

public interface LogisticsDetailService {

    LogisticsDetail findById(Long id);

    LogisticsDetail create(LogisticsDetail resources);

    LogisticsDetail update(Long Id, LogisticsDetail resources);

    void delete(Long id);

    Object queryAll(String search, Pageable pageable);

    List<LogisticsDetail> getAllList();

}