package com.albedo.java.modules.sys.web;

import static com.albedo.java.common.core.constant.BusinessConstants.ADMIN_IDS;
import static com.albedo.java.common.core.constant.BusinessConstants.PERSONAL_USER_ROLE_ID;
import static com.albedo.java.common.core.constant.CommonConstants.ADMIN_ROLE_ID;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.log.annotation.LogOperate;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.util.ExcelUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.biz.domain.Balance;
import com.albedo.java.modules.biz.service.BalanceService;
import com.albedo.java.modules.sys.domain.RegisterUserData;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.domain.dto.UserDto;
import com.albedo.java.modules.sys.domain.dto.UserInfoDto;
import com.albedo.java.modules.sys.domain.dto.UserQueryCriteria;
import com.albedo.java.modules.sys.domain.vo.UserExcelVo;
import com.albedo.java.modules.sys.domain.vo.UserVo;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.tool.service.SmsService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.collect.Lists;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.lang.Snowflake;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;

/**
 * @author somewhere
 * @date 2019/2/1
 */
@RestController
@RequestMapping("${application.admin-path}/sys/user")
@Api("用户相关")
@AllArgsConstructor
public class UserResource extends BaseResource {

  private final UserService userService;

  /**
   * @param id
   * @return
   */
  @GetMapping(CommonConstants.URL_ID_REGEX)
  @PreAuthorize("@pms.hasPermission('sys_user_view')")
  public Result get(@PathVariable String id) {
    log.debug("REST request to get Entity : {}", id);
    return Result.buildOkData(userService.findDtoById(id));
  }

  /**
   * 分页查询用户
   *
   * @param pm
   *          参数集
   * @return 用户集合
   */
  @GetMapping
  @LogOperate(value = "用户管理查看")
  @PreAuthorize("@pms.hasPermission('sys_user_view')")
  public Result<IPage<UserVo>> findPage(PageModel<UserVo> pm, UserQueryCriteria userQueryCriteria) {
    return Result.buildOkData(userService.findPage(pm, userQueryCriteria, SecurityUtil.getDataScope()));
  }

  @LogOperate(value = "用户管理导出")
  @GetMapping(value = "/download")
  @PreAuthorize("@pms.hasPermission('sys_user_view')")
  public void download(UserQueryCriteria userQueryCriteria, HttpServletResponse response) {
    ExcelUtil<UserVo> util = new ExcelUtil<>(UserVo.class);
    util.exportExcel(userService.findPage(userQueryCriteria, SecurityUtil.getDataScope()), "用户数据", response);
  }

  /**
   * 获取当前用户全部信息
   *
   * @return 用户信息
   */
  @GetMapping(value = {"/info"})
  public Result info() {
    String username = SecurityUtil.getUser().getUsername();
    UserVo userVo = userService.findVoByUsername(username);
    if (userVo == null) {
      return Result.buildFail("获取当前用户信息失败");
    }
    return Result.buildOkData(userService.getInfo(userVo));
  }

  /**
   * 个人中心更新信息
   *
   * @param userInfoDto
   *          用户信息
   * @return R
   */
  @LogOperate(value = "用户管理编辑")
  @PostMapping("/info")
  public Result<String> saveInfo(@Valid @RequestBody UserInfoDto userInfoDto) {
    log.debug("REST request to save userDto : {}", userInfoDto);
    String id = userInfoDto.getId();
    User user = userService.getById(id);
    Assert.notNull(user, "未查询到该用户");
    user.setNickname(userInfoDto.getNickname());
    user.setPhone(userInfoDto.getPhone());
    user.setDescription(userInfoDto.getDescription());
    userService.saveOrUpdate(user);
    redisTemplate.delete("user_details::findVoByUsername:" + user.getUsername());
    return Result.buildOk("更新成功");
  }

  @Resource
  RedisTemplate<String, String> redisTemplate;

  /**
   * 获取指定用户全部信息
   *
   * @return 用户信息
   */
  @GetMapping("/info/{username}")
  public Result info(@PathVariable String username) {
    UserVo userVo = userService.findVoByUsername(username);
    if (userVo == null) {
      return Result.buildFail(String.format("用户信息为空 %s", username));
    }
    return Result.buildOkData(userService.getInfo(userVo));
  }

  /**
   * 删除用户
   *
   * @param ids
   * @return
   */
  @LogOperate(value = "用户管理删除")
  @DeleteMapping
  @PreAuthorize("@pms.hasPermission('sys_user_del')")
  public Result removeByIds(@RequestBody Set<String> ids) {
    return Result.buildByFlag(userService.removeByIds(ids));
  }

