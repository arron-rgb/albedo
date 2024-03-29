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

package com.albedo.java.common.security.filter;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.SecurityConstants;
import com.albedo.java.common.security.filter.warpper.ParameterRequestWrapper;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.repository.UserRepository;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.google.common.base.Stopwatch;

import cn.hutool.core.codec.Base64;
import cn.hutool.core.util.CharsetUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.Mode;
import cn.hutool.crypto.Padding;
import cn.hutool.crypto.symmetric.AES;
import cn.hutool.http.HttpUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * @author somewhere
 * @date 2019/2/1
 *       密码解密工具类
 */
@Slf4j
@Component
public class PasswordDecoderFilter extends OncePerRequestFilter {
  private static final String PASSWORD = "password";
  private static final String KEY_ALGORITHM = "AES";

  private final ApplicationProperties applicationProperties;
  private final UserRepository userRepository;

  public PasswordDecoderFilter(ApplicationProperties applicationProperties, UserRepository userRepository) {
    this.applicationProperties = applicationProperties;
    this.userRepository = userRepository;
  }

  public static String decryptAes(String data, String pass) {
    AES aes = new AES(Mode.CBC, Padding.NoPadding, new SecretKeySpec(pass.getBytes(), KEY_ALGORITHM),
      new IvParameterSpec(pass.getBytes()));
    byte[] result = aes.decrypt(Base64.decode(data.getBytes(StandardCharsets.UTF_8)));
    return new String(result, StandardCharsets.UTF_8);
  }

  @Override
  protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
    throws ServletException, IOException {
    // 不是登录请求，直接向下执行
    if (!StrUtil.containsAnyIgnoreCase(request.getRequestURI(),
      applicationProperties.getAdminPath(SecurityConstants.AUTHENTICATE_URL))) {
      filterChain.doFilter(request, response);
      return;
    }
    Stopwatch stopwatch = Stopwatch.createStarted();
    String queryParam = request.getQueryString();
    Map<String, String> paramMap = HttpUtil.decodeParamMap(queryParam, CharsetUtil.CHARSET_UTF_8);
    String username = request.getParameter("username");
    List<User> users = userRepository.selectList(Wrappers.<User>query().eq("username", username));
    if (users.size() < 1) {
      throw new UsernameNotFoundException("用户不存在");
    }
    String password = request.getParameter(PASSWORD);
    if (StrUtil.isNotBlank(password)) {
      try {
        password = decryptAes(password, applicationProperties.getSecurity().getEncodeKey());
      } catch (Exception e) {
        log.error("密码解密失败:{}", password);
        throw e;
      }
      paramMap.put(PASSWORD, password.trim());
    }
    ParameterRequestWrapper requestWrapper = new ParameterRequestWrapper(request, paramMap);
    stopwatch.stop();
    log.info("解密过程执行时间{}s", stopwatch.elapsed(TimeUnit.SECONDS));
    filterChain.doFilter(requestWrapper, response);
  }
}
