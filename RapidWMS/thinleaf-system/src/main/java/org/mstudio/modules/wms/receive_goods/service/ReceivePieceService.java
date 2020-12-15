package org.mstudio.modules.wms.receive_goods.service;

import org.mstudio.modules.wms.receive_goods.domain.RcceiveCoefficient;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoods;
import org.springframework.data.domain.Pageable;

import java.util.Map;

/**
 * @author lfj
 */

public interface ReceivePieceService {

    Map queryAll(Pageable pageable);

    RcceiveCoefficient update(Long id, RcceiveCoefficient resource);

    RcceiveCoefficient findById(Long id);

    Map statistics(String startDate, String endDate, String search, Pageable pageable);

    void save(ReceiveGoods params);

    void cancel(ReceiveGoods params);

}