  /**
   * 添加/更新用户信息
   *
   * @param userDto
   *          用户信息
   * @return R
   */
  @LogOperate(value = "用户管理编辑")
  @PostMapping
  @PreAuthorize("@pms.hasPermission('sys_user_edit')")
  public Result save(@Valid @RequestBody UserDto userDto) {
    log.debug("REST request to save userDto : {}", userDto);
    boolean add = StringUtil.isEmpty(userDto.getId());
    if (add) {
      userDto.setPassword("123456");
    }
    String id = SecurityUtil.getUser().getId();
    List<String> roles = SecurityUtil.getRoles();
    // 超管随便添加
    boolean isAdmin = roles.stream().anyMatch(ADMIN_IDS::contains);
    if (!isAdmin) {
      Assert.isFalse(roles.contains(PERSONAL_USER_ROLE_ID), "个人账号无法绑定子账号，请升级为企业账号");
      Balance balance = balanceService.getByUserId(id);
      Integer childAccount = balance.getChildAccount();
      Assert.isTrue(childAccount >= 1, "子账号数量已超出套餐允许数量");
      balance.setChildAccount(childAccount - 1);
      balanceService.updateById(balance);
    }
    userService.saveOrUpdate(userDto);
    return Result.buildOk(add ? "新增成功，默认密码：123456" : "修改成功");
  }

  @Resource
  BalanceService balanceService;

  /**
   * @param username
   *          用户名称
   * @return 上级部门用户列表
   */
  @GetMapping("/ancestor/{username}")
  public Result listAncestorUsers(@PathVariable String username) {
    return Result.buildOkData(userService.listAncestorUsersByUsername(username));
  }

  /**
   * @param ids
   * @return
   */
  @PutMapping
  @LogOperate(value = "用户管理锁定/解锁")
  @PreAuthorize("@pms.hasPermission('sys_user_lock')")
  public Result lockOrUnLock(@RequestBody Set<String> ids) {
    userService.lockOrUnLock(ids);
    return Result.buildOk("操作成功");
  }

  @PostMapping(value = "/upload")
  @PreAuthorize("@pms.hasPermission('sys_user_edit')")
  @LogOperate(value = "用户导入")
  @ApiOperation(value = "导入用户")
  public Result<List<String>> uploadData(@RequestParam("uploadFile") MultipartFile dataFile) throws Exception {
    if (dataFile.isEmpty()) {
      return Result.buildFail("上传文件为空");
    }
    List<String> errors = userService.importUser(dataFile.getInputStream());
    if (CollectionUtils.isEmpty(errors)) {
      return Result.buildOkData(errors);
    }
    return Result.buildFailData(errors);
  }

  @GetMapping(value = "/exportTemplate")
  @PreAuthorize("@pms.hasPermission('sys_user_view')")
  @LogOperate(value = "用户导入模板导出")
  @ApiOperation(value = "用户导入模板导出")
  public void importTemplate(HttpServletResponse response) {
    ExcelUtil<UserExcelVo> util = new ExcelUtil<>(UserExcelVo.class);
    util.exportExcel(Lists.newArrayList(), "Sheet1", response);
  }

  @PostMapping(value = "/register")
  @LogOperate(value = "注册账号")
  public Result<String> register(@Valid @RequestBody RegisterUserData userData) {
    Assert.isTrue(StringUtils.equals(userData.getPassword(), userData.getRePassword()), "两次密码输入不一致");

    String key = "register" + userData.getPhone();
    String value = userData.getVerifyCode();
    Assert.isTrue(smsService.validated(key, value), "验证码无效");

    userService.register(userData);
    return Result.buildOk("注册成功");
  }

  @Resource
  SmsService smsService;

  @GetMapping("generate")
  @LogOperate("获取邀请码")
  @ApiOperation("查询邀请码")
  public Result<String> getInviteCode() {
    String id = SecurityUtil.getUser().getId();
    User user = userService.getById(id);
    Assert.notNull(user, "请登录后重试");
    if (StringUtils.isNotEmpty(user.getInviteCode())) {
      return Result.buildOkData(user.getInviteCode());
    }
    String uuid = getUUID();
    user.setInviteCode(uuid);
    userService.updateById(user);
    return Result.buildOkData(user.getInviteCode());
  }

  private String getUUID() {
    long id = SNOWFLAKE.nextId();
    return String.valueOf(id).substring(3);
  }

  @GetMapping("list")
  @ApiOperation("后台员工查看自己邀请注册的用户")
  public Result<Set<User>> getUserInfo() {
    String id = SecurityUtil.getUser().getId();
    List<String> roles = SecurityUtil.getRoles();
    Assert.isTrue(roles.contains(ADMIN_ROLE_ID), "非后台员工无法查看");
    User user = userService.getById(id);
    Assert.notEmpty(user.getInviteCode(), "邀请码为空，无法查询");
    List<User> results = userService.list(Wrappers.<User>query().eq("invite_code", user.getInviteCode()));
    Set<User> userSet =
      results.stream().filter(ele -> !StringUtils.equals(ele.getId(), id)).collect(Collectors.toSet());
    return Result.buildOkData(userSet);
  }

  private final static Snowflake SNOWFLAKE = cn.hutool.core.util.IdUtil.getSnowflake(1, 1);
}
