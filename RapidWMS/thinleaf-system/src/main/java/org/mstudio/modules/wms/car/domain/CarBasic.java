package org.mstudio.modules.wms.car.domain;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseEntity;

import javax.persistence.Entity;
import javax.persistence.Table;


@Data
@Entity
@Table(name = "wms_car")
@org.hibernate.annotations.Table(appliesTo = "wms_car",comment = "车辆信息")
public class CarBasic extends BaseEntity {

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
     * 驾驶员姓名
     */
    private String carDriverName;

    /**
     * 备注
     */
    private String carDesc;

    /**
     * 车辆状态
     */
    private String carStatus;
}