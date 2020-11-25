package org.mstudio.modules.wms.store.rest;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.common.WmsUtil;
import org.mstudio.modules.wms.store.domain.Store;
import org.mstudio.modules.wms.store.service.StoreService;
import org.mstudio.modules.wms.store.service.object.StoreVO;
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
* @date 2019-09-28
*/

@RestController
@RequestMapping("api/stores")
public class StoreController {

    @Autowired
    private StoreService storeService;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_STORE_LIST')")
    public ResponseEntity list(@RequestParam(value = "exportExcel", required = false) Boolean exportExcel, @RequestParam(value = "search", required = false) String search, Pageable pageable) {
        if (exportExcel != null && exportExcel) {
            Map result = storeService.queryAll(true, search, pageable);
            List<StoreVO> address = (List)result.get("content");
            return new ResponseEntity<>(storeService.exportExcelData(address), WmsUtil.getExportExcelHeaders(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(storeService.queryAll(false, search, pageable), HttpStatus.OK);
        }
    }

    @GetMapping("/all_list")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_EDIT', 'S_STORE_LIST')")
    public Object allList() {
        return new ResponseEntity<>(storeService.getAllList(), HttpStatus.OK);
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_STORE_CRUD')")
    public ResponseEntity create(@Validated @RequestBody Store resource) {
        return new ResponseEntity<>(storeService.create(resource), HttpStatus.CREATED);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_STORE_CRUD')")
    public ResponseEntity update(@Validated @RequestBody Store resource) {
        if (resource.getId() == null) {
            throw new BadRequestException("ID不能为空");
        }
        return new ResponseEntity<>(storeService.update(resource.getId(), resource), HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_STORE_LIST')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(storeService.findById(id), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_STORE_CRUD')")
    public ResponseEntity delete(@PathVariable Long id) {
        storeService.delete(id);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

}