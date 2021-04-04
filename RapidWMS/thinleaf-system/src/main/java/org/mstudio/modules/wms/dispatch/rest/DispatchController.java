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
 * 配送基础 系数、计件
 *
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

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    public ResponseEntity save() {
        return new ResponseEntity<>(dispatchService.save(), HttpStatus.CREATED);
    }

    @GetMapping("finish")
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    public ResponseEntity finish(
            @RequestParam(value = "mileage", required = true) Float mileage,
            @RequestParam(value = "dispatchSys", required = true)  Long dispatchSys) {
        return new ResponseEntity<>(dispatchService.finish(mileage, dispatchSys), HttpStatus.CREATED);
    }

    @Log("配送计件统计")
    @GetMapping(value = "/statistics")
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    @ResponseBody
    public ResponseEntity statistics(
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "search", required = false) String search,
            Pageable pageable) {
        return new ResponseEntity(dispatchService.statistics(startDate, endDate, search, pageable), HttpStatus.OK);
    }

    @Log("综合统计")
    @GetMapping(value = "/statisticsAll")
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    @ResponseBody
    public ResponseEntity statisticsAll(
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "search", required = false) String search,
            Pageable pageable) {
        return new ResponseEntity(dispatchService.statisticsAll(startDate, endDate, search, pageable), HttpStatus.OK);
    }

}