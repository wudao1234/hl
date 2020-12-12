package org.mstudio.modules.wms.dispatch.service.object;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.dispatch.domain.DispatchStatusEnum;
import org.mstudio.modules.wms.dispatch.domain.DispatchSys;
import org.mstudio.modules.wms.pack.domain.Pack;

import javax.persistence.*;
import java.util.List;

/**
 * 配送 计件 系数
 *
 * @author lfj
 * @date 2020-12-01
 */

@Data
public class DispatchPieceVO extends BaseObject {

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

}