package org.mstudio.modules.wms.address_type.repository;

import org.mstudio.modules.wms.address_type.domain.AddressType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.Optional;

/**
* @author Macrow
* @date 2019-07-09
*/

public interface AddressTypeRepository extends JpaRepository<AddressType, Long>, JpaSpecificationExecutor {

    Page<AddressType> findAllByNameLike(String name, Pageable pageable);

    Optional<AddressType> findTopByName(String name);

}