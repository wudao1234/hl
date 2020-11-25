package org.mstudio.modules.wms.kpi.Object;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @author Macrow
 * @date 2019-05-16
 */

@Data
@AllArgsConstructor
public class OrderSalesKpiDTO implements Serializable {

    List<OrderSales> orderSales;

    List<TopSales> topSales;

}
