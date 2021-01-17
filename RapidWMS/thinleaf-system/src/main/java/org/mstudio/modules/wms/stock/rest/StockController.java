package org.mstudio.modules.wms.stock.rest;

import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.system.service.UserService;
import org.mstudio.modules.system.service.dto.UserDTO;
import org.mstudio.modules.wms.common.WmsUtil;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.stock.domain.Stock;
import org.mstudio.modules.wms.stock.service.StockService;
import org.mstudio.modules.wms.stock.service.mapper.StockMapper;
import org.mstudio.modules.wms.stock.service.object.StockActivateDTO;
import org.mstudio.modules.wms.stock.service.object.StockDTO;
import org.mstudio.modules.wms.stock.service.object.StockMultipleOperateDTO;
import org.mstudio.modules.wms.stock.service.object.StockSingleOperateDTO;
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
@RequestMapping("api/stocks")
public class StockController {

    @Autowired
    private StockService stockService;

    @Autowired
    private UserService userService;

    @Autowired
    private StockMapper stockMapper;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_STOCK_LIST', 'O_ORDER_EDIT')")
    public ResponseEntity list(
            @RequestParam(value = "exportExcel", required = false) Boolean exportExcel,
            @RequestParam(value = "wareZoneFilter", required = false) String wareZoneFilter,
            @RequestParam(value = "customerFilter", required = false) String customerFilter,
            @RequestParam(value = "goodsTypeFilter", required = false) String goodsTypeFilter,
            @RequestParam(value = "isActiveFilter", required = false) Boolean isActiveFilter,
            @RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "quantityGuaranteeSearch", required = false) Double quantityGuaranteeSearch,
            Pageable pageable) {
        JwtUser jwtUser = (JwtUser) getUserDetails();
        UserDTO user = userService.findById(jwtUser.getId());
        Set<CustomerVO> customers = user.getCustomers();
        if (customers.isEmpty()) {
            List<Stock> emptyStocks = new ArrayList<>();
            return new ResponseEntity<>(PageUtil.toPage(stockMapper.toDto(emptyStocks), 0), HttpStatus.OK);
        }
        if (exportExcel != null && exportExcel) {
            Map result = stockService.queryAll(customers, true, wareZoneFilter, customerFilter, goodsTypeFilter, isActiveFilter, search, pageable,quantityGuaranteeSearch);
            List<StockDTO> stocks = (List)result.get("content");
            return new ResponseEntity<>(stockService.exportExcelData(stocks), WmsUtil.getExportExcelHeaders(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(stockService.queryAll(customers, false, wareZoneFilter, customerFilter, goodsTypeFilter, isActiveFilter, search, pageable,quantityGuaranteeSearch), HttpStatus.OK);
        }
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_STOCK_LIST')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(stockService.findById(id), HttpStatus.OK);
    }

    @GetMapping("/query_stocks")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_STOCK_LIST')")
    public ResponseEntity QueryByGoodsSnAndPackCount(@RequestParam(value = "customerId") Long customerId, @RequestParam(value = "goodsSn") String goodsSn, @RequestParam(value = "packCount") Integer packCount) {
        return new ResponseEntity<>(stockService.QueryByCustomerIdAndGoodsSnAndPackCount(customerId, goodsSn, packCount), HttpStatus.OK);
    }

    @PostMapping("/activate")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_STOCK_EDIT')")
    public ResponseEntity activate(@RequestBody StockActivateDTO stockActivateDTO) {
        stockService.activate(stockActivateDTO);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @PostMapping("/single_operate")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_STOCK_EDIT')")
    public ResponseEntity singleOperate(@RequestBody StockSingleOperateDTO stockSingleOperateDTO) {
        stockService.singleOperate(stockSingleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @PostMapping("/multiple_operate")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_STOCK_EDIT')")
    public ResponseEntity singleOperate(@RequestBody StockMultipleOperateDTO stockMultipleOperateDTO) {
        stockService.multipleOperate(stockMultipleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

}