package com.albedo.java.common.core.constant;

/**
 * @author somewhere
 * @date 2019/2/1
 */
public interface CommonConstants {

  String ok = "OK";
  int CAPTCHA_EXPIRES_TIME = 300;

  String PERSONAL_USER_ROLE_ID = "904a870be22c6b84845dbd1699655b4a";
  String BUSINESS_COMMON_ROLE_ID = "49dbe45a4e2a06a56730851e0c87f166";
  String BUSINESS_ADMIN_ROLE_ID = "cdff3f167ae3dfc7984cd6e36976ddf8";
  String PUBLIC_DEPT_ID = "4d20ae207d9c836a732480429af58273";
  /**
   * 后台用户默认部门
   */
  String ADMIN_DEPT_ID = "c095173c3aebcd7ff9c6177fbf7a8b69";
  String ADMIN_ROLE_ID = "3570f348af7214a976e5d6bfbdd97df1";

  /**
   * 编码
   */
  String UTF8 = "UTF-8";

  /**
   * JSON 资源
   */
  String CONTENT_TYPE = "application/json; charset=utf-8";

  /**
   * 前端工程名
   */
  String FRONT_END_PROJECT = "albedo-ui";

  /**
   * 后端工程名
   */
  String BACK_END_PROJECT = "albedo";

  /**
   * 成功标记
   */
  Integer SUCCESS = 1;
  /**
   * 失败标记
   */
  Integer FAIL = 0;

  /**
   * 成功标记
   */
  String STR_SUCCESS = "1";
  /**
   * 失败标记
   */
  String STR_FAIL = "0";

  /**
   *
   */
  String SWAGGER_API_URI = "/v2/api-docs";

  String SPRING_PROFILE_TEST = "test";
  String SPRING_PROFILE_DEVELOPMENT = "dev";
  String SPRING_PROFILE_APP = "app";
  String SPRING_PROFILE_PRODUCTION = "prod";
  String SPRING_PROFILE_JWT = "jwt";
  String SPRING_PROFILE_SWAGGER = "swagger";

  Integer ZERO = 0;

  String SYSTEM_TRUE = "true";
  String SYSTEM_FALSE = "false";
  Integer YES = 1;
  Integer NO = ZERO;
  String STR_YES = "1";
  String STR_NO = "0";

  String TYPE_STRING = "String";
  String TYPE_INTEGER = "Integer";
  String TYPE_INT = "int";
  String TYPE_LONG = "Long";
  String TYPE_SHORT = "Short";
  String TYPE_FLOAT = "Float";
  String TYPE_DOUBLE = "Double";
  String TYPE_DATE = "Date";

  String CONDITION_EQ = "eq";
  String CONDITION_SQL_EQ = "=";
  String CONDITION_NE = "ne";
  String CONDITION_SQL_NE = "!=";
  String CONDITION_BETWEEN = "between";
  String CONDITION_IN = "in";
  String CONDITION_NOTIN = "not in";
  String CONDITION_EXIST = "exist";
  String CONDITION_NOTEXIST = "notexist";
  String CONDITION_GE = "ge";
  String CONDITION_SQL_GE = ">=";
  String CONDITION_GT = "gt";
  String CONDITION_SQL_GT = ">";
  String CONDITION_LE = "le";
  String CONDITION_SQL_LE = "<=";
  String CONDITION_LT = "lt";
  String CONDITION_SQL_LT = "<";
  String CONDITION_LIKE = "like";
  String CONDITION_ILIKE = "ilike";
  String CONDITION_QUERY = "query";
  String CONDITION_EQPROPERTY = "eqproperty";
  String CONDITION_NEPROPERTY = "neproperty";
  String CONDITION_GEPROPERTY = "geproperty";
  String CONDITION_GTPROPERTY = "gtproperty";
  String CONDITION_LEPROPERTY = "leproperty";
  String CONDITION_LTPROPERTY = "ltproperty";
  String CONDITION_OR = "or";
  String CONDITION_AND = "and";
  String SORT_DESC = "desc";
  String SORT_ASC = "asc";
  String SPACE = " ";

  String ID_REGEX = "^[_',.@A-Za-z0-9-]*$";

  String URL_IDS_REGEX = "/{ids:^[_',.@A-Za-z0-9-]*$}";
  String URL_ID_REGEX = "/{id:^[_',.@A-Za-z0-9-]*$}";
  String SYSTEM = "system";

  String BASIC_ = "Basic ";
  String UNKNOWN = "unknown";

  String MYSQL_QUOTE = "`";
  String ORACLE_QUOTE = "\"";

  /**
   * 默认生成图形验证码宽度
   */
  String DEFAULT_IMAGE_WIDTH = "100";

  /**
   * 默认生成图像验证码高度
   */
  String DEFAULT_IMAGE_HEIGHT = "40";

  /**
   * 默认生成图形验证码长度
   */
  String DEFAULT_IMAGE_LENGTH = "4";

  /**
   * 默认生成图形验证码过期时间
   */
  int DEFAULT_IMAGE_EXPIRE = 60;
  /**
   * 边框颜色，合法值： r,g,b (and optional alpha) 或者 white,black,blue.
   */
  String DEFAULT_COLOR_FONT = "black";

  /**
   * 图片边框
   */
  String DEFAULT_IMAGE_BORDER = "no";
  /**
   * 默认图片间隔
   */
  String DEFAULT_CHAR_SPACE = "5";

  /**
   * 默认保存code的前缀
   */
  String DEFAULT_CODE_KEY = "DEFAULT_CODE_KEY_";

  /**
   * 通过旧邮箱重置邮箱
   */
  String EMAIL_RESET_EMAIL_CODE = "EMAIL_RESET_EMAIL_CODE_";
  /**
   * 通过邮箱重置密码
   */
  String EMAIL_RESET_PWD_CODE = "EMAIL_RESET_PWD_CODE_";

  /**
   * 默认保存登录的前缀
   */
  String DEFAULT_LOGIN_KEY = "DEFAULT_LOGIN_KEY";
  /**
   * 默认保存登录的前缀
   */
  String DEFAULT_LOGIN_JWT_KEY = "DEFAULT_LOGIN_JWT_KEY";
  String DEFAULT_LOGIN_JWT_MAP_KEY = "DEFAULT_LOGIN_JWT_MAP_KEY";
  /**
   * 默认保存24小时后登录的前缀
   */
  String DEFAULT_LOGIN_AFTER_24_KEY = "DEFAULT_LOGIN_AFTER_24_KEY";
  /**
   * 验证码文字大小
   */
  String DEFAULT_IMAGE_FONT_SIZE = "30";

  String ANONYMOUS_USER = "anonymoususer";
}
