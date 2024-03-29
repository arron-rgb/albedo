package com.albedo.java.modules.sys.service.impl;

import static com.albedo.java.common.core.constant.CommonConstants.*;

import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import com.albedo.java.common.core.config.ApplicationConfig;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CacheNameConstants;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.core.exception.AccountException;
import com.albedo.java.common.core.exception.EntityExistException;
import com.albedo.java.common.core.exception.RuntimeMsgException;
import com.albedo.java.common.core.util.BeanUtil;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.persistence.datascope.DataScope;
import com.albedo.java.common.persistence.service.impl.DataServiceImpl;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.util.ExcelUtil;
import com.albedo.java.common.util.RedisUtil;
import com.albedo.java.modules.sys.domain.*;
import com.albedo.java.modules.sys.domain.dto.UserDto;
import com.albedo.java.modules.sys.domain.dto.UserQueryCriteria;
import com.albedo.java.modules.sys.domain.vo.MenuVo;
import com.albedo.java.modules.sys.domain.vo.UserExcelVo;
import com.albedo.java.modules.sys.domain.vo.UserInfo;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.albedo.java.modules.sys.domain.vo.account.PasswordChangeVo;
import com.albedo.java.modules.sys.domain.vo.account.PasswordRestVo;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.albedo.java.modules.sys.service.*;
import com.albedo.java.modules.sys.util.SysCacheUtil;
import com.aliyun.oss.internal.OSSUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;

import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.IdUtil;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@Slf4j
@Service
@AllArgsConstructor
@CacheConfig(cacheNames = CacheNameConstants.USER_DETAILS)
public class UserServiceImpl extends DataServiceImpl<UserRepository, User, UserDto, String> implements UserService {
  @Resource
  RoleDeptService roleDeptService;
  @Resource
  ApplicationProperties applicationProperties;
  private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
  @Resource
  MenuService menuService;
  @Resource
  RoleService roleService;
  @Resource
  DeptService deptService;
  @Resource
  UserRoleService userRoleService;

  /**
   * 功能描述: 检查密码长度
   *
   * @param password
   *          密码
   * @return boolean
   */
  private static boolean checkPasswordLength(String password) {
    return !StringUtil.isEmpty(password) && password.length() >= UserDto.PASSWORD_MIN_LENGTH
      && password.length() <= UserDto.PASSWORD_MAX_LENGTH;
  }

  @Override
  @Cacheable(key = "'findVoByUsername:' + #p0")
  public UserVo findVoByUsername(String username) {
    return repository.findVoByUsername(username);
  }

  /**
   * 通过ID查询用户信息
   *
   * @param id
   *          用户ID
   * @return 用户信息
   */
  @Override
  @Transactional(readOnly = true, rollbackFor = Exception.class)
  @Cacheable(key = "'findUserVoById:' + #p0")
  public UserVo findUserVoById(String id) {
    UserVo userVo = baseMapper.findUserVoById(id);
    return userVo;
  }

  /**
   * 通过ID查询用户信息
   *
   * @param id
   *          用户ID
   * @return 用户信息
   */
  @Override
  @Transactional(readOnly = true, rollbackFor = Exception.class)
  @Cacheable(key = "'findDtoById:' + #p0")
  public UserDto findDtoById(String id) {
    UserVo userVo = repository.findUserVoById(id);
    return new UserDto(userVo);
  }

