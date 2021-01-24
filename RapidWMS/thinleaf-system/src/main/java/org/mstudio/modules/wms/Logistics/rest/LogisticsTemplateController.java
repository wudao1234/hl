package org.mstudio.modules.wms.Logistics.rest;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.Logistics.domain.LogisticsTemplate;
import org.mstudio.modules.wms.Logistics.repository.LogisticsDetailRepository;
import org.mstudio.modules.wms.Logistics.service.LogisticsTemplateService;
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
@RequestMapping("api/Logistics_template")
public class LogisticsTemplateController {

    private static final String ENTITY_NAME = "LogisticsTemplate";
    
    @Autowired
    private LogisticsTemplateService logisticsTemplateService;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'LOGISTICSTEMPLATE_ALL')")
    public Object list(@RequestParam(value = "search", required = false) String name, Pageable pageable) {
        return new ResponseEntity<>(logisticsTemplateService.queryAll(name, pageable), HttpStatus.OK);
    }

    @GetMapping("/all_list")
    @PreAuthorize("isAuthenticated()")
    public Object allList() {
        return new ResponseEntity<>(logisticsTemplateService.getAllList(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'LOGISTICSTEMPLATE_ALL')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(logisticsTemplateService.findById(id), HttpStatus.OK);
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'LOGISTICSTEMPLATE_ALL')")
    public ResponseEntity create(@Validated @RequestBody LogisticsTemplate resources) {
        if (resources.getId() != null) {
            throw new BadRequestException("A new " + ENTITY_NAME + " cannot already have an ID");
        }
        return new ResponseEntity<>(logisticsTemplateService.create(resources), HttpStatus.CREATED);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'LOGISTICSTEMPLATE_ALL')")
    public ResponseEntity update(@Validated @RequestBody LogisticsTemplate resources) {
        if (resources.getId() == null) {
            throw new BadRequestException(ENTITY_NAME + " ID Can not be empty");
        }
        return new ResponseEntity<>(logisticsTemplateService.update(resources.getId(), resources), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'LOGISTICSTEMPLATE_ALL')")
    public ResponseEntity delete(@PathVariable Long id) {
        logisticsTemplateService.delete(id);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/fetch_group_all")
    @PreAuthorize("isAuthenticated()")
    public Object fetchGroupAll() {
        return new ResponseEntity<>(logisticsTemplateService.fetchGroupAll(), HttpStatus.OK);
    }

}