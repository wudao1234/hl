package org.mstudio.modules.wms.dispatch.repository;

import org.mstudio.modules.wms.dispatch.domain.DispatchCoefficient;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * 拣配 计件 系数
 * @author lfj
 * @date 2020-12-01
 */

public interface DispatchCoefficientRepository extends JpaRepository<DispatchCoefficient, Long>, JpaSpecificationExecutor {

    @Override
    Page<DispatchCoefficient> findAll(Specification spec, Pageable pageable);

}