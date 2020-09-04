package com.albedo.java.common.security.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.util.WebUtil;
import com.albedo.java.common.log.enums.LogType;
import com.albedo.java.common.log.event.SysUserOnlineEvent;
import com.albedo.java.common.log.util.SysLogUtils;
import com.albedo.java.common.security.util.LoginUtil;
import com.albedo.java.common.util.AsyncUtil;
import com.albedo.java.modules.sys.domain.LogOperate;
import com.albedo.java.modules.sys.domain.UserOnline;

import cn.hutool.http.HttpUtil;

/**
 * Spring Security success handler, specialized for Ajax requests.
 *
 * @author somewhere
 */
public class AjaxAuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

  @Override
  public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
    Authentication authentication) {
    response.setStatus(HttpServletResponse.SC_OK);
    String username = request.getParameter("username");
    LoginUtil.isValidateCodeLogin(username, false, true);
    UserOnline userOnline = LoginUtil.getUserOnline(authentication);
    SpringContextHolder.publishEvent(new SysUserOnlineEvent(userOnline));
    LogOperate logOperate = SysLogUtils.getSysLog();
    logOperate.setParams(HttpUtil.toParams(request.getParameterMap()));
    logOperate.setUsername(username);
    logOperate.setLogType(LogType.INFO.name());
    logOperate.setTitle("用户登录");
    AsyncUtil.recordLogLogin(logOperate);
    WebUtil.renderJson(response, Result.buildOk("登录成功"));
  }

}
