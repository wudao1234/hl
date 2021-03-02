package org.mstudio.modules.wms.dispatch.service;

import org.mstudio.modules.wms.dispatch.domain.DispatchCoefficient;
import org.mstudio.modules.wms.dispatch.service.object.DispatchPieceDTO;
import org.springframework.data.domain.Pageable;

import java.util.Map;

/**
 * @author lfj
 */

public interface DispatchService {

    Map queryAll(Pageable pageable);

    Map querySysAll(Pageable pageable);

    DispatchCoefficient update(Long id, DispatchCoefficient resource);

    DispatchCoefficient findById(Long id);

    Map statistics(String startDate, String endDate, String search, Pageable pageable);

    Long save();

    DispatchPieceDTO finish(Float mileage, Long dispatchSys);

}