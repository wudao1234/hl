package org.mstudio.modules.wms.ware_zone.service.object;

import lombok.Data;

/**
 * @author Macrow
 * @date 2019-05-08
 */

@Data
public class WareZoneExcelObj {

    private Long index;

    private String name;

    private Integer sortOrder;

    private Integer warePositionCount;

    private String description;

}
