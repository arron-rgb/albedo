package com.albedo.java.common.security.filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.security.filter.warpper.BodyRequestWrapper;

/**
 * @author somewhere
 * @description
 * @date 2020/5/30 11:24 下午
 */
public class BodyFilter extends OncePerRequestFilter {

  public BodyFilter(ApplicationProperties applicationProperties) {}

  @Override
  protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
    throws ServletException, IOException {
    boolean isUpload = request.getRequestURI().contains("/file/upload");
    if (isUpload) {
      filterChain.doFilter(request, response);
    } else {
      filterChain.doFilter(new BodyRequestWrapper(request), response);
    }
  }

}
