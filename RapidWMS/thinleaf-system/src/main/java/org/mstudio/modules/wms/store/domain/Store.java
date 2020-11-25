package org.mstudio.modules.wms.store.domain;

import lombok.Data;
import org.mstudio.modules.wms.common.BaseEntity;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
* @author Macrow
* @date 2019-09-28
*/

@Data
@Entity
@Table(name = "wms_store")
public class Store extends BaseEntity {

    private String name;

}