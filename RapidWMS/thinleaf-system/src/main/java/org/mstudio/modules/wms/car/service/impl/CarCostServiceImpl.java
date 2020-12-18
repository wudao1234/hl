package org.mstudio.modules.wms.car.service.impl;

import org.mstudio.modules.wms.car.domain.CarCost;
import org.mstudio.modules.wms.car.repository.CarCostRepository;
import org.mstudio.modules.wms.car.service.CarCostService;
import org.mstudio.modules.wms.car.service.mapper.CarCostMapper;
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
public class CarCostServiceImpl implements CarCostService {

    public static final String CACHE_NAME = "CarCost";

    @Autowired
    CarCostRepository carCostRepository;

    @Autowired
    CarCostMapper carCostMapper;

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Object queryAll(String name, Pageable pageable) {
        Page<CarCost> page;
        if (name == null || name.isEmpty()) {
            page = carCostRepository.findAll(pageable);
        } else {
            page = carCostRepository.findAllByCarNumLikeOrDriverNameLike('%' + name + '%', '%' + name + '%', pageable);
        }
        return PageUtil.toPage(page.map(carCostMapper::toDto));
    }


    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public CarCost create(CarCost resources) {
        return carCostRepository.save(resources);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public CarCost update(Long id, CarCost resources) {
        Optional<CarCost> optional = carCostRepository.findById(id);
        ValidationUtil.isNull(optional, "CarCost", "id", id);
        resources.setId(id);
        return carCostRepository.save(resources);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void delete(Long id) {
        carCostRepository.deleteById(id);
    }

}