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

package com.albedo.java.common.config;

import java.util.Properties;

import org.apache.ibatis.mapping.DatabaseIdProvider;
import org.apache.ibatis.mapping.VendorDatabaseIdProvider;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.AuditorAware;

import com.albedo.java.common.persistence.datascope.DataScopeInterceptor;
import com.albedo.java.common.persistence.handler.EntityMetaObjectHandler;
import com.baomidou.mybatisplus.extension.plugins.OptimisticLockerInterceptor;
import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;

/**
 * @author somewhere
 * @date 2019/06/05
 */
@Configuration
@MapperScan("com.albedo.java.modules.*.repository")
public class MybatisPlusConfigurer {
  /**
   * 分页插件
   *
   * @return PaginationInterceptor
   */
  @Bean
  public PaginationInterceptor paginationInterceptor() {
    return new PaginationInterceptor();
  }

  /**
   * 数据权限插件
   *
   * @return DataScopeInterceptor
   */
  @Bean
  public DataScopeInterceptor dataScopeInterceptor() {
    return new DataScopeInterceptor();
  }

  /**
   * 新增，修改 公共字段填充
   *
   * @return
   */
  @Bean
  public EntityMetaObjectHandler entityMetaObjectHandler(AuditorAware auditorAware) {
    return new EntityMetaObjectHandler(auditorAware);
  }

  /**
   * 乐观锁拦截器 version
   *
   * @return
   */
  @Bean
  public OptimisticLockerInterceptor optimisticLockerInterceptor() {
    return new OptimisticLockerInterceptor();
  }

  @Bean
  public DatabaseIdProvider getDatabaseIdProvider() {
    DatabaseIdProvider databaseIdProvider = new VendorDatabaseIdProvider();
    Properties p = new Properties();
    p.setProperty("Oracle", "oracle");
    p.setProperty("MySQL", "mysql");
    databaseIdProvider.setProperties(p);
    return databaseIdProvider;
  }

}
