package org.mstudio.modules.wms.stock.domain;

import lombok.Data;
import org.hibernate.validator.constraints.Length;
import org.mstudio.modules.wms.common.BaseEntity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
@Entity
@Table(name = "wms_count_stock")
public class CountStock extends BaseEntity {

    @NotBlank(message = "客户名称必须填写")
    @Length(min = 2, max = 255)
    private String customerName;

    @NotBlank(message = "商品识别码必须录入")
    private String sn;

    @NotBlank(message = "商品名称必须填写")
    @Length(min = 2, max = 255)
    private String name;

    @NotNull(message = "商品规格必须录入")
    private Integer packCount;

    /**
     * 到期
     */
    @Temporal(TemporalType.DATE)
    private Date expireDate;
    /**
     * 账面数量(数据库)
     */
    private Long quantity;

    /**
     * 实盘数量（真实库存）
     */
    private Long currentQuantity;

    @NotNull(message = "质保时长必须录入")
    private Integer monthsOfWarranty;

    @NotBlank(message = "库位名称必须填入")
    private String warePositionName;
}