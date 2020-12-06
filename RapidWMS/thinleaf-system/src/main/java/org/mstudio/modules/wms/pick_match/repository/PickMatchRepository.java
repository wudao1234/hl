package org.mstudio.modules.wms.pick_match.repository;

import org.mstudio.modules.wms.pick_match.domain.PickMatch;
import org.mstudio.modules.wms.pick_match.domain.PickMatchCoefficient;
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

public interface PickMatchRepository extends JpaRepository<PickMatch, Long>, JpaSpecificationExecutor {

}