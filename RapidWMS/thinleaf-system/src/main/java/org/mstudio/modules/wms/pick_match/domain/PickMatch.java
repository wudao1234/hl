package org.mstudio.modules.wms.pick_match.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.system.service.dto.UserVO;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.pack.domain.Pack;

import javax.persistence.*;

/**
 * 拣配 计件
* @author lfj
* @date 2020-12-01
*/

@Data
@Entity
@Table(name = "wms_pick_match")
@org.hibernate.annotations.Table(appliesTo = "wms_pick_match",comment = "拣配/复核计件")
public class PickMatch extends BaseEntity {

    /**
     * 计件单价
     */
    private Float piece;

    /**
     *金额系数
     */
    private Float money;

    /**
     * 拣配系数
     */
    private Float pickMatch;

    /**
     * 复核系数
     */
    private Float review;

    /**
     * 拣配/复核
     */
    private PickMatchType type;

    /**
     * 分数
     */
    private Float score;

    /**
     * 拣配、复核人
     */
    @JSONField(serialize = false)
    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private User user;

    /**
     * 计件对应的包
     */
    @JSONField(serialize = false)
    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private Pack pack;
}