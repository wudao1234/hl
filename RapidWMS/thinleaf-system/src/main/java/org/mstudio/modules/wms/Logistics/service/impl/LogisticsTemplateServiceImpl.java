package org.mstudio.modules.wms.Logistics.service.impl;

import io.jsonwebtoken.lang.Assert;
import org.mstudio.modules.wms.Logistics.domain.LogisticsTemplate;
import org.mstudio.modules.wms.Logistics.repository.LogisticsTemplateRepository;
import org.mstudio.modules.wms.Logistics.service.LogisticsTemplateService;
import org.mstudio.modules.wms.Logistics.service.mapper.LogisticsTemplateMapper;
import org.mstudio.utils.PageUtil;
import org.mstudio.utils.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

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
    public List<LogisticsTemplate> getAllList() {
        return logisticsTemplateRepository.findAll();
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
        LogisticsTemplate dispatchSys = logisticsTemplateRepository.findByName(resources.getName());
        Assert.isNull(dispatchSys, "名称不能重复");
        return logisticsTemplateRepository.save(resources);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public LogisticsTemplate update(Long id, LogisticsTemplate resources) {
        Optional<LogisticsTemplate> optional = logisticsTemplateRepository.findById(id);
        ValidationUtil.isNull(optional, "LogisticsTemplate", "id", id);
        resources.setId(id);
        return logisticsTemplateRepository.save(resources);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void delete(Long id) {
        logisticsTemplateRepository.deleteById(id);
    }

}