package org.mstudio.modules.wms.dispatch.service.impl;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.system.repository.UserRepository;
import org.mstudio.modules.wms.address.domain.Address;
import org.mstudio.modules.wms.address.repository.AddressRepository;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrderItem;
import org.mstudio.modules.wms.dispatch.domain.DispatchCoefficient;
import org.mstudio.modules.wms.dispatch.repository.DispatchCoefficientRepository;
import org.mstudio.modules.wms.dispatch.service.DispatchService;
import org.mstudio.utils.PageUtil;
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
import org.springframework.util.ObjectUtils;

import javax.persistence.criteria.Predicate;
import java.util.*;

import static org.mstudio.utils.SecurityContextHolder.getUserDetails;

/**
 * @author lfj
 */

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class DispatchServiceImpl implements DispatchService {

    private static final String CACHE_NAME = "Dispatch";

    @Autowired
    private DispatchCoefficientRepository dispatchCoefficientRepository;

    @Autowired
    private AddressRepository addressRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserRepository userRepo;

    @Override
    //@Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Map queryAll(Pageable pageable) {
        Specification<DispatchCoefficient> spec = (Specification<DispatchCoefficient>) (root, criteriaQuery, criteriaBuilder) -> null;
        // 默认按照创建的时间顺序排列
        Sort sort = pageable.getSort().and(new Sort(Sort.Direction.DESC, "id"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        Page<DispatchCoefficient> page = dispatchCoefficientRepository.findAll(spec, newPageable);
        return PageUtil.toPage(page);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public DispatchCoefficient update(Long id, DispatchCoefficient resource) {
        Optional<DispatchCoefficient> optional = dispatchCoefficientRepository.findById(id);
        if (!optional.isPresent()) {
            throw new BadRequestException("指定的ID有误");
        }
        DispatchCoefficient coefficient = optional.get();
        if (!coefficient.getId().equals(resource.getId())) {
            throw new BadRequestException("指定的ID有误");
        }

        return dispatchCoefficientRepository.save(resource);
    }

    @Override
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public DispatchCoefficient findById(Long id) {
        Optional<DispatchCoefficient> optionalAddress = dispatchCoefficientRepository.findById(id);
        if (!optionalAddress.isPresent()) {
            throw new BadRequestException(" 地址不存在 ID=" + id);
        }
        return optionalAddress.get();
    }


    @Override
//    @Cacheable(value = CACHE_NAME, key = "#p1")
    public Map statistics(String name, Pageable pageable) {
        Specification<User> spec = (Specification<User>) (root, criteriaQuery, cb) -> {
            List<Predicate> list = new ArrayList<Predicate>();
            if (!ObjectUtils.isEmpty(name)) {
                list.add(cb.like(root.get("username").as(String.class), "%" + name + "%"));
            }
            Predicate[] p = new Predicate[list.size()];
            return cb.and(list.toArray(p));
        };
        Page<User> page = userRepo.findAll(spec, pageable);
        return PageUtil.toPage(page.map(user -> {
            Map m = new HashMap();
            m.put("id", user.getId());
            m.put("username", user.getUsername());
            Float pickMatchScore = 0f;
            Float reviewScore = 0f;
//            for (PickMatch pm : user.getPickMatchs()) {
//                if (null != pm.getType()) {
//                    if (PickMatchType.PICK_MATCH.equals(pm.getType())) {
//                        pickMatchScore += pm.getScore();
//                    } else {
//                        reviewScore += pm.getScore();
//                    }
//                }
//            }
            m.put("pickMatchScore", pickMatchScore);
            m.put("reviewScore", reviewScore);
            return m;
        }));
    }
}