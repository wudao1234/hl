package org.mstudio.modules.wms.dispatch.domain;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseEntity;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 配送 计件 系数
* @author lfj
* @date 2020-12-01
*/

@Data
@Entity
@Table(name = "wms_dispatch_coefficient")
@org.hibernate.annotations.Table(appliesTo = "wms_dispatch_coefficient",comment = "配送计件系数")
public class DispatchCoefficient extends BaseEntity {

    /**
     * 门店数单价
     */
    private Float store;

    /**
     *件数单价
     */
    private Float dispatch;

    /**
     * 里程单价
     */
    private Float mileage;

}