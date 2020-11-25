package org.mstudio.modules.wms.customer_order.repository;

import org.mstudio.modules.wms.customer_order.domain.CustomerOrderItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

/**
* @author Macrow
* @date 2019-02-22
*/
public interface CustomerOrderItemRepository extends JpaRepository<CustomerOrderItem, Long>, JpaSpecificationExecutor {

    List<CustomerOrderItem> findAllByCustomerOrderId(Long id);

}