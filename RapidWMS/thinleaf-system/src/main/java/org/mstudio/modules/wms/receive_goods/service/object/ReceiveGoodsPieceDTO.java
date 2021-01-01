package org.mstudio.modules.wms.receive_goods.service.object;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseObject;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoodsPieceTypeEnum;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
public class ReceiveGoodsPieceDTO extends BaseObject {

    /**
     * 计件单价
     */
    private Float price;

    /**
     * 件数
     */
    private Long packages;

    /**
     * 员工系数
     */
    private Float staffPrice;

    /**
     * 总分数
     */
    private Float score;

    /**
     * 类型
     */
    private ReceiveGoodsPieceTypeEnum type;

}