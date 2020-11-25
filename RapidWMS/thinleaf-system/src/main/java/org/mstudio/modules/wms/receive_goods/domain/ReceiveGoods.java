package org.mstudio.modules.wms.receive_goods.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.customer.domain.Customer;
import org.mstudio.modules.wms.stock_flow.domain.StockFlow;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.List;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
@Entity
@Table(name = "wms_receive_goods")
@NamedEntityGraph(name = "receiveGoods.all", attributeNodes = @NamedAttributeNode(value = "customer"))
public class ReceiveGoods extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private Customer customer;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "receiveGoods", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<ReceiveGoodsItem> receiveGoodsItems;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "receiveGoods", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<StockFlow> stockFlows;

    private String flowSn;

    private ReceiveGoodsType receiveGoodsType;

    private Boolean isAudited;

    private Timestamp auditTime;

    private String description;

    private String creator;

    private String auditor;

}