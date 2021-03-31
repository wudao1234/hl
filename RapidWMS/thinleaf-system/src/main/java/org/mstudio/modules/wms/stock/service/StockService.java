package org.mstudio.modules.wms.stock.service;

import org.mstudio.modules.wms.common.MultiOperateResult;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoods;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoodsItem;
import org.mstudio.modules.wms.stock.dto.*;
import org.mstudio.modules.wms.stock.service.object.StockActivateDTO;
import org.mstudio.modules.wms.stock.service.object.StockDTO;
import org.mstudio.modules.wms.stock.service.object.StockMultipleOperateDTO;
import org.mstudio.modules.wms.stock.service.object.StockSingleOperateDTO;
import org.springframework.data.domain.Pageable;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
* @author Macrow
* @date 2019-02-22
*/

public interface StockService {

    Map queryAll(Set<CustomerVO> customers, Boolean exportExcel, String wareZoneFilter, String customerFilter, String goodsTypeFilter, Boolean isActiveFilter, String search, Pageable pageable,Double quantityGuaranteeSearch,Boolean isSingle);

    Map queryAll(Set<CustomerVO> customers, Boolean exportExcel, String wareZoneFilter, String customerFilter, String goodsTypeFilter, Boolean isActiveFilter, String search, Pageable pageable,Double quantityGuaranteeSearch);

    StockDTO findById(Long id);

    List<StockDTO> QueryByCustomerIdAndGoodsSnAndPackCount(Long customerId, String goodsSn, Integer packCount);

    Long countByGoodsId(Long goodsId);

    Long countByWarePositionId(Long warePositionId);

    Long countByGoodsIdAndWarePositionIdAndExpireTime(Long goodsId, Long warePositionId, Date expireTime);

    byte[] exportExcelData(List<StockDTO> stocks);

    byte[] exportSingleExcelData(List<StockDTO> stocks);

    // ========================= 下列涉及更改操作的接口，全部暂时用串行操作处理，保证库存正确 =========================

    void add(AddDTO addDTO);

    Boolean reduce(ReduceDTO reduceDTO);

    Boolean reduceForOrderItem(ReduceForOrderItemDTO reduceForOrderItemDTO);

    Boolean reduceForOrderStock(ReduceForOrderStockDTO reduceForOrderStockDTO);

    Boolean reduceForReceiveGoods(ReceiveGoodsItem receiveGoodsItem);

    void activate(StockActivateDTO stockActivateDTO);

    void singleOperate(StockSingleOperateDTO stockSingleOperateDTO);

    MultiOperateResult multipleOperate(StockMultipleOperateDTO stockMultipleOperateDTO);

    void receiveGoods(ReceiveGoods receiveGoods);

    Boolean cancelReceiveGoods(ReceiveGoods receiveGoods);

    void updateExpireDate(UpdateExpireDateDTO updateExpireDateDTO);

    void move(MoveDTO moveDTO);

    void updateQuantityGuarantee();
}