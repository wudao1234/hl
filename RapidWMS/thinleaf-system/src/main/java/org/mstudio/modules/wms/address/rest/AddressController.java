package org.mstudio.modules.wms.address.rest;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.address.domain.Address;
import org.mstudio.modules.wms.address.service.AddressService;
import org.mstudio.modules.wms.address.service.object.AddressVO;
import org.mstudio.modules.wms.common.WmsUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
* @author Macrow
* @date 2019-04-24
*/

@RestController
@RequestMapping("api/address")
public class AddressController {

    @Autowired
    private AddressService addressService;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_ADDRESS_LIST')")
    public ResponseEntity list(@RequestParam(value = "exportExcel", required = false) Boolean exportExcel, @RequestParam(value = "addressTypeFilter", required = false) String addressTypeFilter, @RequestParam(value = "search", required = false) String search, Pageable pageable) {
        if (exportExcel != null && exportExcel) {
            Map result = addressService.queryAll(true, addressTypeFilter, search, pageable);
            List<AddressVO> address = (List)result.get("content");
            return new ResponseEntity<>(addressService.exportExcelData(address), WmsUtil.getExportExcelHeaders(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(addressService.queryAll(false, addressTypeFilter, search, pageable), HttpStatus.OK);
        }
    }

    @GetMapping("/all_list")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT', 'S_ADDRESS_LIST')")
    public Object allList() {
        return new ResponseEntity<>(addressService.getAllList(), HttpStatus.OK);
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_ADDRESS_CRUD')")
    public ResponseEntity create(@Validated @RequestBody Address resource) {
        return new ResponseEntity<>(addressService.create(resource), HttpStatus.CREATED);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_ADDRESS_CRUD')")
    public ResponseEntity update(@Validated @RequestBody Address resource) {
        if (resource.getId() == null) {
            throw new BadRequestException("ID不能为空");
        }
        return new ResponseEntity<>(addressService.update(resource.getId(), resource), HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_ADDRESS_LIST')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(addressService.findById(id), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_ADDRESS_CRUD')")
    public ResponseEntity delete(@PathVariable Long id) {
        addressService.delete(id);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

}