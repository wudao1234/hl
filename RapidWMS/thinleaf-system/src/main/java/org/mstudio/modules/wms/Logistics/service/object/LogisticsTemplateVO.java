package org.mstudio.modules.wms.Logistics.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

import java.util.Date;

@Data
public class LogisticsTemplateVO extends BaseObject {
    /**
     * 单价生效时间
     */
    private Date dateTime;

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
}
