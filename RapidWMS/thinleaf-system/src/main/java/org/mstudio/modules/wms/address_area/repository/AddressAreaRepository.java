package org.mstudio.modules.wms.address_area.repository;

import org.mstudio.modules.wms.address_area.domain.AddressArea;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.Optional;

/**
* @author Macrow
* @date 2019-07-09
*/

public interface AddressAreaRepository extends JpaRepository<AddressArea, Long>, JpaSpecificationExecutor {

    Page<AddressArea> findAllByNameLike(String name, Pageable pageable);

    Optional<AddressArea> findTopByName(String name);

}