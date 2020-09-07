package com.albedo.java.modules.biz.domain;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections4.CollectionUtils;

import lombok.*;

/**
 * @author arronshentu
 */
@Data
@EqualsAndHashCode
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class Holder<T> {
  private List<Element<T>> data;

  public void addList(List<T> data, String title) {
    if (CollectionUtils.isNotEmpty(data)) {
      if (this.data == null) {
        this.data = new ArrayList<>();
      }
      Element<T> element = new Element<T>();
      element.setData(data);
      element.setTitle(title);
      this.data.add(element);
    }
  }

}
