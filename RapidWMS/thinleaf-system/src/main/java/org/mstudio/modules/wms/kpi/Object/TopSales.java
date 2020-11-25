package org.mstudio.modules.wms.kpi.Object;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * @author Macrow
 * @date 2019-05-16
 */

@Data
@AllArgsConstructor
public class TopSales implements Serializable {

    private String name;

    private String sn;

    private BigDecimal totalPrice;

}
