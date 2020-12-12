package org.mstudio.modules.wms.dispatch.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.mstudio.modules.wms.stock.domain.Stock;

import javax.persistence.*;
import java.util.List;

/**
 * 配送 计件 系数
 *
 * @author lfj
 * @date 2020-12-01
 */

@Data
@Entity
@Table(name = "wms_dispatch_piece")
@org.hibernate.annotations.Table(appliesTo = "wms_dispatch_piece", comment = "配送计件信息")
public class DispatchPiece extends BaseEntity {

    /**
     * 门店数单价
     */
    private Float storePrice;

    /**
     * 门店数
     */
    private Integer storeNum;

    /**
     * 件数单价
     */
    private Float dispatchPrice;

    /**
     * 件数
     */
    private Integer dispatchSum;

    /**
     * 里程单价
     */
    private Float mileagePrice;

    /**
     * 里程数
     */
    private Float mileage;

    /**
     * 总分数
     */
    private Float score;

    /**
     * 状态
     */
    private DispatchStatusEnum status;

    /**
     * 配送人
     */
    @JSONField(serialize = false)
    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private User user;

    /**
     * 配送打包
     */
    @JSONField(serialize = false)
    @OneToMany(mappedBy = "dispatchPiece", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<Pack> packs;

    /**
     * 系统系数
     */
    @JSONField(serialize = false)
    @ManyToOne(fetch = FetchType.LAZY)
    @Fetch(FetchMode.JOIN)
    private DispatchSys dispatchSys;

}