package org.mstudio.modules.wms.customer.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.system.service.dto.UserVO;

import java.util.List;

/**
 * @author Macrow
 * @date 2019-02-22
 */

@Data
public class CustomerDTO extends BaseObject {

    private String name;

    private String shortNameEn;

    private String shortNameCn;

    private Integer goodsCount;

    private Integer ordersCount;

    private List<UserVO> users;

}