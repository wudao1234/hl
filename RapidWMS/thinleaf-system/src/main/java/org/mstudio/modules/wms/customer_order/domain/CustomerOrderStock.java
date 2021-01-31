package org.mstudio.modules.wms.customer_order.domain;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.goods.domain.Goods;
import org.mstudio.modules.wms.ware_position.domain.WarePosition;

import javax.persistence.*;
import javax.validation.constraints.Min;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 订单商品出库信息
* @author Macrow
* @date 2019-02-22
*/

@Data
@Entity
@Table(name = "wms_customer_order_stock")
public class CustomerOrderStock extends BaseEntity {

    @JSONField(serialize = false)
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    private CustomerOrder customerOrder;

    @ManyToOne
    @Fetch(FetchMode.JOIN)
    private WarePosition warePosition;

    @ManyToOne
    @Fetch(FetchMode.JOIN)
    private Goods goods;

    private Integer sortOrder;

    @Temporal(TemporalType.DATE)
    private Date expireDate;

    @Min(value = 0)
    private Long quantityInitial;

    @Min(value = 0)
    private Long quantity;

    private BigDecimal price;

    private String description;

}