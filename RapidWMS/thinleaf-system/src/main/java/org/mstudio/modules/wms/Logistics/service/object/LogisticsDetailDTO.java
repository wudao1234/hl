package org.mstudio.modules.wms.Logistics.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

@Data
public class LogisticsDetailDTO extends BaseObject {
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
    private Float piece;

    /**
     * 实际重量
     */
    private Float realityWeight;

    /**
     * 计算重量
     */
    private Float computeWeight;

    /**
     * 续重/续件（千克、件）
     */
    private Float renewNum;

    /**
     * 渠道
     */
    private String name;

    /**
     * 首重/首件（千克、件）
     */
    private Float first;

    /**
     * 续重/续件（千克、件）
     */
    private Float renew;

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
     * 地址
     */
    private LogisticsTemplateVO logisticsTemplate;
}
