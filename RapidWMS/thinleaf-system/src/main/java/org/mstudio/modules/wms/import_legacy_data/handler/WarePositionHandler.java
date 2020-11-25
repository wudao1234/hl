package org.mstudio.modules.wms.import_legacy_data.handler;

import cn.hutool.poi.excel.sax.handler.RowHandler;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.mstudio.modules.wms.ware_position.domain.WarePosition;
import org.mstudio.modules.wms.ware_position.service.WarePositionService;
import org.mstudio.modules.wms.ware_zone.domain.WareZone;
import org.mstudio.modules.wms.ware_zone.repository.WareZoneRepository;

import java.util.List;
import java.util.Optional;

/**
 * @author Macrow
 * @date 2019-03-27
 */

@Slf4j
@AllArgsConstructor
public class WarePositionHandler implements RowHandler {

    private final static int NAME = 1;
    private final static int DESCRIPTION = 6;

    private final static int WARE_ZONE_NAME = 5;

    private WarePositionService warePositionService;
    private WareZoneRepository wareZoneRepository;

    @Override
    public void handle(int i, int i1, List<Object> list) {
        log.info("[{}] [{}] {}", i, i1, list);
        WarePosition position = new WarePosition();
        position.setName(list.get(NAME).toString());

        if (list.get(DESCRIPTION) != null) {
            position.setDescription(list.get(DESCRIPTION).toString());
        }

        if (list.get(WARE_ZONE_NAME) != null && !list.get(WARE_ZONE_NAME).toString().isEmpty()) {
            Optional<WareZone> optionalWareZone = wareZoneRepository.findByName(list.get(WARE_ZONE_NAME).toString());
            if (optionalWareZone.isPresent()) {
                position.setWareZone(optionalWareZone.get());
            }
            warePositionService.create(position);
        }
    }

}
