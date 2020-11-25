package org.mstudio.modules.wms.customer_order.service.object;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
* @author Macrow
* @date 2019-04-11
*/

@Data
public class CustomerOrderImporterDTO implements Serializable {

    private Long customer;

    private Long[] wareZone;

    private Date orderExpireDateMin;

    private Date orderExpireDateMax;

    private Boolean fetchAll;

    private Boolean usePackCount;

    private Boolean useNewAutoIncreaseSn;

    private Boolean fetchStocks;

    private String[] uploadFileList;

}