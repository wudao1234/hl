package org.mstudio.modules.wms.customer.service.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mstudio.mapper.EntityMapper;
import org.mstudio.modules.wms.customer.domain.Customer;
import org.mstudio.modules.wms.customer.service.object.CustomerDTO;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author Macrow
 * @date 2019-02-22
 */

@Component
@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface CustomerMapper extends EntityMapper<CustomerDTO, Customer> {

    CustomerVO toVO(Customer customer);

    List<CustomerVO> toVOList(List<Customer> customers);

}