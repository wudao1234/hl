package org.mstudio.modules.wms.pick_match.rest;

import org.mstudio.aop.log.Log;
import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.system.service.dto.UserDTO;
import org.mstudio.modules.wms.dispatch.service.object.StatisticsDTO;
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
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    public ResponseEntity list(Pageable pageable) {
        return new ResponseEntity<>(pickMatchService.queryAll(pageable), HttpStatus.OK);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    public ResponseEntity update(@Validated @RequestBody PickMatchCoefficient resource) {
        if (resource.getId() == null) {
            throw new BadRequestException("ID不能为空");
        }
        return new ResponseEntity<>(pickMatchService.update(resource.getId(), resource), HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(pickMatchService.findById(id), HttpStatus.OK);
    }

    @Log("统计")
    @GetMapping(value = "/statistics")
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    public ResponseEntity statistics(
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "search", required = false) String search,
            Pageable pageable) {
        return new ResponseEntity(pickMatchService.statistics(startDate, endDate, search, pageable), HttpStatus.OK);
    }

}