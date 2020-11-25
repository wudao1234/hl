package org.mstudio.modules.wms.customer_order.repository;

import org.mstudio.modules.wms.customer_order.domain.CustomerOrderStock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;

import javax.transaction.Transactional;
import java.util.List;

/**
* @author Macrow
* @date 2019-02-22
*/
public interface CustomerOrderStockRepository extends JpaRepository<CustomerOrderStock, Long>, JpaSpecificationExecutor {

    List<CustomerOrderStock> findAllByCustomerOrderId(Long id);

}