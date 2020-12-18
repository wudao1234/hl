package org.mstudio.modules.wms.car.domain;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseEntity;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;


@Data
@Entity
@Table(name = "wms_car_cost")
@org.hibernate.annotations.Table(appliesTo = "wms_car_cost", comment = "车辆费用信息")
public class CarCost extends BaseEntity {
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