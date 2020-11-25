package org.mstudio.modules.wms.pack.service;

import org.mstudio.modules.wms.common.MultiOperateResult;
import org.mstudio.modules.wms.customer_order.domain.OrderStatus;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.mstudio.modules.wms.pack.domain.PackItem;
import org.mstudio.modules.wms.customer_order.domain.ReceiveType;
import org.mstudio.modules.wms.pack.service.object.PackDTO;
import org.mstudio.modules.wms.pack.service.object.PackMultipleOperateDTO;
import org.mstudio.modules.wms.pack.service.object.PackVO;
import org.mstudio.modules.wms.stock_flow.service.object.StockFlowVO;
import org.springframework.data.domain.Pageable;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
* @author Macrow
* @date 2019-04-24
*/

public interface PackService {

    Map queryAll(Boolean exportExcel, Boolean isPrintedFilter, Boolean isPackagedFilter, String customerFilter, String addressTypeFilter, String packTypeFilter, String receiveTypeFilter, String packStatusFilter, String userNameFilter, String startDate, String endDate, String search, String searchAddress, String searchOrderSn, Pageable pageable);

    PackDTO create(Pack resource);

    PackDTO findById(Long id);

    PackDTO update(Long id, Pack resource);

    PackDTO packages(Long id, List<PackItem> packItems);

    List<StockFlowVO> getStockFlows(Long id);

    void delete(Long id);

    void cancel(Long id, String cancelDescription);

    void sending(Long id, Long sendingUserId, Boolean sendingByMe);

    void returnPack(Long id);

    void signed(Long id, String signedPhoto);

    void complete(Long id, ReceiveType receiveType);

    void updateComplete(Long id, ReceiveType receiveType);

    void sendingByMeAndFlowSn(String packFlowSn);

    List<PackVO> listSendingPacksGroupByUsers();

    List<PackVO> listSendingPacksByUserId(Long id);

    MultiOperateResult batchCancel(PackMultipleOperateDTO packMultipleOperateDTO);

    MultiOperateResult batchDelete(PackMultipleOperateDTO packMultipleOperateDTO);

    MultiOperateResult batchSending(PackMultipleOperateDTO packMultipleOperateDTO);

    MultiOperateResult sendingByMe(PackMultipleOperateDTO packMultipleOperateDTO);

    MultiOperateResult batchReturnPack(PackMultipleOperateDTO packMultipleOperateDTO);

    MultiOperateResult batchSigned(PackMultipleOperateDTO packMultipleOperateDTO);

    MultiOperateResult batchComplete(PackMultipleOperateDTO packMultipleOperateDTO);

    MultiOperateResult batchUpdateComplete(PackMultipleOperateDTO packMultipleOperateDTO);

    byte[] batchPrint(String orderIds) throws IOException;

    byte[] exportExcelData(List<PackVO> packs);

    Integer countDetailByCreateTimeBetween(Date startDate, Date endDate);

    Integer countByCreateTimeBetween(Date startDate, Date endDate);

    Integer countDetailByPackStatus(OrderStatus orderStatus);

    Integer countByPackStatus(OrderStatus orderStatus);

    void changeSignedPhoto(Long id, String signedPhoto);

}