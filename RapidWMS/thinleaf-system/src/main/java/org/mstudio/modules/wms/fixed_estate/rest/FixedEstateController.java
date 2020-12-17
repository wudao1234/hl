package org.mstudio.modules.wms.fixed_estate.rest;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.fixed_estate.domain.FixedEstate;
import org.mstudio.modules.wms.fixed_estate.service.FixedEstateService;
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
@RequestMapping("api/fixed_estate")
public class FixedEstateController {

    private static final String ENTITY_NAME = "FixedEstate";
    
    @Autowired
    private FixedEstateService fixedEstateService;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'FIXED_ALL')")
    public Object list(@RequestParam(value = "search", required = false) String name, Pageable pageable) {
        return new ResponseEntity<>(fixedEstateService.queryAll(name, pageable), HttpStatus.OK);
    }


    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'FIXED_ALL')")
    public ResponseEntity create(@Validated @RequestBody FixedEstate resources) {
        if (resources.getId() != null) {
            throw new BadRequestException("A new " + ENTITY_NAME + " cannot already have an ID");
        }
        return new ResponseEntity<>(fixedEstateService.create(resources), HttpStatus.CREATED);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'FIXED_ALL')")
    public ResponseEntity update(@Validated @RequestBody FixedEstate resources) {
        if (resources.getId() == null) {
            throw new BadRequestException(ENTITY_NAME + " ID Can not be empty");
        }
        return new ResponseEntity<>(fixedEstateService.update(resources.getId(), resources), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'FIXED_ALL')")
    public ResponseEntity delete(@PathVariable Long id) {
        fixedEstateService.delete(id);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

}