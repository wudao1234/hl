package org.mstudio.modules.wms.address_type.service.impl;

import org.mstudio.modules.wms.address.repository.AddressRepository;
import org.mstudio.modules.wms.address_type.domain.AddressType;
import org.mstudio.modules.wms.address_type.repository.AddressTypeRepository;
import org.mstudio.modules.wms.address_type.service.AddressTypeService;
import org.mstudio.modules.wms.address_type.service.mapper.AddressTypeMapper;
import org.mstudio.modules.wms.address_type.service.object.AddressTypeDTO;
import org.mstudio.modules.wms.address_type.service.object.AddressTypeVO;
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
public class AddressTypeServiceImpl implements AddressTypeService {

    public static final String CACHE_NAME = "AddressType";

    @Autowired
    AddressTypeRepository addressTypeRepository;

    @Autowired
    AddressTypeMapper addressTypeMapper;

    @Autowired
    AddressRepository addressRepository;

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Object queryAll(String name, Pageable pageable) {
        Page<AddressType> page;
        if (name == null || name.isEmpty()) {
            page = addressTypeRepository.findAll(pageable);
        } else {
            page = addressTypeRepository.findAllByNameLike(name, pageable);
        }
        return PageUtil.toPage(page.map(addressTypeMapper::toDto).map(goodsTypeDTO -> {
            goodsTypeDTO.setAddressCount(addressRepository.countByAddressTypeId(Long.valueOf(goodsTypeDTO.getId())));
            return goodsTypeDTO;
        }));
    }

    @Override
    @Cacheable(value = CACHE_NAME, key = "'AllList'")
    public List<AddressTypeVO> getAllList() {
        return addressTypeMapper.toVOList(addressTypeRepository.findAll());
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public AddressTypeDTO findById(Long id) {
        Optional<AddressType> goodsType = addressTypeRepository.findById(id);
        ValidationUtil.isNull(goodsType, "AddressType", "id", id);
        return addressTypeMapper.toDto(goodsType.get());
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public AddressTypeDTO create(AddressType resources) {
        return addressTypeMapper.toDto(addressTypeRepository.save(resources));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public AddressTypeVO update(Long id, AddressType resources) {
        Optional<AddressType> optionalAddressType = addressTypeRepository.findById(id);
        ValidationUtil.isNull(optionalAddressType, "AddressType", "id", id);
        resources.setId(id);
        return addressTypeMapper.toVO(addressTypeRepository.save(resources));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void delete(Long id) {
        addressTypeRepository.deleteById(id);
    }

}