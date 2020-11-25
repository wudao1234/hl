package org.mstudio.modules.wms.goods_type.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.goods_type.domain.GoodsType;
import org.mstudio.modules.wms.goods_type.service.object.GoodsTypeDTO;
import org.mstudio.modules.wms.goods_type.service.object.GoodsTypeVO;
import org.springframework.stereotype.Component;

import java.util.List;

/**
* @author Macrow
* @date 2019-02-22
*/

@Component
@Mapper(componentModel = "spring",uses = {},unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface GoodsTypeMapper extends EntityMapper<GoodsTypeDTO, GoodsType> {

    GoodsTypeVO toVO(GoodsType goodsType);

    List<GoodsTypeVO> toVOList(List<GoodsType> goodsTypes);

}