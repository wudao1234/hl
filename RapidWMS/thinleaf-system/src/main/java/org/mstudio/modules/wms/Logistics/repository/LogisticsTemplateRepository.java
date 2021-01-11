package org.mstudio.modules.wms.Logistics.repository;

import org.mstudio.modules.wms.Logistics.domain.LogisticsTemplate;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * 物流结算明细
 * @author lfj
 * @date 2020-12-01
 */

public interface LogisticsTemplateRepository extends JpaRepository<LogisticsTemplate, Long>, JpaSpecificationExecutor {
    Page<LogisticsTemplate> findAllByNameLike(String name, Pageable pageable);

    LogisticsTemplate findByName(String name);
}