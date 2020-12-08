package org.mstudio.modules.wms.dispatch.rest;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.address_type.domain.AddressType;
import org.mstudio.modules.wms.dispatch.domain.DispatchCoefficient;
import org.mstudio.modules.wms.dispatch.domain.DispatchSys;
import org.mstudio.modules.wms.dispatch.service.DispatchService;
import org.mstudio.modules.wms.dispatch.service.DispatchSysService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;


/**
 * 配送 计件 系统系数
 * @author lfj
 */

@RestController
@RequestMapping("api/dispatch_sys")
public class DispatchSysController {

    private static final String ENTITY_NAME = "DispatchSys";
    
    @Autowired
    private DispatchSysService dispatchSysService;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    public Object list(@RequestParam(value = "search", required = false) String name, Pageable pageable) {
        return new ResponseEntity<>(dispatchSysService.queryAll(name, pageable), HttpStatus.OK);
    }

    @GetMapping("/all_list")
    @PreAuthorize("isAuthenticated()")
    public Object allList() {
        return new ResponseEntity<>(dispatchSysService.getAllList(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'IECE_ALL')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(dispatchSysService.findById(id), HttpStatus.OK);
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'IECE_ALL')")
    public ResponseEntity create(@Validated @RequestBody DispatchSys resources) {
        if (resources.getId() != null) {
            throw new BadRequestException("A new " + ENTITY_NAME + " cannot already have an ID");
        }
        return new ResponseEntity<>(dispatchSysService.create(resources), HttpStatus.CREATED);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'IECE_ALL')")
    public ResponseEntity update(@Validated @RequestBody DispatchSys resources) {
        if (resources.getId() == null) {
            throw new BadRequestException(ENTITY_NAME + " ID Can not be empty");
        }
        return new ResponseEntity<>(dispatchSysService.update(resources.getId(), resources), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'IECE_ALL')")
    public ResponseEntity delete(@PathVariable Long id) {
        dispatchSysService.delete(id);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

}