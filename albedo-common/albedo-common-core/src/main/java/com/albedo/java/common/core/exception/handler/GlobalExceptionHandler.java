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

package com.albedo.java.common.core.exception.handler;

import static org.springframework.http.HttpStatus.BAD_REQUEST;
import static org.springframework.http.HttpStatus.NOT_FOUND;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.validation.BindException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.albedo.java.common.core.exception.*;
import com.albedo.java.common.core.util.BeanValidators;
import com.albedo.java.common.core.util.ResponseEntityBuilder;
import com.albedo.java.common.core.util.Result;

import cn.hutool.core.exceptions.ExceptionUtil;
import cn.hutool.core.util.ArrayUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * @author somewhere
 * @date 2019/2/1
 *       全局的的异常处理器
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {
  /**
   * 全局异常.
   *
   * @param e
   *          the e
   * @return R
   */
  @ExceptionHandler(Exception.class)
  @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
  public Result<String> exception(Exception e) {
    log.error("全局异常信息 ex={}", e.getMessage());
    e.printStackTrace();
    return Result.buildFail("未知错误");
  }

  /**
   * validation Exception
   *
   * @param exception
   * @return R
   */
  @ExceptionHandler({AccessDeniedException.class})
  @ResponseStatus(HttpStatus.FORBIDDEN)
  public Result bodyValidExceptionHandler(AccessDeniedException exception) {
    log.warn("AccessDeniedException:{}", exception.getMessage());
    return Result.buildFail("权限不足");
  }

  /**
   * validation Exception
   *
   * @param exception
   * @return R
   */
  @ExceptionHandler({MethodArgumentNotValidException.class, BindException.class})
  @ResponseStatus(BAD_REQUEST)
  public Result bodyValidExceptionHandler(MethodArgumentNotValidException exception) {
    List<String> messages = BeanValidators.extractPropertyAndMessageAsList(exception);
    log.warn("Valid Error:" + messages);
    return Result.buildFail(ArrayUtil.toArray(messages, String.class));
  }

  /**
   * RuntimeMsgException
   *
   * @param exception
   * @return R
   */
  @ExceptionHandler({RuntimeMsgException.class})
  public Result bodyRuntimeMsgExceptionHandler(RuntimeMsgException exception) {
    return Result.buildFail(exception.getMessage());
  }

  /**
   * 处理 badException
   */
  @ExceptionHandler(value = {BadRequestException.class, EntityExistException.class})
  public ResponseEntity<Result> badException(Exception e) {
    // 打印堆栈信息
    log.error(ExceptionUtil.stacktraceToString(e));
    return ResponseEntityBuilder.buildFail(BAD_REQUEST, e.getMessage());
  }

  /**
   * 处理 EntityNotFound
   */
  @ExceptionHandler(value = EntityNotFoundException.class)
  public ResponseEntity<Result> entityNotFoundException(EntityNotFoundException e) {
    // 打印堆栈信息
    log.error(ExceptionUtil.stacktraceToString(e));
    return ResponseEntityBuilder.buildFail(NOT_FOUND, e.getMessage());
  }

  @ExceptionHandler(value = {TimesOverspendException.class, OrderException.class, AccountException.class,
    TokenException.class, TokenException.class})
  public Result<String> overspendException(Exception e) {
    return Result.buildFail(e.getMessage());
  }

  @ExceptionHandler(value = UsernameNotFoundException.class)
  public Result<String> usernameException(UsernameNotFoundException e) {
    return Result.buildFail("系统中未查询到该用户");
  }

  @ExceptionHandler(value = MissingServletRequestParameterException.class)
  public Result<String> missingServletRequestParameterException(MissingServletRequestParameterException e) {
    return Result.buildFail("请求缺少参数");
  }

  @ExceptionHandler(value = IllegalArgumentException.class)
  public Result<String> illegalArgumentException(IllegalArgumentException e) {
    String message = e.getMessage();
    return Result.buildFail(message);
  }

}
