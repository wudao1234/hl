package org.mstudio.modules.wms.dispatch.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

/**
* @author Macrow
* @date 2019-07-09
*/

@Data
public class DispatchSysDTO extends BaseObject {

    private String name;

    private Float value;

}