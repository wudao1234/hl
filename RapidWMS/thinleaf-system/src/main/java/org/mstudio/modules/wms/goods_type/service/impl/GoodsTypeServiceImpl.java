package org.mstudio.modules.wms.goods_type.service.impl;

import org.mstudio.modules.wms.goods.service.GoodsService;
import org.mstudio.modules.wms.goods_type.domain.GoodsType;
import org.mstudio.modules.wms.goods_type.repository.GoodsTypeRepository;
import org.mstudio.modules.wms.goods_type.service.GoodsTypeService;
import org.mstudio.modules.wms.goods_type.service.mapper.GoodsTypeMapper;
import org.mstudio.modules.wms.goods_type.service.object.GoodsTypeDTO;
import org.mstudio.modules.wms.goods_type.service.object.GoodsTypeVO;
import org.mstudio.utils.PageUtil;
import org.mstudio.utils.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.List;
import java.util.Optional;

/**
* @author Macrow
* @date 2019-02-22
*/

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class GoodsTypeServiceImpl implements GoodsTypeService {

    public static final String CACHE_NAME = "GoodsType";


    @Autowired
    GoodsTypeRepository goodsTypeRepository;

    @Autowired
    GoodsTypeMapper goodsTypeMapper;

    @Autowired
    GoodsService goodsService;

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    public Object queryAll(String nameOrShortName, Pageable pageable) {
        Page<GoodsType> page = goodsTypeRepository.findAll(new Spec(nameOrShortName), pageable);
        return PageUtil.toPage(page.map(goodsTypeMapper::toDto).map(goodsTypeDTO -> {
            goodsTypeDTO.setGoodsCount(goodsService.countByGoodsTypeId(Long.valueOf(goodsTypeDTO.getId())));
            return goodsTypeDTO;
        }));
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "'AllList'")
    public List<GoodsTypeVO> getAllList() {
        return goodsTypeMapper.toVOList(goodsTypeRepository.findAll());
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public GoodsTypeDTO findById(Long id) {
        Optional<GoodsType> goodsType = goodsTypeRepository.findById(id);
        ValidationUtil.isNull(goodsType, "GoodsType", "id", id);
        return goodsTypeMapper.toDto(goodsType.get());
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public GoodsTypeDTO create(GoodsType resources) {
        return goodsTypeMapper.toDto(goodsTypeRepository.save(resources));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public GoodsTypeVO update(Long id, GoodsType resources) {
        Optional<GoodsType> optionalGoodsType = goodsTypeRepository.findById(id);
        ValidationUtil.isNull(optionalGoodsType, "GoodsType", "id", id);
        resources.setId(id);
        return goodsTypeMapper.toVO(goodsTypeRepository.save(resources));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void delete(Long id) {
        goodsTypeRepository.deleteById(id);
    }

    class Spec implements Specification<GoodsType> {

        private String nameOrShortName;

        Spec(String nameOrShortName) {
            this.nameOrShortName = nameOrShortName;
        }

        @Override
        public Predicate toPredicate(Root<GoodsType> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
            if(ObjectUtils.isEmpty(nameOrShortName)) {
                return null;
            }
            Predicate p1 = criteriaBuilder.like(root.get("name").as(String.class), "%" + nameOrShortName + "%");
            Predicate p2 = criteriaBuilder.like(root.get("shortNameEn").as(String.class), "%" + nameOrShortName + "%");
            Predicate p3 = criteriaBuilder.or(p1, p2);
            Predicate p4 = criteriaBuilder.and(p3);
            return criteriaQuery.where(p4).getRestriction();
        }
    }

}