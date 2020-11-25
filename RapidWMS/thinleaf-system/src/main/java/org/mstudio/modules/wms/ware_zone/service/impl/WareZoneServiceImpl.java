package org.mstudio.modules.wms.ware_zone.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.lang.Assert;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import lombok.Synchronized;
import org.mstudio.modules.wms.ware_position.repository.WarePositionRepository;
import org.mstudio.modules.wms.ware_zone.domain.WareZone;
import org.mstudio.modules.wms.ware_zone.repository.WareZoneRepository;
import org.mstudio.modules.wms.ware_zone.service.WareZoneService;
import org.mstudio.modules.wms.ware_zone.service.mapper.WareZoneMapper;
import org.mstudio.modules.wms.ware_zone.service.object.WareZoneDTO;
import org.mstudio.modules.wms.ware_zone.service.object.WareZoneExcelObj;
import org.mstudio.modules.wms.ware_zone.service.object.WareZoneVO;
import org.mstudio.utils.PageUtil;
import org.mstudio.utils.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.io.ByteArrayOutputStream;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

/**
* @author Macrow
* @date 2019-02-22
*/

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class WareZoneServiceImpl implements WareZoneService {

    public static final String CACHE_NAME = "WareZone";

    @Value("${excel.export-max-count}")
    private Integer maxCount;

    @Autowired
    WareZoneRepository wareZoneRepository;

    @Autowired
    WareZoneMapper wareZoneMapper;

    @Autowired
    WarePositionRepository warePositionRepository;

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    public Map queryAll(Boolean exportExcel, String search, Pageable pageable) {
        Sort sort = pageable.getSort().and(new Sort(Sort.Direction.DESC, "id"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        if (exportExcel) {
            newPageable = PageRequest.of(0, maxCount, sort);
        }
        Page<WareZone> page = wareZoneRepository.findAll(new Spec(search), newPageable);
        return PageUtil.toPage(page.map(wareZoneMapper::toVO).map(wareZoneVO -> {
            wareZoneVO.setWarePositionCount(warePositionRepository.countByWareZoneId(Long.valueOf(wareZoneVO.getId())));
            return wareZoneVO;
        }));
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "'AllList'")
    public List<WareZoneVO> getAllList() {
        return wareZoneMapper.toVOList(wareZoneRepository.findAll());
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "'Tree'")
    public List<WareZoneDTO> getTree() {
        return wareZoneMapper.toDto(wareZoneRepository.findAll());
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public WareZoneVO findById(Long id) {
        Optional<WareZone> wareZone = wareZoneRepository.findById(id);
        ValidationUtil.isNull(wareZone, "WareZone", "id", id);
        return wareZoneMapper.toVO(wareZone.get());
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    @Synchronized
    public WareZoneVO create(WareZone resources) {
        Assert.isFalse(wareZoneRepository.findByName(resources.getName()).isPresent(), "名称不能重复");
        return wareZoneMapper.toVO(wareZoneRepository.save(resources));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    @Synchronized
    public void update(Long id, WareZone resources) {
        Optional<WareZone> wareZoneExist = wareZoneRepository.findById(id);
        Assert.isTrue(wareZoneExist.isPresent(), "指定id的库区不存在");
        Optional<WareZone> wareZoneWithSameName = wareZoneRepository.findByNameAndIdIsNot(resources.getName(), resources.getId());
        Assert.isFalse(wareZoneWithSameName.isPresent(), "已有同名库区");
        resources.setId(id);
        wareZoneRepository.save(resources);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void delete(Long id) {
        wareZoneRepository.deleteById(id);
    }

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    public List<WareZoneVO> getListByIds(String[] ids) {
        List<Long> newIds = Arrays.stream(ids).map(Long::valueOf).collect(Collectors.toList());
        return wareZoneMapper.toVOList(wareZoneRepository.findAllByIdIn(newIds));
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public byte[] exportExcelData(List<WareZoneVO> wareZones) {
        List<WareZoneExcelObj> rows = CollUtil.newArrayList();
        for (int i = 0; i < wareZones.size(); i++) {
            WareZoneExcelObj excelObj = new WareZoneExcelObj();
            excelObj.setIndex(Long.valueOf(i + 1));
            excelObj.setName(wareZones.get(i).getName());
            excelObj.setSortOrder(wareZones.get(i).getSortOrder());
            excelObj.setWarePositionCount(wareZones.get(i).getWarePositionCount());
            excelObj.setDescription(wareZones.get(i).getDescription());
            rows.add(excelObj);
        }
        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
        ExcelWriter writer = ExcelUtil.getBigWriter();
        writer.addHeaderAlias("index", "#");
        writer.addHeaderAlias("name", "库区名称");
        writer.addHeaderAlias("sortOrder", "排序");
        writer.addHeaderAlias("warePositionCount", "库位数量");
        writer.addHeaderAlias("description", "说明");
        writer.write(rows, true);
        writer.flush(outByteStream);
        writer.close();
        return outByteStream.toByteArray();
    }

    class Spec implements Specification<WareZone> {

        private String nameOrShortName;

        Spec(String nameOrShortName) {
            this.nameOrShortName = nameOrShortName;
        }

        @Override
        public Predicate toPredicate(Root<WareZone> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            if(ObjectUtils.isEmpty(nameOrShortName)) {
                return null;
            }
            Predicate p1 = criteriaBuilder.like(root.get("name").as(String.class), "%" + nameOrShortName + "%");
            return criteriaQuery.where(p1).getRestriction();
        }
    }

}