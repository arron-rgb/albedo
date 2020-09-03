package com.albedo.java.modules.biz.service.task;

import org.springframework.context.ApplicationEvent;

/**
 * @author arronshentu
 */
public class VideoTask extends ApplicationEvent {

  private String filePath;
  private String orderId;

  public VideoTask(Object source) {
    super(source);
  }

  public String getFilePath() {
    return filePath;
  }

  public void setFilePath(String filePath) {
    this.filePath = filePath;
  }

  public String getOrderId() {
    return orderId;
  }

  public void setOrderId(String orderId) {
    this.orderId = orderId;
  }

  public VideoTask(Object source, String filePath, String orderId) {
    super(source);
    this.filePath = filePath;
    this.orderId = orderId;
  }
}
