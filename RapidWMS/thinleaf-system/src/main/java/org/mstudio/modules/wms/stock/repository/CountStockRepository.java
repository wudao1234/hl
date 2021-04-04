package org.mstudio.modules.wms.stock.repository;

import org.mstudio.modules.wms.stock.domain.CountStock;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.Optional;

/**
* @author Macrow
* @date 2019-02-22
*/
public interface CountStockRepository extends JpaRepository<CountStock, Long>, JpaSpecificationExecutor {

    Optional<CountStock> findById(Long stockId);

    @Override
    Page<CountStock> findAll(Specification spec, Pageable pageable);

}