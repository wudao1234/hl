package org.mstudio.modules.wms.pack.repository;

import org.mstudio.modules.wms.customer_order.domain.OrderStatus;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
* @author Macrow
* @date 2019-04-24
*/
public interface PackRepository extends JpaRepository<Pack, Long>, JpaSpecificationExecutor {

    @Override
    @EntityGraph(value = "pack.all", type = EntityGraph.EntityGraphType.FETCH)
    Page<Pack> findAll(Specification spec, Pageable pageable);

    Integer countByCreateTimeBetween(Date startDate, Date endDate);

    List<Pack> findByCreateTimeBetween(Date startDate, Date endDate);

    Optional<Pack> findByFlowSn(String flowSn);

    Integer countByPackStatus(OrderStatus orderStatus);

    List<Pack> findByPackStatus(OrderStatus orderStatus);

    List<Pack> findByPackStatusAndUserId(OrderStatus orderStatus, Long id);

}