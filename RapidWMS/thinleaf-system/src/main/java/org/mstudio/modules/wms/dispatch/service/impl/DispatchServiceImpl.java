package org.mstudio.modules.wms.dispatch.service.impl;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.system.repository.UserRepository;
import org.mstudio.modules.wms.address.repository.AddressRepository;
import org.mstudio.modules.wms.customer_order.domain.OrderStatus;
import org.mstudio.modules.wms.dispatch.domain.DispatchCoefficient;
import org.mstudio.modules.wms.dispatch.domain.DispatchPiece;
import org.mstudio.modules.wms.dispatch.domain.DispatchStatusEnum;
import org.mstudio.modules.wms.dispatch.domain.DispatchSys;
import org.mstudio.modules.wms.dispatch.repository.DispatchCoefficientRepository;
import org.mstudio.modules.wms.dispatch.repository.DispatchPieceRepository;
import org.mstudio.modules.wms.dispatch.repository.DispatchSysRepository;
import org.mstudio.modules.wms.dispatch.service.DispatchService;
import org.mstudio.modules.wms.dispatch.service.object.StatisticsDTO;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.mstudio.modules.wms.pack.repository.PackRepository;
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
import java.util.concurrent.atomic.AtomicReference;

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

    @Autowired
    private DispatchSysRepository dispatchSysRepository;

    @Autowired
    private PackRepository packRepository;

    @Autowired
    private DispatchPieceRepository dispatchPieceRepository;

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
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
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Map querySysAll(Pageable pageable) {
        Specification<DispatchSys> spec = (Specification<DispatchSys>) (root, criteriaQuery, criteriaBuilder) -> null;
        // 默认按照创建的时间顺序排列
        Sort sort = pageable.getSort().and(new Sort(Sort.Direction.DESC, "id"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        Page<DispatchSys> page = dispatchSysRepository.findAll(spec, newPageable);
        return PageUtil.toPage(page);
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
    @Cacheable(value = CACHE_NAME, key = "#p1")
    public Map statistics(String startDate, String endDate, String search, Pageable pageable) {
        Specification<User> spec = (Specification<User>) (root, criteriaQuery, cb) -> {
            List<Predicate> list = new ArrayList<Predicate>();
//            if (!ObjectUtils.isEmpty(name)) {
//                list.add(cb.like(root.get("username").as(String.class), "%" + name + "%"));
//            }
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
            m.put("pickMatchScore", pickMatchScore);
            m.put("reviewScore", reviewScore);
            return m;
        }));
    }

    @Override
    public DispatchPiece save() {
        // 获取用户
        User user = userRepository.findByUsername(getUserDetails().getUsername());

        // 获取所有待派送打包
        Specification<Pack> spec = new Specification<Pack>() {
            @Override
            public Predicate toPredicate(Root<Pack> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();
                predicates.add(criteriaBuilder.equal(root.get("dispatchUser").get("username"), user.getUsername()));
                predicates.add(criteriaBuilder.equal(root.get("packStatus"), OrderStatus.SENDING));

                if (predicates.size() != 0) {
                    Predicate[] p = new Predicate[predicates.size()];
                    return criteriaBuilder.and(predicates.toArray(p));
                } else {
                    return null;
                }
            }
        };
        List<Pack> packs = packRepository.findAll(spec);

        // 获取基础系数
        DispatchCoefficient dispatchCoefficient = dispatchCoefficientRepository.findAll().get(0);

        // 获取待完成配送计件信息
        Specification<DispatchPiece> dispatchPieceSpec = new Specification<DispatchPiece>() {
            @Override
            public Predicate toPredicate(Root<DispatchPiece> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();
                predicates.add(criteriaBuilder.equal(root.get("user").get("username"), getUserDetails().getUsername()));
                predicates.add(criteriaBuilder.equal(root.get("status"), DispatchStatusEnum.UN_FINISH));
                Predicate[] p = new Predicate[predicates.size()];
                return criteriaBuilder.and(predicates.toArray(p));
            }
        };
        DispatchPiece dispatchPiece = (DispatchPiece) dispatchPieceRepository.findOne(dispatchPieceSpec).get();
        dispatchPiece.setStorePrice(dispatchCoefficient.getStore());
        AtomicReference<Integer> storeNum = new AtomicReference<>(0);
        AtomicReference<Integer> dispatchSum = new AtomicReference<>(0);
        Map tmp = new HashMap();
        packs.forEach(item -> {
            dispatchSum.updateAndGet(v -> v + item.getPackages());
            if (!tmp.containsKey(item.getAddress().getId())) {
                storeNum.getAndSet(storeNum.get() + 1);
                tmp.put(item.getAddress().getId(), null);
            }
        });
        dispatchPiece.setStoreNum(storeNum.get());
        dispatchPiece.setDispatchPrice(dispatchCoefficient.getDispatch());
        dispatchPiece.setDispatchSum(dispatchSum.get());
        dispatchPiece.setMileagePrice(dispatchCoefficient.getMileage());
        dispatchPiece.setStatus(DispatchStatusEnum.UN_FINISH);
        dispatchPiece.setUser(user);
        dispatchPiece.setPacks(packs);
        return dispatchPieceRepository.save(dispatchPiece);
    }

    @Override
    public DispatchPiece finish(Float mileage, DispatchSys dispatchSys) {
        // 获取用户
        User user = userRepository.findByUsername(getUserDetails().getUsername());
        // 获取待完成配送计件信息
        Specification<DispatchPiece> dispatchPieceSpec = new Specification<DispatchPiece>() {
            @Override
            public Predicate toPredicate(Root<DispatchPiece> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();
                predicates.add(criteriaBuilder.equal(root.get("user").get("username"), getUserDetails().getUsername()));
                predicates.add(criteriaBuilder.equal(root.get("status"), DispatchStatusEnum.UN_FINISH));
                Predicate[] p = new Predicate[predicates.size()];
                return criteriaBuilder.and(predicates.toArray(p));
            }
        };
        DispatchPiece dispatchPiece = (DispatchPiece) dispatchPieceRepository.findOne(dispatchPieceSpec).get();
        dispatchPiece.setMileage(mileage);
        dispatchPiece.setScore(
                (dispatchPiece.getStoreNum() * dispatchPiece.getStorePrice() +
                        dispatchPiece.getDispatchSum() * dispatchPiece.getDispatchPrice() +
                        dispatchPiece.getMileage() * dispatchPiece.getMileagePrice()
                ) * user.getCoefficient() * dispatchSys.getValue()
        );
        dispatchPiece.setStatus(DispatchStatusEnum.FINISH);
        return dispatchPieceRepository.save(dispatchPiece);
    }

//    @Override
//    @Cacheable(value = CACHE_NAME, key = "#p3")
//    public Map statistics(StatisticsDTO search, Pageable pageable) {
//        Specification<DispatchPiece> spec = (Specification<DispatchPiece>) (root, criteriaQuery, cb) -> {
//            List<Predicate> list = new ArrayList<Predicate>();
////            if (!ObjectUtils.isEmpty(name)) {
////                list.add(cb.like(root.get("username").as(String.class), "%" + name + "%"));
////            }
//            Predicate[] p = new Predicate[list.size()];
//            return cb.and(list.toArray(p));
//        };
//        Page<User> page = userRepo.findAll(spec, pageable);
//        return PageUtil.toPage(page.map(user -> {
//            Map m = new HashMap();
//            m.put("id", user.getId());
//            m.put("username", user.getUsername());
//            Float pickMatchScore = 0f;
//            Float reviewScore = 0f;
//            m.put("pickMatchScore", pickMatchScore);
//            m.put("reviewScore", reviewScore);
//            return m;
//        }));
//    }
}