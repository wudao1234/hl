package org.mstudio.modules.wms.fixed_estate.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

/**
* @author Macrow
* @date 2019-07-09
*/

@Data
public class FixedEstateDTO extends BaseObject {

    /**
     * 固定资产名称
     */
    private String assetsName;

    /**
     * 录入人姓名
     */
    private String assetsInputOperator;

    /**
     * 固定资产类别
     */
    private String assetsType;

    /**
     * 备注
     */
    private String assetsDescription;

}