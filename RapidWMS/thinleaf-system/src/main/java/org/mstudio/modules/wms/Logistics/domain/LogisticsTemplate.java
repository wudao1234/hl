package org.mstudio.modules.wms.Logistics.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.mstudio.modules.wms.address_area.domain.AddressArea;
import org.mstudio.modules.wms.common.BaseEntity;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.util.Date;

/**
 * 物流结算模板
* @author lfj
* @date 2020-12-01
*/

@Data
@Entity
@Table(name = "wms_logistics_template")
@org.hibernate.annotations.Table(appliesTo = "wms_logistics_template",comment = "物流结算模板")
public class LogisticsTemplate extends BaseEntity {

    /**
     * 单价生效时间
     */
    private Date dateTime;

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
     * 按件：0；按重：1；按体：2
     */
    private Integer type;

    @JSONField(serialize = false)
    @ManyToOne
    private AddressArea addressArea;

    /**
     * 保费（分）
     */
    private Integer protectPrice;

}