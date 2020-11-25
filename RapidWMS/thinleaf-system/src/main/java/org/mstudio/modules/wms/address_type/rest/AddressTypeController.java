package org.mstudio.modules.wms.address_type.rest;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.address_type.domain.AddressType;
import org.mstudio.modules.wms.address_type.service.AddressTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * @author Macrow
 * @date 2019-07-09
 */

@RestController
@RequestMapping("api/address_types")
public class AddressTypeController {

    @Autowired
    private AddressTypeService addressTypeService;

    private static final String ENTITY_NAME = "AddressType";

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_ADDRESS_TYPE')")
    public Object list(@RequestParam(value = "search", required = false) String name, Pageable pageable) {
        return new ResponseEntity<>(addressTypeService.queryAll(name, pageable), HttpStatus.OK);
    }

    @GetMapping("/all_list")
    @PreAuthorize("isAuthenticated()")
    public Object allList() {
        return new ResponseEntity<>(addressTypeService.getAllList(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_ADDRESS_TYPE')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(addressTypeService.findById(id), HttpStatus.OK);
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_ADDRESS_TYPE')")
    public ResponseEntity create(@Validated @RequestBody AddressType resources) {
        if (resources.getId() != null) {
            throw new BadRequestException("A new " + ENTITY_NAME + " cannot already have an ID");
        }
        return new ResponseEntity<>(addressTypeService.create(resources), HttpStatus.CREATED);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_ADDRESS_TYPE')")
    public ResponseEntity update(@Validated @RequestBody AddressType resources) {
        if (resources.getId() == null) {
            throw new BadRequestException(ENTITY_NAME + " ID Can not be empty");
        }
        return new ResponseEntity<>(addressTypeService.update(resources.getId(), resources), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_ADDRESS_TYPE')")
    public ResponseEntity delete(@PathVariable Long id) {
        addressTypeService.delete(id);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

}