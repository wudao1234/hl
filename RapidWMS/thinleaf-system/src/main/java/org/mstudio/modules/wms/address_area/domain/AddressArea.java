package org.mstudio.modules.wms.address_area.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.mstudio.modules.wms.Logistics.domain.LogisticsTemplate;
import org.mstudio.modules.wms.address.domain.Address;
import org.mstudio.modules.wms.common.BaseEntity;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import java.util.List;

/**
 * @author Macrow
 * @date 2019-07-09
 */

@Data
@Entity
@Table(name = "wms_address_area")
public class AddressArea extends BaseEntity {

    private String name;

    private Integer sortOrder;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "addressArea", fetch = FetchType.LAZY)
    private List<Address> addresses;

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "addressArea", fetch = FetchType.LAZY)
    private List<LogisticsTemplate> logisticsTemplate;

}
