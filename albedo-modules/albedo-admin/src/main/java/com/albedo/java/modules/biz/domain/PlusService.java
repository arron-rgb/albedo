package com.albedo.java.modules.biz.domain;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import lombok.*;

/**
 * @author arronshentu
 */
@Data
@EqualsAndHashCode
@NoArgsConstructor
@ToString
@Builder
public class PlusService {
  public static final List<String> PLUS_NAMES = new ArrayList<>(Arrays.asList("component, colorStyle", "hairstyle", "clothes", "clothesColor", "plusService");));

  public static final String[] ELEMENT_NAMES = new String[] {"label", "anchorNum", "seat", "anchorType", "style"};

  private List<Config> label;
  private List<Config> anchorNum;
  private List<Config> seat;
  private List<Config> anchorType;
  private List<Config> style;
  private PlusService plusService;

  public void set(String name, List<Config> value) {
    if (PLUS_NAMES.contains(name)) {
      if (plusService == null) {
        plusService = new PlusService();
      }
      return;
    }

    switch (name) {
      case "label":
        this.label = value;
        break;
      case "anchorNum":
        this.anchorNum = value;
        break;
      case "seat":
        this.seat = value;
        break;
      case "anchorType":
        this.style = value;
        break;
      default:
        break;
    }
  }

}
