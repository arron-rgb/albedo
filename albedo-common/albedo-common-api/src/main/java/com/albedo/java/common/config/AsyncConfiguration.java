package com.albedo.java.common.config;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.Executor;
import java.util.concurrent.PriorityBlockingQueue;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.interceptor.AsyncUncaughtExceptionHandler;
import org.springframework.boot.autoconfigure.task.TaskExecutionProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.AsyncConfigurer;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import com.albedo.java.common.async.ExceptionHandlingAsyncTaskExecutor;
import com.albedo.java.common.core.util.Json;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:06
 */
@Configuration
@EnableAsync
public class AsyncConfiguration implements AsyncConfigurer {

  private final Logger log = LoggerFactory.getLogger(AsyncConfiguration.class);

  private final TaskExecutionProperties taskExecutionProperties;

  public AsyncConfiguration(TaskExecutionProperties taskExecutionProperties) {
    this.taskExecutionProperties = taskExecutionProperties;
  }

  @Override
  @Bean(name = "taskExecutor")
  public Executor getAsyncExecutor() {
    log.debug("Creating Async Task Executor");
    ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor() {
      @Override
      protected BlockingQueue<Runnable> createQueue(int queueCapacity) {
        return new PriorityBlockingQueue<>(queueCapacity);
      }
    };
    executor.setCorePoolSize(taskExecutionProperties.getPool().getCoreSize());
    executor.setMaxPoolSize(taskExecutionProperties.getPool().getMaxSize());
    executor.setQueueCapacity(taskExecutionProperties.getPool().getQueueCapacity());
    executor.setThreadNamePrefix(taskExecutionProperties.getThreadNamePrefix());
    return new ExceptionHandlingAsyncTaskExecutor(executor);
  }

  @Override
  public AsyncUncaughtExceptionHandler getAsyncUncaughtExceptionHandler() {
    return (ex, method, params) -> {
      log.error("Message: {}", ex.getMessage());
      log.error("Method: {}", method);
      log.error("Params: {}", Json.toJsonString(params));
    };
  }
}
