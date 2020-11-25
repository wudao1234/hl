package org.mstudio.modules.wms.ware_zone.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.ware_position.service.object.WarePositionVO;

import java.util.List;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class WareZoneDTO extends BaseObject {

    private String name;

    private String description;

    private Integer sortOrder;

    private List<WarePositionVO> warePositions;

}