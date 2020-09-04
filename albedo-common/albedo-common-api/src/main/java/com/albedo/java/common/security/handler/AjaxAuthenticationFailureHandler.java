package com.albedo.java.common.security.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.core.util.WebUtil;
import com.albedo.java.common.security.util.LoginUtil;

/**
 * Returns a 401 error code (Unauthorized) to the client, when Ajax authentication fails.
 *
 * @author arronshentu
 */
public class AjaxAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {
  private static final String BAD_CREDENTIALS = "Bad credentials";

  @Override
  public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
    AuthenticationException exception) {
    String username = request.getParameter("username");
    LoginUtil.isValidateCodeLogin(username, true, false);
    String message = exception.getMessage();
    if (BAD_CREDENTIALS.equals(message)) {
      message = "密码错误";
    }
    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
    WebUtil.renderJson(response, Result.buildFail(message));
  }
}
