package com.albedo.java.common.config;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.EnumSet;

import javax.servlet.DispatcherType;
import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.web.embedded.undertow.UndertowServletWebServerFactory;
import org.springframework.boot.web.server.MimeMappings;
import org.springframework.boot.web.server.WebServerFactory;
import org.springframework.boot.web.server.WebServerFactoryCustomizer;
import org.springframework.boot.web.servlet.ServletContextInitializer;
import org.springframework.boot.web.servlet.server.ConfigurableServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.env.Environment;
import org.springframework.http.MediaType;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.albedo.java.common.core.config.ApplicationConfig;
import com.albedo.java.common.core.config.ApplicationProperties;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.DefaultProfileUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.security.filter.CachingHttpHeadersFilter;

import cn.hutool.core.util.ArrayUtil;
import io.undertow.UndertowOptions;
import lombok.AllArgsConstructor;

/**
 * Configuration of web application with Servlet 3.0 APIs.
 *
 * @author somewhere
 */
@Configuration
@AllArgsConstructor
public class WebConfigurer
  implements ServletContextInitializer, WebServerFactoryCustomizer<WebServerFactory>, WebMvcConfigurer {

  private final Logger log = LoggerFactory.getLogger(WebConfigurer.class);

  private final Environment env;

  private final ApplicationProperties applicationProperties;

  @Override
  public void onStartup(ServletContext servletContext) {
    if (env.getActiveProfiles().length != 0) {
      log.info("Web application configuration, using profiles: {}", Arrays.toString(env.getActiveProfiles()));
    }
    EnumSet<DispatcherType> disps = EnumSet.of(DispatcherType.REQUEST, DispatcherType.FORWARD, DispatcherType.ASYNC);
    if (ArrayUtil.contains(env.getActiveProfiles(), CommonConstants.SPRING_PROFILE_PRODUCTION)) {
      initCachingHttpHeadersFilter(servletContext, disps);
    }
    log.info("Web application fully configured");
  }

  /**
   * Customize the Servlet engine: Mime types, the document root, the cache.
   */
  @Override
  public void customize(WebServerFactory server) {
    setMimeMappings(server);
    setLocationForStaticAssets(server);

    if (applicationProperties.getHttp().getVersion().equals(ApplicationProperties.Http.Version.V_2_0)
      && server instanceof UndertowServletWebServerFactory) {
      ((UndertowServletWebServerFactory)server)
        .addBuilderCustomizers(builder -> builder.setServerOption(UndertowOptions.ENABLE_HTTP2, true));
    }

  }

  private void setMimeMappings(WebServerFactory server) {
    if (server instanceof ConfigurableServletWebServerFactory) {
      MimeMappings mappings = new MimeMappings(MimeMappings.DEFAULT);
      mappings.add("html", MediaType.TEXT_HTML_VALUE + ";charset=" + StandardCharsets.UTF_8.name().toLowerCase());
      mappings.add("json", MediaType.TEXT_HTML_VALUE + ";charset=" + StandardCharsets.UTF_8.name().toLowerCase());
      ConfigurableServletWebServerFactory servletWebServer = (ConfigurableServletWebServerFactory)server;
      servletWebServer.setMimeMappings(mappings);
    }
  }

  private void setLocationForStaticAssets(WebServerFactory server) {
    log.info("server:" + server);
    if (server instanceof ConfigurableServletWebServerFactory) {
      ConfigurableServletWebServerFactory servletWebServer = (ConfigurableServletWebServerFactory)server;
      File root;
      String prefixPath = env.getProperty(DefaultProfileUtil.SPRING_WEB_ROOT_PREFIX);
      if (StringUtil.isEmpty(prefixPath)) {
        prefixPath = DefaultProfileUtil.resolvePathPrefix(this.getClass()) + "src/main/webapp/";
      }
      log.info("web root:" + prefixPath);
      root = new File(prefixPath);
      if (root.exists() && root.isDirectory()) {
        servletWebServer.setDocumentRoot(root);
      }
    }
  }

  /**
   * Initializes the caching HTTP Headers Filter.
   */
  private void initCachingHttpHeadersFilter(ServletContext servletContext, EnumSet<DispatcherType> disps) {
    log.debug("Registering Caching HTTP Headers Filter");
    FilterRegistration.Dynamic cachingHttpHeadersFilter =
      servletContext.addFilter("cachingHttpHeadersFilter", new CachingHttpHeadersFilter(applicationProperties));
    cachingHttpHeadersFilter.addMappingForUrlPatterns(disps, true, "/statics/*", "/WEB-INF/views/*");
    cachingHttpHeadersFilter.setAsyncSupported(true);

  }

  @Bean
  public CorsFilter corsFilter() {
    UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
    CorsConfiguration config = applicationProperties.getCors();
    if (config.getAllowedOrigins() != null && !config.getAllowedOrigins().isEmpty()) {
      log.debug("Registering CORS filter");
      source.registerCorsConfiguration("/management/**", config);
      source.registerCorsConfiguration("/v2/api-docs", config);
    }
    return new CorsFilter(source);
  }

  @Override
  public void addResourceHandlers(ResourceHandlerRegistry registry) {
    String pathUtl = "file:" + ApplicationConfig.getUploadPath().replace("\\", "/");
    registry.addResourceHandler(applicationProperties.getAdminPath("/asset-file/**")).addResourceLocations(pathUtl)
      .setCachePeriod(0);
  }

  @Override
  public void addViewControllers(ViewControllerRegistry registry) {
    registry.addViewController(StringUtil.SLASH).setViewName(StringUtil.isEmpty(applicationProperties.getDefaultView())
      ? "index.html" : applicationProperties.getDefaultView());
    registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
  }

}
