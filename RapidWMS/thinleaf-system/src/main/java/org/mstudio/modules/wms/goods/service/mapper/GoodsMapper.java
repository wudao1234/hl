package org.mstudio.modules.wms.goods.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.goods.domain.Goods;
import org.mstudio.modules.wms.goods.service.object.GoodsDTO;
import org.mstudio.modules.wms.goods.service.object.GoodsVO;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author Macrow
 * @date 2019-02-22
 */

@Component
@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface GoodsMapper extends EntityMapper<GoodsDTO, Goods> {

    GoodsVO toVO(Goods goods);

    List<GoodsVO> toVOList(List<Goods> goods);

}