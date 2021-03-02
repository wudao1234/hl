package org.mstudio.modules.wms.dispatch.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.dispatch.domain.DispatchStatusEnum;

@Data
public class DispatchPieceDTO extends BaseObject {

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
