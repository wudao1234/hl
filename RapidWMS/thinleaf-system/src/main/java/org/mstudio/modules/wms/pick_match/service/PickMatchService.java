package org.mstudio.modules.wms.pick_match.service;

import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.wms.address_type.domain.AddressType;
import org.mstudio.modules.wms.address_type.service.object.AddressTypeDTO;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.pick_match.domain.PickMatch;
import org.mstudio.modules.wms.pick_match.domain.PickMatchCoefficient;
import org.mstudio.modules.wms.pick_match.domain.PickMatchType;
import org.springframework.data.domain.Pageable;

import java.util.Map;

/**
 * @author lfj
 */

public interface PickMatchService {

    Map queryAll(Pageable pageable);

    PickMatchCoefficient update(Long id, PickMatchCoefficient resource);

    PickMatchCoefficient findById(Long id);

    void create(CustomerOrder order, PickMatchType type);

    Map statistics(String name, Pageable pageable);
}