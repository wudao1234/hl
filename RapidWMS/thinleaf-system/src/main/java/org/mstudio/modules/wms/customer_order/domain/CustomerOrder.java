package org.mstudio.modules.wms.customer_order.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.customer.domain.Customer;
import org.mstudio.modules.wms.operate_snapshot.domain.OperateSnapshot;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.mstudio.modules.wms.pick_match.domain.PickMatch;
import org.mstudio.modules.wms.stock_flow.domain.StockFlow;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * @author Macrow
 * @date 2019-02-22
 */

@Data
@Entity
@Table(name = "wms_customer_order")
@NamedEntityGraph(name = "customerOrder.all",
        attributeNodes = {
                @NamedAttributeNode(value = "owner"),
                @NamedAttributeNode(value = "pack")
        })
public class CustomerOrder extends BaseEntity {

    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private Customer owner;

    /**
     * printTitle 订单打印标题
     */
    private String printTitle;

    /**
     * description 订单说明
     */
    private String description;

    /**
     * clientName 客户名称（购货单位）
     */
    @NotNull(message = "客户名称必须录入")
    private String clientName;

    /**
     * clientStore 门店
     */
    @NotNull(message = "订购门店必须录入")
    private String clientStore;

    /**
     * clientAddress 收货地址
     */
    private String clientAddress;

    /**
     * fetchAll 是否要求订单全部匹配
     */
    @NotNull(message = "必须指定是否全匹配")
    private Boolean fetchAll;

    /**
     * expireDate 订单指定的最低过期日，所有匹配的商品不能超过这个日期
     */
    @Temporal(TemporalType.DATE)
    private Date expireDateMin;

    /**
     * expireDateMax 订单指定的最高过期日
     */
    @Temporal(TemporalType.DATE)
    private Date expireDateMax;

    /**
     * clientOrderSN 客户订单号，是客户的订单系统所生成的单号，加进来用户和客户进行对账
     */
    private String clientOrderSn;

    /**
     * clientOrderSN 客户单据编号，是客户的订单系统所生成的单号，加进来用户和客户进行对账
     * 2019.10.16 决定以客户单据编号作为订单唯一判定标准，重复则认为订单重复
     */
    private String clientOrderSn2;

    /**
     * clientOperator 客户订单号操作人员信息，加进用来和客户进行对账
     */
    private String clientOperator;

    /**
     * flowSN 流水号，按照时间戳自动生成
     */
    private String flowSn;

    /**
     * autoIncreaseSn 自定义单据号，自动增长型，可自定义重新从1开始
     */
    private String autoIncreaseSn;

    /**
     * stockTotalPrice 实际匹配出库总价
     */
    private BigDecimal totalPrice;

    /**
     * isSatisfied 订单出货是否完整，如没有出货项目的订单默认也为false
     */
    private Boolean isSatisfied;

    /**
     * orderStatus 订单状态，订单流转的重要判断依据
     */
    private OrderStatus orderStatus;

    /**
     * isPrinted 订单是否已经打印
     */
    private Boolean isPrinted;

    /**
     * isActive 是否为有效状态，作废则为无效
     */
    private Boolean isActive;

    /**
     * cancelDescription 作废原因
     */
    private String cancelDescription;

    /**
     * completeDescription 回执完成说明
     */
    private String completeDescription;

    /**
     * completePrice 回执完成确认订单金额
     */
    private BigDecimal completePrice;

    /**
     * targetWareZones 出货指定的匹配仓库区域
     */
    private String targetWareZones;

    /**
     * usePackCount 在指定商品出库时，是否强制匹配商品的规格
     */
    private Boolean usePackCount;

    /**
     * signTime 订单签收时间
     */
    private Timestamp signTime;

    /**
     * 签收状态
     */
    private ReceiveType receiveType;

    /**
     * 订单创建人
     */
    @ManyToOne
    @Fetch(FetchMode.JOIN)
    private User userCreator;

    /**
     * 订单分拣人
     */
    @ManyToOne
    @Fetch(FetchMode.JOIN)
    private User userGathering;

    /**
     * 订单复核人
     */
    @ManyToOne
    @Fetch(FetchMode.JOIN)
    private User userReviewer;

    /**
     * 订单派送人
     */
    @ManyToOne
    @Fetch(FetchMode.JOIN)
    private User userSending;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "customerOrder", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    @OrderBy("sortOrder asc")
    private List<CustomerOrderItem> customerOrderItems;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "customerOrder", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    @OrderBy("sortOrder asc")
    private List<CustomerOrderStock> customerOrderStocks;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "customerOrder", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    @OrderBy("createTime asc")
    private List<StockFlow> stockFlows;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "customerOrder", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    @OrderBy("id asc")
    private List<OperateSnapshot> operateSnapshots;

    @JSONField(serialize = false)
    @ManyToOne(fetch = FetchType.LAZY)
    private Pack pack;


}