/*
 * Copyright (c) 2019-2020, somewhere (somewhere0813@gmail.com).
 * <p>
 * Licensed under the GNU Lesser General Public License 3.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * https://www.gnu.org/licenses/lgpl.html
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.common.log.util;

import java.time.LocalDateTime;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpHeaders;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import com.albedo.java.common.core.util.RequestHolder;
import com.albedo.java.common.core.util.WebUtil;
import com.albedo.java.modules.sys.domain.LogOperate;

import cn.hutool.core.util.ReflectUtil;
import cn.hutool.core.util.URLUtil;
import cn.hutool.http.useragent.UserAgent;
import cn.hutool.http.useragent.UserAgentUtil;
import lombok.experimental.UtilityClass;

/**
 * 系统日志工具类
 *
 * @author L.cm
 */
@UtilityClass
public class SysLogUtils {
  public LogOperate getSysLog() {
    HttpServletRequest request = RequestHolder.getHttpServletRequest();
    LogOperate logOperate = new LogOperate();
    logOperate.setCreatedBy(getUserId());
    logOperate.setCreatedDate(LocalDateTime.now());
    logOperate.setUsername(getUsername());
    logOperate.setIpAddress(WebUtil.getIp(request));
    logOperate.setIpLocation(logOperate.getIpAddress());
    logOperate.setUserAgent(request.getHeader(HttpHeaders.USER_AGENT));
    UserAgent userAgent = UserAgentUtil.parse(logOperate.getUserAgent());
    logOperate.setBrowser(userAgent.getBrowser().getName());
    logOperate.setOs(userAgent.getOs().getName());
    logOperate.setRequestUri(URLUtil.getPath(request.getRequestURI()));
    return logOperate;
  }

  /**
   * 获取用户名称
   *
   * @return username
   */
  private String getUsername() {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    if (authentication == null) {
      return null;
    }
    return authentication.getName();
  }

  /**
   * 获取用户Id
   *
   * @return username
   */
  private String getUserId() {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    if (authentication == null || authentication.getPrincipal() == null) {
      return null;
    }
    return (String)ReflectUtil.getFieldValue(authentication.getPrincipal(), "id");
  }
}
