package org.mstudio.modules.wms.pack.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;

import java.util.Date;

/**
 * @author Macrow
 * @date 2019-07-06
 */

@Data
public class PackItemVO extends BaseObject {

    private Integer number;

    private Integer quantity;

    private String name;

    private String sn;

    private Date expireDate;

}
