package org.mstudio.modules.wms.stock.service.object;

import lombok.Data;

import java.io.Serializable;

/**
* @author Macrow
* @date 2019-04-10
*/

@Data
public class StockActivateDTO implements Serializable {

    private Long[] selectedRowKeys;

    private Boolean isActive;

}