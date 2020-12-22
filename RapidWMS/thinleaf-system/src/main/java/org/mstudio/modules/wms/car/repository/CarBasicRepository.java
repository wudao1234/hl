package org.mstudio.modules.wms.car.repository;

import org.mstudio.modules.wms.car.domain.CarBasic;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * @author lfj
 * @date 2020-12-01
 */

public interface CarBasicRepository extends JpaRepository<CarBasic, Long>, JpaSpecificationExecutor {
    Page<CarBasic> findAllByCarNumLike(String name, Pageable pageable);
}