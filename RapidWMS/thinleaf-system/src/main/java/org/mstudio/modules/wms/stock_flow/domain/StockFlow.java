package org.mstudio.modules.wms.stock_flow.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrderPage;
import org.mstudio.modules.wms.goods.domain.Goods;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoods;
import org.mstudio.modules.wms.ware_position.domain.WarePosition;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "wms_stock_flow")
@NamedEntityGraph(name = "stockFlow.all",
        attributeNodes = {
                @NamedAttributeNode(value = "goods"),
                @NamedAttributeNode(value = "customerOrder"),
                @NamedAttributeNode(value = "warePositionIn", subgraph = "warePositionIn.wareZone"),
                @NamedAttributeNode(value = "warePositionOut", subgraph = "warePositionOut.wareZone")
        },
        subgraphs = {
                @NamedSubgraph(name = "warePositionIn.wareZone", attributeNodes = @NamedAttributeNode("wareZone")),
                @NamedSubgraph(name = "warePositionOut.wareZone", attributeNodes = @NamedAttributeNode("wareZone"))
        })
@NamedEntityGraph(name = "stockFlow.onlyEntity")
public class StockFlow extends BaseEntity {

    private StockFlowType flowOperateType;

    private String sn;

    private String name;

    private Long quantity;

    private BigDecimal price;

    @Temporal(TemporalType.DATE)
    private Date expireDate;

    private Integer packCount;

    private String unit;

    private String operator;

    private String description;

    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private CustomerOrder customerOrder;

    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private ReceiveGoods receiveGoods;

    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private Goods goods;

    @ManyToOne
    @Fetch(FetchMode.JOIN)
    private WarePosition warePositionIn;

    @ManyToOne
    @Fetch(FetchMode.JOIN)
    private WarePosition warePositionOut;

    @ManyToOne(fetch = FetchType.LAZY)
    private CustomerOrderPage customerOrderPage;

}