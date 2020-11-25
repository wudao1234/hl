package org.mstudio.modules.wms.ware_position.repository;

import org.mstudio.modules.wms.ware_position.domain.WarePosition;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.Optional;

/**
* @author Macrow
* @date 2019-02-22
*/
public interface WarePositionRepository extends JpaRepository<WarePosition, Long>, JpaSpecificationExecutor {

    Optional<WarePosition> findByName(String name);

    Optional<WarePosition> findByNameAndWareZoneId(String name, Long wareZoneId);

    Optional<WarePosition> findByNameAndWareZoneIdAndIdIsNot(String name, Long wareZoneId, Long id);

    Integer countByWareZoneId(Long id);

    @Override
    @EntityGraph(value = "warePosition.all", type = EntityGraph.EntityGraphType.FETCH)
    Page<WarePosition> findAll(Specification spec, Pageable pageable);

}