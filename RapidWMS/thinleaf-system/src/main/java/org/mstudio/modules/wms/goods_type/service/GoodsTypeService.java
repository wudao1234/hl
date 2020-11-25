package org.mstudio.modules.wms.goods_type.service;

import org.mstudio.modules.wms.goods_type.domain.GoodsType;
import org.mstudio.modules.wms.goods_type.service.object.GoodsTypeDTO;
import org.mstudio.modules.wms.goods_type.service.object.GoodsTypeVO;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
* @author Macrow
* @date 2019-02-22
*/

public interface GoodsTypeService {

    GoodsTypeDTO findById(Long id);

    GoodsTypeDTO create(GoodsType resources);

    GoodsTypeVO update(Long Id, GoodsType resources);

    void delete(Long id);

    Object queryAll(String search, Pageable pageable);

    List<GoodsTypeVO> getAllList();

}