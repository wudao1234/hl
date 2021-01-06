package org.mstudio.modules.wms.customer_order.service.object;

import lombok.Data;
import org.mstudio.modules.system.service.dto.UserVO;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.customer_order.domain.OrderStatus;

import java.util.List;

/**
 * 订单分页信息VO
 *
 * @author Macrow
 * @date 2019-02-22
 */

@Data
public class CustomerOrderPageVO extends BaseObject {
    private String flowSn;
    private Integer num;
    private OrderStatus orderStatus;
    private List<UserVO> userGatherings;
    private List<UserVO> userReviewers;
}