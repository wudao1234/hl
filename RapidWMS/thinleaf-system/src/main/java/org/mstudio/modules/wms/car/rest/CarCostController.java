package org.mstudio.modules.wms.car.rest;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.car.domain.CarCost;
import org.mstudio.modules.wms.car.service.CarCostService;
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
@RequestMapping("api/car_cost")
public class CarCostController {

    private static final String ENTITY_NAME = "CarCost";
    
    @Autowired
    private CarCostService carCostService;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'CAR_ALL')")
    public Object list(@RequestParam(value = "search", required = false) String name, Pageable pageable) {
        return new ResponseEntity<>(carCostService.queryAll(name, pageable), HttpStatus.OK);
    }


    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'CAR_ALL')")
    public ResponseEntity create(@Validated @RequestBody CarCost resources) {
        if (resources.getId() != null) {
            throw new BadRequestException("A new " + ENTITY_NAME + " cannot already have an ID");
        }
        return new ResponseEntity<>(carCostService.create(resources), HttpStatus.CREATED);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'CAR_ALL')")
    public ResponseEntity update(@Validated @RequestBody CarCost resources) {
        if (resources.getId() == null) {
            throw new BadRequestException(ENTITY_NAME + " ID Can not be empty");
        }
        return new ResponseEntity<>(carCostService.update(resources.getId(), resources), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'CAR_ALL')")
    public ResponseEntity delete(@PathVariable Long id) {
        carCostService.delete(id);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

}