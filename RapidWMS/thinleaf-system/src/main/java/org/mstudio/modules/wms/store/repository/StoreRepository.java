package org.mstudio.modules.wms.store.repository;

import org.mstudio.modules.wms.store.domain.Store;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.Optional;

/**
* @author Macrow
* @date 2019-09-28
*/
public interface StoreRepository extends JpaRepository<Store, Long>, JpaSpecificationExecutor {

    Optional<Store> findByName(String name);

}