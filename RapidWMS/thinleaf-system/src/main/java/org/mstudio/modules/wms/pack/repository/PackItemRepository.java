package org.mstudio.modules.wms.pack.repository;

import org.mstudio.modules.wms.pack.domain.PackItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

/**
 * @author Macrow
 * @date 2019-07-06
 */

public interface PackItemRepository extends JpaRepository<PackItem, Long>, JpaSpecificationExecutor {

    List<PackItem> findAllByPackId(Long id);

}
