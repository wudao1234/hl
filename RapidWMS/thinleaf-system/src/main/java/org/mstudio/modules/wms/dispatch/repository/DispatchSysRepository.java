package org.mstudio.modules.wms.dispatch.repository;

import org.mstudio.modules.wms.address_type.domain.AddressType;
import org.mstudio.modules.wms.dispatch.domain.DispatchCoefficient;
import org.mstudio.modules.wms.dispatch.domain.DispatchSys;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.Optional;

/**
 * 拣配 计件 系数
 * @author lfj
 * @date 2020-12-01
 */

public interface DispatchSysRepository extends JpaRepository<DispatchSys, Long>, JpaSpecificationExecutor {

    Page<DispatchSys> findAllByNameLike(String name, Pageable pageable);

    Optional<DispatchSys> findTopByName(String name);

    DispatchSys findByName(String name);
}