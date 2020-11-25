package org.mstudio.modules.wms.ware_zone.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class WareZoneVO extends BaseObject {

    private String name;

    private String description;

    private Integer sortOrder;

    private Integer warePositionCount;

}