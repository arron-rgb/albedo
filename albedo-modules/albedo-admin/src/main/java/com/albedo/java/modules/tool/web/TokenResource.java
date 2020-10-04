package com.albedo.java.modules.tool.web;

import static com.albedo.java.common.core.constant.BusinessConstants.BUSINESS_ADMIN_ROLE_ID;
import static com.albedo.java.common.core.constant.BusinessConstants.PERSONAL_USER_ROLE_ID;

import java.time.Duration;
import java.util.List;

import javax.annotation.Resource;
import javax.validation.constraints.NotEmpty;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.modules.sys.domain.Dept;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.domain.UserRole;
import com.albedo.java.modules.sys.service.DeptService;
import com.albedo.java.modules.sys.service.UserRoleService;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.sys.util.SysCacheUtil;
import com.albedo.java.modules.tool.domain.SmsEnum;
import com.albedo.java.modules.tool.service.SmsService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.IdUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * @author arronshentu
 */

@RestController
@RequestMapping(value = "${application.admin-path}")
@AllArgsConstructor
@Api(tags = "验证码、token接口")
public class TokenResource {
  @Resource
  RedisTemplate<String, String> redisTemplate;

  @GetMapping("token")
  @ApiOperation("获取token")
  public String get() {
    String token = IdUtil.fastSimpleUUID();
    redisTemplate.opsForValue().set(token, token);
    String memory = redisTemplate.opsForValue().get(token);
    if (!token.equals(memory)) {
      throw new RuntimeException("token获取错误");
    }
    Boolean expire = redisTemplate.expire(token, Duration.ofMinutes(5L));
    return token;
  }

  @Resource
  SmsService smsService;

  @GetMapping("password/reset")
  @ApiOperation("验证码-找回密码")
  public Result<String> validatedByPhone(@RequestParam String phone) {
    String code = "reset";
    smsService.sendMsg(phone, code, SmsEnum.FORGET_PASSWORD_TEMPLATE_CODE);
    return Result.buildOk("发送成功");
  }

  @GetMapping("account/register")
  @ApiOperation("验证码-注册账号")
  public Result<String> getCode(@RequestParam String phone) {
    String key = "register";
    smsService.sendMsg(phone, key, SmsEnum.REGISTER_TEMPLATE_CODE);
    return Result.buildOk("发送成功");
  }

  @PostMapping("sys/user/change")
  @Transactional(rollbackFor = Exception.class)
  @ApiOperation("个人用户更改为企业用户")
  public Result<String> change(@RequestBody ChangeBody body) {
    String id = SecurityUtil.getUser().getId();
    List<String> roles = SecurityUtil.getRoles();
    Assert.isTrue(roles.contains(PERSONAL_USER_ROLE_ID), "不含个人用户角色的账号无法升级");
    Dept dept = new Dept();
    dept.setAvailable(1);
    dept.setName(body.getCompanyName());
    dept.setParentId("-1");
    boolean save = deptService.save(dept);

    userRoleService.removeRoleByUserId(id);
    UserRole userRole = new UserRole();
    userRole.setUserId(id);
    userRole.setRoleId(BUSINESS_ADMIN_ROLE_ID);
    save = save && userRole.insert();
    User user = userService.getById(id);
    user.setDeptId(dept.getId());
    save = save && userService.updateById(user);
    SysCacheUtil.delBaseUserCaches(user.getId(), user.getUsername());
    return save ? Result.buildOk("更改成功") : Result.buildFail("更改失败");
  }

  @Resource
  UserRoleService userRoleService;

  @Data
  static class ChangeBody {
    @NotEmpty(message = "必须输入公司名")
    String companyName;
  }

  @PostMapping("sys/password/reset")
  @ApiOperation("找回密码")
  public Result<String> reset(@RequestBody ResetBody body) {
    Assert.isTrue(StringUtils.equals(body.getPassword(), body.getRePassword()), "两次密码输入不一致");
    User user = userService.getOne(Wrappers.<User>query().eq("phone", body.getPhone()));
    Assert.notNull(user, "系统中未查询到该账号");
    Assert.isTrue(StringUtils.equals(body.getPhone(), user.getPhone()), "账号与手机号不匹配");
    String key = "reset" + body.getPhone();
    String code = body.getCode();
    Assert.isTrue(smsService.validated(key, code), "验证码无效");
    String password = body.getPassword();
    user.setPassword(password);
    userService.resetPassword(user);
    SysCacheUtil.delBaseUserCaches(user.getId(), user.getUsername());
    return Result.buildOk("更改成功，请重新登录");
  }

  @Data
  public static class ResetBody {
    @NotEmpty(message = "请输入新密码")
    String password;
    @NotEmpty(message = "请再次输入新密码")
    String rePassword;
    @NotEmpty(message = "请获取验证码")
    String code;
    // @NotEmpty(message = "请输入用户名")
    // String username;
    @NotEmpty(message = "请输入手机号")
    String phone;
  }

  @Resource
  DeptService deptService;

  @Resource
  UserService userService;
}
