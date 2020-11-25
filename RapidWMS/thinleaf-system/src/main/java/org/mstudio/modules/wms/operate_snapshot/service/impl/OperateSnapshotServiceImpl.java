package org.mstudio.modules.wms.operate_snapshot.service.impl;

import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.operate_snapshot.domain.OperateSnapshot;
import org.mstudio.modules.wms.operate_snapshot.repository.OperateSnapshotRepository;
import org.mstudio.modules.wms.operate_snapshot.service.OperateSnapshotService;
import org.mstudio.modules.wms.operate_snapshot.service.mapper.OperateSnapshotMapper;
import org.mstudio.modules.wms.operate_snapshot.service.object.OperateSnapshotDTO;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.mstudio.utils.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

import static org.mstudio.utils.SecurityContextHolder.getUserDetails;

/**
* @author Macrow
* @date 2019-02-22
*/

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class OperateSnapshotServiceImpl implements OperateSnapshotService {

    @Autowired
    private OperateSnapshotRepository operateSnapshotRepository;

    @Autowired
    private OperateSnapshotMapper operateSnapshotMapper;

    @Override
    @Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
    public OperateSnapshotDTO findById(Long id) {
        Optional<OperateSnapshot> operateSnapshot = operateSnapshotRepository.findById(id);
        ValidationUtil.isNull(operateSnapshot, "OperateSnapshot", "id", id);
        return operateSnapshotMapper.toDto(operateSnapshot.get());
    }

    @Override
    public OperateSnapshotDTO create(String operation, String operator, CustomerOrder order) {
        OperateSnapshot operateSnapshot = new OperateSnapshot();
        operateSnapshot.setOperator(operator);
        operateSnapshot.setOperation(operation);
        operateSnapshot.setCustomerOrder(order);
        return create(operateSnapshot);
    }

    @Override
    public OperateSnapshotDTO create(String operation, CustomerOrder order) {
        JwtUser user = (JwtUser)getUserDetails();
        return create(operation, user.getUsername(), order);
    }

    @Override
    public OperateSnapshotDTO create(String operation, String operator, Pack pack) {
        OperateSnapshot operateSnapshot = new OperateSnapshot();
        operateSnapshot.setOperator(operator);
        operateSnapshot.setOperation(operation);
        operateSnapshot.setPack(pack);
        return create(operateSnapshot);
    }

    @Override
    public OperateSnapshotDTO create(String operation, Pack pack) {
        JwtUser user = (JwtUser)getUserDetails();
        return create(operation, user.getUsername(), pack);
    }

    @Override
    public void delete(Long id) {
        operateSnapshotRepository.deleteById(id);
    }

    private OperateSnapshotDTO create(OperateSnapshot resources) {
        return operateSnapshotMapper.toDto(operateSnapshotRepository.save(resources));
    }

}