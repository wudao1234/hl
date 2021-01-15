package org.mstudio.modules.wms.Logistics.rest;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.Logistics.domain.LogisticsDetail;
import org.mstudio.modules.wms.Logistics.service.LogisticsDetailService;
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
@RequestMapping("api/Logistics_detail")
public class LogisticsDetailController {

    private static final String ENTITY_NAME = "LogisticsDetail";

    @Autowired
    private LogisticsDetailService logisticsDetailService;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'LOGISTICSDETAIL_ALL')")
    public Object list(@RequestParam(value = "search", required = false) String name,
                       @RequestParam(value = "startDate", required = false) String startDate,
                       @RequestParam(value = "endDate", required = false) String endDate,
                       Pageable pageable) {
        return new ResponseEntity<>(logisticsDetailService.queryAll(name, startDate, endDate, pageable), HttpStatus.OK);
    }

    @GetMapping("/all_list")
    @PreAuthorize("isAuthenticated()")
    public Object allList() {
        return new ResponseEntity<>(logisticsDetailService.getAllList(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'LOGISTICSDETAIL_ALL')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(logisticsDetailService.findById(id), HttpStatus.OK);
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'LOGISTICSDETAIL_ALL')")
    public ResponseEntity create(@Validated @RequestBody LogisticsDetail resources) {
        if (resources.getId() != null) {
            throw new BadRequestException("A new " + ENTITY_NAME + " cannot already have an ID");
        }
        return new ResponseEntity<>(logisticsDetailService.create(resources), HttpStatus.CREATED);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'LOGISTICSDETAIL_ALL')")
    public ResponseEntity update(@Validated @RequestBody LogisticsDetail resources) {
        if (resources.getId() == null) {
            throw new BadRequestException(ENTITY_NAME + " ID Can not be empty");
        }
        return new ResponseEntity<>(logisticsDetailService.update(resources.getId(), resources), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'LOGISTICSDETAIL_ALL')")
    public ResponseEntity delete(@PathVariable Long id) {
        logisticsDetailService.delete(id);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

}