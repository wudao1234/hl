package org.mstudio.modules.wms.receive_goods.repository;

import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoodsPiece;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 * 拣配 计件 系数
 * @author lfj
 * @date 2020-12-01
 */

public interface ReceiveGoodsPieceRepository extends JpaRepository<ReceiveGoodsPiece, Long>, JpaSpecificationExecutor<ReceiveGoodsPiece> {

}