package org.mstudio.modules.wms.car.rest;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.car.domain.CarBasic;
import org.mstudio.modules.wms.car.service.CarBasicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;


/**
 * 车辆信息
 * @author lfj
 */

@RestController
@RequestMapping("api/car_basic")
public class CarBasicController {

    private static final String ENTITY_NAME = "CarBasic";
    
    @Autowired
    private CarBasicService carBasicService;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'CAR_ALL')")
    public Object list(@RequestParam(value = "search", required = false) String name, Pageable pageable) {
        return new ResponseEntity<>(carBasicService.queryAll(name, pageable), HttpStatus.OK);
    }


    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'CAR_ALL')")
    public ResponseEntity create(@Validated @RequestBody CarBasic resources) {
        if (resources.getId() != null) {
            throw new BadRequestException("A new " + ENTITY_NAME + " cannot already have an ID");
        }
        return new ResponseEntity<>(carBasicService.create(resources), HttpStatus.CREATED);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'CAR_ALL')")
    public ResponseEntity update(@Validated @RequestBody CarBasic resources) {
        if (resources.getId() == null) {
            throw new BadRequestException(ENTITY_NAME + " ID Can not be empty");
        }
        return new ResponseEntity<>(carBasicService.update(resources.getId(), resources), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'CAR_ALL')")
    public ResponseEntity delete(@PathVariable Long id) {
        carBasicService.delete(id);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

}