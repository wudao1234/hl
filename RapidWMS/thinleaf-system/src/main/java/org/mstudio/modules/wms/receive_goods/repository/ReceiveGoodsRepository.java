package org.mstudio.modules.wms.receive_goods.repository;

import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoods;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
* @author Macrow
* @date 2019-04-12
*/
public interface ReceiveGoodsRepository extends JpaRepository<ReceiveGoods, Long>, JpaSpecificationExecutor {

    @Override
    @EntityGraph(value = "receiveGoods.all", type = EntityGraph.EntityGraphType.FETCH)
    Page<ReceiveGoods> findAll(Specification spec, Pageable pageable);

}