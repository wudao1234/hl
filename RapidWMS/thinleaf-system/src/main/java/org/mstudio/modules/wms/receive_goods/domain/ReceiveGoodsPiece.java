package org.mstudio.modules.wms.receive_goods.domain;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.wms.common.BaseEntity;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * 配送 计件 系数
 *
 * @author lfj
 * @date 2020-12-01
 */

@Data
@Entity
@Table(name = "wms_receive_goods_piece")
@org.hibernate.annotations.Table(appliesTo = "wms_receive_goods_piece", comment = "入库计件信息")
public class ReceiveGoodsPiece extends BaseEntity {

    /**
     * 计件单价
     */
    private Float price;

    /**
     * 件数
     */
    private Long packages;

    /**
     * 员工系数
     */
    private Float staffPrice;

    /**
     * 总分数
     */
    private Float score;

    /**
     * 类型
     */
    private ReceiveGoodsPieceTypeEnum type;

    /**
     * 计件人
     */
    @JSONField(serialize = false)
    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private User user;

    /**
     * 入库商品
     */
    @JSONField(serialize = false)
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    private ReceiveGoods receiveGoodses;
}