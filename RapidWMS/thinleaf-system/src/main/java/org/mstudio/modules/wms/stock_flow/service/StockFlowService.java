package org.mstudio.modules.wms.stock_flow.service;

import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.goods.domain.Goods;
import org.mstudio.modules.wms.kpi.Object.TopSales;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoods;
import org.mstudio.modules.wms.stock_flow.domain.StockFlowType;
import org.mstudio.modules.wms.stock_flow.service.object.StockFlowDTO;
import org.mstudio.modules.wms.ware_position.domain.WarePosition;
import org.springframework.data.domain.Pageable;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
* @author Macrow
* @date 2019-02-22
*/

public interface StockFlowService {

    StockFlowDTO findById(Long id);

    void delete(Long id);

    Map queryAll(Set<CustomerVO> customers, Boolean exportExcel, String flowOperateTypeFilter, String customerFilter, String wareZoneInFilter, String wareZoneOutFilter, String startDate, String endDate, String search, String searchWarePositionIn, String searchWarePositionOut, Pageable pageable);

    Map queryForOrders(Set<CustomerVO> customers, Boolean exportExcel, String customerFilter, String wareZoneOutFilter, String startDate, String endDate, String search, String searchWarePositionOut, Pageable pageable);

    void create(StockFlowType stockFlowType, String goodsSn, String goodsName, Long quantity, BigDecimal price, Date expireDate, Integer packCount, String unit, CustomerOrder order, ReceiveGoods receiveGoods, Goods goods, WarePosition warePositionIn, WarePosition warePositionOut, String operator, String description);

    List<StockFlowDTO> queryAllByOrderId(Long orderId);

    List<StockFlowDTO> queryAllByReceiveGoodsId(Long receiveGoodsId);

    byte[] exportExcelDataForOrder(List<StockFlowDTO> stockFlows);

    byte[] exportExcelData(List<StockFlowDTO> stockFlows);

    List<TopSales> queryTopSales(String type);

    Long countSalesByGoodsIdBetween(Long goodsId, Date startDate, Date endDate);

}