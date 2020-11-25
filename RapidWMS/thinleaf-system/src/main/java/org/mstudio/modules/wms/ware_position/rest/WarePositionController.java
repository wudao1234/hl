package org.mstudio.modules.wms.ware_position.rest;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.common.WmsUtil;
import org.mstudio.modules.wms.ware_position.domain.WarePosition;
import org.mstudio.modules.wms.ware_position.service.WarePositionService;
import org.mstudio.modules.wms.ware_position.service.object.WarePositionDTO;
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
@RequestMapping("api/ware_positions")
public class WarePositionController {

    @Autowired
    private WarePositionService warePositionService;

    private static final String ENTITY_NAME = "WarePosition";

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_WARE_POSITION_LIST')")
    public ResponseEntity list(
            @RequestParam(value = "exportExcel", required = false) Boolean exportExcel,
            @RequestParam(value = "wareZoneFilter", required = false) String wareZoneFilter,
            @RequestParam(value = "search", required = false) String name,
            Pageable pageable) {
        if (exportExcel != null && exportExcel) {
            Map result = warePositionService.queryAll(true, wareZoneFilter, name, pageable);
            List<WarePositionDTO> warePositions = (List)result.get("content");
            return new ResponseEntity<>(warePositionService.exportExcelData(warePositions), WmsUtil.getExportExcelHeaders(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(warePositionService.queryAll(false, wareZoneFilter, name, pageable), HttpStatus.OK);
        }
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_WARE_POSITION_LIST')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(warePositionService.findById(id), HttpStatus.OK);
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_WARE_POSITION_CRUD')")
    public ResponseEntity create(@Validated @RequestBody WarePosition resources) {
        if (resources.getId() != null) {
            throw new BadRequestException("A new " + ENTITY_NAME + " cannot already have an ID");
        }
        return new ResponseEntity<>(warePositionService.create(resources), HttpStatus.CREATED);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_WARE_POSITION_CRUD')")
    public ResponseEntity update(@Validated @RequestBody WarePosition resources) {
        if (resources.getId() == null) {
            throw new BadRequestException(ENTITY_NAME + " ID Can not be empty");
        }
        warePositionService.update(resources.getId(), resources);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_WARE_POSITION_CRUD')")
    public ResponseEntity delete(@PathVariable Long id) {
        warePositionService.delete(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

}