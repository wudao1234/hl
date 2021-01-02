package org.mstudio.modules.wms.pick_match.service.impl;

import cn.hutool.core.date.DateUtil;
import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.system.repository.UserRepository;
import org.mstudio.modules.wms.address.domain.Address;
import org.mstudio.modules.wms.address.repository.AddressRepository;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.mstudio.modules.wms.pack.repository.PackRepository;
import org.mstudio.modules.wms.pick_match.domain.PickMatch;
import org.mstudio.modules.wms.pick_match.domain.PickMatchCoefficient;
import org.mstudio.modules.wms.pick_match.domain.PickMatchTypeEnum;
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

import javax.persistence.criteria.Predicate;
import java.util.*;

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

    @Autowired
    private PackRepository packRepository;

    @Override
    //@Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
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
    public void create(Pack pack) {
         // todo 新增 拣配 复核信息
        // 获取门店信息
        Address address = addressRepository.getOne(pack.getAddress().getId());
        if (Objects.isNull(address.getCoefficient())) {
            throw new BadRequestException("门店系数错误");
        }
        // 获取系数信息
        PickMatchCoefficient c = pickMatchCoefficientRepository.findAll().get(0);

        // 获取 分拣 拣配人
        List<User> userGatherings = new ArrayList<>();
        List<User> userReviewers = new ArrayList<>();
        pack.getOrders().forEach(customerOrder -> {
            customerOrder.getUserGatherings().forEach(user -> {
                boolean noMatch = userGatherings.stream().noneMatch(u -> u.getId().equals(user.getId()));
                if (noMatch) {
                    userGatherings.add(user);
                }
            });
            customerOrder.getUserReviewers().forEach(user -> {
                boolean noMatch = userReviewers.stream().noneMatch(u -> u.getId().equals(user.getId()));
                if (noMatch) {
                    userReviewers.add(user);
                }
            });
        });

        PickMatchTypeEnum[] pickMatchTypeEnums = PickMatchTypeEnum.values();
        for (PickMatchTypeEnum pickMatchTypeEnum : pickMatchTypeEnums) {
            switch (pickMatchTypeEnum) {
                case PICK_MATCH:
                    savePickMatch(userGatherings, c, pack, address, PickMatchTypeEnum.PICK_MATCH);
                    break;
                case REVIEW:
                    savePickMatch(userReviewers, c, pack, address, PickMatchTypeEnum.REVIEW);
                    break;
                default:
                    throw new BadRequestException("未知拣配计件规则");
            }
        }
    }

    private void savePickMatch(List<User> users, PickMatchCoefficient c, Pack pack, Address address, PickMatchTypeEnum pickMatchTypeEnum) {
        users.forEach(user -> {
            // init PickMatch
            PickMatch pickMatch = new PickMatch();
            pickMatch.setPiece(c.getPiece());
            pickMatch.setMoney(c.getMoney());
            pickMatch.setPickMatch(c.getPickMatch());
            pickMatch.setReview(c.getReview());
            pickMatch.setPack(pack);
            pickMatch.setType(pickMatchTypeEnum);
            pickMatch.setUser(user);
            Float score = ((pack.getPackages() * pickMatch.getPiece()) + (pack.getTotalPrice().floatValue() * pickMatch.getMoney())) *
                    user.getCoefficient() * address.getCoefficient() *
                    (pickMatchTypeEnum == PickMatchTypeEnum.PICK_MATCH ? pickMatch.getPickMatch() : pickMatch.getReview());
            pickMatch.setScore(score / users.size());
            pickMatchRepository.save(pickMatch);
        });
    }

    @Override
//    @Cacheable(value = CACHE_NAME, key = "#p1")
    public Map statistics(String startDate, String endDate, String search, Pageable pageable) {
        Specification<User> spec = (Specification<User>) (root, criteriaQuery, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<Predicate>();
            if (!ObjectUtils.isEmpty(search)) {
                predicates.add(criteriaBuilder.like(root.get("username").as(String.class), "%" + search + "%"));
            }
            Predicate[] p = new Predicate[predicates.size()];
            return criteriaBuilder.and(predicates.toArray(p));
        };
        Sort sort = pageable.getSort().and(new Sort(Sort.Direction.DESC, "id"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        Page<User> page = userRepo.findAll(spec, newPageable);

        Date start = null;
        Date end = null;
        if (startDate != null && endDate != null) {
            start = DateUtil.parse(startDate);
            end = DateUtil.parse(endDate);
            // 必须在结束日期基础上加上一天，第二天凌晨0点作为结束时间点
            Calendar c = Calendar.getInstance();
            c.setTime(end);
            c.add(Calendar.DAY_OF_MONTH, 1);
            end = c.getTime();
        }
        Date finalStart = start;
        Date finalEnd = end;

        return PageUtil.toPage(page.map(user -> {
            Map m = new HashMap();
            m.put("id", user.getId());
            m.put("username", user.getUsername());
            Float pickMatchScore = 0f;
            Float reviewScore = 0f;
            for (PickMatch pm : user.getPickMatchs()) {
                if (startDate != null && endDate != null) {
                    if (pm.getCreateTime().before(finalStart) || pm.getCreateTime().after(finalEnd)) {
                        continue;
                    }
                }
                if (null != pm.getType()) {
                    if (PickMatchTypeEnum.PICK_MATCH.equals(pm.getType())) {
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