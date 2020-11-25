package org.mstudio.modules.wms.customer_order.rest;

import lombok.extern.slf4j.Slf4j;
import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.system.service.UserService;
import org.mstudio.modules.system.service.dto.UserDTO;
import org.mstudio.modules.wms.common.MultiOperateResult;
import org.mstudio.modules.wms.common.WmsUtil;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.customer_order.domain.OrderStatus;
import org.mstudio.modules.wms.customer_order.service.CustomerOrderService;
import org.mstudio.modules.wms.customer_order.service.mapper.CustomerOrderMapper;
import org.mstudio.modules.wms.customer_order.service.object.*;
import org.mstudio.utils.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.*;

import static org.mstudio.utils.SecurityContextHolder.getUserDetails;

/**
 * @author Macrow
 * @date 2019-02-22
 */

@Slf4j
@RestController
@RequestMapping("api/customer_orders")
public class CustomerOrderController {

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    private UserService userService;

    @Autowired
    private CustomerOrderService customerOrderService;

    @Autowired
    private CustomerOrderMapper customerOrderMapper;

    private static final String ENTITY_NAME = "CustomerOrder";

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_LIST')")
    public ResponseEntity list(
            @RequestParam(value = "exportExcel", required = false) Boolean exportExcel,
            @RequestParam(value = "isPrintedFilter", required = false) Boolean isPrintedFilter,
            @RequestParam(value = "isSatisfiedFilter", required = false) String isSatisfiedFilter,
            @RequestParam(value = "customerFilter", required = false) String customerFilter,
            @RequestParam(value = "orderStatusFilter", required = false) String orderStatusFilter,
            @RequestParam(value = "receiveTypeFilter", required = false) String receiveTypeFilter,
            @RequestParam(value = "isActiveFilter", required = false) Boolean isActiveFilter,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "search", required = false) String search,
            Pageable pageable) {
        JwtUser jwtUser = (JwtUser) getUserDetails();
        UserDTO user = userService.findById(jwtUser.getId());
        Set<CustomerVO> customers = user.getCustomers();
        if (customers.isEmpty()) {
            List<CustomerOrder> emptyOrders = new ArrayList<>();
            return new ResponseEntity<>(PageUtil.toPage(customerOrderMapper.toVO(emptyOrders), 0), HttpStatus.OK);
        }
        if (exportExcel != null && exportExcel) {
            Map result = customerOrderService.queryAll(customers, true, isPrintedFilter, isSatisfiedFilter, customerFilter, orderStatusFilter, receiveTypeFilter, isActiveFilter, startDate, endDate, search, pageable);
            List<CustomerOrderVO> orders = (List) result.get("content");
            return new ResponseEntity<>(customerOrderService.exportExcelData(orders), WmsUtil.getExportExcelHeaders(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(customerOrderService.queryAll(customers, false, isPrintedFilter, isSatisfiedFilter, customerFilter, orderStatusFilter, receiveTypeFilter, isActiveFilter, startDate, endDate, search, pageable), HttpStatus.OK);
        }
    }

    @GetMapping("/list_for_gather_confirm")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_ORDER_GATHER', 'T_ORDER_CONFIRM')")
    public ResponseEntity list_for_gather_confirm(
            @RequestParam(value = "isSatisfiedFilter", required = false) String isSatisfiedFilter,
            @RequestParam(value = "customerFilter", required = false) String customerFilter,
            @RequestParam(value = "orderStatusFilter", required = false) String orderStatusFilter,
            @RequestParam(value = "isActiveFilter", required = false) Boolean isActiveFilter,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "search", required = false) String search,
            Pageable pageable) {
        String orderStatusFilterOrigin = OrderStatus.FETCH_STOCK.getIndex() + "," + OrderStatus.GATHERING_GOODS.getIndex() + "," + OrderStatus.GATHER_GOODS.getIndex();
        String orderStatusFilterResult;
        if (orderStatusFilter != null) {
            orderStatusFilterResult = String.join(",", WmsUtil.intersect(orderStatusFilterOrigin.split(","), orderStatusFilter.split(",")));
        } else {
            orderStatusFilterResult = orderStatusFilterOrigin;
        }
        return new ResponseEntity<>(customerOrderService.queryAll(null, false, null, isSatisfiedFilter, customerFilter, orderStatusFilterResult, null, isActiveFilter, startDate, endDate, search, pageable), HttpStatus.OK);
    }

    @GetMapping("/list_for_pack")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_LIST', 'T_PACK_EDIT')")
    public ResponseEntity listForPack(
            @RequestParam(value = "customerFilter", required = false) String customerFilter,
            @RequestParam(value = "search", required = false) String search,
            Pageable pageable) {
        return new ResponseEntity<>(customerOrderService.listForPack(customerFilter, search, pageable), HttpStatus.OK);
    }

    @GetMapping("/list_for_complete")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_COMPLETE_LIST')")
    public ResponseEntity list_for_complete(
            @RequestParam(value = "exportExcel", required = false) Boolean exportExcel,
            @RequestParam(value = "customerFilter", required = false) String customerFilter,
            @RequestParam(value = "packTypeFilter", required = false) String packTypeFilter,
            @RequestParam(value = "receiveTypeFilter", required = false) String receiveTypeFilter,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "search", required = false) String search,
            Pageable pageable) {
        JwtUser jwtUser = (JwtUser) getUserDetails();
        UserDTO user = userService.findById(jwtUser.getId());
        Set<CustomerVO> customers = user.getCustomers();
        if (customers.isEmpty()) {
            List<CustomerOrder> emptyOrders = new ArrayList<>();
            return new ResponseEntity<>(PageUtil.toPage(customerOrderMapper.toVO(emptyOrders), 0), HttpStatus.OK);
        }
        if (exportExcel != null && exportExcel) {
            Map result = customerOrderService.listForComplete(customers, true, customerFilter, packTypeFilter, receiveTypeFilter, startDate, endDate, search, pageable);
            List<CustomerOrderVO> orders = (List) result.get("content");
            return new ResponseEntity<>(customerOrderService.exportExcelData(orders), WmsUtil.getExportExcelHeaders(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(customerOrderService.listForComplete(customers, false, customerFilter, packTypeFilter, receiveTypeFilter, startDate, endDate, search, pageable), HttpStatus.OK);
        }
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_LIST', 'T_ORDER_GATHER', 'T_ORDER_CONFIRM', 'O_ORDER_COMPLETE_LIST')")
    public ResponseEntity get(@PathVariable Long id, @RequestParam(value = "queryQuantityLeft", required = false) Boolean queryQuantifyLeft) {
        if (queryQuantifyLeft != null && queryQuantifyLeft) {
            return new ResponseEntity<>(customerOrderService.findByIdAndQueryQuantityLeft(id), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(customerOrderService.findById(id), HttpStatus.OK);
        }
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_EDIT')")
    @Validated
    public ResponseEntity create(
            @RequestBody CustomerOrder resource,
            @RequestParam(value = "useNewAutoIncreaseSn") Boolean useNewAutoIncreaseSn,
            @RequestParam(value = "fetchStocks") Boolean fetchStocks) {
        if (resource.getId() != null) {
            throw new BadRequestException("A new " + ENTITY_NAME + " cannot already have an ID");
        }
        checkPermission(resource.getOwner().getId());
        return new ResponseEntity<>(customerOrderService.create(resource, useNewAutoIncreaseSn, fetchStocks), HttpStatus.CREATED);
    }

    @PostMapping("/upload_excel_file")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_EDIT')")
    @Validated
    public String uploadExcelFile(@RequestParam(value = "file") MultipartFile excelFile) throws Exception {
        return WmsUtil.uploadExcelFile(uploadPath, excelFile);
    }

    @PostMapping("/upload_html_file")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_EDIT')")
    @Validated
    public String uploadHtmlFile(@RequestParam(value = "file") MultipartFile htmlFile) throws Exception {
        return WmsUtil.uploadHtmlFile(uploadPath, htmlFile);
    }

    @PostMapping("/import_kingdee")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_EDIT')")
    public ResponseEntity importKingdee(@RequestBody CustomerOrderImporterDTO customerOrderMultipleOperateDTO) {
        checkPermission(customerOrderMultipleOperateDTO.getCustomer());
        MultiOperateResult result = customerOrderService.importKingdee(customerOrderMultipleOperateDTO);
        if (result.getCountSucceed() == 0) {
            throw new BadRequestException("未能成功导入订单！请检查导入文件，是否已经导入过了.");
        }
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @PostMapping("/import_kingdee2")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_EDIT')")
    public ResponseEntity importKingdee2(@RequestBody CustomerOrderImporterDTO customerOrderMultipleOperateDTO) {
        checkPermission(customerOrderMultipleOperateDTO.getCustomer());
        MultiOperateResult result = customerOrderService.importKingdee2(customerOrderMultipleOperateDTO);
        if (result.getCountSucceed() == 0) {
            throw new BadRequestException("未能成功导入订单！请检查导入文件，是否已经导入过了.");
        }
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @PostMapping("/import_html")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_EDIT')")
    public ResponseEntity importHtml(@RequestBody CustomerOrderImporterDTO customerOrderMultipleOperateDTO) {
        checkPermission(customerOrderMultipleOperateDTO.getCustomer());
        MultiOperateResult result = customerOrderService.importHtml(customerOrderMultipleOperateDTO);
        if (result.getCountSucceed() == 0) {
            throw new BadRequestException("未能成功导入订单！请检查导入文件，是否已经导入过了.");
        }
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @PostMapping("/import_general")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_EDIT')")
    public ResponseEntity importGeneral(@RequestBody CustomerOrderImporterDTO customerOrderMultipleOperateDTO) {
        checkPermission(customerOrderMultipleOperateDTO.getCustomer());
        MultiOperateResult result = customerOrderService.importGeneral(customerOrderMultipleOperateDTO);
        if (result.getCountSucceed() == 0) {
            throw new BadRequestException("未能成功导入订单！请检查导入文件，是否已经导入过了.");
        }
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @PostMapping("/fetchStocks")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_EDIT')")
    public ResponseEntity singleOperate(@RequestBody CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = customerOrderService.batchFetchStocks(customerOrderMultipleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @PostMapping("/batchGatherGoods")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_ORDER_GATHER')")
    public ResponseEntity batchGatherGoods(@RequestBody CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = customerOrderService.batchGatherGoods(customerOrderMultipleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @PostMapping("/gather_goods/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_ORDER_GATHER')")
    public ResponseEntity gatherGoods(@PathVariable Long id) {
        customerOrderService.gatherGoods(id);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @PostMapping("/batchUnGatherGoods")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_ORDER_GATHER')")
    public ResponseEntity batchUnGatherGoods(@RequestBody CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = customerOrderService.batchUnGatherGoods(customerOrderMultipleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @PostMapping("/un_gather_goods/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_ORDER_GATHER')")
    public ResponseEntity unGatherGoods(@PathVariable Long id) {
        customerOrderService.unGatherGoods(id);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @PostMapping("{id}/completeGatherGoods")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_ORDER_GATHER')")
    public ResponseEntity completeGatherGoods(@PathVariable Long id) {
        customerOrderService.completeGatherGoods(id);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @PostMapping("/batchCompleteGatherGoods")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_ORDER_GATHER')")
    public ResponseEntity batchCompleteGatherGoods(@RequestBody CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = customerOrderService.batchCompleteGatherGoods(customerOrderMultipleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @PostMapping("/batchUnCompleteGatherGoods")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_ORDER_GATHER')")
    public ResponseEntity batchUnCompleteGatherGoods(@RequestBody CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = customerOrderService.batchUnCompleteGatherGoods(customerOrderMultipleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @PostMapping("/un_complete_gather_goods/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_ORDER_GATHER')")
    public ResponseEntity unCompleteGatherGoods(@PathVariable Long id) {
        customerOrderService.unCompleteGatherGoods(id);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @PostMapping("/batchConfirm")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_ORDER_CONFIRM')")
    public ResponseEntity batchConfirm(@RequestBody CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = customerOrderService.batchConfirm(customerOrderMultipleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @PostMapping("/confirm/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_ORDER_CONFIRM')")
    public ResponseEntity confirm(@PathVariable Long id) {
        customerOrderService.confirm(id);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @PostMapping("/batchUnConfirm")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_ORDER_CONFIRM')")
    public ResponseEntity batchUnConfirm(@RequestBody CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = customerOrderService.batchUnConfirm(customerOrderMultipleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @PostMapping("/cancel/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_EDIT')")
    public ResponseEntity cancel(@PathVariable Long id, @RequestParam String description) {
        customerOrderService.cancel(id, description);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @PostMapping("/batchCancel")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_EDIT')")
    public ResponseEntity batchCancel(@RequestBody CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = customerOrderService.batchCancel(customerOrderMultipleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @PostMapping("/batchDelete")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_DELETE')")
    public ResponseEntity batchDelete(@RequestBody CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = customerOrderService.batchDelete(customerOrderMultipleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.OK);
    }

    @PostMapping("/batchReturnStock")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_EDIT')")
    public ResponseEntity batchReturnStock(@RequestBody CustomerOrderMultipleOperateDTO customerOrderMultipleOperateDTO) {
        MultiOperateResult result = customerOrderService.batchReturnStock(customerOrderMultipleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @GetMapping("/batchPrint")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_LIST')")
    public ResponseEntity batchPrint(@RequestParam String orderIds) {
        HttpHeaders headers = new HttpHeaders();
        headers.setAccessControlExposeHeaders(Collections.singletonList("Content-Disposition"));
        headers.set("Content-Disposition", "inline; filename=orders.pdf");
        headers.setAccessControlExposeHeaders(Collections.singletonList("Content-Type"));
        headers.set("Content-Type", "application/pdf");
        try {
            return new ResponseEntity<>(customerOrderService.batchPrint(orderIds, false), headers, HttpStatus.OK);
        } catch (IOException e) {
            e.printStackTrace();
            throw new BadRequestException("IO发生错误");
        }
    }

    @GetMapping("/batchPrintOrigin")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_LIST')")
    public ResponseEntity batchPrintOrigin(@RequestParam String orderIds) {
        HttpHeaders headers = new HttpHeaders();
        headers.setAccessControlExposeHeaders(Collections.singletonList("Content-Disposition"));
        headers.set("Content-Disposition", "inline; filename=orders.pdf");
        headers.setAccessControlExposeHeaders(Collections.singletonList("Content-Type"));
        headers.set("Content-Type", "application/pdf");
        try {
            return new ResponseEntity<>(customerOrderService.batchPrint(orderIds, true), headers, HttpStatus.OK);
        } catch (IOException e) {
            throw new BadRequestException("IO发生错误");
        }
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_EDIT')")
    public ResponseEntity update(
            @Validated @RequestBody CustomerOrder resources,
            @RequestParam(value = "useNewAutoIncreaseSn") Boolean useNewAutoIncreaseSn,
            @RequestParam(value = "fetchStocks") Boolean fetchStocks) {
        if (resources.getId() == null) {
            throw new BadRequestException(ENTITY_NAME + " ID Can not be empty");
        }
        customerOrderService.update(resources.getId(), resources, useNewAutoIncreaseSn, fetchStocks);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @PutMapping("/complete")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_COMPLETE')")
    public ResponseEntity complete(@Validated @RequestBody CustomerOrderCompleteDTO customerOrderCompleteDTO) {
        customerOrderService.complete(customerOrderCompleteDTO);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @PutMapping("/updateComplete")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_COMPLETE')")
    public ResponseEntity updateComplete(@Validated @RequestBody CustomerOrderCompleteDTO customerOrderCompleteDTO) {
        customerOrderService.updateComplete(customerOrderCompleteDTO);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_DELETE')")
    public ResponseEntity delete(@PathVariable Long id) {
        customerOrderService.delete(id);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    private void checkPermission(Long customerId) {
        if (customerId == null) {
            throw new BadRequestException("客户ID参数错误");
        }
        JwtUser user = (JwtUser) getUserDetails();
        Set<CustomerVO> customers = userService.findById(user.getId()).getCustomers();
        if (customers.stream().noneMatch(p -> p.getId().equals(String.valueOf(customerId)))) {
            throw new BadRequestException("当前用户没有该客户的管理权限");
        }
    }

}