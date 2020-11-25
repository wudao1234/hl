package org.mstudio.modules.wms.stock_flow.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.stock_flow.domain.StockFlow;
import org.mstudio.modules.wms.stock_flow.service.object.StockFlowDTO;
import org.mstudio.modules.wms.stock_flow.service.object.StockFlowVO;
import org.springframework.stereotype.Component;

import java.util.List;

/**
* @author Macrow
* @date 2019-02-22
*/

@Component
@Mapper(componentModel = "spring",uses = {},unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface StockFlowMapper extends EntityMapper<StockFlowDTO, StockFlow> {

    StockFlowVO toVO(StockFlow stockFlow);

    List<StockFlowVO> toVOList(List<StockFlow> stockFlows);

}