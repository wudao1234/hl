package org.mstudio.modules.wms.dispatch.service.impl;

import io.jsonwebtoken.lang.Assert;
import org.mstudio.modules.wms.address.repository.AddressRepository;
import org.mstudio.modules.wms.address_type.service.mapper.AddressTypeMapper;
import org.mstudio.modules.wms.dispatch.domain.DispatchSys;
import org.mstudio.modules.wms.dispatch.repository.DispatchSysRepository;
import org.mstudio.modules.wms.dispatch.service.DispatchSysService;
import org.mstudio.modules.wms.dispatch.service.mapper.DispatchSysMapper;
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
public class DispatchSysServiceImpl implements DispatchSysService {

    public static final String CACHE_NAME = "DispatchSys";

    @Autowired
    AddressTypeMapper addressTypeMapper;

    @Autowired
    AddressRepository addressRepository;

    @Autowired
    DispatchSysRepository dispatchSysRepository;

    @Autowired
    DispatchSysMapper dispatchSysMapper;

    @Override
//    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Object queryAll(String name, Pageable pageable) {
        Page<DispatchSys> page;
        if (name == null || name.isEmpty()) {
            page = dispatchSysRepository.findAll(pageable);
        } else {
            page = dispatchSysRepository.findAllByNameLike(name, pageable);
        }
        return PageUtil.toPage(page.map(dispatchSysMapper::toDto));
    }

    @Override
    @Cacheable(value = CACHE_NAME, key = "'AllList'")
    public List<DispatchSys> getAllList() {
        return dispatchSysRepository.findAll();
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public DispatchSys findById(Long id) {
        Optional<DispatchSys> goodsType = dispatchSysRepository.findById(id);
        return goodsType.get();
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public DispatchSys create(DispatchSys resources) {
        DispatchSys dispatchSys = dispatchSysRepository.findByName(resources.getName());
        Assert.isNull(dispatchSys,"名称不能重复");
        return dispatchSysRepository.save(resources);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public DispatchSys update(Long id, DispatchSys resources) {
        Optional<DispatchSys> optional = dispatchSysRepository.findById(id);
        ValidationUtil.isNull(optional, "DispatchSys", "id", id);
        resources.setId(id);
        return dispatchSysRepository.save(resources);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void delete(Long id) {
        dispatchSysRepository.deleteById(id);
    }

}