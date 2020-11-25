package org.mstudio.modules.wms.customer_order.service.object;

import lombok.Data;
import org.mstudio.modules.system.service.dto.UserVO;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.customer_order.domain.OrderStatus;
import org.mstudio.modules.wms.customer_order.domain.ReceiveType;
import org.mstudio.modules.wms.operate_snapshot.service.object.OperateSnapshotVO;
import org.mstudio.modules.wms.stock_flow.service.object.StockFlowVO;
import org.mstudio.modules.wms.ware_zone.service.object.WareZoneVO;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class CustomerOrderDTO extends BaseObject {

    private CustomerVO owner;

    private String printTitle;

    private String description;

    private String clientName;

    private String clientStore;

    private String clientAddress;

    private Boolean fetchAll;

    private Date expireDateMin;

    private Date expireDateMax;

    private String clientOrderSn;

    private String clientOrderSn2;

    private String clientOperator;

    private String flowSn;

    private String autoIncreaseSn;

    private BigDecimal totalPrice;

    private OrderStatus orderStatus;

    private Boolean isActive;

    private String cancelDescription;

    private String completeDescription;

    private BigDecimal completePrice;

    private Boolean isSatisfied;

    private Boolean isPrinted;

    private String targetWareZones;

    private Boolean usePackCount;

    private UserVO userCreator;

    private UserVO userGathering;

    private UserVO userSending;

    private Timestamp signTime;

    private ReceiveType receiveType;

    private List<CustomerOrderItemVO> customerOrderItems;

    private List<CustomerOrderStockVO> customerOrderStocks;

    private List<StockFlowVO> stockFlowItems;

    private List<OperateSnapshotVO> operateSnapshots;

    private List<WareZoneVO> targetWareZoneList;

}