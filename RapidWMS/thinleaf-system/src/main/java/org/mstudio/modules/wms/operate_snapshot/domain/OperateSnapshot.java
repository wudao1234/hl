package org.mstudio.modules.wms.operate_snapshot.domain;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.pack.domain.Pack;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
@Entity
@Table(name = "wms_operate_snapshot")
public class OperateSnapshot extends BaseEntity {

    @ManyToOne
    private CustomerOrder customerOrder;

    @ManyToOne
    private Pack pack;

    /**
     * userNameSnapshot 用户名快照
     */
    private String operation;

    /**
     * operateDetail 操作快照
     */
    private String operator;

}