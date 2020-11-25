package org.mstudio.service;

import org.mstudio.domain.VerificationCode;
import org.mstudio.domain.vo.EmailVo;

/**
 *
 * @date 2018-12-26
 */
public interface VerificationCodeService {

    /**
     * 发送邮件验证码
     * @param code
     */
    EmailVo sendEmail(VerificationCode code);

    /**
     * 验证
     * @param code
     */
    void validated(VerificationCode code);
}
