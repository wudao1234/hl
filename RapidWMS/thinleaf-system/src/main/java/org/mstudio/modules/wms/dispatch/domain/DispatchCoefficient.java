package org.mstudio.modules.wms.dispatch.domain;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseEntity;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 拣配 计件 系数
* @author lfj
* @date 2020-12-01
*/

@Data
@Entity
@Table(name = "wms_dispatch_coefficient")
@org.hibernate.annotations.Table(appliesTo = "wms_dispatch_coefficient",comment = "配送计件系数")
public class DispatchCoefficient extends BaseEntity {

    /**
     * 门店系数
     */
    private Float store;

    /**
     *配送系数
     */
    private Float dispatch;

    /**
     * 里程系数
     */
    private Float mileage;

}