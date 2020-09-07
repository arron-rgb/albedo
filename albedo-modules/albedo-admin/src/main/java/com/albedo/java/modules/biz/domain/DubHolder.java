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
@Builder
public class DubHolder {

  private List<Element> data = new ArrayList<>();

  public void addList(List<Dub> data, String title) {
    if (CollectionUtils.isNotEmpty(data)) {
      if (this.data == null) {
        this.data = new ArrayList<>();
      }
      this.data.add(Element.builder().title(title).data(data).build());
    }
  }

  @Data
  @EqualsAndHashCode
  @NoArgsConstructor
  @AllArgsConstructor
  @Builder
  public static class Element {
    String title;
    List<Dub> data;
  }
}