  /**
   * 通过查用户的全部信息
   *
   * @param userVo
   *          用户
   * @return
   */
  @Override
  @Transactional(readOnly = true, rollbackFor = Exception.class)
  public UserInfo getInfo(UserVo userVo) {
    UserInfo userInfo = new UserInfo();
    userInfo.setUser(userVo);
    List<Role> roles = roleService.findListByUserId(userVo.getId());
    // 设置角色列表 （ID）
    List<String> roleIds = roles.stream().map(Role::getId).collect(Collectors.toList());
    userInfo.setRoles(ArrayUtil.toArray(roleIds, String.class));
    // 设置权限列表（menu.permission）
    Set<String> permissions = new HashSet<>();
    roleIds.forEach(roleId -> {
      List<String> permissionList =
        menuService.findListByRoleId(roleId).stream().filter(menuVo -> StringUtil.isNotEmpty(menuVo.getPermission()))
          .map(MenuVo::getPermission).collect(Collectors.toList());
      permissions.addAll(permissionList);
    });
    if (roleIds.contains(PERSONAL_USER_ROLE_ID)) {
      userInfo.setUserType("1");
    } else if (roleIds.contains(BUSINESS_ADMIN_ROLE_ID) || roleIds.contains(BUSINESS_COMMON_ROLE_ID)) {
      userInfo.setUserType("2");
    } else {
      userInfo.setUserType("3");
    }
    userInfo.setPermissions(ArrayUtil.toArray(permissions, String.class));
    return userInfo;
  }

  /**
   * 分页查询用户信息（含有角色信息）
   *
   * @param pm
   *          分页对象
   * @return
   */
  @Override
  @Transactional(readOnly = true, rollbackFor = Exception.class)
  public IPage<UserVo> findPage(PageModel pm, UserQueryCriteria userQueryCriteria, DataScope dataScope) {
    // pm.addOrder(OrderItem.desc("a.created_date"));
    QueryWrapper wrapper = QueryWrapperUtil.getWrapper(pm, userQueryCriteria);
    wrapper.eq("a.del_flag", User.FLAG_NORMAL);
    IPage<UserVo> userVosPage = repository.findUserVoPage(pm, wrapper, dataScope);
    return userVosPage;
  }

  @Override
  public List<UserVo> findPage(UserQueryCriteria userQueryCriteria, DataScope dataScope) {
    QueryWrapper wrapper = QueryWrapperUtil.<User>getWrapper(userQueryCriteria);
    wrapper.eq("a.del_flag", User.FLAG_NORMAL);
    wrapper.orderByDesc("a.created_date");
    return repository.findUserVoPage(wrapper, dataScope);
  }

  public Boolean exitUserByUserName(UserDto userDto) {
    return getOne(Wrappers.<User>query().ne(StringUtil.isNotEmpty(userDto.getId()), UserDto.F_ID, userDto.getId())
      .eq(UserDto.F_USERNAME, userDto.getUsername())) != null;
  }

  public Boolean exitUserByEmail(UserDto userDto) {
    return getOne(Wrappers.<User>query().ne(StringUtil.isNotEmpty(userDto.getId()), UserDto.F_ID, userDto.getId())
      .eq(UserDto.F_EMAIL, userDto.getEmail())) != null;
  }

  public Boolean exitUserByPhone(UserDto userDto) {
    return getOne(Wrappers.<User>query().ne(StringUtil.isNotEmpty(userDto.getId()), UserDto.F_ID, userDto.getId())
      .eq(UserDto.F_PHONE, userDto.getPhone())) != null;
  }

  /**
   * 保存用户信息
   *
   * @param userDto
   *          DTO 对象
   */
  @Override
  @Transactional(rollbackFor = Exception.class)
  @CacheEvict(cacheNames = {CacheNameConstants.USER_DETAILS}, allEntries = true)
  public void saveOrUpdate(UserDto userDto) {
    boolean add = StringUtil.isEmpty(userDto.getId());
    if (add) {
      Assert.isTrue(StringUtil.isNotEmpty(userDto.getPassword()), "密码不能为空");
    }
    // username before comparing with database
    if (exitUserByUserName(userDto)) {
      throw new EntityExistException(UserDto.class, "username", userDto.getUsername());
    }
    // email before comparing with database
    if (StringUtil.isNotEmpty(userDto.getEmail()) && exitUserByEmail(userDto)) {
      throw new EntityExistException(UserDto.class, "email", userDto.getEmail());
    }
    // phone before comparing with database
    if (StringUtil.isNotEmpty(userDto.getPhone()) && exitUserByPhone(userDto)) {
      throw new EntityExistException(UserDto.class, "phone", userDto.getPhone());
    }
    User user = add ? new User() : repository.selectById(userDto.getId());
    BeanUtil.copyProperties(userDto, user, true);
    if (StringUtil.isNotEmpty(userDto.getPassword())) {
      user.setPassword(passwordEncoder.encode(userDto.getPassword()));
    }
    super.saveOrUpdate(user);
    userDto.setId(user.getId());
    if (add || CollUtil.isNotEmpty(userDto.getRoleIdList())) {

      Assert.isTrue(CollUtil.isNotEmpty(userDto.getRoleIdList()), "用户角色不能为空");
      if (!add) {
        SysCacheUtil.delUserCaches(user.getId(), user.getUsername());
      }
      List<UserRole> userRoleList = userDto.getRoleIdList().stream().map(roleId -> {
        UserRole userRole = new UserRole();
        userRole.setUserId(user.getId());
        userRole.setRoleId(roleId);
        return userRole;
      }).collect(Collectors.toList());
      userRoleService.removeRoleByUserId(user.getId());
      userRoleService.saveBatch(userRoleList);
    }
  }

