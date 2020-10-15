package com.albedo.java.common.security.filter;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.web.filter.OncePerRequestFilter;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.security.util.LoginUtil;
import com.albedo.java.modules.sys.domain.vo.account.LoginVo;
import com.google.common.base.Stopwatch;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * @author somewhere
 * @description
 * @date 2020/5/30 11:26 下午
 */
@AllArgsConstructor
@Slf4j
public class ValidateCodeFilter extends OncePerRequestFilter {

  private final AuthenticationFailureHandler authenticationFailureHandler;
  private final ApplicationProperties applicationProperties;

  @Override
  protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
    throws ServletException, IOException {
    if (StringUtils.equals(applicationProperties.getAdminPath(SecurityConstants.AUTHENTICATE_URL),
      request.getRequestURI()) && StringUtils.equalsIgnoreCase(request.getMethod(), "post")) {
      Stopwatch stopwatch = Stopwatch.createStarted();
      LoginVo loginVo = new LoginVo();
      loginVo.setCode(request.getParameter("code"));
      loginVo.setRandomStr(request.getParameter("randomStr"));
      try {
        LoginUtil.checkCode(loginVo);
      } catch (AuthenticationException e) {
        authenticationFailureHandler.onAuthenticationFailure(request, response, e);
        return;
      }
      stopwatch.stop();
      log.info("验证验证码执行时间{}s", stopwatch.elapsed(TimeUnit.SECONDS));
    }
    filterChain.doFilter(request, response);
  }
}
