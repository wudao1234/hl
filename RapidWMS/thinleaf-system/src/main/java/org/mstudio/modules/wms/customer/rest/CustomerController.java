package org.mstudio.modules.wms.customer.rest;

import lombok.extern.slf4j.Slf4j;
import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.wms.common.WmsUtil;
import org.mstudio.modules.wms.customer.domain.Customer;
import org.mstudio.modules.wms.customer.service.CustomerService;
import org.mstudio.modules.wms.customer.service.object.CustomerDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

import static org.mstudio.utils.SecurityContextHolder.getUserDetails;

/**
 * @author Macrow
 * @date 2019-02-22
 */

@Slf4j
@RestController
@RequestMapping("api/customers")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    private static final String ENTITY_NAME = "Customer";

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_CUSTOMER_LIST')")
    public ResponseEntity list(@RequestParam(value = "exportExcel", required = false) Boolean exportExcel, @RequestParam(value = "search", required = false) String search, Pageable pageable) {
        if (exportExcel != null && exportExcel) {
            Map result = customerService.queryAll(true, search, pageable);
            List<CustomerDTO> address = (List) result.get("content");
            return new ResponseEntity<>(customerService.exportExcelData(address), WmsUtil.getExportExcelHeaders(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(customerService.queryAll(false, search, pageable), HttpStatus.OK);
        }
    }

    @GetMapping("/all_list")
    @PreAuthorize("isAuthenticated()")
    public Object allList() {
        return new ResponseEntity<>(customerService.getAllList(), HttpStatus.OK);
    }

    @GetMapping("/my_list")
    @PreAuthorize("isAuthenticated()")
    public Object myList() {
        JwtUser jwtUser = (JwtUser) getUserDetails();
        return new ResponseEntity<>(customerService.getListByUserId(jwtUser.getId()), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_CUSTOMER_LIST')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(customerService.findById(id), HttpStatus.OK);
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_CUSTOMER_CRUD')")
    public ResponseEntity create(@Validated @RequestBody Customer resource) {
        if (resource.getId() != null) {
            throw new BadRequestException("A new " + ENTITY_NAME + " cannot already have an ID");
        }
        return new ResponseEntity<>(customerService.create(resource), HttpStatus.CREATED);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_CUSTOMER_CRUD')")
    public ResponseEntity update(@Validated @RequestBody Customer resource) {
        if (resource.getId() == null) {
            throw new BadRequestException(ENTITY_NAME + " ID Can not be empty");
        }
        return new ResponseEntity<>(customerService.update(resource.getId(), resource), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_CUSTOMER_CRUD')")
    public ResponseEntity delete(@PathVariable Long id) {
        customerService.delete(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @GetMapping("/{id}/users")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_CUSTOMER_LIST')")
    public ResponseEntity getUsers(@PathVariable Long id) {
        return new ResponseEntity<>(customerService.getUsersById(id), HttpStatus.OK);
    }

}