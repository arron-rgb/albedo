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
@AllArgsConstructor
@ToString
@Builder
public class PlusService {

  private List<Element<Config>> data = new ArrayList<>();
  private PlusService plusService;

  public void addList(List<Config> data, String title) {
    if (CollectionUtils.isNotEmpty(data)) {
      if (this.data == null) {
        this.data = new ArrayList<>();
      }
      Element<Config> element = new Element<>();
      element.setTitle(title);
      element.setData(data);
      this.data.add(element);
    }
  }

}
