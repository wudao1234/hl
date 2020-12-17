package org.mstudio.modules.wms.fixed_estate.repository;

import org.mstudio.modules.wms.fixed_estate.domain.FixedEstate;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * 拣配 计件 系数
 * @author lfj
 * @date 2020-12-01
 */

public interface FixedEstateRepository extends JpaRepository<FixedEstate, Long>, JpaSpecificationExecutor {
    Page<FixedEstate> findAllByAssetsNameLike(String name, Pageable pageable);
}