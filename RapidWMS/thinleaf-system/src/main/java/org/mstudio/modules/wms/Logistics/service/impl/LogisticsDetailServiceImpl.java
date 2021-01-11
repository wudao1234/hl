package org.mstudio.modules.wms.Logistics.service.impl;

import io.jsonwebtoken.lang.Assert;
import org.mstudio.modules.wms.Logistics.domain.LogisticsDetail;
import org.mstudio.modules.wms.Logistics.repository.LogisticsDetailRepository;
import org.mstudio.modules.wms.Logistics.service.LogisticsDetailService;
import org.mstudio.modules.wms.Logistics.service.mapper.LogisticsDetailMapper;
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
public class LogisticsDetailServiceImpl implements LogisticsDetailService {

    public static final String CACHE_NAME = "LogisticsDetail";

    @Autowired
    LogisticsDetailRepository logisticsDetailRepository;

    @Autowired
    LogisticsDetailMapper logisticsDetailMapper;

    @Override
//    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Object queryAll(String name, Pageable pageable) {
        Page<LogisticsDetail> page;
        if (name == null || name.isEmpty()) {
            page = logisticsDetailRepository.findAll(pageable);
        } else {
            page = logisticsDetailRepository.findAllByNameLike('%' + name + '%', pageable);
        }
        return PageUtil.toPage(page.map(logisticsDetailMapper::toDto));
    }

    @Override
    @Cacheable(value = CACHE_NAME, key = "'AllList'")
    public List<LogisticsDetail> getAllList() {
        return logisticsDetailRepository.findAll();
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public LogisticsDetail findById(Long id) {
        Optional<LogisticsDetail> goodsType = logisticsDetailRepository.findById(id);
        return goodsType.get();
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public LogisticsDetail create(LogisticsDetail resources) {
        LogisticsDetail dispatchSys = logisticsDetailRepository.findByName(resources.getName());
        Assert.isNull(dispatchSys, "名称不能重复");
        return logisticsDetailRepository.save(resources);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public LogisticsDetail update(Long id, LogisticsDetail resources) {
        Optional<LogisticsDetail> optional = logisticsDetailRepository.findById(id);
        ValidationUtil.isNull(optional, "LogisticsDetail", "id", id);
        resources.setId(id);
        return logisticsDetailRepository.save(resources);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void delete(Long id) {
        logisticsDetailRepository.deleteById(id);
    }

}