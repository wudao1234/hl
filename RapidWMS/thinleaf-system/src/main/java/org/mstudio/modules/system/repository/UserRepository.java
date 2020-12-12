package org.mstudio.modules.system.repository;

import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.*;

import java.util.Date;
import java.util.List;

/**
 *
 * @date 2018-11-22
 */
public interface UserRepository extends JpaRepository<User, Long>, JpaSpecificationExecutor {

    /**
     * findByUsername
     * @param username
     * @return
     */
    User findByUsername(String username);

    /**
     * findByEmail
     * @param email
     * @return
     */
    User findByEmail(String email);

    /**
     * 修改密码
     * @param id
     * @param pass
     */
    @Modifying
    @Query(value = "update user set password = ?2 , last_password_reset_time = ?3 where id = ?1",nativeQuery = true)
    void updatePass(Long id, String pass, Date lastPasswordResetTime);

    /**
     * 修改头像
     * @param id
     * @param url
     */
    @Modifying
    @Query(value = "update user set avatar = ?2 where id = ?1",nativeQuery = true)
    void updateAvatar(Long id, String url);

    /**
     * 修改邮箱
     * @param id
     * @param email
     */
    @Modifying
    @Query(value = "update user set email = ?2 where id = ?1",nativeQuery = true)
    void updateEmail(Long id, String email);

    /**
     * 更新当前用户，包含用户名和邮箱
     * @param id
     * @param username
     * @param email
     */
    @Modifying
    @Query(value = "update user set username = ?2 , email = ?3 where id = ?1",nativeQuery = true)
    void updateCurrent(Long id, String username, String email);

    List<User> findByRolesIdIn(List<Long> ids);

}
