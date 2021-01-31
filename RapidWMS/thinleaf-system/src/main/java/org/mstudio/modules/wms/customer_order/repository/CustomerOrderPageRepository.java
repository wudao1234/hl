package org.mstudio.modules.wms.customer_order.repository;

import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrderPage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
* @author Macrow
* @date 2019-02-22
*/
public interface CustomerOrderPageRepository extends JpaRepository<CustomerOrderPage, Long>, JpaSpecificationExecutor {

    int deleteByCustomerOrder(CustomerOrder order);
}