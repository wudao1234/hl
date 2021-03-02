package org.mstudio.modules.wms.Logistics.rest;

import org.mstudio.aop.log.Log;
import org.mstudio.modules.wms.Logistics.service.LogisticsDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
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

    @Log("物流统计")
    @GetMapping(value = "/statics")
    @PreAuthorize("hasAnyRole('ADMIN', 'LOGISTICSDETAIL_ALL')")
    @ResponseBody
    public ResponseEntity statistics(
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "search", required = false) String search,
            Pageable pageable) {
        return new ResponseEntity(logisticsDetailService.statistics(startDate, endDate, search, pageable), HttpStatus.OK);
    }

}