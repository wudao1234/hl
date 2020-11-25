package org.mstudio.modules.wms.customer.repository;

import org.mstudio.modules.wms.customer.domain.Customer;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;
import java.util.Optional;

/**
 * @author Macrow
 * @date 2019-02-22
 */

public interface CustomerRepository extends JpaRepository<Customer, Long>, JpaSpecificationExecutor {

    Optional<Customer> findByName(String name);

    Optional<Customer> findByShortNameEn(String shortNameEn);

    Optional<Customer> findByShortNameCn(String shortNameCn);

    Page<Customer> findByNameLikeOrShortNameEnLike(Pageable pageable, String name, String shortNameEn);

    @Override
    Page<Customer> findAll(Pageable pageable);

    @Override
    List<Customer> findAll();

}