package org.mstudio.modules.wms.pick_match.service.impl;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.system.repository.UserRepository;
import org.mstudio.modules.wms.address.domain.Address;
import org.mstudio.modules.wms.address.repository.AddressRepository;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrderItem;
import org.mstudio.modules.wms.pick_match.domain.PickMatch;
import org.mstudio.modules.wms.pick_match.domain.PickMatchCoefficient;
import org.mstudio.modules.wms.pick_match.domain.PickMatchType;
import org.mstudio.modules.wms.pick_match.repository.PickMatchCoefficientRepository;
import org.mstudio.modules.wms.pick_match.repository.PickMatchRepository;
import org.mstudio.modules.wms.pick_match.service.PickMatchService;
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

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.*;

import static org.mstudio.utils.SecurityContextHolder.getUserDetails;

/**
 * @author lfj
 */

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class PickMatchServiceImpl implements PickMatchService {

    private static final String CACHE_NAME = "PickMatch";

    @Autowired
    private PickMatchCoefficientRepository pickMatchCoefficientRepository;

    @Autowired
    private PickMatchRepository pickMatchRepository;

    @Autowired
    private AddressRepository addressRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserRepository userRepo;

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Map queryAll(Pageable pageable) {
        Specification<PickMatchCoefficient> spec = (Specification<PickMatchCoefficient>) (root, criteriaQuery, criteriaBuilder) -> null;
        // 默认按照创建的时间顺序排列
        Sort sort = pageable.getSort().and(new Sort(Sort.Direction.DESC, "id"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        Page<PickMatchCoefficient> page = pickMatchCoefficientRepository.findAll(spec, newPageable);
        return PageUtil.toPage(page);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public PickMatchCoefficient update(Long id, PickMatchCoefficient resource) {
        Optional<PickMatchCoefficient> optional = pickMatchCoefficientRepository.findById(id);
        if (!optional.isPresent()) {
            throw new BadRequestException("指定的ID有误");
        }
        PickMatchCoefficient coefficient = optional.get();
        if (!coefficient.getId().equals(resource.getId())) {
            throw new BadRequestException("指定的ID有误");
        }

        return pickMatchCoefficientRepository.save(resource);
    }

    @Override
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public PickMatchCoefficient findById(Long id) {
        Optional<PickMatchCoefficient> optionalAddress = pickMatchCoefficientRepository.findById(id);
        if (!optionalAddress.isPresent()) {
            throw new BadRequestException(" 地址不存在 ID=" + id);
        }
        return optionalAddress.get();
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public void create(CustomerOrder order, PickMatchType type) {
        JwtUser user = (JwtUser) getUserDetails();
        // 获取门店信息
        Address address = addressRepository.findOneByClientStore(order.getClientStore());
        if (null == address || null == address.getCoefficient()) {
            throw new BadRequestException("订单门店信息错误");
        }
        User u = userRepository.findById(user.getId()).get();
        // 获取系数信息
        PickMatchCoefficient c = pickMatchCoefficientRepository.findAll().get(0);

        PickMatch pickMatch = new PickMatch();
        if (null != order.getPickMatch()) {
            PickMatch pm = order.getPickMatch().stream().filter(item -> item.getType().equals(type))
                    .findFirst()
                    .orElse(null);
            if (null != pm) {
                pickMatch.setId(pm.getId());
            }
        }
        pickMatch.setPiece(c.getPiece());
        pickMatch.setMoney(c.getMoney());
        pickMatch.setPickMatch(c.getPickMatch());
        pickMatch.setReview(c.getReview());
        pickMatch.setCustomerOrder(order);
        pickMatch.setType(type);
        u.setId(user.getId());

        pickMatch.setUser(u);
        Long quantityInitial = order.getCustomerOrderItems().stream().mapToLong(CustomerOrderItem::getQuantityInitial).sum();

        Float diffCoe = type.equals(PickMatchType.PICK_MATCH) ? pickMatch.getPickMatch() : pickMatch.getReview();
        Float score = ((quantityInitial * pickMatch.getPiece()) +
                (order.getTotalPrice().floatValue() * pickMatch.getMoney())
        ) * u.getCoefficient() * diffCoe * address.getCoefficient();

        pickMatch.setScore(score);
        pickMatchRepository.save(pickMatch);
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
            for (PickMatch pm : user.getPickMatchs()) {
                if (null != pm.getType()) {
                    if (PickMatchType.PICK_MATCH.equals(pm.getType())) {
                        pickMatchScore += pm.getScore();
                    } else {
                        reviewScore += pm.getScore();
                    }
                }
            }
            m.put("pickMatchScore", pickMatchScore);
            m.put("reviewScore", reviewScore);
            return m;
        }));
    }
}