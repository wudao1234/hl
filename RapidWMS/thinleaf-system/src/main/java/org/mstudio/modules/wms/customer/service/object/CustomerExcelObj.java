package org.mstudio.modules.wms.customer.service.object;

import lombok.Data;

/**
 * @author Macrow
 * @date 2019-05-08
 */

@Data
public class CustomerExcelObj {

    private Long index;

    private String name;

    private String shortNameEn;

    private String shortNameCn;

    private Integer goodsCount;

    private Integer ordersCount;

}
