package org.mstudio.modules.wms.ware_zone.rest;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.common.WmsUtil;
import org.mstudio.modules.wms.ware_zone.domain.WareZone;
import org.mstudio.modules.wms.ware_zone.service.WareZoneService;
import org.mstudio.modules.wms.ware_zone.service.object.WareZoneVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
* @author Macrow
* @date 2019-02-22
*/

@RestController
@RequestMapping("api/ware_zones")
public class WareZoneController {

    @Autowired
    private WareZoneService wareZoneService;

    private static final String ENTITY_NAME = "WareZone";

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_WARE_ZONE_LIST')")
    public ResponseEntity list(@RequestParam(value = "exportExcel", required = false) Boolean exportExcel, @RequestParam(value = "search", required = false) String search, Pageable pageable) {
        if (exportExcel != null && exportExcel) {
            Map result = wareZoneService.queryAll(true, search, pageable);
            List<WareZoneVO> wareZones = (List)result.get("content");
            return new ResponseEntity<>(wareZoneService.exportExcelData(wareZones), WmsUtil.getExportExcelHeaders(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(wareZoneService.queryAll(false, search, pageable), HttpStatus.OK);
        }
    }

    @GetMapping("/all_list")
    @PreAuthorize("isAuthenticated()")
    public Object allList() {
        return new ResponseEntity<>(wareZoneService.getAllList(), HttpStatus.OK);
    }

    @GetMapping("/tree")
    @PreAuthorize("isAuthenticated()")
    public Object queryTree() {
        return new ResponseEntity<>(wareZoneService.getTree(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_WARE_ZONE_LIST')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(wareZoneService.findById(id), HttpStatus.OK);
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_WARE_ZONE_CRUD')")
    public ResponseEntity create(@Validated @RequestBody WareZone resources) {
        if (resources.getId() != null) {
            throw new BadRequestException("A new " + ENTITY_NAME + " cannot already have an ID");
        }
        return new ResponseEntity<>(wareZoneService.create(resources), HttpStatus.CREATED);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_WARE_ZONE_CRUD')")
    public ResponseEntity update(@Validated @RequestBody WareZone resources) {
        if (resources.getId() == null) {
            throw new BadRequestException(ENTITY_NAME + " ID Can not be empty");
        }
        wareZoneService.update(resources.getId(), resources);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_WARE_ZONE_CRUD')")
    public ResponseEntity delete(@PathVariable Long id) {
        wareZoneService.delete(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

}