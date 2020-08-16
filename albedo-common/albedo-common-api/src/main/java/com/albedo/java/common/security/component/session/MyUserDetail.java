package com.albedo.java.common.security.component.session;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 为了处理dev-tool导致的无法强制转换principal
 *
 * @author arronshentu
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class MyUserDetail {
  /**
   * 用户ID
   */
  private String id;
  /**
   * 部门ID
   */
  private String deptId;
  /**
   * 部门名称
   */
  private String deptName;
  String username;
  String loginId;
  String password;
  boolean enabled;
  boolean accountNonExpired;
  boolean credentialsNonExpired;
  boolean accountNonLocked;
  Collection<? extends GrantedAuthority> authorities;

}
