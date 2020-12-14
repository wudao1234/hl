package org.mstudio.modules.wms.receive_goods.domain;

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
* @author Macrow
* @date 2019-02-22
*/

@Data
@Entity
@Table(name = "wms_receive_goods_item")
public class ReceiveGoodsItem extends BaseEntity {

    @JSONField(serialize = false)
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    private ReceiveGoods receiveGoods;

    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private Goods goods;

    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private WarePosition warePosition;

    @Min(value = 0)
    private Long quantityInitial;

    /**
     * 件数
     */
    @Min(value = 0)
    private Long packages;

    private Long packagesInitial;

    @Min(value = 0)
    private Long quantity;

    // 取消审核时，取回的商品数量，比对数量后，决定是否可以取消审核
    @Min(value = 0)
    private Long quantityCancelFetch;

    @Temporal(TemporalType.DATE)
    private Date expireDate;

    private BigDecimal price;

    private String description;

}