package org.mstudio.modules.wms.goods.rest;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.system.service.UserService;
import org.mstudio.modules.system.service.dto.UserDTO;
import org.mstudio.modules.wms.common.WmsUtil;
import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.goods.domain.Goods;
import org.mstudio.modules.wms.goods.service.GoodsService;
import org.mstudio.modules.wms.goods.service.mapper.GoodsMapper;
import org.mstudio.modules.wms.goods.service.object.GoodsDTO;
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
@RequestMapping("api/goods")
public class GoodsController {

    private static final String ENTITY_NAME = "Goods";

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private UserService userService;

    @Autowired
    private GoodsMapper goodsMapper;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_GOODS', 'O_ORDER_EDIT')")
    public ResponseEntity list(
            @RequestParam(value = "exportExcel", required = false) Boolean exportExcel,
            @RequestParam(value = "goodsTypeFilter", required = false) String goodsTypeFilter,
            @RequestParam(value = "goodsCustomerFilter", required = false) String goodsCustomerFilter,
            @RequestParam(value = "search", required = false) String search,
            Pageable pageable) {
        JwtUser jwtUser = (JwtUser) getUserDetails();
        UserDTO user = userService.findById(jwtUser.getId());
        Set<CustomerVO> customers = user.getCustomers();
        if (customers.isEmpty()) {
            List<Goods> emptyGoods = new ArrayList<>();
            return new ResponseEntity<>(PageUtil.toPage(goodsMapper.toDto(emptyGoods), 0), HttpStatus.OK);
        }
        if (exportExcel != null && exportExcel) {
            Map result = goodsService.queryAll(customers, true, goodsTypeFilter, goodsCustomerFilter, search, pageable);
            List<GoodsDTO> goods = (List) result.get("content");
            return new ResponseEntity<>(goodsService.exportExcelData(goods), WmsUtil.getExportExcelHeaders(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(goodsService.queryAll(customers, false, goodsTypeFilter, goodsCustomerFilter, search, pageable), HttpStatus.OK);
        }
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_GOODS')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(goodsService.findById(id), HttpStatus.OK);
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_GOODS')")
    public ResponseEntity create(@Validated @RequestBody Goods resources) {
        if (resources.getId() != null) {
            throw new BadRequestException("A new " + ENTITY_NAME + " cannot already have an ID");
        }
        return new ResponseEntity<>(goodsService.create(resources), HttpStatus.CREATED);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_GOODS')")
    public ResponseEntity update(@Validated @RequestBody Goods resources) {
        if (resources.getId() == null) {
            throw new BadRequestException(ENTITY_NAME + " ID Can not be empty");
        }
        return new ResponseEntity<>(goodsService.update(resources.getId(), resources), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_GOODS')")
    public ResponseEntity delete(@PathVariable Long id) {
        goodsService.delete(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

}