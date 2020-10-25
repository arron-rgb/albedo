/**
 * Copyright &copy; 2020 <a href="https://github.com/somowhere/albedo">albedo</a> All rights reserved.
 */
package com.albedo.java.modules.biz.repository;

import org.springframework.stereotype.Repository;

import com.albedo.java.common.persistence.repository.BaseRepository;
import com.albedo.java.modules.biz.domain.Invoice;

/**
 * 发票抬头管理Repository 发票抬头
 *
 * @author arronshentu
 * @version 2020-08-16 16:19:02
 */
@Repository
public interface InvoiceRepository extends BaseRepository<Invoice> {

}
