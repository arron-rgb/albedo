package com.albedo.java.common.config;

import java.text.SimpleDateFormat;
import java.time.ZoneId;
import java.util.Locale;
import java.util.TimeZone;

import org.springframework.boot.autoconfigure.AutoConfigureBefore;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.jackson.JacksonAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;

import com.albedo.java.common.core.jackson.JavaTimeModule;
import com.albedo.java.common.core.util.DateUtil;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.json.JsonReadFeature;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jdk8.Jdk8Module;

/**
 * @author somewhere
 * @description
 * @date 2020/5/30 11:25 下午
 */
@Configuration
@ConditionalOnClass(ObjectMapper.class)
@AutoConfigureBefore(JacksonAutoConfiguration.class)
public class JacksonMapperConfiguration {

  @Primary
  @Bean
  public ObjectMapper myObjectMapper(Jackson2ObjectMapperBuilder builder) {
    builder.simpleDateFormat(DateUtil.TIME_FORMAT);
    ObjectMapper objectMapper = builder.createXmlMapper(false).modules(new CustomFieldModule()).build();
    // 设置地点为中国
    objectMapper.setLocale(Locale.CHINA);
    // 去掉默认的时间戳格式
    objectMapper.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false);
    // 设置为中国上海时区
    objectMapper.setTimeZone(TimeZone.getTimeZone(ZoneId.systemDefault()));
    // 序列化时，日期的统一格式
    objectMapper.setDateFormat(new SimpleDateFormat(DateUtil.TIME_FORMAT, Locale.CHINA));
    // 序列化处理
    objectMapper.configure(JsonReadFeature.ALLOW_UNESCAPED_CONTROL_CHARS.mappedFeature(), true);
    objectMapper.configure(JsonReadFeature.ALLOW_BACKSLASH_ESCAPING_ANY_CHARACTER.mappedFeature(), true);
    objectMapper.findAndRegisterModules();
    // 失败处理
    objectMapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
    objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    // 单引号处理
    objectMapper.configure(JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
    // 反序列化时，属性不存在的兼容处理s
    objectMapper.getDeserializationConfig().withoutFeatures(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
    // 日期格式化
    objectMapper.registerModule(new JavaTimeModule()).registerModule(new Jdk8Module());
    objectMapper.findAndRegisterModules();
    return objectMapper;
  }

}
