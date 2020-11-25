package org.mstudio.modules.wms.kpi.Object;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.io.Serializable;

/**
 * @author Macrow
 * @date 2019-05-16
 */

@Data
@AllArgsConstructor
public class TopUnSales implements Serializable {

    private String goodsName;

    private String goodsSn;

    private float goodsPrice;

    private Long stockCount;

    private Long saleCount;

}
