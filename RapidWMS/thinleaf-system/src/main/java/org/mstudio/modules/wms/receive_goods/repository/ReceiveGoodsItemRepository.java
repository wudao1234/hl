package org.mstudio.modules.wms.receive_goods.repository;

import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoodsItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
* @author Macrow
* @date 2019-02-22
*/
public interface ReceiveGoodsItemRepository extends JpaRepository<ReceiveGoodsItem, Long>, JpaSpecificationExecutor {

}