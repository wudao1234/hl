package org.mstudio.modules.wms.ware_position.service.object;

import lombok.Data;

/**
 * @author Macrow
 * @date 2019-05-08
 */

@Data
public class WarePositionExcelObj {

    private Long index;

    private String name;

    private Integer sortOrder;

    private String description;

    private String wareZoneName;

    private Long stockCount;

}
