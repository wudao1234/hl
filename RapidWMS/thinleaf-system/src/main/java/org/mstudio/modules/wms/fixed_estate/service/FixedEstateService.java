package org.mstudio.modules.wms.fixed_estate.service;

import org.mstudio.modules.wms.fixed_estate.domain.FixedEstate;
import org.springframework.data.domain.Pageable;


/**
* @author Macrow
* @date 2019-07-09
*/

public interface FixedEstateService {

    FixedEstate create(FixedEstate resources);

    FixedEstate update(Long Id, FixedEstate resources);

    void delete(Long id);

    Object queryAll(String search, Pageable pageable);

}