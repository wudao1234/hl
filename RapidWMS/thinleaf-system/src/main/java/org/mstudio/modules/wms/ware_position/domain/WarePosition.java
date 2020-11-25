package org.mstudio.modules.wms.ware_position.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoodsItem;
import org.mstudio.modules.wms.stock.domain.Stock;
import org.mstudio.modules.wms.stock_flow.domain.StockFlow;
import org.mstudio.modules.wms.ware_zone.domain.WareZone;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.List;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
@Entity
@Table(name = "wms_ware_position")
@NamedEntityGraph(name = "warePosition.all", attributeNodes = { @NamedAttributeNode("wareZone") })
public class WarePosition extends BaseEntity {

    @NotBlank(message = "库位名称必须填入")
    private String name;

    private String description;

    private Integer sortOrder;

    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private WareZone wareZone;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "warePosition", fetch = FetchType.LAZY)
    private List<Stock> stocks;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "warePositionIn", fetch = FetchType.LAZY)
    private List<StockFlow> stockFlowsIn;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "warePositionOut", fetch = FetchType.LAZY)
    private List<StockFlow> stockFlowsOut;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "warePosition", fetch = FetchType.LAZY)
    private List<ReceiveGoodsItem> receiveGoodsItems;

}