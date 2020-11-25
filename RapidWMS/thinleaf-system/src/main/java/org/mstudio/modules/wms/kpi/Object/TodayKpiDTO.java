package org.mstudio.modules.wms.kpi.Object;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * @author Macrow
 * @date 2019-05-16
 */

@Data
public class TodayKpiDTO implements Serializable {

    private BigDecimal totalPriceToday;

    private Integer orderCountToday;

    private Integer unConfirmOrders;

    private Integer confirmOrdersToday;

    private Integer packCountDetailToday;

    private Integer packCountToday;

    private Integer packCountDetailSending;

    private Integer packCountSending;

}