  @Override
  public Boolean removeByIds(List<String> idList) {
    idList.forEach(id -> {
      Assert.isTrue(!StringUtil.equals(SecurityUtil.getUser().getId(), id), "不能操作当前登录用户");
      User user = repository.selectById(id);
      SysCacheUtil.delUserCaches(user.getId(), user.getUsername());
      userRoleService.removeRoleByUserId(user.getId());
      this.removeById(user.getId());
    });
    return Boolean.TRUE;
  }

  /**
   * 查询上级部门的用户信息
   *
   * @param username
   *          用户名
   * @return R
   */
  @Override
  @Transactional(readOnly = true, rollbackFor = Exception.class)
  public List<User> listAncestorUsersByUsername(String username) {
    User user = this.getOne(Wrappers.<User>query().lambda().eq(User::getUsername, username));

    Dept dept = deptService.getById(user.getDeptId());
    if (dept == null) {
      return null;
    }

    String parentId = dept.getParentId();
    return this.list(Wrappers.<User>query().lambda().eq(User::getDeptId, parentId));
  }

  @Override
  public void lockOrUnLock(Set<String> idList) {
    Assert.isTrue(CollUtil.isNotEmpty(idList), "idList不能为空");
    for (String id : idList) {
      Assert.isTrue(!StringUtil.equals(SecurityUtil.getUser().getId(), id), "不能操作当前登录用户");
      User user = repository.selectById(id);
      Assert.isTrue(user != null, "无法找到ID为" + id + "的数据");
      user.setAvailable(CommonConstants.YES.equals(user.getAvailable()) ? CommonConstants.NO : CommonConstants.YES);
      SysCacheUtil.delUserCaches(user.getId(), user.getUsername());
      int i = repository.updateById(user);
      Assert.isTrue(i != 0, "无法更新ID为" + id + "的数据");
    } ;
  }

  @Override
  public void resetPassword(PasswordRestVo passwordRestVo) {
    Assert.isTrue(passwordRestVo.getNewPassword().equals(passwordRestVo.getConfirmPassword()), "两次输入密码不一致");
    passwordRestVo.setPasswordPlaintext(passwordRestVo.getNewPassword());
    passwordRestVo.setNewPassword(passwordEncoder.encode(passwordRestVo.getNewPassword()));

    Object tempCode = RedisUtil.getCacheString(SecurityConstants.DEFAULT_CODE_KEY + passwordRestVo.getPhone());
    Assert.isTrue(passwordRestVo.getCode().equals(tempCode), "验证码输入有误");
    User user =
      repository.selectOne(Wrappers.<User>query().lambda().eq(User::getUsername, passwordRestVo.getUsername()));
    updatePassword(user, passwordRestVo.getNewPassword());
  }

  private void updatePassword(User user, String newPassword) {
    user.setPassword(newPassword);
    SysCacheUtil.delBaseUserCaches(user.getId(), user.getUsername());
    repository.updateById(user);
    log.debug("Changed password for User: {}", user);
  }

