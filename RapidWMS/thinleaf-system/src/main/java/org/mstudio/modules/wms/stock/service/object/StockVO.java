package org.mstudio.modules.wms.stock.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

import java.util.Date;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class StockVO extends BaseObject {

    private Date expireDate;

    private Long quantity;

    private Boolean isActive;

}