package org.mstudio.modules.wms.pack.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.wms.address.domain.Address;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.customer.domain.Customer;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.customer_order.domain.OrderStatus;
import org.mstudio.modules.wms.customer_order.domain.ReceiveType;
import org.mstudio.modules.wms.dispatch.domain.DispatchPiece;
import org.mstudio.modules.wms.operate_snapshot.domain.OperateSnapshot;
import org.mstudio.modules.wms.pick_match.domain.PickMatch;

import javax.persistence.*;
import javax.validation.constraints.Min;
import java.math.BigDecimal;
import java.util.List;

/**
* @author Macrow
* @date 2019-04-24
*/

@Data
@Entity
@Table(name = "wms_pack")
@NamedEntityGraph(name = "pack.all", attributeNodes = {
        @NamedAttributeNode(value = "customer"),
        @NamedAttributeNode(value = "orders"),
        @NamedAttributeNode(value = "address"),
        @NamedAttributeNode(value = "user")
})
public class Pack extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private Customer customer;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "pack", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<CustomerOrder> orders;

    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private Address address;

    private PackType packType;

    private OrderStatus packStatus;

    /**
     * flowSN 流水号，按照时间戳自动生成
     */
    private String flowSn;

    @Min(value = 1)
    private Integer packages;

    private BigDecimal totalPrice;

    private Boolean isPrinted;

    private String signedPhoto;

    /**
     * isActive 是否为有效状态，作废则为无效
     */
    private Boolean isActive;

    /**
     * cancelDescription 作废原因
     */
    private String cancelDescription;

    /**
     * 外发物流单号
     */
    private String trackingNumber;

    private String description;

    /**
     * 是否分配好商品打包
     */
    private Boolean isPackaged;

    /**
     * 签收状态
     */
    private ReceiveType receiveType;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "pack", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    @OrderBy("number asc")
    private List<PackItem> packItems;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "pack", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    @OrderBy("createTime asc")
    private List<OperateSnapshot> operateSnapshots;

    /**
     * 打包、派送人
     */
    @JSONField(serialize = false)
    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private User user;

    /**
     * 拣配、复核计件信息
     */
    @JSONField(serialize = false)
    @OneToMany(mappedBy = "pack", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<PickMatch> pickMatch;

    @JSONField(serialize = false)
    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private DispatchPiece dispatchPiece;

}