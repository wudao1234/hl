package org.mstudio.modules.wms.receive_goods.service.impl;

import cn.hutool.core.date.DateUtil;
import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.system.repository.UserRepository;
import org.mstudio.modules.wms.receive_goods.domain.*;
import org.mstudio.modules.wms.receive_goods.repository.RcceiveCoefficientRepository;
import org.mstudio.modules.wms.receive_goods.repository.ReceiveGoodsPieceRepository;
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

import javax.persistence.criteria.Predicate;
import java.util.*;

import static org.mstudio.utils.SecurityContextHolder.getUserDetails;

/**
 * @author lfj
 */

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class ReceivePieceServiceImpl implements ReceivePieceService {

    private static final String CACHE_NAME = "ReceivePiece";

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RcceiveCoefficientRepository rcceiveCoefficientRepository;

    @Autowired
    private ReceiveGoodsPieceRepository receiveGoodsPieceRepository;

    @Override
    @Cacheable(value = CACHE_NAME, keyGenerator = "keyGenerator")
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
    @Cacheable(value = CACHE_NAME, key = "#p0")
    public RcceiveCoefficient findById(Long id) {
        Optional<RcceiveCoefficient> optionalAddress = rcceiveCoefficientRepository.findById(id);
        if (!optionalAddress.isPresent()) {
            throw new BadRequestException(" 地址不存在 ID=" + id);
        }
        return optionalAddress.get();
    }


    @Override
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
        Page<User> page = userRepository.findAll(spec, newPageable);

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
            Float unloadScore = 0f;
            Float putInScore = 0f;
            for (ReceiveGoodsPiece receiveGoodsPiece : user.getReceiveGoodsPieces()) {
                if (startDate != null && endDate != null) {
                    if (receiveGoodsPiece.getCreateTime().before(finalStart) || receiveGoodsPiece.getCreateTime().after(finalEnd)) {
                        continue;
                    }
                }
                if (ReceiveGoodsPieceTypeEnum.UNLOAD == receiveGoodsPiece.getType()) {
                    unloadScore += receiveGoodsPiece.getScore();
                } else {
                    putInScore += receiveGoodsPiece.getScore();
                }
            }
            m.put("unloadScore", unloadScore);
            m.put("putInScore", putInScore);
            return m;
        }));
    }

    @Override
    public void save(ReceiveGoods params) {
        // 获取用户
        User user = userRepository.findByUsername(getUserDetails().getUsername());
        // 获取基础系数
        RcceiveCoefficient dispatchCoefficient = rcceiveCoefficientRepository.findAll().get(0);

        ReceiveGoodsPieceTypeEnum[] receiveGoodsPieceTypeEnums = ReceiveGoodsPieceTypeEnum.values();
        for (ReceiveGoodsPieceTypeEnum receiveGoodsPieceTypeEnum : receiveGoodsPieceTypeEnums) {
            // init receiveGoodsPiece
            ReceiveGoodsPiece receiveGoodsPiece = new ReceiveGoodsPiece();
            receiveGoodsPiece.setUser(user);
            receiveGoodsPiece.setReceiveGoodses(params);
            receiveGoodsPiece.setStaffPrice(user.getCoefficient());
            receiveGoodsPiece.setType(receiveGoodsPieceTypeEnum);
            receiveGoodsPiece.setPackages(params.getReceiveGoodsItems().stream().mapToLong(ReceiveGoodsItem::getPackages).sum());
            receiveGoodsPiece.setPrice(ReceiveGoodsPieceTypeEnum.UNLOAD == receiveGoodsPieceTypeEnum ? dispatchCoefficient.getUnloadPrice() : dispatchCoefficient.getPutInPrice());
            receiveGoodsPiece.setScore(receiveGoodsPiece.getPackages() * receiveGoodsPiece.getPrice() * receiveGoodsPiece.getStaffPrice());
            receiveGoodsPieceRepository.save(receiveGoodsPiece);
        }
    }

    @Override
    public void cancel(ReceiveGoods params) {
        List<ReceiveGoodsPiece> receiveGoodsPieceList = params.getReceiveGoodsPieces();
        receiveGoodsPieceList.forEach(item ->{
            receiveGoodsPieceRepository.delete(item);
        });
    }

}