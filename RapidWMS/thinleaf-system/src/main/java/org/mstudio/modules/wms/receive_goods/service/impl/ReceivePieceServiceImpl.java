package org.mstudio.modules.wms.receive_goods.service.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.system.repository.UserRepository;
import org.mstudio.modules.wms.address.repository.AddressRepository;
import org.mstudio.modules.wms.customer_order.domain.OrderStatus;
import org.mstudio.modules.wms.dispatch.domain.DispatchPiece;
import org.mstudio.modules.wms.dispatch.domain.DispatchStatusEnum;
import org.mstudio.modules.wms.dispatch.domain.DispatchSys;
import org.mstudio.modules.wms.dispatch.repository.DispatchCoefficientRepository;
import org.mstudio.modules.wms.dispatch.repository.DispatchPieceRepository;
import org.mstudio.modules.wms.dispatch.repository.DispatchSysRepository;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.mstudio.modules.wms.pack.repository.PackRepository;
import org.mstudio.modules.wms.receive_goods.domain.RcceiveCoefficient;
import org.mstudio.modules.wms.receive_goods.repository.RcceiveCoefficientRepository;
import org.mstudio.modules.wms.receive_goods.service.ReceivePieceService;
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
public class ReceivePieceServiceImpl implements ReceivePieceService {

    private static final String CACHE_NAME = "ReceivePiece";

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
    
    @Autowired
    private RcceiveCoefficientRepository rcceiveCoefficientRepository;

    @Override
    //@Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public Map queryAll(Pageable pageable) {
        Specification<RcceiveCoefficient> spec = (Specification<RcceiveCoefficient>) (root, criteriaQuery, criteriaBuilder) -> null;
        // 默认按照创建的时间顺序排列
        Sort sort = pageable.getSort().and(new Sort(Sort.Direction.DESC, "id"));
        Pageable newPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        Page<RcceiveCoefficient> page = rcceiveCoefficientRepository.findAll(spec, newPageable);
        return PageUtil.toPage(page);
    }

    @Override
    @CacheEvict(value = CACHE_NAME, allEntries = true)
    public RcceiveCoefficient update(Long id, RcceiveCoefficient resource) {
        Optional<RcceiveCoefficient> optional = rcceiveCoefficientRepository.findById(id);
        if (!optional.isPresent()) {
            throw new BadRequestException("指定的ID有误");
        }
        RcceiveCoefficient coefficient = optional.get();
        if (!coefficient.getId().equals(resource.getId())) {
            throw new BadRequestException("指定的ID有误");
        }

        return rcceiveCoefficientRepository.save(resource);
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
    public RcceiveCoefficient findById(Long id) {
        Optional<RcceiveCoefficient> optionalAddress = rcceiveCoefficientRepository.findById(id);
        if (!optionalAddress.isPresent()) {
            throw new BadRequestException(" 地址不存在 ID=" + id);
        }
        return optionalAddress.get();
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
            Float unFinishScore = 0f;
            Float finishScore = 0f;
            for (DispatchPiece dispatchPiece : user.getDispatchPieces()) {
                if (startDate != null && endDate != null) {
                    if (dispatchPiece.getCreateTime().before(finalStart) || dispatchPiece.getCreateTime().after(finalEnd)) {
                        continue;
                    }
                }
                if (DispatchStatusEnum.FINISH.equals(dispatchPiece.getStatus())) {
                    finishScore += dispatchPiece.getScore();
                } else {
                    unFinishScore += dispatchPiece.getScore();
                }
            }
            m.put("unFinishScore", unFinishScore);
            m.put("finishScore", finishScore);
            return m;
        }));
    }

    @Override
    public Long save() {
        // 获取用户
        User user = userRepository.findByUsername(getUserDetails().getUsername());

        // 获取所有待派送打包
        Specification<Pack> spec = new Specification<Pack>() {
            @Override
            public Predicate toPredicate(Root<Pack> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();
                predicates.add(criteriaBuilder.equal(root.get("user").get("username"), user.getUsername()));
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
        RcceiveCoefficient dispatchCoefficient = rcceiveCoefficientRepository.findAll().get(0);

        // 获取待完成配送计件信息
        Specification<DispatchPiece> dispatchPieceSpec = new Specification<DispatchPiece>() {
            @Override
            public Predicate toPredicate(Root<DispatchPiece> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<>();
                predicates.add(criteriaBuilder.equal(root.get("user").get("username"), user.getUsername()));
                predicates.add(criteriaBuilder.equal(root.get("status"), DispatchStatusEnum.UN_FINISH));
                Predicate[] p = new Predicate[predicates.size()];
                return criteriaBuilder.and(predicates.toArray(p));
            }
        };
        Optional<DispatchPiece> optionalDispatchPiece = dispatchPieceRepository.findOne(dispatchPieceSpec);
        DispatchPiece dispatchPiece = optionalDispatchPiece.isPresent() ? optionalDispatchPiece.get() : new DispatchPiece();
        //dispatchPiece.setStorePrice(dispatchCoefficient.getStore());
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
        //dispatchPiece.setDispatchPrice(dispatchCoefficient.getDispatch());
        dispatchPiece.setDispatchSum(dispatchSum.get());
        //dispatchPiece.setMileagePrice(dispatchCoefficient.getMileage());
        dispatchPiece.setStatus(DispatchStatusEnum.UN_FINISH);
        dispatchPiece.setUser(user);
        dispatchPiece.setPacks(packs);
        return dispatchPieceRepository.save(dispatchPiece).getId();
    }

    @Override
    public DispatchPiece finish(Float mileage, Long dispatchSysId) {
        if (ObjectUtil.isNull(mileage) || mileage.compareTo(0f) <= 0) {
            throw new BadRequestException("里数错误");
        }
        if (ObjectUtil.isNull(dispatchSysId)) {
            throw new BadRequestException("系统系数错误");
        }
        DispatchSys dispatchSys = dispatchSysRepository.getOne(dispatchSysId);
        if (ObjectUtil.isNull(dispatchSys)) {
            throw new BadRequestException("系统系数错误");
        }
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
        dispatchPiece.setDispatchSys(dispatchSys);
        dispatchPiece.setScore(
                (dispatchPiece.getStoreNum() * dispatchPiece.getStorePrice() +
                        dispatchPiece.getDispatchSum() * dispatchPiece.getDispatchPrice() +
                        dispatchPiece.getMileage() * dispatchPiece.getMileagePrice()
                ) * user.getCoefficient() * dispatchSys.getValue()
        );
        dispatchPiece.setStatus(DispatchStatusEnum.FINISH);
        return dispatchPieceRepository.save(dispatchPiece);
    }

}