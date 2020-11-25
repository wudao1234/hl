package org.mstudio.modules.wms.customer.service.object;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.mstudio.modules.wms.common.BaseObject;

import java.util.Date;

/**
 * @author Macrow
 * @date 2019-02-22
 */

@Data
@NoArgsConstructor
public class CustomerVO extends BaseObject {

    private String name;

    private String shortNameEn;

    private String shortNameCn;

    public CustomerVO(Long id, Date createTime, Date updateTime, String name, String shortNameEn, String shortNameCn) {
        setId(String.valueOf(id));
        setCreateTime(createTime);
        setUpdateTime(updateTime);
        setName(name);
        setShortNameEn(shortNameEn);
        setShortNameCn(shortNameCn);
    }

}