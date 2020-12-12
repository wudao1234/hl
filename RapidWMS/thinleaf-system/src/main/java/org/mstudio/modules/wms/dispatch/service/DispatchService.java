package org.mstudio.modules.wms.dispatch.service;

import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.dispatch.domain.DispatchCoefficient;
import org.mstudio.modules.wms.dispatch.domain.DispatchPiece;
import org.mstudio.modules.wms.dispatch.domain.DispatchSys;
import org.mstudio.modules.wms.dispatch.service.object.StatisticsDTO;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.RequestParam;

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

    DispatchPiece save();

    DispatchPiece finish(Float mileage, DispatchSys dispatchSys);

}