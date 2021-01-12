package org.mstudio.modules.wms.Logistics.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

@Data
public class LogisticsDetailDTO extends BaseObject {
    /**
     * 单价生效时间
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
}
