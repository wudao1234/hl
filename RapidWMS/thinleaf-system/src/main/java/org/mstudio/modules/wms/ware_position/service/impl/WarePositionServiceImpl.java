package org.mstudio.modules.wms.ware_position.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import lombok.Synchronized;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.mstudio.modules.wms.stock.domain.Stock;
import org.mstudio.modules.wms.stock.service.StockService;
import org.mstudio.modules.wms.ware_position.domain.WarePosition;
import org.mstudio.modules.wms.ware_position.repository.WarePositionRepository;
import org.mstudio.modules.wms.ware_position.service.WarePositionService;
import org.mstudio.modules.wms.ware_position.service.mapper.WarePositionMapper;
import org.mstudio.modules.wms.ware_position.service.object.WarePositionDTO;
import org.mstudio.modules.wms.ware_position.service.object.WarePositionExcelObj;
import org.mstudio.modules.wms.ware_zone.service.impl.WareZoneServiceImpl;
import org.mstudio.utils.PageUtil;
import org.mstudio.utils.StringUtils;
import org.mstudio.utils.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.Caching;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.*;
import java.io.ByteArrayOutputStream;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author Macrow
 * @date 2019-02-22
 */

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class WarePositionServiceImpl implements WarePositionService {

    public static final String CACHE_NAME = "WarePosition";

    @Value("${excel.export-max-count}")
    private Integer maxCount;

    @Autowired
    WarePositionRepository warePositionRepository;

    @Autowired
    WarePositionMapper warePositionMapper;

    @Autowired
    StockService stockService;

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    public Map queryAll(Boolean exportExcel, String wareZoneFilter, String name, Pageable pageable) {
        Specification<WarePosition> spec = new Specification<WarePosition>() {
            @Override
            public Predicate toPredicate(Root<WarePosition> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();

                if (wareZoneFilter != null && !"".equals(wareZoneFilter)) {
                    String[] goodsTypeIds = wareZoneFilter.split(",");
                    CriteriaBuilder.In<Long> in = criteriaBuilder.in(root.get("wareZone").get("id"));
                    Arrays.stream(goodsTypeIds).forEach(id -> in.value(Long.valueOf(id)));
                    predicates.add(in);
                }

                if (name != null) {
                    predicates.add(criteriaBuilder.like(root.get("name").as(String.class), "%" + name + "%"));
                }

                if (predicates.size() != 0) {
                    Predicate[] p = new Predicate[predicates.size()];
                    return criteriaBuilder.and(predicates.toArray(p));
                } else {
                    return null;
                }
            }
        };
        Sort sort = pageable.getSort().and(new Sort(Sort.Direction.DESC, "id"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        if (exportExcel) {
            newPageable = PageRequest.of(0, maxCount, sort);
        }
        Page<WarePosition> page = warePositionRepository.findAll(spec, newPageable);
        return PageUtil.toPage(page.map(warePositionMapper::toDto).map(warePositionDTO -> {
            warePositionDTO.setStockCount(stockService.countByWarePositionId(Long.valueOf(warePositionDTO.getId())));
            return warePositionDTO;
        }));
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public WarePositionDTO findById(Long id) {
        Optional<WarePosition> warePosition = warePositionRepository.findById(id);
        ValidationUtil.isNull(warePosition, "WarePosition", "id", id);
        return warePositionMapper.toDto(warePosition.get());
    }

    @Override
    @Synchronized
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = WareZoneServiceImpl.CACHE_NAME, allEntries = true),
            @CacheEvict(value = WareZoneServiceImpl.CACHE_NAME, allEntries = true),
    })
    public WarePositionDTO create(WarePosition resources) {
        Assert.isFalse(warePositionRepository.findByNameAndWareZoneId(resources.getName(), resources.getWareZone().getId()).isPresent(), "同库区下名称不能重复");
        return warePositionMapper.toDto(warePositionRepository.save(resources));
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = WareZoneServiceImpl.CACHE_NAME, allEntries = true),
            @CacheEvict(value = WareZoneServiceImpl.CACHE_NAME, allEntries = true),
    })
    public void update(Long id, WarePosition resources) {
        Optional<WarePosition> warePositionExist = warePositionRepository.findById(id);
        Assert.isTrue(warePositionExist.isPresent(), "指定id的库位不存在");
        Optional<WarePosition> warePositionWithSameName = warePositionRepository.findByNameAndWareZoneIdAndIdIsNot(resources.getName(), resources.getWareZone().getId(), id);
        Assert.isFalse(warePositionWithSameName.isPresent(), "同库区下已有同名库位");
        resources.setId(id);
        warePositionRepository.save(resources);
    }

    @Override
    @Caching(evict = {
            @CacheEvict(value = CACHE_NAME, allEntries = true),
            @CacheEvict(value = WareZoneServiceImpl.CACHE_NAME, allEntries = true),
            @CacheEvict(value = WareZoneServiceImpl.CACHE_NAME, allEntries = true),
    })
    public void delete(Long id) {
        warePositionRepository.deleteById(id);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public byte[] exportExcelData(List<WarePositionDTO> warePositions) {
        List<WarePositionExcelObj> rows = CollUtil.newArrayList();
        for (int i = 0; i < warePositions.size(); i++) {
            WarePositionExcelObj excelObj = new WarePositionExcelObj();
            excelObj.setIndex(Long.valueOf(i + 1));
            excelObj.setName(warePositions.get(i).getName());
            excelObj.setSortOrder(warePositions.get(i).getSortOrder());
            excelObj.setDescription(warePositions.get(i).getDescription());
            excelObj.setWareZoneName(warePositions.get(i).getWareZone().getName());
            excelObj.setStockCount(warePositions.get(i).getStockCount());
            rows.add(excelObj);
        }
        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
        ExcelWriter writer = ExcelUtil.getBigWriter();
        writer.addHeaderAlias("index", "#");
        writer.addHeaderAlias("name", "库位名称");
        writer.addHeaderAlias("sortOrder", "排序");
        writer.addHeaderAlias("description", "说明");
        writer.addHeaderAlias("wareZoneName", "所在库区");
        writer.addHeaderAlias("stockCount", "现有库存数量");
        writer.write(rows, true);
        writer.flush(outByteStream);
        writer.close();
        return outByteStream.toByteArray();
    }

    @Override
    public Map spare(String name, Pageable pageable) {
        Specification<WarePosition> spec = new Specification<WarePosition>() {
            @Override
            public Predicate toPredicate(Root<WarePosition> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();
                if (StringUtils.isNotEmpty(name)) {
                    predicates.add(criteriaBuilder.like(root.get("name").as(String.class), "%" + name + "%"));
                }

                if (predicates.size() != 0) {
                    Predicate[] p = new Predicate[predicates.size()];
                    return criteriaBuilder.and(predicates.toArray(p));
                } else {
                    return null;
                }
            }
        };
        Sort sort = pageable.getSort().and(new Sort(Sort.Direction.DESC, "id"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        Page<WarePosition> page = warePositionRepository.findAll(spec, newPageable);
        List<WarePositionDTO> pageFilter = page.stream().filter(warePosition ->
                ObjectUtil.isNull(warePosition.getStocks()) || warePosition.getStocks().size() == 0)
                .collect(Collectors.toList())
                .stream().map(warePositionMapper::toDto)
                .collect(Collectors.toList());
        return PageUtil.toPage(pageFilter);
//        return PageUtil.toPage(page.map(warePositionMapper::toDto));
    }

}