package org.mstudio.modules.system.domain.vo;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

/**
 * @author Macrow
 * @date 2019-04-02
 */

@Data
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class ResetPasswordVO {

    private String oldPassword;

    private String newPassword;

}
