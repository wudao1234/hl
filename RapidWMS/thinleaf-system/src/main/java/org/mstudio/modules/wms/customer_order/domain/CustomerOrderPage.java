package org.mstudio.modules.wms.customer_order.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.mstudio.modules.wms.stock_flow.domain.StockFlow;

import javax.persistence.*;
import java.util.List;

/**
 * 订单分页信息
 *
 * @author Macrow
 * @date 2019-02-22
 */

@Data
@Entity
@Table(name = "wms_customer_order_page")
public class CustomerOrderPage extends BaseEntity {

    /**
     * flowSN 流水号，按照时间戳自动生成
     */
    private String flowSn;

    /**
     * orderStatus 订单状态，订单流转的重要判断依据
     */
    private OrderStatus orderStatus;

    /**
     * 签收状态
     */
    private ReceiveType receiveType;

    /**
     * 打包信息据
     */
    @JSONField(serialize = false)
    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private Pack pack;

    /**
     * 订单分拣人
     */
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "wms_join_table_customer_orders_page_userGatherings")
    @Fetch(FetchMode.SUBSELECT)
    private List<User> userGatherings;

    /**
     * 订单复核人
     */
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "wms_join_table_customer_orders_page_userReviewers")
    @Fetch(FetchMode.SUBSELECT)
    private List<User> userReviewers;

    /**
     * 订单信息
     */
    @JSONField(serialize = false)
    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private CustomerOrder customerOrder;

    /**
     * 出库流水
     */
    @JSONField(serialize = false)
    @OneToMany(mappedBy = "customerOrderPage", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    @OrderBy("createTime asc")
    private List<StockFlow> stockFlows;

    /**
     * 订单派送人
     */
    @ManyToOne
    @Fetch(FetchMode.JOIN)
    private User userSending;

}