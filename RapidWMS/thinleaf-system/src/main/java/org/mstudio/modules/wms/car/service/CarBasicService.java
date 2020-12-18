package org.mstudio.modules.wms.car.service;

import org.mstudio.modules.wms.car.domain.CarBasic;
import org.springframework.data.domain.Pageable;


/**
 * lfj
 */

public interface CarBasicService {

    CarBasic create(CarBasic resources);

    CarBasic update(Long Id, CarBasic resources);

    void delete(Long id);

    Object queryAll(String search, Pageable pageable);

}