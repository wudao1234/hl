package org.mstudio.modules.wms.customer_order.service;

import org.mstudio.modules.wms.address.domain.Address;
import org.mstudio.modules.wms.common.MultiOperateResult;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.customer_order.domain.OrderStatus;
import org.mstudio.modules.wms.customer_order.service.object.*;
import org.mstudio.modules.wms.goods.domain.Goods;
import org.mstudio.modules.wms.kpi.Object.OrderSales;
import org.springframework.data.domain.Pageable;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
* @author Macrow
* @date 2019-02-22
*/

public interface CustomerOrderService {

    CustomerOrderDTO create(CustomerOrder resource, Boolean useNewAutoIncreaseSn, Boolean fetchStocks);

    void fetchStocks(CustomerOrder order);

    void cancel(CustomerOrder order, String cancelDescription);

    void cancel(Long id, String description);

    void delete(Long id);

    void returnStock(CustomerOrder order);

    void returnStock(Long id);

    void gatherGoods(CustomerOrder order,String pageFlowSn,Long userId);

    void gatherGoods(Long id,String pageFlowSn,Long userId);

    void unGatherGoods(CustomerOrder order, Long userId, String pageFlowSn);

    void unGatherGoods(Long id, Long userId, String pageFlowSn);

    void completeGatherGoods(Long id,String pageFlowSn);

    void unCompleteGatherGoods(CustomerOrder order,String pageFlowSn);

    void unCompleteGatherGoods(Long id,String pageFlowSn);

    void confirm(CustomerOrder order,Long userId,String pageFlowSn);

    void confirm(Long id,Long userId,String pageFlowSn);

    void unConfirm(CustomerOrder order);

    void unConfirm(Long id);

    void complete(CustomerOrderCompleteDTO customerOrderCompleteDTO);

    void updateComplete(CustomerOrderCompleteDTO customerOrderCompleteDTO);

    MultiOperateResult batchFetchStocks(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO);

    MultiOperateResult batchCancel(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO);

    MultiOperateResult batchDelete(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO);

    MultiOperateResult batchGatherGoods(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO);

    MultiOperateResult batchUnGatherGoods(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO);

    MultiOperateResult batchCompleteGatherGoods(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO);

    MultiOperateResult batchUnCompleteGatherGoods(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO);

    MultiOperateResult batchConfirm(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO);

    MultiOperateResult batchUnConfirm(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO);

    MultiOperateResult batchReturnStock(CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO);

    CustomerOrderDTO findById(Long id);

    CustomerOrderDTO findByIdAndQueryQuantityLeft(Long id);

    void update(Long id, CustomerOrder resources, Boolean useNewAutoIncreaseSn, Boolean fetchStocks);

    Map queryAll(Set<CustomerVO> customers, Boolean exportExcel, Boolean isPrintedFilter, String isSatisfiedFilter, String customerFilter, String orderStatusFilter, String receiveTypeFilter, Boolean isActiveFilter, String startDate, String endDate, String search, Pageable pageable);

    Map listForPack(String customerFilter, String search, Pageable pageable);

    Map listForComplete(Set<CustomerVO> customers, Boolean exportExcel, String customerFilter, String packTypeFilter, String receiveTypeFilter, String startDate, String endDate, String search, Pageable pageable);

    String getLastAutoIncreaseSn(Long customerId);

    byte[] exportExcelData(List<CustomerOrderVO> orders);

    byte[] batchPrint(String orderIds, Boolean isOriginal) throws IOException;

    MultiOperateResult importKingdee(CustomerOrderImporterDTO customerOrderImporterDTO);

    MultiOperateResult importKingdee2(CustomerOrderImporterDTO customerOrderImporterDTO);

    MultiOperateResult importHtml(CustomerOrderImporterDTO customerOrderImporterDTO);

    MultiOperateResult importGeneral(CustomerOrderImporterDTO customerOrderImporterDTO);

    Integer countByOwnerId(Long id);

    Integer countByCreateTimeBetween(Date startDate, Date endDate);

    Integer countByOrderStatus(OrderStatus orderStatus);

    Integer countByOrderStatusAndUpdateTimeBetween(OrderStatus orderStatus, Date startDate, Date endDate);

    BigDecimal countTotalPriceByCreateTimeBetween(Date startDate, Date endDate);

    List<OrderSales> queryOrderSales(String type, String date);

    byte[] batchPrintPageInfo(String orderIds) throws IOException;

    Address getAddressByClientStore(String clientStore);

    Goods getGoodsByCustomerAndNameAndSn(Long id, String name, String sn);

    CustomerOrderDTO findByCustomerOrderPagesId(Long id);

    Address getAddressByClientStoreAndAddressType(String clientStore, String AddressType);
}