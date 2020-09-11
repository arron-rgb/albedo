package com.albedo.java.modules.biz.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.scheduling.annotation.EnableAsync;

import com.albedo.java.modules.biz.service.task.VideoTaskExecutor;

import lombok.AllArgsConstructor;

/**
 * @author arronshentu
 */

@EnableAsync
@Configuration
@AllArgsConstructor
@EnableAspectJAutoProxy
public class ExecutorConfiguration {

  @Bean
  public VideoTaskExecutor videoTaskExecutor() {
    return new VideoTaskExecutor();
  }

}
