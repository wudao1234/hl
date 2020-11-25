package org.mstudio.modules.system.service.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @author Macrow
 * @date 2019-03-22
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserVO {

    private Long id;

    private String username;

    private String avatar;

    private String email;

    private Boolean enabled;

    private Date createTime;

}
