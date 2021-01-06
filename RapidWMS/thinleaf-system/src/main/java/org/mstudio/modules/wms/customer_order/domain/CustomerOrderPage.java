package org.mstudio.modules.wms.customer_order.domain;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.wms.common.BaseEntity;

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
     * num 第几页
     */
    private Integer num;

    /**
     * orderStatus 订单状态，订单流转的重要判断依据
     */
    private OrderStatus orderStatus;

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
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    private CustomerOrder customerOrder;

}