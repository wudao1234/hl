package org.mstudio.modules.wms.import_legacy_data.handler;

import cn.hutool.poi.excel.sax.handler.RowHandler;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.mstudio.modules.wms.customer.domain.Customer;
import org.mstudio.modules.wms.customer.service.CustomerService;

import java.util.List;

/**
 * @author Macrow
 * @date 2019-03-27
 */

@Slf4j
@AllArgsConstructor
public class CustomerHandler implements RowHandler {

    private final static int NAME = 0;
    private final static int SHORT_NAME_EN = 1;
    private final static int SHORT_NAME_CN = 2;

    private CustomerService customerService;

    @Override
    public void handle(int i, int i1, List<Object> list) {
        log.info("[{}] [{}] {}", i, i1, list);
        if (i1 >= 2) {
            Customer customer = new Customer();
            customer.setName(list.get(NAME).toString());
            customer.setShortNameEn(list.get(SHORT_NAME_EN).toString());
            customer.setShortNameCn(list.get(SHORT_NAME_CN).toString());
            customerService.create(customer);
        }
    }

}
