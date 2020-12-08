package org.mstudio.modules.wms.dispatch.rest;

import org.mstudio.aop.log.Log;
import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.dispatch.domain.DispatchCoefficient;
import org.mstudio.modules.wms.dispatch.service.DispatchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;


/**
 * @author lfj
 */

@RestController
@RequestMapping("api/dispatch")
public class DispatchController {

    @Autowired
    private DispatchService dispatchService;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    public ResponseEntity list(Pageable pageable) {
        return new ResponseEntity<>(dispatchService.queryAll(pageable), HttpStatus.OK);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    public ResponseEntity update(@Validated @RequestBody DispatchCoefficient resource) {
        if (resource.getId() == null) {
            throw new BadRequestException("ID不能为空");
        }
        return new ResponseEntity<>(dispatchService.update(resource.getId(), resource), HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(dispatchService.findById(id), HttpStatus.OK);
    }

    @Log("统计")
    @GetMapping(value = "/statistics")
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    public ResponseEntity statistics(@RequestParam(value = "search", required = false) String name, Pageable pageable) {
        return new ResponseEntity(dispatchService.statistics(name, pageable), HttpStatus.OK);
    }

}