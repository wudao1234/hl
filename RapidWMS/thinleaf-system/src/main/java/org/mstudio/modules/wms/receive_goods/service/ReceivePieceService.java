package org.mstudio.modules.wms.receive_goods.service;

import org.mstudio.modules.wms.dispatch.domain.DispatchPiece;
import org.mstudio.modules.wms.receive_goods.domain.RcceiveCoefficient;
import org.springframework.data.domain.Pageable;

import java.util.Map;

/**
 * @author lfj
 */

public interface ReceivePieceService {

    Map queryAll(Pageable pageable);

    Map querySysAll(Pageable pageable);

    RcceiveCoefficient update(Long id, RcceiveCoefficient resource);

    RcceiveCoefficient findById(Long id);

    Map statistics(String startDate, String endDate, String search, Pageable pageable);

    Long save();

    DispatchPiece finish(Float mileage, Long dispatchSys);

}