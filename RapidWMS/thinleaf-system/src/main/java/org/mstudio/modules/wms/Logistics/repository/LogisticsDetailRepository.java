package org.mstudio.modules.wms.Logistics.repository;

import org.mstudio.modules.wms.Logistics.domain.LogisticsDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * 物流结算明细
 * @author lfj
 * @date 2020-12-01
 */

public interface LogisticsDetailRepository extends JpaRepository<LogisticsDetail, Long>, JpaSpecificationExecutor {
    Page<LogisticsDetail> findAllByNameLike(String name, Pageable pageable);

    LogisticsDetail findByName(String name);
}