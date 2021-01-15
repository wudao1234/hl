package org.mstudio.modules.wms.goods.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.validator.constraints.Length;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.customer.domain.Customer;
import org.mstudio.modules.wms.goods_type.domain.GoodsType;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoodsItem;
import org.mstudio.modules.wms.stock.domain.Stock;
import org.mstudio.modules.wms.stock_flow.domain.StockFlow;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * @author Macrow
 * @date 2019-02-22
 */

@Data
@Entity
@Table(name = "wms_goods")
@NamedEntityGraph(name = "goods.all", attributeNodes = { @NamedAttributeNode("customer"), @NamedAttributeNode("goodsType") })
public class Goods extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private Customer customer;

    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private GoodsType goodsType;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "goods", fetch = FetchType.LAZY)
    private List<Stock> stocks;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "goods", fetch = FetchType.LAZY)
    private List<StockFlow> stockFlows;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "goods", fetch = FetchType.LAZY)
    private List<ReceiveGoodsItem> receiveGoodsItems;

    @NotBlank(message = "商品名称必须填写")
    @Length(min = 2, max = 255)
    private String name;

    @NotBlank(message = "商品识别码必须录入")
    private String sn;

    /**
     * packCount 商品规格，规格不同，我们认为是两种不同的商品
     */
    @NotNull(message = "商品规格必须录入")
    private Integer packCount;

    @NotNull(message = "质保时长必须录入")
    private Integer monthsOfWarranty;

    @NotNull(message = "商品单价必须录入")
    private float price;

    @NotNull(message = "商品退货单价必须录入")
    private float returnPrice;

    @NotNull(message = "商品单位必须录入")
    private String unit;

    private String description;

}