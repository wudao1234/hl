package org.mstudio.modules.wms.ware_position.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class WarePositionVO extends BaseObject {

    private String name;

    private String description;

    private Integer sortOrder;

}