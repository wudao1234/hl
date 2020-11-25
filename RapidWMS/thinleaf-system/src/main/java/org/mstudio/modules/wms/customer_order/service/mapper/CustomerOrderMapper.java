package org.mstudio.modules.wms.customer_order.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.customer_order.service.object.CustomerOrderDTO;
import org.mstudio.modules.wms.customer_order.service.object.CustomerOrderVO;
import org.springframework.stereotype.Component;

import java.util.List;

/**
* @author Macrow
* @date 2019-02-22
*/

@Component
@Mapper(componentModel = "spring",uses = {},unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface CustomerOrderMapper extends EntityMapper<CustomerOrderDTO, CustomerOrder> {

    CustomerOrderVO toVO(CustomerOrder customerOrder);

    List<CustomerOrderVO> toVO(List<CustomerOrder> customerOrders);

}