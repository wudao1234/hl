package org.mstudio.modules.wms.address.service.object;

import lombok.Data;
import org.mstudio.modules.wms.address_type.service.object.AddressTypeVO;
import org.mstudio.modules.wms.common.BaseObject;

/**
* @author Macrow
* @date 2019-04-24
*/

@Data
public class AddressVO extends BaseObject {

    private AddressTypeVO addressType;

    private String name;

    private String contact;

    private String phone;

    private String description;

    private Float coefficient;

}