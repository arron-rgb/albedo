package com.albedo.java.modules.biz.domain;

import java.util.ArrayList;
import java.util.Arrays;
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
  public static final List<String> PLUS_NAMES =
    new ArrayList<>(Arrays.asList("component, colorStyle", "hairstyle", "clothes", "clothesColor", "plusService"));

  public static final String[] ELEMENT_NAMES = new String[] {"label", "anchorNum", "seat", "anchorType", "style"};

  private List<Element> data = new ArrayList<>();
  private PlusService plusService;

  public void addList(List<Config> data, String title) {
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
    List<Config> data;
  }
}
