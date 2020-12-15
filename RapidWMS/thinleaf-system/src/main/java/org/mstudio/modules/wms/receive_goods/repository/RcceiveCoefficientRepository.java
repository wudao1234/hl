package org.mstudio.modules.wms.receive_goods.repository;

import org.mstudio.modules.wms.receive_goods.domain.RcceiveCoefficient;
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

public interface RcceiveCoefficientRepository extends JpaRepository<RcceiveCoefficient, Long>, JpaSpecificationExecutor {

    @Override
    Page<RcceiveCoefficient> findAll(Specification spec, Pageable pageable);

}