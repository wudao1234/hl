package org.mstudio.modules.wms.stock_flow.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.stock_flow.domain.StockFlowType;

import java.math.BigDecimal;
import java.util.Date;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class StockFlowVO extends BaseObject {

    private StockFlowType flowOperateType;

    private String sn;

    private String name;

    private Long quantity;

    private BigDecimal price;

    private Date expireDate;

    private Integer packCount;

    private String unit;

    private String operator;

    private String description;

}