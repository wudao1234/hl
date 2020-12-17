package org.mstudio.modules.wms.fixed_estate.domain;

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
@Table(name = "wms_fixed_estate")
@org.hibernate.annotations.Table(appliesTo = "wms_fixed_estate",comment = "固定资产")
public class FixedEstate extends BaseEntity {

    /**
     * 固定资产名称
     */
    private String assetsName;

    /**
     * 录入人姓名
     */
    private String assetsInputOperator;

    /**
     * 固定资产类别
     */
    private String assetsType;

    /**
     * 备注
     */
    private String assetsDescription;



}