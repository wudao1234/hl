package org.mstudio.modules.wms.address.repository;

import org.mstudio.modules.wms.address.domain.Address;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
* @author Macrow
* @date 2019-04-24
*/
public interface AddressRepository extends JpaRepository<Address, Long>, JpaSpecificationExecutor {

    @Override
    @EntityGraph(value = "address.all", type = EntityGraph.EntityGraphType.FETCH)
    Page<Address> findAll(Specification spec, Pageable pageable);

    Integer countByAddressTypeId(Long addressTypeId);

    Address findOneByClientStore(String clientStore);
}