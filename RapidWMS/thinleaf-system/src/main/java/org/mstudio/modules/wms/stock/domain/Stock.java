package org.mstudio.modules.wms.stock.domain;

import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.goods.domain.Goods;
import org.mstudio.modules.wms.ware_position.domain.WarePosition;

import javax.persistence.*;
import java.util.Date;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
@Entity
@Table(name = "wms_stock")
@NamedEntityGraph(name = "stock.all",
        attributeNodes = {
                @NamedAttributeNode(value = "goods", subgraph = "goods.customerAndGoodsType"),
                @NamedAttributeNode(value = "warePosition", subgraph = "warePosition.wareZone")
        },
        subgraphs = {
                @NamedSubgraph(name = "goods.customerAndGoodsType", attributeNodes = {@NamedAttributeNode("customer"), @NamedAttributeNode("goodsType")}),
                @NamedSubgraph(name = "warePosition.wareZone", attributeNodes = @NamedAttributeNode("wareZone"))
        })
public class Stock extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private WarePosition warePosition;

    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private Goods goods;

    @Temporal(TemporalType.DATE)
    private Date expireDate;

    private Long quantity;

    /**
     * isActive 库存是否冻结
     */
    private Boolean isActive;

}