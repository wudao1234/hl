package org.mstudio.modules.wms.fixed_estate.service.impl;

import org.mstudio.modules.wms.fixed_estate.domain.FixedEstate;
import org.mstudio.modules.wms.fixed_estate.repository.FixedEstateRepository;
import org.mstudio.modules.wms.fixed_estate.service.FixedEstateService;
import org.mstudio.modules.wms.fixed_estate.service.mapper.FixedEstateMapper;
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

import java.util.Optional;

/**
 * @author Macrow
 * @date 2019-07-09
 */

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class FixedEstateServiceImpl implements FixedEstateService {

    public static final String CACHE_NAME = "FixedEstate";

    @Autowired
    FixedEstateRepository fixedEstateRepository;

    @Autowired
    FixedEstateMapper fixedEstateMapper;

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Object queryAll(String name, Pageable pageable) {
        Page<FixedEstate> page;
        if (name == null || name.isEmpty()) {
            page = fixedEstateRepository.findAll(pageable);
        } else {
            page = fixedEstateRepository.findAllByAssetsNameLike('%' + name + '%', pageable);
        }
        return PageUtil.toPage(page.map(fixedEstateMapper::toDto));
    }


    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public FixedEstate create(FixedEstate resources) {
        return fixedEstateRepository.save(resources);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public FixedEstate update(Long id, FixedEstate resources) {
        Optional<FixedEstate> optional = fixedEstateRepository.findById(id);
        ValidationUtil.isNull(optional, "FixedEstate", "id", id);
        resources.setId(id);
        return fixedEstateRepository.save(resources);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void delete(Long id) {
        fixedEstateRepository.deleteById(id);
    }

}