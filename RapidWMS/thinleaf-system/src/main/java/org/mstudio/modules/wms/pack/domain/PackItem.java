package org.mstudio.modules.wms.pack.domain;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.mstudio.modules.wms.common.BaseEntity;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * @author Macrow
 * @date 2019-07-06
 */

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "wms_pack_item")
public class PackItem extends BaseEntity {

    @JSONField(serialize = false)
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    private Pack pack;

    @NotNull
    private Integer number;

    @NotNull
    private Long quantity;

    @NotBlank(message = "商品名称必须录入")
    private String name;

    @NotBlank(message = "商品条码必须录入")
    private String sn;

    @NotNull
    @Temporal(TemporalType.DATE)
    private Date expireDate;

}
