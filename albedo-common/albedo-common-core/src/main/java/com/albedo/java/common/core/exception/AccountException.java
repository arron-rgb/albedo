package com.albedo.java.common.core.exception;

import lombok.Getter;
import lombok.Setter;

/**
 * @author arronshentu
 */

public class AccountException extends RuntimeException {

  @Getter
  @Setter
  private String msg;

  public AccountException() {
    super();
  }

  public AccountException(String msg) {
    super(msg);
    this.msg = msg;
  }
}
