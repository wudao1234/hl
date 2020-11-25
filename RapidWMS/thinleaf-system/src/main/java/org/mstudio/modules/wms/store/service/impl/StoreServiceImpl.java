package org.mstudio.modules.wms.store.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.store.domain.Store;
import org.mstudio.modules.wms.store.repository.StoreRepository;
import org.mstudio.modules.wms.store.service.StoreService;
import org.mstudio.modules.wms.store.service.mapper.StoreMapper;
import org.mstudio.modules.wms.store.service.object.StoreDTO;
import org.mstudio.modules.wms.store.service.object.StoreExcelObj;
import org.mstudio.modules.wms.store.service.object.StoreVO;
import org.mstudio.utils.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * @author Macrow
 * @date 2019-09-28
 */

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class StoreServiceImpl implements StoreService {

    private static final String CACHE_NAME = "Store";

    @Value("${excel.export-max-count}")
    private Integer maxCount;

    @Autowired
    private StoreRepository storeRepository;

    @Autowired
    private StoreMapper storeMapper;

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Map queryAll(Boolean exportExcel, String search, Pageable pageable) {
        Specification<Store> spec = new Specification<Store>() {
            @Override
            public Predicate toPredicate(Root<Store> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();

                if (search != null) {
                    predicates.add(criteriaBuilder.or(
                            criteriaBuilder.like(root.get("name").as(String.class), "%" + search + "%")
                    ));
                }

                if (predicates.size() != 0) {
                    Predicate[] p = new Predicate[predicates.size()];
                    return criteriaBuilder.and(predicates.toArray(p));
                } else {
                    return null;
                }
            }
        };

        // 默认按照创建的时间顺序排列
        Sort sort = pageable.getSort().and(new Sort(Sort.Direction.DESC, "id"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        if (exportExcel) {
            newPageable = PageRequest.of(0, maxCount, sort);
        }
        Page<Store> page = storeRepository.findAll(spec, newPageable);
        return PageUtil.toPage(page.map(storeMapper::toVO));
    }

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public byte[] exportExcelData(List<StoreVO> stores) {
        List<StoreExcelObj> rows = CollUtil.newArrayList();
        for (int i = 0; i < stores.size(); i++) {
            StoreExcelObj excelObj = new StoreExcelObj();
            excelObj.setIndex(Long.valueOf(i + 1));
            excelObj.setName(stores.get(i).getName());
            rows.add(excelObj);
        }

        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
        ExcelWriter writer = ExcelUtil.getBigWriter();
        writer.addHeaderAlias("index", "#");
        writer.addHeaderAlias("name", "地址");
        writer.write(rows, true);
        writer.flush(outByteStream);
        writer.close();
        return outByteStream.toByteArray();
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public StoreVO create(Store resource) {
        Optional<Store> optionalStore = storeRepository.findByName(resource.getName());
        if (optionalStore.isPresent()) {
            throw new BadRequestException(resource.getName() + " 已经存在");
        }
        return storeMapper.toVO(storeRepository.save(resource));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public StoreVO update(Long id, Store resource) {
        Optional<Store> optionalStore = storeRepository.findById(id);
        if (!optionalStore.isPresent()) {
            throw new BadRequestException("指定的ID有误");
        }
        Store store = optionalStore.get();
        if (!store.getId().equals(resource.getId())) {
            throw new BadRequestException("指定的ID有误");
        }
        Optional<Store> optionalStore2 = storeRepository.findByName(resource.getName());
        if (optionalStore2.isPresent() && !optionalStore2.get().getId().equals(resource.getId())) {
            throw new BadRequestException(resource.getName() + " 已经存在");
        }

        return storeMapper.toVO(storeRepository.save(resource));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void delete(Long id) {
        Optional<Store> optionalStore = storeRepository.findById(id);
        if (!optionalStore.isPresent()) {
            throw new BadRequestException("门店不存在 ID=" + id);
        }
        Store store = optionalStore.get();
        storeRepository.delete(store);
    }

    @Override
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public StoreDTO findById(Long id) {
        Optional<Store> optionalStore = storeRepository.findById(id);
        if (!optionalStore.isPresent()) {
            throw new BadRequestException("门店不存在 ID=" + id);
        }
        return storeMapper.toDto(optionalStore.get());
    }

    @Override
    @Cacheable(value = CACHE_NAME)
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public List<StoreVO> getAllList() {
        return storeMapper.toVOList(storeRepository.findAll());
    }

}