package org.mstudio.modules.wms.goods_type.rest;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.goods_type.domain.GoodsType;
import org.mstudio.modules.wms.goods_type.service.GoodsTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
* @author Macrow
* @date 2019-02-22
*/

@RestController
@RequestMapping("api/goods_types")
public class GoodsTypeController {

    @Autowired
    private GoodsTypeService goodsTypeService;

    private static final String ENTITY_NAME = "GoodsType";

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_GOODS_TYPE')")
    public Object list(@RequestParam(value = "search", required = false) String nameOrShortName, Pageable pageable) {
        return new ResponseEntity<>(goodsTypeService.queryAll(nameOrShortName, pageable), HttpStatus.OK);
    }

    @GetMapping("/all_list")
    @PreAuthorize("hasAnyRole('ADMIN', 'W_STOCK_LIST', 'S_GOODS', 'S_GOODS_TYPE')")
    public Object allList() {
        return new ResponseEntity<>(goodsTypeService.getAllList(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_GOODS_TYPE')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(goodsTypeService.findById(id), HttpStatus.OK);
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_GOODS_TYPE')")
    public ResponseEntity create(@Validated @RequestBody GoodsType resources) {
        if (resources.getId() != null) {
            throw new BadRequestException("A new " + ENTITY_NAME + " cannot already have an ID");
        }
        return new ResponseEntity<>(goodsTypeService.create(resources), HttpStatus.CREATED);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_GOODS_TYPE')")
    public ResponseEntity update(@Validated @RequestBody GoodsType resources) {
        if (resources.getId() == null) {
            throw new BadRequestException(ENTITY_NAME + " ID Can not be empty");
        }
        return new ResponseEntity<>(goodsTypeService.update(resources.getId(), resources), HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_GOODS_TYPE')")
    public ResponseEntity delete(@PathVariable Long id) {
        goodsTypeService.delete(id);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

}