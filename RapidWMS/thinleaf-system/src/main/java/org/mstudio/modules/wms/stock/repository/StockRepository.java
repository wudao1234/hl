package org.mstudio.modules.wms.stock.repository;

import org.mstudio.modules.wms.stock.domain.Stock;
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
public interface StockRepository extends JpaRepository<Stock, Long>, JpaSpecificationExecutor {

    Optional<Stock> findByWarePositionIdAndGoodsIdAndExpireDate(Long warePositionId, Long goodsId, Date expireDate);

    Optional<Stock> findByWarePositionIdAndGoodsIdAndExpireDateAndIsActive(Long warePositionId, Long goodsId, Date expireDate, Boolean isActive);

    List<Stock> findByGoodsId(Long goodsId);

    Optional<Stock> findById(Long stockId);

    List<Stock> findByWarePositionId(Long warePositionId);

    @Override
    @EntityGraph(value = "stock.all", type = EntityGraph.EntityGraphType.FETCH)
    Page<Stock> findAll(Specification spec, Pageable pageable);

}