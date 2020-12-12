package org.mstudio.modules.wms.dispatch.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.pack.domain.Pack;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.List;

/**
 * 配送 计件 系统系数
* @author lfj
* @date 2020-12-01
*/

@Data
@Entity
@Table(name = "wms_dispatch_sys_coefficient")
@org.hibernate.annotations.Table(appliesTo = "wms_dispatch_sys_coefficient",comment = "配送计件系统系数")
public class DispatchSys extends BaseEntity {

    /**
     * 系数名称
     */
    private String name;

    /**
     *系数值
     */
    private Float value;

    /**
     * 配送计件信息
     */
    @JSONField(serialize = false)
    @OneToMany(mappedBy = "dispatchSys", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<DispatchPiece> dispatchPieces;

}