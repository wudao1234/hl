package org.mstudio.modules.wms.receive_goods.service;

import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoods;
import org.mstudio.modules.wms.receive_goods.service.object.ReceiveGoodsDTO;
import org.mstudio.modules.wms.receive_goods.service.object.ReceiveGoodsVO;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
* @author Macrow
* @date 2019-02-22
*/

public interface ReceiveGoodsService {

    Map queryAll(Set<CustomerVO> customers, Boolean exportExcel, String customerFilter, String receiveGoodsTypeFilter, Boolean isAuditedFilter, String startDate, String endDate, String search, Pageable pageable);

    ReceiveGoodsDTO create(ReceiveGoods resource);

    ReceiveGoodsDTO update(Long id, ReceiveGoods resource);

    ReceiveGoodsVO audit(ReceiveGoods resource);

    ReceiveGoodsVO cancelAudit(ReceiveGoods resource);

    void delete(Long id);

    ReceiveGoodsDTO findById(Long id);

    byte[] exportExcelData(List<ReceiveGoodsVO> receiveGoods);

}