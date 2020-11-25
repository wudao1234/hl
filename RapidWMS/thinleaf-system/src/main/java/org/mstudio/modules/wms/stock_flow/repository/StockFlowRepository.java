package org.mstudio.modules.wms.stock_flow.repository;

import org.mstudio.modules.wms.stock_flow.domain.StockFlow;
import org.mstudio.modules.wms.stock_flow.domain.StockFlowType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;

import javax.transaction.Transactional;
import java.util.Date;
import java.util.List;

/**
* @author Macrow
* @date 2019-02-22
*/
public interface StockFlowRepository extends JpaRepository<StockFlow, Long>, JpaSpecificationExecutor {

    @Override
    @EntityGraph(value = "stockFlow.all", type = EntityGraph.EntityGraphType.FETCH)
    Page<StockFlow> findAll(Specification spec, Pageable pageable);

    List<StockFlow> findAllByCustomerOrderIdOrderByWarePositionOut(Long orderId);

    List<StockFlow> findAllByReceiveGoodsIdOrderByCreateTimeDesc(Long receiveGoodsId);

    @EntityGraph(value = "stockFlow.onlyEntity")
    List<StockFlow> findAllByCreateTimeBetweenAndFlowOperateTypeOrderBySn(Date startDate, Date endDate, StockFlowType stockFlowType);

    @Transactional
    @Modifying
    void deleteAllByCustomerOrderId(Long id);

    @Transactional
    @Modifying
    void deleteAllByReceiveGoodsId(Long id);

    Long countByGoodsIdAndFlowOperateTypeAndCreateTimeBetween(Long goodsId, StockFlowType type, Date startDate, Date endDate);

}