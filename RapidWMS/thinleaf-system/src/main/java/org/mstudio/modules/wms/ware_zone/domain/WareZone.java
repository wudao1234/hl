package org.mstudio.modules.wms.ware_zone.domain;

import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.ware_position.domain.WarePosition;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.List;

/**
* @author Macrow
* @date 2019-02-22
*/

@Data
@Entity
@Table(name = "wms_ware_zone")
public class WareZone extends BaseEntity {

    @NotBlank(message = "仓库区域名称必须填入")
    private String name;

    private String description;

    private Integer sortOrder;

    @OneToMany(mappedBy = "wareZone", fetch = FetchType.LAZY)
    @Fetch(FetchMode.SUBSELECT)
    private List<WarePosition> warePositions;

}