package org.mstudio.modules.wms.receive_goods.domain;

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
@Table(name = "wms_receive_goods_coefficient")
@org.hibernate.annotations.Table(appliesTo = "wms_receive_goods_coefficient",comment = "收货、卸货系统参数")
public class RcceiveCoefficient extends BaseEntity {

    /**
     * 收货计件单价
     */
    private Float unloadPrice;

    /**
     * 入库 计件单价
     */
    private Float putInPrice;

}