package org.mstudio.modules.wms.customer.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.validator.constraints.Length;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.goods.domain.Goods;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoods;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import java.util.List;

/**
 * @author Macrow
 * @date 2019-02-22
 */

@Data
@Entity
@Table(name = "wms_customer")
public class Customer extends BaseEntity {

    @NotBlank(message = "客户名称必须填写")
    @Length(min = 2, max = 255)
    private String name;

    @NotBlank(message = "英文简称必须填写")
    @Length(max = 20)
    @Pattern(regexp = "([a-zA-Z]){2,20}",message = "英文简称格式错误")
    private String shortNameEn;

    @NotBlank(message = "中文简称必须填写")
    @Length(max = 20)
    private String shortNameCn;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "customer", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<Goods> goods;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "owner", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<CustomerOrder> orders;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "customer", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<ReceiveGoods> receiveGoods;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "wms_join_table_customers_users")
    @Fetch(FetchMode.SUBSELECT)
    private List<User> users;

}