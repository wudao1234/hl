package org.mstudio.modules.wms.ware_zone.repository;

import org.mstudio.modules.wms.ware_zone.domain.WareZone;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;
import java.util.Optional;

/**
* @author Macrow
* @date 2019-02-22
*/
public interface WareZoneRepository extends JpaRepository<WareZone, Long>, JpaSpecificationExecutor {

    Optional<WareZone> findByName(String name);

    Optional<WareZone> findByNameAndIdIsNot(String name, Long id);

    List<WareZone> findAllByIdIn(List<Long> ids);

}