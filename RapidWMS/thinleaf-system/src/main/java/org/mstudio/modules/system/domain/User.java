package org.mstudio.modules.system.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.wms.customer.domain.Customer;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.dispatch.domain.DispatchPiece;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.mstudio.modules.wms.pick_match.domain.PickMatch;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoods;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoodsPiece;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * @date 2018-11-22
 */
@Entity
@Data
@Table(name = "user")
public class User implements Serializable {

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "unloadUser", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<ReceiveGoods> unloadGoods;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "receiveUser", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<ReceiveGoods> receiveGoods;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @NotNull(groups = Update.class)
    private Long id;

    @NotBlank
    private String username;

    private String avatar;

    @NotBlank
    @Email
    private String email;

    private Float coefficient;

    @NotNull
    private Boolean enabled;

    private String password;

    @CreationTimestamp
    @Column(name = "create_time")
    private Timestamp createTime;

    @Column(name = "last_password_reset_time")
    private Date lastPasswordResetTime;

    @ManyToMany
    @JoinTable(name = "users_roles", joinColumns = {@JoinColumn(name = "user_id", referencedColumnName = "id")}, inverseJoinColumns = {@JoinColumn(name = "role_id", referencedColumnName = "id")})
    private Set<Role> roles;

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", avatar='" + avatar + '\'' +
                ", email='" + email + '\'' +
                ", enabled=" + enabled +
                ", password='" + password + '\'' +
                ", createTime=" + createTime +
                ", lastPasswordResetTime=" + lastPasswordResetTime +
                '}';
    }

    public @interface Update {
    }

    @JSONField(serialize = false)
    @ManyToMany(mappedBy = "users", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<Customer> customers;

    /**
     * 配送和打包的打包
     */
    @JSONField(serialize = false)
    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<Pack> packs;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "userCreator", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<CustomerOrder> ordersCreator;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "userReviewer", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<CustomerOrder> ordersReviewer;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "userGathering", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<CustomerOrder> ordersGathering;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "userSending", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<CustomerOrder> ordersSending;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<PickMatch> pickMatchs;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<DispatchPiece> dispatchPieces;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<ReceiveGoodsPiece> receiveGoodsPieces;
}