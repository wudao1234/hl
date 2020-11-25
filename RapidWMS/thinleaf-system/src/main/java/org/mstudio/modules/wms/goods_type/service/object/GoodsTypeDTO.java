package org.mstudio.modules.wms.goods_type.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class GoodsTypeDTO extends BaseObject {

    private String name;

    private Integer sortOrder;

    private Integer goodsCount;

}