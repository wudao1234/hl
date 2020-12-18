package org.mstudio.modules.wms.car.service.impl;

import org.mstudio.modules.wms.car.domain.CarBasic;
import org.mstudio.modules.wms.car.repository.CarBasicRepository;
import org.mstudio.modules.wms.car.service.CarBasicService;
import org.mstudio.modules.wms.car.service.mapper.CarBasicMapper;
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
public class CarBasicServiceImpl implements CarBasicService {

    public static final String CACHE_NAME = "CarBasic";

    @Autowired
    CarBasicRepository carBasicRepository;

    @Autowired
    CarBasicMapper carBasicMapper;

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Object queryAll(String name, Pageable pageable) {
        Page<CarBasic> page;
        if (name == null || name.isEmpty()) {
            page = carBasicRepository.findAll(pageable);
        } else {
            page = carBasicRepository.findAllByCarNumLike('%' + name + '%', pageable);
        }
        return PageUtil.toPage(page.map(carBasicMapper::toDto));
    }


    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public CarBasic create(CarBasic resources) {
        return carBasicRepository.save(resources);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public CarBasic update(Long id, CarBasic resources) {
        Optional<CarBasic> optional = carBasicRepository.findById(id);
        ValidationUtil.isNull(optional, "CarBasic", "id", id);
        resources.setId(id);
        return carBasicRepository.save(resources);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void delete(Long id) {
        carBasicRepository.deleteById(id);
    }

}