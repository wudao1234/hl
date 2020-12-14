package org.mstudio.modules.wms.receive_goods.rest;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.system.service.UserService;
import org.mstudio.modules.system.service.dto.UserDTO;
import org.mstudio.modules.wms.common.WmsUtil;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoods;
import org.mstudio.modules.wms.receive_goods.service.ReceiveGoodsService;
import org.mstudio.modules.wms.receive_goods.service.mapper.ReceiveGoodsMapper;
import org.mstudio.modules.wms.receive_goods.service.object.ReceiveGoodsVO;
import org.mstudio.utils.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import static org.mstudio.utils.SecurityContextHolder.getUserDetails;

/**
* @author Macrow
* @date 2019-02-22
*/

@RestController
@RequestMapping("api/receive_goods")
public class ReceiveGoodsController {

    @Autowired
    private ReceiveGoodsService receiveGoodsService;

    @Autowired
    private UserService userService;

    @Autowired
    private ReceiveGoodsMapper receiveGoodsMapper;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_RECEIVE_LIST')")
    public ResponseEntity list(
            @RequestParam(value = "exportExcel", required = false) Boolean exportExcel,
            @RequestParam(value = "customerFilter", required = false) String customerFilter,
            @RequestParam(value = "receiveGoodsTypeFilter", required = false) String receiveGoodsTypeFilter,
            @RequestParam(value = "isAuditedFilter", required = false) Boolean isAuditedFilter,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "search", required = false) String search,
            Pageable pageable) {
        JwtUser jwtUser = (JwtUser) getUserDetails();
        UserDTO user = userService.findById(jwtUser.getId());
        Set<CustomerVO> customers = user.getCustomers();
        if (customers.isEmpty()) {
            List<ReceiveGoods> emptyReceiveGoods = new ArrayList<>();
            return new ResponseEntity<>(PageUtil.toPage(receiveGoodsMapper.toDto(emptyReceiveGoods), 0), HttpStatus.OK);
        }
        if (exportExcel != null && exportExcel) {
            Map result = receiveGoodsService.queryAll(customers, true, customerFilter, receiveGoodsTypeFilter, isAuditedFilter, startDate, endDate, search, pageable);
            List<ReceiveGoodsVO> receiveGoods = (List)result.get("content");
            return new ResponseEntity<>(receiveGoodsService.exportExcelData(receiveGoods), WmsUtil.getExportExcelHeaders(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(receiveGoodsService.queryAll(customers, false, customerFilter, receiveGoodsTypeFilter, isAuditedFilter, startDate, endDate, search, pageable), HttpStatus.OK);
        }
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_RECEIVE_CRUD')")
    public ResponseEntity create(@Validated @RequestBody ReceiveGoods resource) {
        return new ResponseEntity<>(receiveGoodsService.create(resource), HttpStatus.CREATED);
    }

    @PostMapping("/unload")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_RECEIVE_CRUD')")
    public ResponseEntity unload(@Validated @RequestBody ReceiveGoods resource) {
        return new ResponseEntity<>(receiveGoodsService.unload(resource), HttpStatus.CREATED);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_RECEIVE_CRUD')")
    public ResponseEntity update(@Validated @RequestBody ReceiveGoods resource) {
        if (resource.getId() == null) {
            throw new BadRequestException("ID不能为空");
        }
        return new ResponseEntity<>(receiveGoodsService.update(resource.getId(), resource), HttpStatus.CREATED);
    }

    @GetMapping("/put_in_storage/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_RECEIVE_LIST')")
    public ResponseEntity putInStorage(@PathVariable Long id) {
        return new ResponseEntity<>(receiveGoodsService.putInStorage(id), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_RECEIVE_LIST')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(receiveGoodsService.findById(id), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_RECEIVE_CRUD')")
    public ResponseEntity delete(@PathVariable Long id) {
        receiveGoodsService.delete(id);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @PutMapping("/audit")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_RECEIVE_AUDIT')")
    public ResponseEntity audit(@RequestBody ReceiveGoods resource) {
        return new ResponseEntity<>(receiveGoodsService.audit(resource), HttpStatus.CREATED);
    }

    @PutMapping("/cancel_audit")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_RECEIVE_AUDIT')")
    public ResponseEntity cancelAudit(@RequestBody ReceiveGoods resource) {
        ReceiveGoodsVO receiveGoodsVO = receiveGoodsService.cancelAudit(resource);
        if ( receiveGoodsVO != null) {
            return new ResponseEntity<>(receiveGoodsVO, HttpStatus.CREATED);
        } else {
            throw new BadRequestException("库存已不足，可能有商品已经出库，请确保库存充足再进行此操作。");
        }
    }
}