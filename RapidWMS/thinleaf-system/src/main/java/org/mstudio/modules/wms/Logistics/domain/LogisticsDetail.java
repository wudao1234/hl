package org.mstudio.modules.wms.Logistics.domain;

import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.wms.common.BaseEntity;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * 物流结算明细
* @author lfj
* @date 2020-12-01
*/

@Data
@Entity
@Table(name = "wms_logistics_detail")
@org.hibernate.annotations.Table(appliesTo = "wms_logistics_detail",comment = "物流结算明细")
public class LogisticsDetail extends BaseEntity {

    /**
     * 省
     */
    private String province;

    /**
     * 单据
     */
    private String bill;

    /**
     * 件
     */
    private Integer piece;

    /**
     * 实际重量
     */
    private Integer realityWeight;

    /**
     * 计算重量
     */
    private Integer computeWeight;

    /**
     * 续重/续件（克、件）
     */
    private Integer renewNum;

    /**
     * 渠道
     */
    private String name;

    /**
     * 首重/首件（克、件）
     */
    private Integer first;

    /**
     * 续重/续件（克、件）
     */
    private Integer renew;

    /**
     * 首重/首件单价（分）
     */
    private Integer firstPrice;

    /**
     * 续重/续件单价（分）
     */
    private Integer renewPrice;

    /**
     * 总价
     */
    private Integer totalPrice;

    /**
     * 备注
     */
    private String remark;

    /**
     * 客户
     */
    private String customer;

    /**
     * 地址
     */
    private String address;

    /**
     * 模板
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private LogisticsTemplate logisticsTemplate;

}