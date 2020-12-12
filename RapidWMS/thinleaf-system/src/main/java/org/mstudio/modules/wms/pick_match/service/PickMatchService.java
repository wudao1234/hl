package org.mstudio.modules.wms.pick_match.service;

import org.mstudio.modules.wms.dispatch.service.object.StatisticsDTO;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.mstudio.modules.wms.pick_match.domain.PickMatchCoefficient;
import org.springframework.data.domain.Pageable;

import java.util.Map;

/**
 * @author lfj
 */

public interface PickMatchService {

    Map queryAll(Pageable pageable);

    PickMatchCoefficient update(Long id, PickMatchCoefficient resource);

    PickMatchCoefficient findById(Long id);

    void create(Pack pack);

    Map statistics(String startDate, String endDate, String search, Pageable pageable);
}