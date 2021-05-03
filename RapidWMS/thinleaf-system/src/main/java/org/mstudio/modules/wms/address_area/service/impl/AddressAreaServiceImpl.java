package org.mstudio.modules.wms.address_area.service.impl;

import org.mstudio.modules.wms.address.repository.AddressRepository;
import org.mstudio.modules.wms.address_area.domain.AddressArea;
import org.mstudio.modules.wms.address_area.repository.AddressAreaRepository;
import org.mstudio.modules.wms.address_area.service.AddressAreaService;
import org.mstudio.modules.wms.address_area.service.mapper.AddressAreaMapper;
import org.mstudio.modules.wms.address_area.service.object.AddressAreaDTO;
import org.mstudio.modules.wms.address_area.service.object.AddressAreaVO;
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
public class AddressAreaServiceImpl implements AddressAreaService {

    public static final String CACHE_NAME = "AddressArea";

    @Autowired
    AddressAreaRepository addressAreaRepository;

    @Autowired
    AddressAreaMapper addressAreaMapper;

    @Autowired
    AddressRepository addressRepository;

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Object queryAll(String name, Pageable pageable) {
        Page<AddressArea> page;
        if (name == null || name.isEmpty()) {
            page = addressAreaRepository.findAll(pageable);
        } else {
            page = addressAreaRepository.findAllByNameLike(name, pageable);
        }
        return PageUtil.toPage(page.map(addressAreaMapper::toDto).map(goodsTypeDTO -> {
            goodsTypeDTO.setAddressCount(addressRepository.countByAddressAreaId(Long.valueOf(goodsTypeDTO.getId())));
            return goodsTypeDTO;
        }));
    }

    @Override
    @Cacheable(value = CACHE_NAME, key = "'AllList'")
    public List<AddressAreaVO> getAllList() {
        return addressAreaMapper.toVOList(addressAreaRepository.findAll());
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public AddressAreaDTO findById(Long id) {
        Optional<AddressArea> goodsType = addressAreaRepository.findById(id);
        ValidationUtil.isNull(goodsType, "AddressArea", "id", id);
        return addressAreaMapper.toDto(goodsType.get());
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public AddressAreaDTO create(AddressArea resources) {
        return addressAreaMapper.toDto(addressAreaRepository.save(resources));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public AddressAreaVO update(Long id, AddressArea resources) {
        Optional<AddressArea> optionalAddressArea = addressAreaRepository.findById(id);
        ValidationUtil.isNull(optionalAddressArea, "AddressArea", "id", id);
        resources.setId(id);
        return addressAreaMapper.toVO(addressAreaRepository.save(resources));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void delete(Long id) {
        addressAreaRepository.deleteById(id);
    }

}