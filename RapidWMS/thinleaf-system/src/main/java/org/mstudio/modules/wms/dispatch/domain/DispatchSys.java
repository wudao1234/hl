package org.mstudio.modules.wms.dispatch.domain;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseEntity;

import javax.persistence.Entity;
import javax.persistence.Table;

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

}