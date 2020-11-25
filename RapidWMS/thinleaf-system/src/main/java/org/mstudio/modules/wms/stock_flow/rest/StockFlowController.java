package org.mstudio.modules.wms.stock_flow.rest;

import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.system.service.UserService;
import org.mstudio.modules.system.service.dto.UserDTO;
import org.mstudio.modules.wms.common.WmsUtil;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.stock_flow.domain.StockFlow;
import org.mstudio.modules.wms.stock_flow.service.StockFlowService;
import org.mstudio.modules.wms.stock_flow.service.mapper.StockFlowMapper;
import org.mstudio.modules.wms.stock_flow.service.object.StockFlowDTO;
import org.mstudio.utils.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
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
@RequestMapping("api/stock_flows")
public class StockFlowController {

    @Autowired
    private StockFlowService stockFlowService;

    @Autowired
    private UserService userService;

    @Autowired
    private StockFlowMapper stockFlowMapper;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_STOCK_FLOW_LIST')")
    public ResponseEntity list(
            @RequestParam(value = "exportExcel", required = false) Boolean exportExcel,
            @RequestParam(value = "flowOperateTypeFilter", required = false) String flowOperateTypeFilter,
            @RequestParam(value = "customerFilter", required = false) String customerFilter,
            @RequestParam(value = "wareZoneInFilter", required = false) String wareZoneInFilter,
            @RequestParam(value = "wareZoneOutFilter", required = false) String wareZoneOutFilter,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "searchWarePositionIn", required = false) String searchWarePositionIn,
            @RequestParam(value = "searchWarePositionOut", required = false) String searchWarePositionOut,
            Pageable pageable) {
        JwtUser jwtUser = (JwtUser) getUserDetails();
        UserDTO user = userService.findById(jwtUser.getId());
        Set<CustomerVO> customers = user.getCustomers();
        if (customers.isEmpty()) {
            List<StockFlow> emptyStockFlows = new ArrayList<>();
            return new ResponseEntity(PageUtil.toPage(stockFlowMapper.toDto(emptyStockFlows), 0), HttpStatus.OK);
        }
        if (exportExcel != null && exportExcel) {
            Map result = stockFlowService.queryAll(customers, true, flowOperateTypeFilter, customerFilter, wareZoneInFilter, wareZoneOutFilter, startDate, endDate, search, searchWarePositionIn, searchWarePositionOut, pageable);
            List<StockFlowDTO> stockFlows = (List)result.get("content");
            return new ResponseEntity<>(stockFlowService.exportExcelData(stockFlows), WmsUtil.getExportExcelHeaders(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(stockFlowService.queryAll(customers, false, flowOperateTypeFilter, customerFilter, wareZoneInFilter, wareZoneOutFilter, startDate, endDate, search, searchWarePositionIn, searchWarePositionOut, pageable), HttpStatus.OK);
        }
    }

    @GetMapping("/list_for_orders")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_STOCK_FLOW')")
    public ResponseEntity listForOrders(
            @RequestParam(value = "exportExcel", required = false) Boolean exportExcel,
            @RequestParam(value = "customerFilter", required = false) String customerFilter,
            @RequestParam(value = "wareZoneOutFilter", required = false) String wareZoneOutFilter,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "searchWarePositionOut", required = false) String searchWarePositionOut,
            Pageable pageable) {
        JwtUser jwtUser = (JwtUser) getUserDetails();
        UserDTO user = userService.findById(jwtUser.getId());
        Set<CustomerVO> customers = user.getCustomers();
        if (customers.isEmpty()) {
            List<StockFlow> emptyStockFlows = new ArrayList<>();
            return new ResponseEntity<>(PageUtil.toPage(stockFlowMapper.toDto(emptyStockFlows), 0), HttpStatus.OK);
        }
        if (exportExcel != null && exportExcel) {
            Map result = stockFlowService.queryForOrders(customers, true, customerFilter, wareZoneOutFilter, startDate, endDate, search, searchWarePositionOut, pageable);
            List<StockFlowDTO> stockFlows = (List) result.get("content");
            return new ResponseEntity<>(stockFlowService.exportExcelDataForOrder(stockFlows), WmsUtil.getExportExcelHeaders(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(stockFlowService.queryForOrders(customers, false, customerFilter, wareZoneOutFilter, startDate, endDate, search, searchWarePositionOut, pageable), HttpStatus.OK);
        }
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'BUSINESS_ALL', 'WAREHOUSE_ALL', 'WAREHOUSE_STOCK_FLOW')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(stockFlowService.findById(id), HttpStatus.OK);
    }

    @GetMapping("/findByOrderId/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'O_ORDER_LIST', 'T_ORDER_GATHER', 'T_ORDER_CONFIRM')")
    public ResponseEntity findByOrderId(@PathVariable Long id) {
        return new ResponseEntity<>(stockFlowService.queryAllByOrderId(id), HttpStatus.OK);
    }

    @GetMapping("/findByReceiveGoodsId/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_RECEIVE_LIST')")
    public ResponseEntity findByReceiveGoodsId(@PathVariable Long id) {
        return new ResponseEntity<>(stockFlowService.queryAllByReceiveGoodsId(id), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'BUSINESS_ALL', 'WAREHOUSE_ALL', 'WAREHOUSE_STOCK_FLOW')")
    public ResponseEntity delete(@PathVariable Long id) {
        stockFlowService.delete(id);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

}