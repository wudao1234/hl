package org.mstudio.modules.wms.goods_type.repository;

import org.mstudio.modules.wms.goods_type.domain.GoodsType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
* @author Macrow
* @date 2019-02-22
*/
public interface GoodsTypeRepository extends JpaRepository<GoodsType, Long>, JpaSpecificationExecutor {
}