package org.mstudio.modules.wms.customer.service;

import org.mstudio.modules.system.service.dto.UserVO;
import org.mstudio.modules.wms.customer.domain.Customer;
import org.mstudio.modules.wms.customer.service.object.CustomerDTO;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @author Macrow
 * @date 2019-02-22
 */

public interface CustomerService {

    Map queryAll(Boolean exportExcel, String search, Pageable pageable);

    Customer findCustomerById(Long id);

    CustomerDTO findById(Long id);

    CustomerDTO findByName(String name);

    CustomerDTO create(Customer resources);

    CustomerDTO update(Long Id, Customer resources);

    void delete(Long id);

    byte[] exportExcelData(List<CustomerDTO> customers);

    List<UserVO> getUsersById(Long id);

    List<CustomerVO> getAllList();

    Set<CustomerVO> getListByUserId(Long id);

}