package org.mstudio.modules.wms.car.service;

import org.mstudio.modules.wms.car.domain.CarCost;
import org.springframework.data.domain.Pageable;


/**
 * lfj
 */

public interface CarCostService {

    CarCost create(CarCost resources);

    CarCost update(Long Id, CarCost resources);

    void delete(Long id);

    Object queryAll(String search, Pageable pageable);

}