package org.mstudio.modules.wms.stock.service.object;

import lombok.Data;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class StockCountDTO extends StockDTO {
    /**
     * 实盘数量（真实库存）
     */
    private Long currentQuantity;

}