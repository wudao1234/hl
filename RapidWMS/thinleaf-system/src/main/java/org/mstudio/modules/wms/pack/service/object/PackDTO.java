package org.mstudio.modules.wms.pack.service.object;

import lombok.Data;
import org.mstudio.modules.system.service.dto.UserVO;
import org.mstudio.modules.wms.Logistics.service.object.LogisticsTemplateVO;
import org.mstudio.modules.wms.address.service.object.AddressVO;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.customer_order.domain.OrderStatus;
import org.mstudio.modules.wms.customer_order.domain.ReceiveType;
import org.mstudio.modules.wms.customer_order.service.object.CustomerOrderVO;
import org.mstudio.modules.wms.operate_snapshot.service.object.OperateSnapshotVO;
import org.mstudio.modules.wms.pack.domain.PackType;

import java.math.BigDecimal;
import java.util.List;

/**
* @author Macrow
* @date 2019-04-24
*/

@Data
public class PackDTO extends BaseObject {

    private CustomerVO customer;

    private List<CustomerOrderVO> orders;

    private AddressVO address;

    private UserVO user;

    private PackType packType;

    private OrderStatus packStatus;

    private String flowSn;

    private Integer packages;

    private BigDecimal totalPrice;

    private Boolean isPrinted;

    private String signedPhoto;

    private Boolean isActive;

    private String cancelDescription;

    private String completeDescription;

    private String trackingNumber;

    private String description;

    private Boolean isPackaged;

    private ReceiveType receiveType;

    private List<PackItemVO> packItems;

    private List<OperateSnapshotVO> operateSnapshots;

    private LogisticsTemplateVO logisticsTemplate;

    private Float weight;

}