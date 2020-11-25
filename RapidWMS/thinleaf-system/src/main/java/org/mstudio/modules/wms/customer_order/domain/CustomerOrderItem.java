package org.mstudio.modules.wms.customer_order.domain;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import org.mstudio.modules.wms.common.BaseEntity;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.Min;
import java.math.BigDecimal;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
@Entity
@Table(name = "wms_customer_order_item")
public class CustomerOrderItem extends BaseEntity {

    @JSONField(serialize = false)
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    private CustomerOrder customerOrder;

    private Integer sortOrder;

    private String name;

    private String sn;

    private BigDecimal price;

    private Integer packCount;

    @Min(value = 0)
    private Long quantityInitial;

    @Min(value = 0)
    private Long quantity;

    private String description;
}