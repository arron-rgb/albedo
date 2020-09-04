package com.albedo.java.common.core.exception;

import lombok.AllArgsConstructor;

/**
 * @author arronshentu
 */
@AllArgsConstructor
public class OrderException extends Exception {

  private static final long serialVersionUID = -7285211528095468156L;

  public OrderException(String msg) {
    super(msg);
  }

}
