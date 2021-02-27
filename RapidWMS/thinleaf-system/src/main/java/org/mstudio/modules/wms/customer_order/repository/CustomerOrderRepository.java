package org.mstudio.modules.wms.customer_order.repository;

import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.customer_order.domain.OrderStatus;
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
 * @date 2019-02-22
 */
public interface CustomerOrderRepository extends JpaRepository<CustomerOrder, Long>, JpaSpecificationExecutor {

    Integer countByOwnerId(Long ownerId);

    Optional<CustomerOrder> findTopByOwnerIdOrderByIdDesc(Long id);

    Optional<CustomerOrder> findTopByClientOrderSn2AndIsActiveAndOwnerId(String sn2, Boolean isActive, Long id);

    @Override
    @EntityGraph(value = "customerOrder.all", type = EntityGraph.EntityGraphType.FETCH)
    Page<CustomerOrder> findAll(Specification spec, Pageable pageable);

    Integer countByCreateTimeBetween(Date startDate, Date endDate);

    Integer countByOrderStatus(OrderStatus orderStatus);

    Integer countByOrderStatusAndUpdateTimeBetween(OrderStatus orderStatus, Date startDate, Date endDate);

    List<CustomerOrder> findByCreateTimeBetweenAndIsActive(Date startDate, Date endDate, Boolean isActive);

//    @Query(value = "SELECT co.* FROM wms_customer_order co LEFT JOIN wms_customer_order_page cop ON cop.customer_order_id = co.id WHERE cop.id = ?1", nativeQuery = true)
    CustomerOrder findByCustomerOrderPagesId(Long id);

//    List<CustomerOrder> findByPackId(Long packId);

}