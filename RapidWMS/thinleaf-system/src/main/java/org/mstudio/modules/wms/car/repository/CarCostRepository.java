package org.mstudio.modules.wms.car.repository;

import org.mstudio.modules.wms.car.domain.CarCost;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * @author lfj
 * @date 2020-12-01
 */

public interface CarCostRepository extends JpaRepository<CarCost, Long>, JpaSpecificationExecutor {
    Page<CarCost> findAllByCarNumLikeOrDriverNameLike(String name, String names, Pageable pageable);
}