package org.mstudio.modules.system.rest;

import org.mstudio.aop.log.Log;
import org.mstudio.domain.VerificationCode;
import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.security.utils.JwtTokenUtil;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.system.domain.vo.ResetPasswordVO;
import org.mstudio.modules.system.service.UserService;
import org.mstudio.modules.system.service.dto.UserDTO;
import org.mstudio.modules.system.service.query.UserQueryService;
import org.mstudio.service.VerificationCodeService;
import org.mstudio.utils.EncryptUtils;
import org.mstudio.utils.SecurityContextHolder;
import org.mstudio.utils.ThinLeafConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

/**
 * @date 2018-11-23
 */
@RestController
@RequestMapping("api")
public class UserController {

    @Value("${upload.avatar}")
    private String avatarPath;

    @Autowired
    private UserService userService;

    @Autowired
    private UserQueryService userQueryService;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    @Qualifier("jwtUserDetailsService")
    private UserDetailsService userDetailsService;

    @Autowired
    private VerificationCodeService verificationCodeService;

    private static final String ENTITY_NAME = "user";

    @Log("查询用户")
    @GetMapping(value = "/users")
    @PreAuthorize("hasAnyRole('ADMIN', 'S_CUSTOMER_LIST')")
    public ResponseEntity getUsers(UserDTO userDTO, Pageable pageable) {
        return new ResponseEntity(userQueryService.queryAll(userDTO, pageable), HttpStatus.OK);
    }

    @Log("新增用户")
    @PostMapping(value = "/users")
    @PreAuthorize("hasAnyRole('ADMIN')")
    public ResponseEntity create(@Validated @RequestBody User resources) {
        if (resources.getId() != null) {
            throw new BadRequestException("A new " + ENTITY_NAME + " cannot already have an ID");
        }
        return new ResponseEntity(userService.create(resources), HttpStatus.CREATED);
    }

    @Log("修改用户")
    @PutMapping(value = "/users")
    @PreAuthorize("hasAnyRole('ADMIN')")
    public ResponseEntity update(@Validated(User.Update.class) @RequestBody User resources) {
        userService.update(resources);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @Log("删除用户")
    @DeleteMapping(value = "/users/{id}")
    @PreAuthorize("hasAnyRole('ADMIN')")
    public ResponseEntity delete(@PathVariable Long id) {
        userService.delete(id);
        return new ResponseEntity(HttpStatus.OK);
    }

    /**
     * 修改密码
     *
     * @param resetPassword
     * @return
     */
    @Log("登录用户修改密码")
    @PutMapping(value = "/users/updatePassword")
    public ResponseEntity updatePassword(@RequestBody ResetPasswordVO resetPassword) {
        UserDetails userDetails = SecurityContextHolder.getUserDetails();
        JwtUser jwtUser = (JwtUser) userDetailsService.loadUserByUsername(userDetails.getUsername());
        if (!jwtUser.getPassword().equals(EncryptUtils.encryptPassword(resetPassword.getOldPassword()))) {
            throw new BadRequestException("当前用户密码输入不正确");
        }
        if (jwtUser.getPassword().equals(EncryptUtils.encryptPassword(resetPassword.getNewPassword()))) {
            throw new BadRequestException("新密码不能与旧密码相同");
        }
        userService.updatePassword(jwtUser, EncryptUtils.encryptPassword(resetPassword.getNewPassword()));
        return new ResponseEntity(HttpStatus.OK);
    }

    /**
     * 修改头像
     *
     * @param avatar
     * @return
     */
    @Log("登录用户修改头像")
    @PostMapping(value = "/users/updateAvatar")
    public ResponseEntity updateAvatar(@RequestParam MultipartFile avatar) throws Exception {
        UserDetails userDetails = SecurityContextHolder.getUserDetails();
        JwtUser jwtUser = (JwtUser) userDetailsService.loadUserByUsername(userDetails.getUsername());
        userService.updateAvatar(jwtUser, avatarPath, avatar);
        return new ResponseEntity(HttpStatus.OK);
    }

    /**
     * 修改邮箱
     *
     * @param user
     * @return
     */
    @Log("修改邮箱")
    @PostMapping(value = "/users/updateEmail/{code}")
    public ResponseEntity updateEmail(@PathVariable String code, @RequestBody User user) {
        UserDetails userDetails = SecurityContextHolder.getUserDetails();
        JwtUser jwtUser = (JwtUser) userDetailsService.loadUserByUsername(userDetails.getUsername());
        if (!jwtUser.getPassword().equals(EncryptUtils.encryptPassword(user.getPassword()))) {
            throw new BadRequestException("密码错误");
        }
        VerificationCode verificationCode = new VerificationCode(code, ThinLeafConstant.RESET_MAIL, "email", user.getEmail());
        verificationCodeService.validated(verificationCode);
        userService.updateEmail(jwtUser, user.getEmail());
        return new ResponseEntity(HttpStatus.OK);
    }

    @Log("重置用户密码")
    @PutMapping(value = "/users/{id}/resetPassword")
    @PreAuthorize("hasAnyRole('ADMIN','USER_ALL','USER_EDIT')")
    public ResponseEntity resetPassword(@PathVariable Long id) {
        userService.resetPassword(id);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @Log("登录用户更新信息")
    @PutMapping(value = "/users/current/update")
    @PreAuthorize("hasAnyRole('ADMIN','USER_ALL','USER_EDIT')")
    public ResponseEntity updateCurrent(@RequestBody User resources) {
        userService.updateCurrent(resources);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @GetMapping(value = "/users/list_by_role_names")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_LIST')")
    public ResponseEntity listByRoleName(@RequestParam String names) {
        return new ResponseEntity(userService.listByRoleNames(names), HttpStatus.OK);
    }
}
