package org.mstudio.modules.wms.common;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author Macrow
 * @date 2019-03-15
 */

@Data
public abstract class BaseObject implements Serializable {

    private String id;

    private Date createTime;

    private Date updateTime;

}
