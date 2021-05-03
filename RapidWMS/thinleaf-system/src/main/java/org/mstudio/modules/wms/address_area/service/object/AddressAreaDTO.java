package org.mstudio.modules.wms.address_area.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

/**
* @author Macrow
* @date 2019-07-09
*/

@Data
public class AddressAreaDTO extends BaseObject {

    private String name;

    private Integer sortOrder;

    private Integer addressCount;

}