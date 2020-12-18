package org.mstudio.modules.wms.car.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

import java.util.Date;

/**
* @author lfj
*/

@Data
public class CarCostDTO extends BaseObject {
    /**
     * 时间
     */
    private Date dateTime;

    /**
     * 里程数
     */
    private Double mile;

    /**
     * 驾驶员姓名
     */
    private String driverName;

    /**
     * 车牌号
     */
    private String carNum;

    /**
     * 油费
     */
    private Double oilCost;

    /**
     * 停车费
     */
    private Double parkingCharge;

    /**
     * 路桥费
     */
    private Double tollCharge;

}