  @Override
  public void changePassword(String username, PasswordChangeVo passwordChangeVo) {

    Assert.isTrue(passwordChangeVo != null && checkPasswordLength(passwordChangeVo.getNewPassword()), "密码格式有误");
    Assert.isTrue(!passwordChangeVo.getNewPassword().equals(passwordChangeVo.getOldPassword()), "新旧密码不能相同");
    Assert.isTrue(passwordChangeVo.getNewPassword().equals(passwordChangeVo.getConfirmPassword()), "两次输入密码不一致");
    User user = repository.selectOne(Wrappers.<User>query().lambda().eq(User::getUsername, username));
    Assert.isTrue(passwordEncoder.matches(passwordChangeVo.getOldPassword(), user.getPassword()), "输入原密码有误");

    passwordChangeVo.setNewPassword(passwordEncoder.encode(passwordChangeVo.getNewPassword()));

    updatePassword(user, passwordChangeVo.getNewPassword());
  }

  @Override
  public void save(@Valid UserExcelVo userExcelVo) {
    UserDto user = new UserDto();
    BeanUtils.copyProperties(userExcelVo, user);
    Dept dept = deptService.getOne(Wrappers.<Dept>query().lambda().eq(Dept::getName, userExcelVo.getDeptName()));
    if (dept != null) {
      user.setDeptId(dept.getId());
    }
    Role role = roleService.getOne(Wrappers.<Role>query().lambda().eq(Role::getName, userExcelVo.getRoleName()));
    if (role == null) {
      throw new RuntimeMsgException("无法获取角色" + userExcelVo.getRoleName() + "信息");
    }
    user.setRoleIdList(Lists.newArrayList(role.getId()));
    saveOrUpdate(user);
  }

  @Override
  public List<User> findListByRoleId(String roleId) {
    return repository.findListByRoleId(roleId);
  }

