package org.mstudio.modules.wms.receive_goods.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoods;
import org.mstudio.modules.wms.receive_goods.service.object.ReceiveGoodsDTO;
import org.mstudio.modules.wms.receive_goods.service.object.ReceiveGoodsVO;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author Macrow
 * @date 2019-02-22
 */

@Component
@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ReceiveGoodsMapper extends EntityMapper<ReceiveGoodsDTO, ReceiveGoods> {

    ReceiveGoodsVO toVO(ReceiveGoods receiveGoods);

    List<ReceiveGoodsVO> toVOList(List<ReceiveGoods> receiveGoodsList);

}