package org.mstudio.modules.wms.Logistics.service.impl;

import io.jsonwebtoken.lang.Assert;
import org.mstudio.modules.wms.Logistics.domain.LogisticsTemplate;
import org.mstudio.modules.wms.Logistics.repository.LogisticsTemplateRepository;
import org.mstudio.modules.wms.Logistics.service.LogisticsTemplateService;
import org.mstudio.modules.wms.Logistics.service.mapper.LogisticsTemplateMapper;
import org.mstudio.modules.wms.Logistics.service.object.LogisticsTemplateDTO;
import org.mstudio.modules.wms.Logistics.service.object.LogisticsTemplateVO;
import org.mstudio.utils.PageUtil;
import org.mstudio.utils.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
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

import java.util.*;
import java.util.stream.Collectors;

/**
 * @author Macrow
 * @date 2019-07-09
 */

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class LogisticsTemplateServiceImpl implements LogisticsTemplateService {

    public static final String CACHE_NAME = "LogisticsTemplate";

    @Autowired
    LogisticsTemplateRepository logisticsTemplateRepository;

    @Autowired
    LogisticsTemplateMapper logisticsTemplateMapper;

    @Override
//    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Object queryAll(String name, Pageable pageable) {
        Page<LogisticsTemplate> page;
        if (name == null || name.isEmpty()) {
            page = logisticsTemplateRepository.findAll(pageable);
        } else {
            page = logisticsTemplateRepository.findAllByNameLike('%' + name + '%', pageable);
        }
        return PageUtil.toPage(page.map(logisticsTemplateMapper::toDto));
    }

    @Override
    @Cacheable(value = CACHE_NAME, key = "'AllList'")
    public List<LogisticsTemplateVO> getAllList() {
        return logisticsTemplateMapper.toVOList(logisticsTemplateRepository.findAll());
    }

    @Override
    public List<LogisticsTemplateDTO> fetchGroupAll() {
        Specification<LogisticsTemplate> spec = (root, criteriaQuery, criteriaBuilder) ->
                criteriaBuilder.and(
                        criteriaBuilder.lessThanOrEqualTo(root.get("dateTime").as(Date.class), new Date()));
        Sort sort = new Sort(Sort.Direction.DESC, "dateTime");
        Pageable pageable = PageRequest.of(0, 1000, sort);
        Page<LogisticsTemplate> page = logisticsTemplateRepository.findAll(spec, pageable);
        List<LogisticsTemplate> data = page.getContent();
        Map<String, List<LogisticsTemplate>> LogisticsTemplateListMap = data.stream()
                .collect(Collectors.groupingBy(LogisticsTemplate::getName));
        List<LogisticsTemplate> newData = new ArrayList<>();
        LogisticsTemplateListMap.forEach((k, v) -> {
            newData.add(v.get(0));
        });
        return logisticsTemplateMapper.toDto(newData);
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public LogisticsTemplate findById(Long id) {
        Optional<LogisticsTemplate> goodsType = logisticsTemplateRepository.findById(id);
        return goodsType.get();
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public LogisticsTemplate create(LogisticsTemplate resources) {
        LogisticsTemplate dispatchSys = logisticsTemplateRepository.findByNameAndDateTime(resources.getName(), resources.getDateTime());
        Assert.isNull(dispatchSys, "不能重复");
        return logisticsTemplateRepository.save(resources);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public LogisticsTemplateVO update(Long id, LogisticsTemplate resources) {
        Optional<LogisticsTemplate> optional = logisticsTemplateRepository.findById(id);
        ValidationUtil.isNull(optional, "LogisticsTemplate", "id", id);
        resources.setId(id);
        return logisticsTemplateMapper.toVO(logisticsTemplateRepository.save(resources));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void delete(Long id) {
        logisticsTemplateRepository.deleteById(id);
    }

}