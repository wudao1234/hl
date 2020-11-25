package org.mstudio.modules.wms.stock.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.stock.domain.Stock;
import org.mstudio.modules.wms.stock.service.object.StockDTO;
import org.springframework.stereotype.Component;

/**
* @author Macrow
* @date 2019-02-22
*/

@Component
@Mapper(componentModel = "spring",uses = {},unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface StockMapper extends EntityMapper<StockDTO, Stock> {

}