  @Override
  public void updateAvatar(String username, String avatar) {
    User user = repository.selectOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, username));
    Assert.isTrue(user != null, "无法获取用户信息" + username);
    user.setAvatar(avatar);
    SysCacheUtil.delBaseUserCaches(user.getId(), user.getUsername());
    repository.updateById(user);
  }

  @Override
  public void register(RegisterUserData userData) {

    List<User> list = baseMapper.selectList(Wrappers.<User>query().eq(User.F_USERNAME, userData.getUsername()));
    Assert.isTrue(CollectionUtils.isEmpty(list), "用户名已存在");

    if (StringUtils.isNotBlank(userData.getPhone())) {
      list = baseMapper.selectList(Wrappers.<User>query().eq(User.F_SQL_PHONE, userData.getPhone()));
      Assert.isTrue(CollectionUtils.isEmpty(list), "该手机号已绑定其他账号");
    }

    // 2. 用户角色-系统角色-部门对应
    switch (userData.getUserType()) {
      case "personal":
        registerPersonalUser(userData);
        break;
      case "business":
        registerBusinessUser(userData);
        break;
      default:
        throw new AccountException("未知用户类型");
    }
  }

  private void registerBusinessUser(RegisterUserData userData) {
    String deptId;
    String roleId;
    Dept dept;
    if (StringUtils.isNotEmpty(userData.getNewCompanyName())) {
      // 新建一个企业的流程：1. new 一个dept 2. 将企业管理员roleId与deptId绑定 3. 将userId与企业管理员roleId绑定起来
      dept = new Dept();
      dept.setAvailable(1);
      dept.setName(userData.getNewCompanyName());
      deptService.save(dept);
      roleId = BUSINESS_ADMIN_ROLE_ID;
    } else {
      // 已有企业的流程：1. 找到该企业名对应的dept 2. 找到deptId对应的普通roleId 3. 将roleId与userId绑定
      String ownedCompanyName = userData.getOwnedCompanyName();
      dept = deptService.getOne(Wrappers.<Dept>query().eq(Dept.F_SQL_NAME, ownedCompanyName));
      Assert.notNull(dept, "未查询到该企业，请检查后重试");
      String adminId = baseMapper.getDeptAdminIdByDeptId(dept.getId());
      // 验证 对应 企业账号数量限制
      String left = baseMapper.getOutTradeNosByUserId(adminId);
      if (StringUtils.isEmpty(left)) {
        throw new AccountException("该企业管理员未购买任何套餐，无法绑定子账号");
      }
      if (Integer.parseInt(left) < 1) {
        throw new AccountException("该企业管理员套餐下可账号注册数量已超过限制");
      }
      roleId = BUSINESS_COMMON_ROLE_ID;
    }
    deptId = dept.getId();
    String userId = saveUser(userData, deptId);
    saveUserRole(userId, roleId);
  }

  private void registerPersonalUser(RegisterUserData userData) {
    String userId = saveUser(userData, PUBLIC_DEPT_ID);
    // 个人用户默认所属公共用户部门，角色为个人。个人角色已在系统中与默认公共部门硬编码
    boolean flag = saveUserRole(userId, PERSONAL_USER_ROLE_ID);
    if (!flag) {
      throw new AccountException("注册失败");
    }
  }

  private String saveUser(RegisterUserData userData, String deptId) {
    User user = new User();
    user.setUsername(userData.getUsername());
    user.setPassword(passwordEncoder.encode(userData.getPassword()));
    user.setPhone(userData.getPhone());
    user.setDeptId(deptId);
    user.setInviteCode(userData.getInvitationCode());
    // todo 无效邀请码
    baseMapper.insert(user);
    return user.getId();
  }

  private boolean saveUserRole(String userId, String roleId) {
    UserRole userRole = new UserRole();
    userRole.setRoleId(roleId);
    userRole.setUserId(userId);
    return userRoleService.save(userRole);
  }

  @Override
  public List<String> importUser(InputStream inputStream) {
    ExcelUtil<UserExcelVo> util = new ExcelUtil<>(UserExcelVo.class);
    List<UserExcelVo> errors = new ArrayList<>();
    try {
      List<UserExcelVo> data = util.importExcel(inputStream);
      if (CollectionUtils.isEmpty(data)) {
        return new ArrayList<>();
      }
      User user = new User();
      for (UserExcelVo datum : data) {
        BeanUtils.copyProperties(datum, user);
        user.setPassword(passwordEncoder.encode(user.getUsername()));
        user.setNickname(datum.getName());
        user.setDeptId(ADMIN_DEPT_ID);
        baseMapper.insert(user);
        if (StringUtils.isBlank(user.getId())) {
          errors.add(datum);
          continue;
        }
        // user的默认role
        UserRole userRole = new UserRole();
        userRole.setUserId(user.getId());
        userRole.setRoleId(ADMIN_ROLE_ID);
        userRoleService.save(userRole);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    if (!CollectionUtils.isEmpty(errors)) {
      return errors.stream().map(UserExcelVo::getUsername).collect(Collectors.toList());
    }
    return new ArrayList<>();
  }

  @Override
  public String getAdminIdByDeptId(String deptId) {
    return baseMapper.getDeptAdminIdByDeptId(deptId);
  }

  @Override
  public String getBucketName(String userId) {
    User user = baseMapper.selectById(userId);
    Assert.notNull(user, "系统中不存在该用户");
    // userId有效则用userId
    if (OSSUtils.validateBucketName(userId)) {
      user.setBucketName(userId);
      user.updateById();
      return user.getBucketName();
    }
    //
    String bucketName = user.getBucketName();
    // 为空则初始化一个
    if (StringUtils.isEmpty(bucketName)) {
      bucketName = IdUtil.fastSimpleUUID();
      user.setBucketName(bucketName);
      user.updateById();
    }
    return bucketName;
  }

  @Override
  public String getUploadPath(String userId) {
    return ApplicationConfig.getUploadPath() + File.separator + getBucketName(userId);
  }

  @Override
  public String resetPassword(User user) {
    String encodePassword = passwordEncoder.encode(user.getPassword());
    user.setPassword(encodePassword);
    return updateById(user) ? "更新成功，请重新登录" : "更新失败，请联系网站管理员";
  }
}
