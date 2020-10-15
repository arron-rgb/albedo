package com.albedo.java.common.security.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AbstractAuthenticationTargetUrlRequestHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.WebUtil;

import lombok.AllArgsConstructor;

/**
 * Spring Security logout handler, specialized for Ajax requests.
 *
 * @author somewhere
 */
@AllArgsConstructor
public class AjaxLogoutSuccessHandler extends AbstractAuthenticationTargetUrlRequestHandler
  implements LogoutSuccessHandler {

  @Override
  public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
    response.setStatus(HttpServletResponse.SC_OK);
    WebUtil.renderJson(response, Result.buildOk("退出登录成功"));
  }
}
