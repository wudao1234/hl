package org.mstudio.modules.wms.address.service.object;

import lombok.Data;
import org.mstudio.modules.wms.address_type.service.object.AddressTypeVO;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.pack.service.object.PackVO;

import java.util.List;

/**
* @author Macrow
* @date 2019-04-24
*/

@Data
public class AddressDTO extends BaseObject {

    private List<PackVO> packs;

    private AddressTypeVO addressType;

    private String name;

    private String contact;

    private String phone;

    private String description;

}