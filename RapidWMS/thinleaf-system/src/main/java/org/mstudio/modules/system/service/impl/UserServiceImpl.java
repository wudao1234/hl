package org.mstudio.modules.system.service.impl;

import org.mstudio.exception.BadRequestException;
import org.mstudio.exception.EntityExistException;
import org.mstudio.exception.EntityNotFoundException;
import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.security.utils.JwtTokenUtil;
import org.mstudio.modules.system.domain.Role;
import org.mstudio.modules.system.domain.User;
import org.mstudio.modules.system.repository.RoleRepository;
import org.mstudio.modules.system.repository.UserRepository;
import org.mstudio.modules.system.service.UserService;
import org.mstudio.modules.system.service.dto.UserDTO;
import org.mstudio.modules.system.service.dto.UserVO;
import org.mstudio.modules.system.service.mapper.UserMapper;
import org.mstudio.utils.FileUtil;
import org.mstudio.utils.SecurityContextHolder;
import org.mstudio.utils.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @date 2018-11-23
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class UserServiceImpl implements UserService {

    /**
     * MD5_123 默认密码 123456，此密码是 MD5加密后的字符
     */
    private static final String MD5_123 = "14e1b600b1fd579f47433b88e8d85291";

    private static final String AVATAR = "/avatar/no_avatar.jpg";

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    @Autowired
    @Qualifier("jwtUserDetailsService")
    private UserDetailsService userDetailsService;

    @Autowired
    private RoleRepository roleRepository;

    @Override
    public UserDTO findById(long id) {
        Optional<User> user = userRepository.findById(id);
        ValidationUtil.isNull(user, "User", "id", id);
        return userMapper.toDto(user.get());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    synchronized public UserDTO create(User resources) {

        if (userRepository.findByUsername(resources.getUsername()) != null) {
            throw new EntityExistException(User.class, "username", resources.getUsername());
        }

        if (userRepository.findByEmail(resources.getEmail()) != null) {
            throw new EntityExistException(User.class, "email", resources.getEmail());
        }

        if (resources.getRoles() == null || resources.getRoles().size() == 0) {
            throw new BadRequestException("角色不能为空");
        }

        resources.setPassword(MD5_123);
        resources.setAvatar(AVATAR);
        return userMapper.toDto(userRepository.save(resources));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    synchronized public void update(User resources) {
        User user = getValidUser(resources, resources.getId());
        user.setUsername(resources.getUsername());
        user.setEmail(resources.getEmail());
        user.setCoefficient(resources.getCoefficient());
        user.setEnabled(resources.getEnabled());
        user.setRoles(resources.getRoles());
        // add Customers
        user.setCustomers(resources.getCustomers());
        userRepository.save(user);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    synchronized public void delete(Long id) {
        userRepository.deleteById(id);
    }

    @Override
    public User findByName(String userName) {
        User user = null;
        if (ValidationUtil.isEmail(userName)) {
            user = userRepository.findByEmail(userName);
        } else {
            user = userRepository.findByUsername(userName);
        }

        if (user == null) {
            throw new EntityNotFoundException(User.class, "name", userName);
        } else {
            return user;
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updatePassword(JwtUser jwtUser, String pass) {
        userRepository.updatePass(jwtUser.getId(), pass, new Date());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateAvatar(JwtUser jwtUser, String avatarPath, MultipartFile avatar) throws Exception {
        String avatarFileName = FileUtil.uploadFile(avatarPath, avatar);
        String avatarFileUrl = "/" + avatarPath + "/" + avatarFileName;
        if (!jwtUser.getAvatar().equals(AVATAR)) {
            FileUtil.deleteAvatar(jwtUser.getAvatar());
        }
        userRepository.updateAvatar(jwtUser.getId(), avatarFileUrl);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateEmail(JwtUser jwtUser, String email) {
        userRepository.updateEmail(jwtUser.getId(), email);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void resetPassword(Long id) {
        userRepository.updatePass(id, MD5_123, new Date());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    synchronized public void updateCurrent(User resources) {
        if (resources.getUsername() == null || resources.getEmail() == null) {
            throw new BadRequestException("未提供完整信息");
        }
        UserDetails userDetails = SecurityContextHolder.getUserDetails();
        JwtUser jwtUser = (JwtUser)userDetailsService.loadUserByUsername(userDetails.getUsername());
        User user = getValidUser(resources, jwtUser.getId());
        userRepository.updateCurrent(user.getId(), user.getUsername(), user.getEmail());
    }

    @Override
    public List<UserVO> listByRoleNames(String names) {
        List<Long> roleIds = new ArrayList<>();
        Arrays.stream(names.split(",")).forEach(name -> {
            Role role = roleRepository.findByName(name);
            if (role != null) {
                roleIds.add(role.getId());
            }
        });
        List<User> users = userRepository.findByRolesIdIn(roleIds).stream().distinct().collect(Collectors.toList());
        return userMapper.toVOList(users);
    }

    private User getValidUser(User resource, Long id) {
        Optional<User> userOptional = userRepository.findById(id);
        ValidationUtil.isNull(userOptional, "User", "id", resource.getId());

        User user = userOptional.get();

        User user1 = userRepository.findByUsername(user.getUsername());
        User user2 = userRepository.findByEmail(user.getEmail());

        if (user1 != null && !user.getId().equals(user1.getId())) {
            throw new EntityExistException(User.class, "username", resource.getUsername());
        }

        if (user2 != null && !user.getId().equals(user2.getId())) {
            throw new EntityExistException(User.class, "email", resource.getEmail());
        }
        return user;
    }
}
