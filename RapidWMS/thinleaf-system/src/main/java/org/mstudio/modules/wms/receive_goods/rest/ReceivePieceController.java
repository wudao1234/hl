package org.mstudio.modules.wms.receive_goods.rest;

import org.mstudio.aop.log.Log;
import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.receive_goods.domain.RcceiveCoefficient;
import org.mstudio.modules.wms.receive_goods.service.ReceivePieceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;


/**
 * 收货计件-系数、统计、信息
 *
 * @author lfj
 */

@RestController
@RequestMapping("api/receive_goods_piece")
public class ReceivePieceController {

    @Autowired
    private ReceivePieceService receivePieceService;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    public ResponseEntity list(Pageable pageable) {
        return new ResponseEntity<>(receivePieceService.queryAll(pageable), HttpStatus.OK);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    public ResponseEntity update(@Validated @RequestBody RcceiveCoefficient resource) {
        if (resource.getId() == null) {
            throw new BadRequestException("ID不能为空");
        }
        return new ResponseEntity<>(receivePieceService.update(resource.getId(), resource), HttpStatus.CREATED);
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    public ResponseEntity save() {
        return new ResponseEntity<>(receivePieceService.save(), HttpStatus.CREATED);
    }

    @GetMapping("finish")
    @PreAuthorize("hasAnyRole('ADMIN', 'PIECE_ALL')")
    public ResponseEntity finish(
            @RequestParam(value = "mileage", required = true) Float mileage,
            @RequestParam(value = "dispatchSys", required = true)  Long dispatchSys) {
        return new ResponseEntity<>(receivePieceService.finish(mileage, dispatchSys), HttpStatus.CREATED);
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
        return new ResponseEntity(receivePieceService.statistics(startDate, endDate, search, pageable), HttpStatus.OK);
    }

}