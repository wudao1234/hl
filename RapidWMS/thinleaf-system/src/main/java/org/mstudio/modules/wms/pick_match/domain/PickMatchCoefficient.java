package org.mstudio.modules.wms.pick_match.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.mstudio.modules.wms.address_type.domain.AddressType;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.pack.domain.Pack;

import javax.persistence.*;
import java.util.List;

/**
 * 拣配 计件 系数
* @author lfj
* @date 2020-12-01
*/

@Data
@Entity
@Table(name = "wms_pick_match_coefficient")
@org.hibernate.annotations.Table(appliesTo = "wms_pick_match_coefficient",comment = "拣配/复核计件系数")
public class PickMatchCoefficient extends BaseEntity {

    /**
     * 计件系数
     */
    private Float piece;

    /**
     *金额系数
     */
    private Float money;

    /**
     * 拣配系数
     */
    private Float pickMatch;

    /**
     * 复核系数
     */
    private Float review;

}