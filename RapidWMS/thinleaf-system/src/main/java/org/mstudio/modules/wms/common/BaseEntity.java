package org.mstudio.modules.wms.common;

import lombok.Data;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * @author Macrow
 * @date 2019-03-15
 */

@Data
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public abstract class BaseEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SnowFlakeGenerator")
    @GenericGenerator(name = "SnowFlakeGenerator", strategy = "org.mstudio.modules.wms.common.SnowFlakeGenerator")
    private Long id;

    @CreatedDate
    @Column(nullable = false, updatable = false)
    private Timestamp createTime;

    @LastModifiedDate
    @Column(nullable = false)
    private Timestamp updateTime;

}
