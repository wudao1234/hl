package org.mstudio.modules.wms.Logistics.service.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import org.apache.commons.lang3.StringUtils;
import org.mstudio.modules.wms.Logistics.domain.LogisticsDetail;
import org.mstudio.modules.wms.Logistics.domain.LogisticsTemplate;
import org.mstudio.modules.wms.Logistics.repository.LogisticsDetailRepository;
import org.mstudio.modules.wms.Logistics.repository.LogisticsTemplateRepository;
import org.mstudio.modules.wms.Logistics.service.LogisticsDetailService;
import org.mstudio.modules.wms.Logistics.service.mapper.LogisticsDetailMapper;
import org.mstudio.modules.wms.address.repository.AddressRepository;
import org.mstudio.modules.wms.customer.repository.CustomerRepository;
import org.mstudio.utils.PageUtil;
import org.mstudio.utils.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
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

import javax.persistence.criteria.Predicate;
import java.util.*;

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

    @Autowired
    LogisticsTemplateRepository logisticsTemplateRepository;

    @Autowired
    CustomerRepository customerRepository;

    @Autowired
    AddressRepository addressRepository;

    @Override
//    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Object queryAll(String name, String startDate, String endDate, Pageable pageable) {
        Specification<LogisticsDetail> spec = (root, criteriaQuery, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();
            if (StringUtils.isNotEmpty(startDate) && StringUtils.isNotEmpty(endDate)) {
                Date start = DateUtil.parse(startDate);
                Date end = DateUtil.parse(endDate);
                Calendar c = Calendar.getInstance();
                c.setTime(end);
                c.add(Calendar.DAY_OF_MONTH, 1);
                end = c.getTime();
                predicates.add(criteriaBuilder.between(root.get("createTime").as(Date.class), start, end));
            }

            if (StringUtils.isNotEmpty(name)) {
                predicates.add(criteriaBuilder.like(root.get("name"), "%" + name + "%"));
            }
            if (predicates.size() != 0) {
                Predicate[] p = new Predicate[predicates.size()];
                return criteriaBuilder.and(predicates.toArray(p));
            } else {
                return null;
            }
        };
        // 默认按照创建的时间顺序、自定义编号排列
        Sort sort = pageable.getSort()
                .and(new Sort(Sort.Direction.DESC, "id"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);

        Page<LogisticsDetail> page = logisticsDetailRepository.findAll(spec, newPageable);
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
    public LogisticsDetail create(LogisticsDetail resources,Long logisticsTemplateId) {
        return logisticsDetailRepository.save(initLogisticsDetail(resources,logisticsTemplateId));
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public LogisticsDetail update(Long id, LogisticsDetail resources,Long logisticsTemplateId) {
        // todo 修改
        Optional<LogisticsDetail> optional = logisticsDetailRepository.findById(id);
        ValidationUtil.isNull(optional, "LogisticsDetail", "id", id);
        resources.setId(id);
        return logisticsDetailRepository.save(initLogisticsDetail(resources,logisticsTemplateId));
    }

    private LogisticsDetail initLogisticsDetail(LogisticsDetail resources,Long logisticsTemplateId) {
        LogisticsTemplate logisticsTemplate = logisticsTemplateRepository.getOne(logisticsTemplateId);
        resources.setName(logisticsTemplate.getName());
        resources.setFirst(logisticsTemplate.getFirst());
        resources.setRenew(logisticsTemplate.getRenew());
        resources.setFirstPrice(logisticsTemplate.getFirstPrice());
        resources.setRenewPrice(logisticsTemplate.getRenewPrice());
        resources.setRenewNum(
                ((ObjectUtil.isNotNull(resources.getPiece()) && resources.getPiece() > 0) ? resources.getPiece() : resources.getComputeWeight()) -
                        logisticsTemplate.getFirst());
        resources.setTotalPrice((int) (logisticsTemplate.getFirst() * logisticsTemplate.getFirstPrice() +
                resources.getRenewNum() / logisticsTemplate.getRenew() * logisticsTemplate.getRenewPrice()));
        return resources;
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void delete(Long id) {
        logisticsDetailRepository.deleteById(id);
    }

}