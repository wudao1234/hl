package org.mstudio.modules.wms.pack.service.object;

import lombok.Data;
import org.mstudio.modules.wms.pack.domain.PackItem;

import java.io.Serializable;
import java.util.List;

/**
* @author Macrow
* @date 2019-04-11
*/

@Data
public class PackPackageDTO implements Serializable {

    private Long id;

    private List<PackItem> packItems;

}