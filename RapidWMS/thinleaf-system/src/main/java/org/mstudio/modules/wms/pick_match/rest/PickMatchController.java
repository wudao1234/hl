package org.mstudio.modules.wms.pick_match.rest;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.pick_match.domain.PickMatchCoefficient;
import org.mstudio.modules.wms.pick_match.service.PickMatchService;
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
@RequestMapping("api/pick_match")
public class PickMatchController {

    @Autowired
    private PickMatchService pickMatchService;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_ADDRESS_LIST')")
    public ResponseEntity list(Pageable pageable) {
        return new ResponseEntity<>(pickMatchService.queryAll(pageable), HttpStatus.OK);
    }


    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_ADDRESS_CRUD')")
    public ResponseEntity update(@Validated @RequestBody PickMatchCoefficient resource) {
        if (resource.getId() == null) {
            throw new BadRequestException("ID不能为空");
        }
        return new ResponseEntity<>(pickMatchService.update(resource.getId(), resource), HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_ADDRESS_LIST')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(pickMatchService.findById(id), HttpStatus.OK);
    }

}