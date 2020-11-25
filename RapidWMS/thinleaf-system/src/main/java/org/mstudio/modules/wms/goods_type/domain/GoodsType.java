package org.mstudio.modules.wms.goods_type.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.goods.domain.Goods;

import javax.persistence.*;
import java.util.List;

@Data
@Entity
@Table(name = "wms_goods_type")
public class GoodsType extends BaseEntity {

    private String name;

    private Integer sortOrder;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "goodsType", fetch = FetchType.LAZY)
    private List<Goods> goods;

}
