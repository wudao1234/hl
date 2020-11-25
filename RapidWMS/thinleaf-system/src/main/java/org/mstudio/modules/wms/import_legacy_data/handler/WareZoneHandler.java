package org.mstudio.modules.wms.import_legacy_data.handler;

import cn.hutool.poi.excel.sax.handler.RowHandler;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.mstudio.modules.wms.ware_zone.domain.WareZone;
import org.mstudio.modules.wms.ware_zone.service.WareZoneService;

import java.util.List;

/**
 * @author Macrow
 * @date 2019-03-27
 */

@Slf4j
@AllArgsConstructor
public class WareZoneHandler implements RowHandler {

    private final static int NAME = 1;
    private final static int DESCRIPTION = 2;

    private WareZoneService wareZoneService;

    @Override
    public void handle(int i, int i1, List<Object> list) {
        log.info("[{}] [{}] {}", i, i1, list);
        WareZone zone = new WareZone();

        if (list.get(DESCRIPTION) != null) {
            zone.setDescription(list.get(DESCRIPTION).toString());
        }

        if (list.get(NAME) != null && !list.get(NAME).toString().isEmpty()) {
            zone.setName(list.get(NAME).toString());
            wareZoneService.create(zone);
        }
    }

}
