package org.mstudio.modules.wms.address.domain;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;
import org.mstudio.modules.wms.address_type.domain.AddressType;
import org.mstudio.modules.wms.common.BaseEntity;
import org.mstudio.modules.wms.pack.domain.Pack;

import javax.persistence.*;
import java.util.List;

/**
* @author Macrow
* @date 2019-04-24
*/

@Data
@Entity
@Table(name = "wms_address")
@NamedEntityGraph(name = "address.all", attributeNodes = { @NamedAttributeNode("addressType") })
public class Address extends BaseEntity {

    @JSONField(serialize = false)
    @OneToMany(mappedBy = "address", fetch = FetchType.LAZY)
    private List<Pack> packs;

    @JSONField(serialize = false)
    @ManyToOne
    private AddressType addressType;

    private String name;

    private String contact;

    private String phone;

    private String description;

    private Float coefficient;

    private String clientStore;

}