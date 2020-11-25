package org.mstudio.modules.system.service;

import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.system.service.dto.UserDTO;
import org.mstudio.modules.system.service.dto.UserVO;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.Caching;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 *
 * @date 2018-11-23
 */
@CacheConfig(cacheNames = "user")
public interface UserService {

    /**
     * get
     * @param id
     * @return
     */
    @Cacheable(key = "#p0")
    UserDTO findById(long id);

    /**
     * create
     * @param resources
     * @return
     */
    @Caching(evict = {
            @CacheEvict(allEntries = true),
            @CacheEvict(value = "JwtPermission", allEntries = true),
            @CacheEvict(value = "permission", allEntries = true)
    })
    UserDTO create(User resources);

    /**
     * update
     * @param resources
     */
    @Caching(evict = {
            @CacheEvict(allEntries = true),
            @CacheEvict(value = "JwtPermission", allEntries = true),
            @CacheEvict(value = "permission", allEntries = true)
    })
    void update(User resources);

    /**
     * delete
     * @param id
     */
    @Caching(evict = {
            @CacheEvict(allEntries = true),
            @CacheEvict(value = "JwtPermission", allEntries = true),
            @CacheEvict(value = "permission", allEntries = true)
    })
    void delete(Long id);

    /**
     * findByName
     * @param userName
     * @return
     */
    @Cacheable(keyGenerator = "keyGenerator")
    User findByName(String userName);

    /**
     * 修改密码
     * @param jwtUser
     * @param encryptPassword
     */
    @CacheEvict(allEntries = true)
    void updatePassword(JwtUser jwtUser, String encryptPassword);

    /**
     * 修改头像
     * @param jwtUser
     * @param avatarPath
     * @param avatar
     */
    @CacheEvict(allEntries = true)
    void updateAvatar(JwtUser jwtUser, String avatarPath, MultipartFile avatar) throws Exception;

    /**
     * 修改邮箱
     * @param jwtUser
     * @param email
     */
    @CacheEvict(allEntries = true)
    void updateEmail(JwtUser jwtUser, String email);

    /**
     * 重置密码为123456
     * @param id
     */
    @CacheEvict(allEntries = true)
    void resetPassword(Long id);

    /**
     * 更新当前用户
     * @param resource
     */
    @CacheEvict(allEntries = true)
    void updateCurrent(User resource);

    @Cacheable(key = "#p0")
    List<UserVO> listByRoleNames(String name);

}
