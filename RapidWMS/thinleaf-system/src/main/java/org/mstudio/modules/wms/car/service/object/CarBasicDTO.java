package org.mstudio.modules.wms.car.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

/**
* @author lfj
*/

@Data
public class CarBasicDTO extends BaseObject {

    /**
     * 车牌号
     */
    private String carNum;

    /**
     * 车辆型号
     */
    private String carModel;

    /**
     * 车辆类型
     */
    private String carType;

    /**
     * 车辆状态
     */
    private String carDriverName;

    /**
     * 驾驶员姓名
     */
    private String carDesc;

    /**
     * 备注
     */
    private String carStatus;

}