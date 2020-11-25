package org.mstudio.modules.wms.goods.repository;

import org.mstudio.modules.wms.goods.domain.Goods;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;
import java.util.Optional;

/**
 * @author Macrow
 * @date 2019-02-22
 */
public interface GoodsRepository extends JpaRepository<Goods, Long>, JpaSpecificationExecutor {

    Integer countByCustomerId(Long customerId);

    Optional<List<Goods>> findByCustomerIdAndSn(Long customerId, String sn);

    Optional<Goods> findByCustomerIdAndSnAndPackCount(Long customerId, String sn, Integer packCount);

    @Override
    @EntityGraph(value = "goods.all", type = EntityGraph.EntityGraphType.FETCH)
    Page<Goods> findAll(Specification spec, Pageable pageable);

    Integer countByGoodsTypeId(Long goodsTypeId);

    List<Goods> findAllByCustomerId(String customerId);

}