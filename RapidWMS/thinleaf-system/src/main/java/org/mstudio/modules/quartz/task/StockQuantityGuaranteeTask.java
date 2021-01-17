package org.mstudio.modules.quartz.task;

import org.mstudio.modules.wms.stock.service.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 质保实数更新
 */
@Component
public class StockQuantityGuaranteeTask {

    @Autowired
    private StockService stockService;

    public void run(){
        stockService.updateQuantityGuarantee();
    }
}
