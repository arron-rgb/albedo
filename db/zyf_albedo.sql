/*
 Navicat Premium Data Transfer

 Source Server         : 本地mysql
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : albedo

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 12/08/2020 16:00:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dept
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept`
(
    `id`                 varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `parent_id`          varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL,
    `parent_ids`         varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL,
    `name`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci        NOT NULL,
    `created_date`       timestamp(3)                                                  NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci        NULL DEFAULT NULL,
    `last_modified_date` timestamp(3)                                                  NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL COMMENT '描述',
    `version`            int(0)                                                        NOT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin             NULL DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gen_scheme
-- ----------------------------
DROP TABLE IF EXISTS `gen_scheme`;
CREATE TABLE `gen_scheme`
(
    `id`                   varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL COMMENT '编号',
    `name`                 varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '名称',
    `category`             varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL     DEFAULT NULL COMMENT '分类',
    `view_type`            char(2) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL     DEFAULT NULL COMMENT '视图类型 0  普通表格 1  表格采用ajax刷新',
    `package_name`         varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '生成包路径',
    `module_name`          varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL     DEFAULT NULL COMMENT '生成模块名',
    `sub_module_name`      varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL     DEFAULT NULL COMMENT '生成子模块名',
    `function_name`        varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '生成功能名',
    `function_name_simple` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '生成功能名（简写）',
    `function_author`      varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '生成功能作者',
    `gen_table_id`         varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '生成表编号',
    `version`              int(0)                                                   NULL     DEFAULT 0 COMMENT '默认0，必填，离线乐观锁',
    `description`          varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '描述',
    `created_by`           varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL,
    `created_date`         timestamp(3)                                             NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    `last_modified_by`     varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL     DEFAULT NULL,
    `last_modified_date`   timestamp(3)                                             NULL     DEFAULT NULL,
    `del_flag`             char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin        NULL     DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '生成方案'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_scheme
-- ----------------------------
INSERT INTO `gen_scheme`
VALUES ('01f1d49348ef63a0558f439ca090d412', '视频', 'curd', NULL, 'com.albedo.java.modules', 't', NULL, '视频管理', 't_video',
        'admin', '201a2bb8de59d0e0c2a9743f60f6ec11', 1, NULL, '1', '2020-08-12 15:41:01.682', '1',
        '2020-08-12 15:59:38.274', '0');
INSERT INTO `gen_scheme`
VALUES ('1ce52b5152e6573af29889040a859bc2', '发票历史', 'curd', NULL, 'com.albedo.java.modules', 't', NULL, '查看发票申请历史',
        't_invoice_history', 'admin', '31b4af23fe3bd30452e7a8b4c367034a', 0, NULL, '1', '2020-08-12 11:02:01.714', '1',
        '2020-08-12 11:02:01.714', '0');
INSERT INTO `gen_scheme`
VALUES ('3e5ff5f38622f2169fe0e29cfd5fe1be', '短信管理', 'curd', NULL, 'com.albedo.java.modules', 'sys', NULL, '管理短信',
        'sys_sms', 'admin', 'ff7056ae6be7d5994b8d870549fc1c6a', 0, NULL, '1', '2020-08-12 15:46:27.838', '1',
        '2020-08-12 15:46:27.838', '0');
INSERT INTO `gen_scheme`
VALUES ('8710dca982407997268fd52546029e42', '前端内容控制', 'curd', NULL, 'com.albedo.java.modules', 't', NULL, '控制前端页面内容',
        't_front', 'admin', '7dbc0aa32d25dbffcba0ff2940842b1c', 1, NULL, '1', '2020-08-12 10:24:39.693', '1',
        '2020-08-12 10:47:45.892', '0');
INSERT INTO `gen_scheme`
VALUES ('8add8646b2599ccfebacd90d8e9a2096', '商品管理', 'curd', NULL, 'com.albedo.java.modules', 't', NULL, '商品管理',
        't_goods', 'admin', '303003236467e4dc970d8eed90e565eb', 1, NULL, '1', '2020-08-12 15:54:10.554', '1',
        '2020-08-12 15:55:52.314', '0');
INSERT INTO `gen_scheme`
VALUES ('b3855dabaff80c57bbd7c3139e82dc4d', '订单', 'curd', NULL, 'com.albedo.java.modules', 't', NULL, '订单管理', 't_order',
        'admin', '5419e930e63aecec3b0266776cca0fbf', 0, NULL, '1', '2020-08-12 15:36:12.723', '1',
        '2020-08-12 15:36:12.723', '0');
INSERT INTO `gen_scheme`
VALUES ('ef1398de9f8aa2803fe374b44200a381', '发票抬头管理', 'curd', NULL, 'com.albedo.java.modules', 't', NULL, '管理发票抬头',
        't_invoice', 'admin', '0291c0ba2aeb9b7e290a5d73f3751189', 1, NULL, '1', '2020-08-12 11:01:11.057', '1',
        '2020-08-12 11:17:40.406', '0');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `t_order_form`
(

#     1. labels: []
#        2. user_id
#        3. anchor_num
#        4. seat: 0:standing, 1:sitting
#        5. anchor_type: 活力青春、成熟稳重...
#        6. studio_style
#        7. plus_service:[{src:, color:}]
    `id`                 varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL COMMENT '编号',
    `labels`             text CHARACTER SET utf8 COLLATE utf8_general_ci         NOT NULL COMMENT '标签文本',
    `user_id`            varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL     DEFAULT NULL,
    `anchor_num`         varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL     DEFAULT NULL COMMENT '是否站立，0站1坐',
    `seat`               varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '活力青春',
    `anchor_type`        varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '直播间风格',
    `plus_service`       varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL     DEFAULT NULL COMMENT '实体类名称',
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL     DEFAULT NULL COMMENT '描述',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL,
    `created_date`       timestamp(3)                                            NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL,
    `last_modified_date` timestamp(3)                                            NULL     DEFAULT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin       NULL     DEFAULT '0' COMMENT '0-正常，1-删除'

) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '表单temp'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table`
VALUES ('0291c0ba2aeb9b7e290a5d73f3751189', 't_invoice', 't_invoice', NULL, NULL, 'TInvoice', NULL, NULL, 0, NULL, '1',
        '2020-08-12 11:17:26.565', '1', '2020-08-12 11:17:26.565', '0');
INSERT INTO `gen_table`
VALUES ('0788ece2109b1485ab5d53f7fa14f9ab', 't_invoice', 't_invoice', NULL, NULL, 'TInvoice', NULL, NULL, 0, NULL, '1',
        '2020-08-12 10:46:17.973', '1', '2020-08-12 10:46:11.272', '1');
INSERT INTO `gen_table`
VALUES ('201a2bb8de59d0e0c2a9743f60f6ec11', 't_video', 't_video', NULL, NULL, 'TVideo', NULL, NULL, 0, NULL, '1',
        '2020-08-12 15:59:25.200', '1', '2020-08-12 15:59:25.200', '0');
INSERT INTO `gen_table`
VALUES ('303003236467e4dc970d8eed90e565eb', 't_goods', 't_goods', NULL, NULL, 'TGoods', NULL, NULL, 0, NULL, '1',
        '2020-08-12 15:55:39.461', '1', '2020-08-12 15:55:39.461', '0');
INSERT INTO `gen_table`
VALUES ('31b4af23fe3bd30452e7a8b4c367034a', 't_invoice_history', 't_invoice_history', NULL, NULL, 'TInvoiceHistory',
        NULL, NULL, 0, NULL, '1', '2020-08-12 10:46:39.613', '1', '2020-08-12 10:46:39.613', '0');
INSERT INTO `gen_table`
VALUES ('5419e930e63aecec3b0266776cca0fbf', 't_order', 't_order', NULL, NULL, 'TOrder', NULL, NULL, 0, NULL, '1',
        '2020-08-12 15:35:16.428', '1', '2020-08-12 15:35:16.428', '0');
INSERT INTO `gen_table`
VALUES ('6ecc39110e24a46af9df21ae5c725155', 't_invoice', 't_invoice', NULL, NULL, 'TInvoice', NULL, NULL, 0, NULL, '1',
        '2020-08-12 11:17:04.935', '1', '2020-08-12 10:46:11.475', '1');
INSERT INTO `gen_table`
VALUES ('7dbc0aa32d25dbffcba0ff2940842b1c', 't_front', 't_front', NULL, NULL, 'TFront', NULL, NULL, 0, NULL, '1',
        '2020-08-12 10:23:42.159', '1', '2020-08-12 10:23:42.159', '0');
INSERT INTO `gen_table`
VALUES ('8012923c1e3bdf0ed8c3071a32d32685', 't_video', 't_video', NULL, NULL, 'TVideo', NULL, NULL, 0, NULL, '1',
        '2020-08-12 15:59:12.757', '1', '2020-08-12 15:40:26.686', '1');
INSERT INTO `gen_table`
VALUES ('e51850e0e9e0444fb581fb6bf65dd11e', 't_goods', 't_goods', NULL, NULL, 'TGoods', NULL, NULL, 0, NULL, '1',
        '2020-08-12 15:55:21.169', '1', '2020-08-12 15:53:36.799', '1');
INSERT INTO `gen_table`
VALUES ('ff7056ae6be7d5994b8d870549fc1c6a', 'sys_sms', 'sys_sms', NULL, NULL, 'SysSms', NULL, NULL, 0, NULL, '1',
        '2020-08-12 15:45:52.519', '1', '2020-08-12 15:45:52.519', '0');

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`
(
    `id`                 varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL COMMENT '编号',
    `gen_table_id`       varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL     DEFAULT NULL COMMENT '归属表编号',
    `name`               varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '名称',
    `title`              varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL COMMENT '标题',
    `comments`           varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '描述备注',
    `jdbc_type`          varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '列的数据类型的字节长度',
    `java_type`          varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT 'JAVA类型',
    `java_field`         varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT 'JAVA字段名',
    `is_pk`              bit(1)                                                   NULL     DEFAULT NULL COMMENT '是否主键',
    `is_unique`          bit(1)                                                   NULL     DEFAULT NULL COMMENT '是否唯一（1：是；0：否）',
    `is_null`            bit(1)                                                   NULL     DEFAULT NULL COMMENT '是否可为空',
    `is_insert`          bit(1)                                                   NULL     DEFAULT NULL COMMENT '是否为插入字段',
    `is_edit`            bit(1)                                                   NULL     DEFAULT NULL COMMENT '是否编辑字段',
    `is_list`            bit(1)                                                   NULL     DEFAULT NULL COMMENT '是否列表字段',
    `is_query`           bit(1)                                                   NULL     DEFAULT NULL COMMENT '是否查询字段',
    `query_type`         varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
    `show_type`          varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
    `dict_type`          varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '字典类型',
    `settings`           varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL     DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
    `sort`               decimal(10, 0)                                           NULL     DEFAULT NULL COMMENT '排序（升序）',
    `version`            int(0)                                                   NULL     DEFAULT 0 COMMENT '默认0，必填，离线乐观锁',
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '描述',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL,
    `created_date`       timestamp(3)                                             NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL     DEFAULT NULL,
    `last_modified_date` timestamp(3)                                             NULL     DEFAULT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin        NULL     DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `gen_table_column_table_id` (`gen_table_id`) USING BTREE,
    INDEX `gen_table_column_name` (`name`) USING BTREE,
    INDEX `gen_table_column_sort` (`sort`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '业务表字段'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column`
VALUES ('05ad07b258d00421cf76174f9b82a14a', '0788ece2109b1485ab5d53f7fa14f9ab', 'type', '0-个人，1-企业', NULL, 'varchar(1)',
        'String', 'type', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 20, 0, NULL, '1',
        '2020-08-12 10:46:17.982', '1', '2020-08-12 10:46:11.299', '1');
INSERT INTO `gen_table_column`
VALUES ('05d2e5a0d317b259c5825c2f392745d3', '7dbc0aa32d25dbffcba0ff2940842b1c', 'last_modified_by', 'last_modified_by',
        NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '',
        NULL, 70, 0, NULL, '1', '2020-08-12 10:23:42.181', '1', '2020-08-12 10:23:42.181', '0');
INSERT INTO `gen_table_column`
VALUES ('062d133992dd03336de94880cfc8c787', '7dbc0aa32d25dbffcba0ff2940842b1c', 'version', 'version', NULL, 'int',
        'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 100, 0, NULL, '1',
        '2020-08-12 10:23:42.184', '1', '2020-08-12 10:23:42.184', '0');
INSERT INTO `gen_table_column`
VALUES ('0978920f1717b85451d8f6dde2adf06e', '8012923c1e3bdf0ed8c3071a32d32685', 'last_modified_by', 'last_modified_by',
        NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '',
        NULL, 90, 0, NULL, '1', '2020-08-12 15:59:12.765', '1', '2020-08-12 15:40:26.699', '1');
INSERT INTO `gen_table_column`
VALUES ('0e49a8d1464b35dd6d9ff4bc66e32ab3', '7dbc0aa32d25dbffcba0ff2940842b1c', 'path', '前端页面地址', NULL, 'varchar(255)',
        'String', 'path', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 0, NULL, '1',
        '2020-08-12 10:23:42.177', '1', '2020-08-12 10:23:42.177', '0');
INSERT INTO `gen_table_column`
VALUES ('0f1d41337237b734646c98111a1a41b5', 'ff7056ae6be7d5994b8d870549fc1c6a', 'type', '类型？', NULL, 'varchar(1)',
        'String', 'type', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 40, 0, NULL, '1',
        '2020-08-12 15:45:52.529', '1', '2020-08-12 15:45:52.529', '0');
INSERT INTO `gen_table_column`
VALUES ('0ffb9b9daeea311c01e9a4362e8d3d0d', 'ff7056ae6be7d5994b8d870549fc1c6a', 'description', '备注', NULL,
        'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 120,
        0, NULL, '1', '2020-08-12 15:45:52.532', '1', '2020-08-12 15:45:52.532', '0');
INSERT INTO `gen_table_column`
VALUES ('10d417b66b854a9a324f8e8ec424f6fd', '201a2bb8de59d0e0c2a9743f60f6ec11', 'del_flag', '0-正常，1-删除', NULL,
        'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 140,
        0, NULL, '1', '2020-08-12 15:59:25.217', '1', '2020-08-12 15:59:25.217', '0');
INSERT INTO `gen_table_column`
VALUES ('129f50f98e4692c651790a98c1ea31b7', '7dbc0aa32d25dbffcba0ff2940842b1c', 'last_modified_date', '修改时间', NULL,
        'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq',
        'dateselect', '', NULL, 80, 0, NULL, '1', '2020-08-12 10:23:42.182', '1', '2020-08-12 10:23:42.182', '0');
INSERT INTO `gen_table_column`
VALUES ('1372390d34af22c4d65aa3779c283395', '0788ece2109b1485ab5d53f7fa14f9ab', 'company_phone', '公司电话', NULL,
        'varchar(255)', 'String', 'companyPhone', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 60,
        0, NULL, '1', '2020-08-12 10:46:17.982', '1', '2020-08-12 10:46:11.303', '1');
INSERT INTO `gen_table_column`
VALUES ('15ad075007f4112f2937a6ff84ce2f82', 'ff7056ae6be7d5994b8d870549fc1c6a', 'id', 'id', NULL, 'varchar(32)',
        'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1',
        '2020-08-12 15:45:52.526', '1', '2020-08-12 15:45:52.526', '0');
INSERT INTO `gen_table_column`
VALUES ('16c56e71b148d5708b4cd38570031560', '6ecc39110e24a46af9df21ae5c725155', 'tax_num', '公司税号', NULL, 'varchar(0)',
        'String', 'taxNum', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 40, 0, NULL, '1',
        '2020-08-12 11:17:04.945', '1', '2020-08-12 10:46:11.491', '1');
INSERT INTO `gen_table_column`
VALUES ('1b9e90b36117b52c7202eed4b5a31ecc', '201a2bb8de59d0e0c2a9743f60f6ec11', 'id', 'id', NULL, 'varchar(32)',
        'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1',
        '2020-08-12 15:59:25.208', '1', '2020-08-12 15:59:25.208', '0');
INSERT INTO `gen_table_column`
VALUES ('1cc7794b8dade37874c0f29fd0cc7c4c', '201a2bb8de59d0e0c2a9743f60f6ec11', 'output_url', '输出地址', NULL,
        'varchar(255)', 'String', 'outputUrl', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 0,
        NULL, '1', '2020-08-12 15:59:25.212', '1', '2020-08-12 15:59:25.212', '0');
INSERT INTO `gen_table_column`
VALUES ('1cca80ed8210c485051b4fd931edaa0a', '6ecc39110e24a46af9df21ae5c725155', 'type', '0-个人，1-企业', NULL, 'varchar(1)',
        'String', 'type', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 20, 0, NULL, '1',
        '2020-08-12 11:17:04.945', '1', '2020-08-12 10:46:11.488', '1');
INSERT INTO `gen_table_column`
VALUES ('1d34ce49df1d63d6d2c4947af5667f85', '0291c0ba2aeb9b7e290a5d73f3751189', 'last_modified_date', '修改时间', NULL,
        'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq',
        'dateselect', '', NULL, 130, 0, NULL, '1', '2020-08-12 11:17:26.593', '1', '2020-08-12 11:17:26.593', '0');
INSERT INTO `gen_table_column`
VALUES ('1d8fb6c44958a38fc53a1aef456bb639', '0788ece2109b1485ab5d53f7fa14f9ab', 'name', '企业名称/个人名称', NULL,
        'varchar(255)', 'String', 'name', b'0', b'0', b'0', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 30, 0,
        NULL, '1', '2020-08-12 10:46:17.982', '1', '2020-08-12 10:46:11.300', '1');
INSERT INTO `gen_table_column`
VALUES ('1deef1c609c27cd00578cce80116ef67', '303003236467e4dc970d8eed90e565eb', 'voice_url', '这一小段文本的音频地址', NULL,
        'varchar(255)', 'String', 'voiceUrl', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 50, 0,
        NULL, '1', '2020-08-12 15:55:39.472', '1', '2020-08-12 15:55:39.472', '0');
INSERT INTO `gen_table_column`
VALUES ('1eccdc07a31f91b8efeb9a184a05f531', '0788ece2109b1485ab5d53f7fa14f9ab', 'account_bank', '开户公司', NULL,
        'varchar(255)', 'String', 'accountBank', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 70,
        0, NULL, '1', '2020-08-12 10:46:17.982', '1', '2020-08-12 10:46:11.304', '1');
INSERT INTO `gen_table_column`
VALUES ('1f88db3039281f55a8a07463dabcbb24', '303003236467e4dc970d8eed90e565eb', 'last_modified_date', '修改时间', NULL,
        'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq',
        'dateselect', '', NULL, 130, 0, NULL, '1', '2020-08-12 15:55:39.476', '1', '2020-08-12 15:55:39.476', '0');
INSERT INTO `gen_table_column`
VALUES ('22e19c6ab4ca4a60dc958e500a1b6cee', '8012923c1e3bdf0ed8c3071a32d32685', 'last_modified_date', '修改时间', NULL,
        'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq',
        'dateselect', '', NULL, 100, 0, NULL, '1', '2020-08-12 15:59:12.765', '1', '2020-08-12 15:40:26.699', '1');
INSERT INTO `gen_table_column`
VALUES ('2509b9f1d4b128d7f27f690db268c3d0', 'ff7056ae6be7d5994b8d870549fc1c6a', 'template_param', 'template_param',
        NULL, 'varchar(255)', 'String', 'templateParam', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '',
        NULL, 60, 0, NULL, '1', '2020-08-12 15:45:52.529', '1', '2020-08-12 15:45:52.529', '0');
INSERT INTO `gen_table_column`
VALUES ('2ccaf81c8e40c5def7c35523304f52a9', '0291c0ba2aeb9b7e290a5d73f3751189', 'version', 'version', NULL, 'int',
        'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 150, 0, NULL, '1',
        '2020-08-12 11:17:26.595', '1', '2020-08-12 11:17:26.595', '0');
INSERT INTO `gen_table_column`
VALUES ('3537790b3c8b65b0a8cd9ec1aca94e76', '201a2bb8de59d0e0c2a9743f60f6ec11', 'version', 'version', NULL, 'int',
        'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 130, 0, NULL, '1',
        '2020-08-12 15:59:25.217', '1', '2020-08-12 15:59:25.217', '0');
INSERT INTO `gen_table_column`
VALUES ('3625cbdbbc629735208e1f7b982c0e41', '0788ece2109b1485ab5d53f7fa14f9ab', 'last_modified_date', '修改时间', NULL,
        'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq',
        'dateselect', '', NULL, 120, 0, NULL, '1', '2020-08-12 10:46:17.982', '1', '2020-08-12 10:46:11.307', '1');
INSERT INTO `gen_table_column`
VALUES ('36594f9778c1ce8ab52b0cd4d9481653', '6ecc39110e24a46af9df21ae5c725155', 'last_modified_by', 'last_modified_by',
        NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '',
        NULL, 110, 0, NULL, '1', '2020-08-12 11:17:04.945', '1', '2020-08-12 10:46:11.497', '1');
INSERT INTO `gen_table_column`
VALUES ('37de82878e08e5aa8abd1befda7a535f', '0291c0ba2aeb9b7e290a5d73f3751189', 'del_flag', '0-正常，1-删除', NULL,
        'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 160,
        0, NULL, '1', '2020-08-12 11:17:26.595', '1', '2020-08-12 11:17:26.595', '0');
INSERT INTO `gen_table_column`
VALUES ('3d987466163d6f6908a241bb73c82db1', '303003236467e4dc970d8eed90e565eb', 'version', 'version', NULL, 'int',
        'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 150, 0, NULL, '1',
        '2020-08-12 15:55:39.477', '1', '2020-08-12 15:55:39.477', '0');
INSERT INTO `gen_table_column`
VALUES ('3e1a7958c623fa45459ac82ef7c961b5', 'e51850e0e9e0444fb581fb6bf65dd11e', 'photo_urls',
        '多个图片，用英文逗号分开。怕太长用longtext', NULL, 'text', 'String', 'photoUrls', b'0', b'0', b'1', b'1', b'1', b'1', b'0',
        'eq', 'input', '', NULL, 80, 0, NULL, '1', '2020-08-12 15:55:21.179', '1', '2020-08-12 15:53:36.829', '1');
INSERT INTO `gen_table_column`
VALUES ('3fc6939ea289763b741fff2c3991cd32', '0788ece2109b1485ab5d53f7fa14f9ab', 'company_location', '注册地址', NULL,
        'varchar(255)', 'String', 'companyLocation', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL,
        50, 0, NULL, '1', '2020-08-12 10:46:17.982', '1', '2020-08-12 10:46:11.302', '1');
INSERT INTO `gen_table_column`
VALUES ('42bad3d482c97afcf6ada126d28e2161', 'ff7056ae6be7d5994b8d870549fc1c6a', 'phone_number', 'phone_number', NULL,
        'int', 'Long', 'phoneNumber', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 20, 0, NULL,
        '1', '2020-08-12 15:45:52.528', '1', '2020-08-12 15:45:52.528', '0');
INSERT INTO `gen_table_column`
VALUES ('42c04b324bee1c2d05b29c89061f349b', '303003236467e4dc970d8eed90e565eb', 'user_id', '用户id', NULL, 'varchar(32)',
        'String', 'userId', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 20, 0, NULL, '1',
        '2020-08-12 15:55:39.470', '1', '2020-08-12 15:55:39.470', '0');
INSERT INTO `gen_table_column`
VALUES ('4432b24ae8faee635f8d21082aef44b9', '0291c0ba2aeb9b7e290a5d73f3751189', 'account_number', '开户账号', NULL,
        'varchar(32)', 'String', 'accountNumber', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90,
        0, NULL, '1', '2020-08-12 11:17:26.591', '1', '2020-08-12 11:17:26.591', '0');
INSERT INTO `gen_table_column`
VALUES ('44a270183b5dce41cf78e610857dbaca', '0291c0ba2aeb9b7e290a5d73f3751189', 'type', '0-个人，1-企业', NULL, 'varchar(1)',
        'String', 'type', b'0', b'0', b'0', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 30, 0, NULL, '1',
        '2020-08-12 11:17:26.585', '1', '2020-08-12 11:17:26.585', '0');
INSERT INTO `gen_table_column`
VALUES ('452f74cbd6ed771ac05dc74773df5222', 'ff7056ae6be7d5994b8d870549fc1c6a', 'last_modified_date', '修改时间', NULL,
        'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq',
        'dateselect', '', NULL, 110, 0, NULL, '1', '2020-08-12 15:45:52.532', '1', '2020-08-12 15:45:52.532', '0');
INSERT INTO `gen_table_column`
VALUES ('4640b12fe363f2a0ffcf9529e797ea9c', '303003236467e4dc970d8eed90e565eb', 'last_modified_by', 'last_modified_by',
        NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '',
        NULL, 120, 0, NULL, '1', '2020-08-12 15:55:39.476', '1', '2020-08-12 15:55:39.476', '0');
INSERT INTO `gen_table_column`
VALUES ('47b1ac5d3c9dc94da26fd3c58472a122', 'e51850e0e9e0444fb581fb6bf65dd11e', 'id', 'id', NULL, 'varchar(32)',
        'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1',
        '2020-08-12 15:55:21.179', '1', '2020-08-12 15:53:36.822', '1');
INSERT INTO `gen_table_column`
VALUES ('491120e2741af6d49d882d30bb2279b2', '5419e930e63aecec3b0266776cca0fbf', 'created_date', '创建时间', NULL,
        'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect',
        '', NULL, 110, 0, NULL, '1', '2020-08-12 15:35:16.461', '1', '2020-08-12 15:35:16.461', '0');
INSERT INTO `gen_table_column`
VALUES ('49498e514354eb0cc6c1043674cbf198', '5419e930e63aecec3b0266776cca0fbf', 'user_id', '用户id', NULL, 'varchar(32)',
        'String', 'userId', b'0', b'0', b'0', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 20, 0, NULL, '1',
        '2020-08-12 15:35:16.451', '1', '2020-08-12 15:35:16.451', '0');
INSERT INTO `gen_table_column`
VALUES ('4ae7e01bdb29c854349e1f591b4c2bbe', '5419e930e63aecec3b0266776cca0fbf', 'last_modified_date', '修改时间', NULL,
        'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq',
        'dateselect', '', NULL, 130, 0, NULL, '1', '2020-08-12 15:35:16.463', '1', '2020-08-12 15:35:16.463', '0');
INSERT INTO `gen_table_column`
VALUES ('4c4fcc427d668728d8fc8bf06a7c8f80', 'e51850e0e9e0444fb581fb6bf65dd11e', 'version', 'version', NULL, 'int',
        'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 0, NULL, '1',
        '2020-08-12 15:55:21.179', '1', '2020-08-12 15:53:36.834', '1');
INSERT INTO `gen_table_column`
VALUES ('4d4cde2004291c32f69922d715180627', '5419e930e63aecec3b0266776cca0fbf', 'created_by', 'created_by', NULL,
        'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 100, 0,
        NULL, '1', '2020-08-12 15:35:16.460', '1', '2020-08-12 15:35:16.460', '0');
INSERT INTO `gen_table_column`
VALUES ('4e3bb69c896bf2543abe71ee055839c3', '303003236467e4dc970d8eed90e565eb', 'id', 'id', NULL, 'varchar(32)',
        'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1',
        '2020-08-12 15:55:39.468', '1', '2020-08-12 15:55:39.468', '0');
INSERT INTO `gen_table_column`
VALUES ('4ee1a9c6d4d3c5a92b9a78aac3b34f8b', 'e51850e0e9e0444fb581fb6bf65dd11e', 'description', '备注', NULL,
        'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 130,
        0, NULL, '1', '2020-08-12 15:55:21.179', '1', '2020-08-12 15:53:36.833', '1');
INSERT INTO `gen_table_column`
VALUES ('4fb6eb61d68b74a74a77602081bf43af', '8012923c1e3bdf0ed8c3071a32d32685', 'version', 'version', NULL, 'int',
        'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 0, NULL, '1',
        '2020-08-12 15:59:12.765', '1', '2020-08-12 15:40:26.700', '1');
INSERT INTO `gen_table_column`
VALUES ('508c6ca819d2a56630c781a1cc100693', '0291c0ba2aeb9b7e290a5d73f3751189', 'description', '备注', NULL,
        'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 140,
        0, NULL, '1', '2020-08-12 11:17:26.594', '1', '2020-08-12 11:17:26.594', '0');
INSERT INTO `gen_table_column`
VALUES ('50bb21c358313add761b67d648154c73', '0788ece2109b1485ab5d53f7fa14f9ab', 'tax_num', '公司税号', NULL, 'varchar(0)',
        'String', 'taxNum', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 40, 0, NULL, '1',
        '2020-08-12 10:46:17.982', '1', '2020-08-12 10:46:11.301', '1');
INSERT INTO `gen_table_column`
VALUES ('50db5cbaf6f1117d827c48befe86c2da', '8012923c1e3bdf0ed8c3071a32d32685', 'created_by', 'created_by', NULL,
        'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 70, 0,
        NULL, '1', '2020-08-12 15:59:12.765', '1', '2020-08-12 15:40:26.698', '1');
INSERT INTO `gen_table_column`
VALUES ('524287ea0659f7ac6012fdf5ef6a869a', '31b4af23fe3bd30452e7a8b4c367034a', 'created_date', '创建时间', NULL,
        'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect',
        '', NULL, 50, 0, NULL, '1', '2020-08-12 10:46:39.624', '1', '2020-08-12 10:46:39.624', '0');
INSERT INTO `gen_table_column`
VALUES ('581949bf77acd8eeb77f62ebac13b8df', '7dbc0aa32d25dbffcba0ff2940842b1c', 'description', '备注', NULL,
        'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 90,
        0, NULL, '1', '2020-08-12 10:23:42.183', '1', '2020-08-12 10:23:42.183', '0');
INSERT INTO `gen_table_column`
VALUES ('58b77b66fbf1b3651a572d315d3154d7', '6ecc39110e24a46af9df21ae5c725155', 'created_by', 'created_by', NULL,
        'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 90, 0,
        NULL, '1', '2020-08-12 11:17:04.945', '1', '2020-08-12 10:46:11.496', '1');
INSERT INTO `gen_table_column`
VALUES ('59881e26b8a17ae2d421f0dc3ffe5bb1', 'e51850e0e9e0444fb581fb6bf65dd11e', 'last_modified_by', 'last_modified_by',
        NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '',
        NULL, 110, 0, NULL, '1', '2020-08-12 15:55:21.179', '1', '2020-08-12 15:53:36.832', '1');
INSERT INTO `gen_table_column`
VALUES ('5a3d54cac9f74bfcff7b076d48070307', '7dbc0aa32d25dbffcba0ff2940842b1c', 'created_by', 'created_by', NULL,
        'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 50, 0,
        NULL, '1', '2020-08-12 10:23:42.179', '1', '2020-08-12 10:23:42.179', '0');
INSERT INTO `gen_table_column`
VALUES ('5ba05cd4bec3ebac9b8b368f5f56d388', '8012923c1e3bdf0ed8c3071a32d32685', 'name', '视频名字', NULL, 'varchar(255)',
        'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 0, NULL, '1',
        '2020-08-12 15:59:12.765', '1', '2020-08-12 15:40:26.695', '1');
INSERT INTO `gen_table_column`
VALUES ('5d9fa5b37867bd29ab61a69b90acc7b3', '303003236467e4dc970d8eed90e565eb', 'name', '商品名字', NULL, 'varchar(255)',
        'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 30, 0, NULL, '1',
        '2020-08-12 15:55:39.471', '1', '2020-08-12 15:55:39.471', '0');
INSERT INTO `gen_table_column`
VALUES ('5e2a3092f5079dc2f897e93c0d3f7617', 'ff7056ae6be7d5994b8d870549fc1c6a', 'del_flag', '0-正常，1-删除', NULL,
        'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 140,
        0, NULL, '1', '2020-08-12 15:45:52.534', '1', '2020-08-12 15:45:52.534', '0');
INSERT INTO `gen_table_column`
VALUES ('5e7e88b297a0b7cf92246556ee93ab93', '201a2bb8de59d0e0c2a9743f60f6ec11', 'last_modified_by', 'last_modified_by',
        NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '',
        NULL, 100, 0, NULL, '1', '2020-08-12 15:59:25.214', '1', '2020-08-12 15:59:25.214', '0');
INSERT INTO `gen_table_column`
VALUES ('626210416a56d4c5e048464125bd41cf', '0291c0ba2aeb9b7e290a5d73f3751189', 'tax_num', '公司税号', NULL, 'varchar(0)',
        'String', 'taxNum', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 50, 0, NULL, '1',
        '2020-08-12 11:17:26.587', '1', '2020-08-12 11:17:26.587', '0');
INSERT INTO `gen_table_column`
VALUES ('62d19690e862fd0c6ea382b9e8cf9d7e', '6ecc39110e24a46af9df21ae5c725155', 'description', '备注', NULL,
        'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 130,
        0, NULL, '1', '2020-08-12 11:17:04.945', '1', '2020-08-12 10:46:11.498', '1');
INSERT INTO `gen_table_column`
VALUES ('648bb687fd777e746666ef7138bb9415', 'e51850e0e9e0444fb581fb6bf65dd11e', 'video_id', '视频id', NULL, 'varchar(32)',
        'String', 'videoId', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 30, 0, NULL, '1',
        '2020-08-12 15:55:21.179', '1', '2020-08-12 15:53:36.825', '1');
INSERT INTO `gen_table_column`
VALUES ('6504ec10fb38a6f2bbb03dad7328314d', '5419e930e63aecec3b0266776cca0fbf', 'user_name', '用户名字', NULL,
        'varchar(255)', 'String', 'userName', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 80, 0,
        NULL, '1', '2020-08-12 15:35:16.458', '1', '2020-08-12 15:35:16.458', '0');
INSERT INTO `gen_table_column`
VALUES ('66a86840ecadb7e2e8864bc9ccd0bdcd', '8012923c1e3bdf0ed8c3071a32d32685', 'duration', '视频长度，单位是秒', NULL, 'int',
        'Long', 'duration', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 0, NULL, '1',
        '2020-08-12 15:59:12.765', '1', '2020-08-12 15:40:26.697', '1');
INSERT INTO `gen_table_column`
VALUES ('66cc662cf0027e31dc0b07fd38ab1e69', '6ecc39110e24a46af9df21ae5c725155', 'company_location', '注册地址', NULL,
        'varchar(255)', 'String', 'companyLocation', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL,
        50, 0, NULL, '1', '2020-08-12 11:17:04.945', '1', '2020-08-12 10:46:11.491', '1');
INSERT INTO `gen_table_column`
VALUES ('68cf890573c3a541b71854c351c78720', '6ecc39110e24a46af9df21ae5c725155', 'del_flag', '0-正常，1-删除', NULL,
        'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 150,
        0, NULL, '1', '2020-08-12 11:17:04.945', '1', '2020-08-12 10:46:11.500', '1');
INSERT INTO `gen_table_column`
VALUES ('6b859e4f28787a8d48ae78e100bb9de5', '8012923c1e3bdf0ed8c3071a32d32685', 'id', 'id', NULL, 'varchar(32)',
        'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1',
        '2020-08-12 15:59:12.765', '1', '2020-08-12 15:40:26.694', '1');
INSERT INTO `gen_table_column`
VALUES ('6b95ad0e7e29987e06d356b2d5589dfe', '6ecc39110e24a46af9df21ae5c725155', 'name', '企业名称/个人名称', NULL,
        'varchar(255)', 'String', 'name', b'0', b'0', b'0', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 30, 0,
        NULL, '1', '2020-08-12 11:17:04.945', '1', '2020-08-12 10:46:11.490', '1');
INSERT INTO `gen_table_column`
VALUES ('6face9aaf4ff2c4207739a64beebd98e', '303003236467e4dc970d8eed90e565eb', 'created_date', '创建时间', NULL,
        'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect',
        '', NULL, 110, 0, NULL, '1', '2020-08-12 15:55:39.475', '1', '2020-08-12 15:55:39.475', '0');
INSERT INTO `gen_table_column`
VALUES ('729d804d1f144f2430caea3939ad4fdd', '6ecc39110e24a46af9df21ae5c725155', 'company_phone', '公司电话', NULL,
        'varchar(255)', 'String', 'companyPhone', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 60,
        0, NULL, '1', '2020-08-12 11:17:04.945', '1', '2020-08-12 10:46:11.492', '1');
INSERT INTO `gen_table_column`
VALUES ('76cab82767bb4329dde8a482ed5b606b', '31b4af23fe3bd30452e7a8b4c367034a', 'user_id', '用户id', NULL, 'varchar(32)',
        'String', 'userId', b'0', b'0', b'0', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 20, 0, NULL, '1',
        '2020-08-12 10:46:39.622', '1', '2020-08-12 10:46:39.622', '0');
INSERT INTO `gen_table_column`
VALUES ('7731a8c32ecfca8f76696699d282db1e', 'ff7056ae6be7d5994b8d870549fc1c6a', 'created_by', 'created_by', NULL,
        'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 80, 0,
        NULL, '1', '2020-08-12 15:45:52.530', '1', '2020-08-12 15:45:52.530', '0');
INSERT INTO `gen_table_column`
VALUES ('7892ddacac753bf12348ab6947047123', '7dbc0aa32d25dbffcba0ff2940842b1c', 'ad_word', '广告语内容', NULL,
        'varchar(255)', 'String', 'adWord', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 40, 0,
        NULL, '1', '2020-08-12 10:23:42.177', '1', '2020-08-12 10:23:42.177', '0');
INSERT INTO `gen_table_column`
VALUES ('7acf11d62c4af526297fa52d2e09ca32', '8012923c1e3bdf0ed8c3071a32d32685', 'description', '备注', NULL,
        'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 110,
        0, NULL, '1', '2020-08-12 15:59:12.765', '1', '2020-08-12 15:40:26.700', '1');
INSERT INTO `gen_table_column`
VALUES ('7c6c3ffe391f51ae04c8e93d54434cfd', 'ff7056ae6be7d5994b8d870549fc1c6a', 'user_id', '开发票的userid', NULL,
        'varchar(32)', 'String', 'userId', b'0', b'0', b'0', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 30, 0,
        NULL, '1', '2020-08-12 15:45:52.528', '1', '2020-08-12 15:45:52.528', '0');
INSERT INTO `gen_table_column`
VALUES ('7f5f6929bce1191c87655775148e4a0c', '0788ece2109b1485ab5d53f7fa14f9ab', 'created_by', 'created_by', NULL,
        'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 90, 0,
        NULL, '1', '2020-08-12 10:46:17.982', '1', '2020-08-12 10:46:11.306', '1');
INSERT INTO `gen_table_column`
VALUES ('81bcfad6f76c6996df1217b775bc2663', '8012923c1e3bdf0ed8c3071a32d32685', 'del_flag', '0-正常，1-删除', NULL,
        'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 130,
        0, NULL, '1', '2020-08-12 15:59:12.765', '1', '2020-08-12 15:40:26.700', '1');
INSERT INTO `gen_table_column`
VALUES ('829b0646a2f3bbe0a930c8df660f39f6', 'e51850e0e9e0444fb581fb6bf65dd11e', 'voice_time', '音频时间，单位是秒', NULL, 'int',
        'Long', 'voiceTime', b'0', b'0', b'0', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 50, 0, NULL, '1',
        '2020-08-12 15:55:21.179', '1', '2020-08-12 15:53:36.826', '1');
INSERT INTO `gen_table_column`
VALUES ('84c12c5b6529e3809dcd20567d0e244b', 'ff7056ae6be7d5994b8d870549fc1c6a', 'last_modified_by', 'last_modified_by',
        NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '',
        NULL, 100, 0, NULL, '1', '2020-08-12 15:45:52.531', '1', '2020-08-12 15:45:52.531', '0');
INSERT INTO `gen_table_column`
VALUES ('84d213099a7c167b058fdbeb82583603', '0291c0ba2aeb9b7e290a5d73f3751189', 'user_id', '用户id', NULL, 'varchar(32)',
        'String', 'userId', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 20, 0, NULL, '1',
        '2020-08-12 11:17:26.584', '1', '2020-08-12 11:17:26.584', '0');
INSERT INTO `gen_table_column`
VALUES ('85c47cf26318361e4ed03a2b1e44e98e', 'ff7056ae6be7d5994b8d870549fc1c6a', 'version', 'version', NULL, 'int',
        'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 130, 0, NULL, '1',
        '2020-08-12 15:45:52.533', '1', '2020-08-12 15:45:52.533', '0');
INSERT INTO `gen_table_column`
VALUES ('85fb85d2e0339c087dc9cbab6744bee7', '0291c0ba2aeb9b7e290a5d73f3751189', 'company_phone', '公司电话', NULL,
        'varchar(255)', 'String', 'companyPhone', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 70,
        0, NULL, '1', '2020-08-12 11:17:26.590', '1', '2020-08-12 11:17:26.590', '0');
INSERT INTO `gen_table_column`
VALUES ('874ab021390e4fc7eefea2dbe6ac0a90', 'e51850e0e9e0444fb581fb6bf65dd11e', 'last_modified_date', '修改时间', NULL,
        'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq',
        'dateselect', '', NULL, 120, 0, NULL, '1', '2020-08-12 15:55:21.179', '1', '2020-08-12 15:53:36.833', '1');
INSERT INTO `gen_table_column`
VALUES ('8993c3c8de4a9913ddbdd0fa66f2b914', '0788ece2109b1485ab5d53f7fa14f9ab', 'version', 'version', NULL, 'int',
        'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 0, NULL, '1',
        '2020-08-12 10:46:17.982', '1', '2020-08-12 10:46:11.309', '1');
INSERT INTO `gen_table_column`
VALUES ('8da3d606d428e540aa2ced01425c1d20', '31b4af23fe3bd30452e7a8b4c367034a', 'description', '备注', NULL,
        'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 80,
        0, NULL, '1', '2020-08-12 10:46:39.626', '1', '2020-08-12 10:46:39.626', '0');
INSERT INTO `gen_table_column`
VALUES ('91c2c481ca6cdacbb094bb2448708d2b', '31b4af23fe3bd30452e7a8b4c367034a', 'del_flag', '0-正常，1-删除', NULL,
        'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 100,
        0, NULL, '1', '2020-08-12 10:46:39.627', '1', '2020-08-12 10:46:39.627', '0');
INSERT INTO `gen_table_column`
VALUES ('91db06e214412d7314431c39a92fb709', 'ff7056ae6be7d5994b8d870549fc1c6a', 'created_date', '创建时间', NULL,
        'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect',
        '', NULL, 90, 0, NULL, '1', '2020-08-12 15:45:52.531', '1', '2020-08-12 15:45:52.531', '0');
INSERT INTO `gen_table_column`
VALUES ('91ef181a7e83962ebca440a88be90cbf', 'e51850e0e9e0444fb581fb6bf65dd11e', 'template_words', '这是啥意思？', NULL,
        'varchar(255)', 'String', 'templateWords', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL,
        70, 0, NULL, '1', '2020-08-12 15:55:21.179', '1', '2020-08-12 15:53:36.828', '1');
INSERT INTO `gen_table_column`
VALUES ('936c6ad5bfbb8c1f9befc3bdfe5da6b9', '201a2bb8de59d0e0c2a9743f60f6ec11', 'origin_url', 'origin_url', NULL,
        'varchar(255)', 'String', 'originUrl', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 40, 0,
        NULL, '1', '2020-08-12 15:59:25.211', '1', '2020-08-12 15:59:25.211', '0');
INSERT INTO `gen_table_column`
VALUES ('93db922b01e1d344b2c3e5d891a58cc0', 'e51850e0e9e0444fb581fb6bf65dd11e', 'voice_url', '这一小段文本的音频地址', NULL,
        'varchar(255)', 'String', 'voiceUrl', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 40, 0,
        NULL, '1', '2020-08-12 15:55:21.179', '1', '2020-08-12 15:53:36.826', '1');
INSERT INTO `gen_table_column`
VALUES ('97d0d41b10ddbfddab75a8381539ddf6', '7dbc0aa32d25dbffcba0ff2940842b1c', 'del_flag', '0-正常，1-删除', NULL,
        'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 110,
        0, NULL, '1', '2020-08-12 10:23:42.184', '1', '2020-08-12 10:23:42.184', '0');
INSERT INTO `gen_table_column`
VALUES ('993cca647485e907f6df6ddabc3d9bb6', '303003236467e4dc970d8eed90e565eb', 'video_id', '视频id', NULL, 'varchar(32)',
        'String', 'videoId', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 40, 0, NULL, '1',
        '2020-08-12 15:55:39.471', '1', '2020-08-12 15:55:39.471', '0');
INSERT INTO `gen_table_column`
VALUES ('9aa1c09fb47aca33444263aca5eb49e7', '201a2bb8de59d0e0c2a9743f60f6ec11', 'description', '备注', NULL,
        'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 120,
        0, NULL, '1', '2020-08-12 15:59:25.216', '1', '2020-08-12 15:59:25.216', '0');
INSERT INTO `gen_table_column`
VALUES ('9beeaacf5d9153522f8dd82f34f0b4cf', '5419e930e63aecec3b0266776cca0fbf', 'version', 'version', NULL, 'int',
        'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 150, 0, NULL, '1',
        '2020-08-12 15:35:16.465', '1', '2020-08-12 15:35:16.465', '0');
INSERT INTO `gen_table_column`
VALUES ('9ed8fc729277d9c275799466a5936864', '5419e930e63aecec3b0266776cca0fbf', 'del_flag', '0-正常，1-删除', NULL,
        'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 160,
        0, NULL, '1', '2020-08-12 15:35:16.466', '1', '2020-08-12 15:35:16.466', '0');
INSERT INTO `gen_table_column`
VALUES ('9f55be8d3e7789e20bbd74da8577649f', '31b4af23fe3bd30452e7a8b4c367034a', 'last_modified_date', '修改时间', NULL,
        'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq',
        'dateselect', '', NULL, 70, 0, NULL, '1', '2020-08-12 10:46:39.625', '1', '2020-08-12 10:46:39.625', '0');
INSERT INTO `gen_table_column`
VALUES ('a25bd01d51b8a478f99a182a02318a54', 'e51850e0e9e0444fb581fb6bf65dd11e', 'name', '商品名字', NULL, 'varchar(255)',
        'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 0, NULL, '1',
        '2020-08-12 15:55:21.179', '1', '2020-08-12 15:53:36.824', '1');
INSERT INTO `gen_table_column`
VALUES ('a418ddf9aff5ba38e7380d737e942b71', '303003236467e4dc970d8eed90e565eb', 'created_by', 'created_by', NULL,
        'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 100, 0,
        NULL, '1', '2020-08-12 15:55:39.475', '1', '2020-08-12 15:55:39.475', '0');
INSERT INTO `gen_table_column`
VALUES ('a423224a363a93cb5015bf3e70032c80', '201a2bb8de59d0e0c2a9743f60f6ec11', 'last_modified_date', '修改时间', NULL,
        'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq',
        'dateselect', '', NULL, 110, 0, NULL, '1', '2020-08-12 15:59:25.215', '1', '2020-08-12 15:59:25.215', '0');
INSERT INTO `gen_table_column`
VALUES ('a460774f36191a1be3b260ae317055dc', '7dbc0aa32d25dbffcba0ff2940842b1c', 'created_date', '创建时间', NULL,
        'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect',
        '', NULL, 60, 0, NULL, '1', '2020-08-12 10:23:42.180', '1', '2020-08-12 10:23:42.180', '0');
INSERT INTO `gen_table_column`
VALUES ('a62d48166d1a2d5daf60ab5604dd1a8d', '303003236467e4dc970d8eed90e565eb', 'description', '备注', NULL,
        'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 140,
        0, NULL, '1', '2020-08-12 15:55:39.477', '1', '2020-08-12 15:55:39.477', '0');
INSERT INTO `gen_table_column`
VALUES ('a8c53c99296dbfb8d714e38e16ceb43c', 'e51850e0e9e0444fb581fb6bf65dd11e', 'created_date', '创建时间', NULL,
        'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect',
        '', NULL, 100, 0, NULL, '1', '2020-08-12 15:55:21.179', '1', '2020-08-12 15:53:36.831', '1');
INSERT INTO `gen_table_column`
VALUES ('a9c92b6fadc2a4a8bf11facccfd9f8af', '5419e930e63aecec3b0266776cca0fbf', 'trade_no', '支付宝订单交易号', NULL,
        'varchar(50)', 'String', 'tradeNo', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 60, 0,
        NULL, '1', '2020-08-12 15:35:16.456', '1', '2020-08-12 15:35:16.456', '0');
INSERT INTO `gen_table_column`
VALUES ('acec1523a36c34645ebf3fb83882c59a', '303003236467e4dc970d8eed90e565eb', 'ad_words', '文本介绍', NULL,
        'varchar(255)', 'String', 'adWords', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 70, 0,
        NULL, '1', '2020-08-12 15:55:39.473', '1', '2020-08-12 15:55:39.473', '0');
INSERT INTO `gen_table_column`
VALUES ('b48109999a69c2f594cb22f23b9e4e3f', '5419e930e63aecec3b0266776cca0fbf', 'status', '订单状态（具体细节后面再说）', NULL,
        'varchar(255)', 'String', 'status', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 30, 0,
        NULL, '1', '2020-08-12 15:35:16.452', '1', '2020-08-12 15:35:16.452', '0');
INSERT INTO `gen_table_column`
VALUES ('b5da0d91262f2dce86b412da0f4aefda', '6ecc39110e24a46af9df21ae5c725155', 'id', 'user_id或dept_id', NULL,
        'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL,
        '1', '2020-08-12 11:17:04.945', '1', '2020-08-12 10:46:11.485', '1');
INSERT INTO `gen_table_column`
VALUES ('b7ed598f0810aede6b22453ff2ec2d19', '5419e930e63aecec3b0266776cca0fbf', 'last_modified_by', 'last_modified_by',
        NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '',
        NULL, 120, 0, NULL, '1', '2020-08-12 15:35:16.462', '1', '2020-08-12 15:35:16.462', '0');
INSERT INTO `gen_table_column`
VALUES ('b8618a639f38b5b20a413ebceac1784b', '201a2bb8de59d0e0c2a9743f60f6ec11', 'user_id', '用户id', NULL, 'varchar(32)',
        'String', 'userId', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 20, 0, NULL, '1',
        '2020-08-12 15:59:25.210', '1', '2020-08-12 15:59:25.210', '0');
INSERT INTO `gen_table_column`
VALUES ('bb95ff0e7676af494dc0f1d86b6bfa15', '0788ece2109b1485ab5d53f7fa14f9ab', 'last_modified_by', 'last_modified_by',
        NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '',
        NULL, 110, 0, NULL, '1', '2020-08-12 10:46:17.982', '1', '2020-08-12 10:46:11.307', '1');
INSERT INTO `gen_table_column`
VALUES ('bc022f22eabbc4d308f34ec0f040dae4', '303003236467e4dc970d8eed90e565eb', 'voice_time', '音频时间，单位是秒', NULL, 'int',
        'Long', 'voiceTime', b'0', b'0', b'0', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 60, 0, NULL, '1',
        '2020-08-12 15:55:39.472', '1', '2020-08-12 15:55:39.472', '0');
INSERT INTO `gen_table_column`
VALUES ('bd168e0c64a097d7607b265635954672', 'e51850e0e9e0444fb581fb6bf65dd11e', 'del_flag', '0-正常，1-删除', NULL,
        'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 150,
        0, NULL, '1', '2020-08-12 15:55:21.179', '1', '2020-08-12 15:53:36.834', '1');
INSERT INTO `gen_table_column`
VALUES ('bd8f9746d46e41dc280df5f7fe224a47', '5419e930e63aecec3b0266776cca0fbf', 'description', '备注', NULL,
        'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 140,
        0, NULL, '1', '2020-08-12 15:35:16.464', '1', '2020-08-12 15:35:16.464', '0');
INSERT INTO `gen_table_column`
VALUES ('bdf231914c7634a6bf9e16255c8f2bbd', '201a2bb8de59d0e0c2a9743f60f6ec11', 'duration', '视频长度，单位是秒', NULL, 'int',
        'Long', 'duration', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 0, NULL, '1',
        '2020-08-12 15:59:25.213', '1', '2020-08-12 15:59:25.213', '0');
INSERT INTO `gen_table_column`
VALUES ('be0f1427da1bb32b416952a099bcf462', '0291c0ba2aeb9b7e290a5d73f3751189', 'created_by', 'created_by', NULL,
        'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 100, 0,
        NULL, '1', '2020-08-12 11:17:26.592', '1', '2020-08-12 11:17:26.592', '0');
INSERT INTO `gen_table_column`
VALUES ('c251e53a76b2116891e815374d801bc1', '6ecc39110e24a46af9df21ae5c725155', 'created_date', '创建时间', NULL,
        'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect',
        '', NULL, 100, 0, NULL, '1', '2020-08-12 11:17:04.945', '1', '2020-08-12 10:46:11.496', '1');
INSERT INTO `gen_table_column`
VALUES ('c25c7bffc169458574185fe5f31ac13e', '303003236467e4dc970d8eed90e565eb', 'del_flag', '0-正常，1-删除', NULL,
        'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 160,
        0, NULL, '1', '2020-08-12 15:55:39.478', '1', '2020-08-12 15:55:39.478', '0');
INSERT INTO `gen_table_column`
VALUES ('c4e782e378d8126cb055872b7374db80', '8012923c1e3bdf0ed8c3071a32d32685', 'created_date', '创建时间', NULL,
        'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect',
        '', NULL, 80, 0, NULL, '1', '2020-08-12 15:59:12.765', '1', '2020-08-12 15:40:26.698', '1');
INSERT INTO `gen_table_column`
VALUES ('c512de3dd55491bfa46c211e98aac7a7', '7dbc0aa32d25dbffcba0ff2940842b1c', 'id', '主键id', NULL, 'varchar(32)',
        'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1',
        '2020-08-12 10:23:42.172', '1', '2020-08-12 10:23:42.172', '0');
INSERT INTO `gen_table_column`
VALUES ('c74e1b99157fb3560fd998852ebac180', '6ecc39110e24a46af9df21ae5c725155', 'last_modified_date', '修改时间', NULL,
        'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq',
        'dateselect', '', NULL, 120, 0, NULL, '1', '2020-08-12 11:17:04.945', '1', '2020-08-12 10:46:11.497', '1');
INSERT INTO `gen_table_column`
VALUES ('c81f9650acd9f2ae044562dd1314da31', '0788ece2109b1485ab5d53f7fa14f9ab', 'del_flag', '0-正常，1-删除', NULL,
        'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 150,
        0, NULL, '1', '2020-08-12 10:46:17.982', '1', '2020-08-12 10:46:11.310', '1');
INSERT INTO `gen_table_column`
VALUES ('c96e2e56c3f62d64c6564f512bb58def', '0291c0ba2aeb9b7e290a5d73f3751189', 'created_date', '创建时间', NULL,
        'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect',
        '', NULL, 110, 0, NULL, '1', '2020-08-12 11:17:26.592', '1', '2020-08-12 11:17:26.592', '0');
INSERT INTO `gen_table_column`
VALUES ('cbc546c237a8759bae6a4e39869211a3', '6ecc39110e24a46af9df21ae5c725155', 'account_number', '开户账号', NULL,
        'varchar(32)', 'String', 'accountNumber', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80,
        0, NULL, '1', '2020-08-12 11:17:04.945', '1', '2020-08-12 10:46:11.495', '1');
INSERT INTO `gen_table_column`
VALUES ('cc5aec39175191fc84e9d259971cef8f', '8012923c1e3bdf0ed8c3071a32d32685', 'output_url', '输出地址', NULL,
        'varchar(255)', 'String', 'outputUrl', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 50, 0,
        NULL, '1', '2020-08-12 15:59:12.765', '1', '2020-08-12 15:40:26.697', '1');
INSERT INTO `gen_table_column`
VALUES ('d03de10a23b8d566bb68bb65adb1fa25', '5419e930e63aecec3b0266776cca0fbf', 'type', '订单类型（加速卡，单次，多次）', NULL,
        'varchar(255)', 'String', 'type', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 40, 0,
        NULL, '1', '2020-08-12 15:35:16.453', '1', '2020-08-12 15:35:16.453', '0');
INSERT INTO `gen_table_column`
VALUES ('d0941b57bc0ac1851ef990ceee2d6436', 'ff7056ae6be7d5994b8d870549fc1c6a', 'status', '状态', NULL, 'varchar(255)',
        'String', 'status', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 0, NULL, '1',
        '2020-08-12 15:45:52.530', '1', '2020-08-12 15:45:52.530', '0');
INSERT INTO `gen_table_column`
VALUES ('d199cddc3d32d22f2c4438c101f7cac0', 'e51850e0e9e0444fb581fb6bf65dd11e', 'ad_words', '文本介绍', NULL,
        'varchar(255)', 'String', 'adWords', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 60, 0,
        NULL, '1', '2020-08-12 15:55:21.179', '1', '2020-08-12 15:53:36.828', '1');
INSERT INTO `gen_table_column`
VALUES ('d2493d65eb51863d0879f5882bcb24c6', '303003236467e4dc970d8eed90e565eb', 'photo_urls',
        '多个图片，用英文逗号分开。怕太长用longtext', NULL, 'text', 'String', 'photoUrls', b'0', b'0', b'1', b'1', b'1', b'1', b'1',
        'eq', 'input', '', NULL, 90, 0, NULL, '1', '2020-08-12 15:55:39.474', '1', '2020-08-12 15:55:39.474', '0');
INSERT INTO `gen_table_column`
VALUES ('d27774193f87b4327d96c6483c87043d', '0291c0ba2aeb9b7e290a5d73f3751189', 'account_bank', '开户公司', NULL,
        'varchar(255)', 'String', 'accountBank', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 80,
        0, NULL, '1', '2020-08-12 11:17:26.591', '1', '2020-08-12 11:17:26.591', '0');
INSERT INTO `gen_table_column`
VALUES ('d59e62bef7fff8f9f53cdcb608a318e0', '0788ece2109b1485ab5d53f7fa14f9ab', 'id', 'user_id或dept_id', NULL,
        'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL,
        '1', '2020-08-12 10:46:17.982', '1', '2020-08-12 10:46:11.296', '1');
INSERT INTO `gen_table_column`
VALUES ('d5c3337920c33f2d549ee8efaed0c001', '303003236467e4dc970d8eed90e565eb', 'template_words', '这是啥意思？', NULL,
        'varchar(255)', 'String', 'templateWords', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL,
        80, 0, NULL, '1', '2020-08-12 15:55:39.474', '1', '2020-08-12 15:55:39.474', '0');
INSERT INTO `gen_table_column`
VALUES ('d620e4eb1f53120314e4696ec7e1d117', '0291c0ba2aeb9b7e290a5d73f3751189', 'id', 'user_id或dept_id', NULL,
        'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL,
        '1', '2020-08-12 11:17:26.582', '1', '2020-08-12 11:17:26.582', '0');
INSERT INTO `gen_table_column`
VALUES ('d6880a99e52197a853f13f0a7c66a1c3', '31b4af23fe3bd30452e7a8b4c367034a', 'version', 'version', NULL, 'int',
        'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 90, 0, NULL, '1',
        '2020-08-12 10:46:39.626', '1', '2020-08-12 10:46:39.626', '0');
INSERT INTO `gen_table_column`
VALUES ('d6e2c0ee6fd8b3f6d99bee0111e21954', '8012923c1e3bdf0ed8c3071a32d32685', 'logo_url', 'logo的地址', NULL,
        'varchar(255)', 'String', 'logoUrl', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 40, 0,
        NULL, '1', '2020-08-12 15:59:12.765', '1', '2020-08-12 15:40:26.696', '1');
INSERT INTO `gen_table_column`
VALUES ('d6f794031a6b022b0eb23fc72e24134f', '0788ece2109b1485ab5d53f7fa14f9ab', 'description', '备注', NULL,
        'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 130,
        0, NULL, '1', '2020-08-12 10:46:17.982', '1', '2020-08-12 10:46:11.308', '1');
INSERT INTO `gen_table_column`
VALUES ('d78c8496229f1a7431b053e4df133af7', '5419e930e63aecec3b0266776cca0fbf', 'id', 'id', NULL, 'varchar(32)',
        'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1',
        '2020-08-12 15:35:16.448', '1', '2020-08-12 15:35:16.448', '0');
INSERT INTO `gen_table_column`
VALUES ('d83851904fc96d7043cf804d53255473', '6ecc39110e24a46af9df21ae5c725155', 'account_bank', '开户公司', NULL,
        'varchar(255)', 'String', 'accountBank', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 70,
        0, NULL, '1', '2020-08-12 11:17:04.945', '1', '2020-08-12 10:46:11.493', '1');
INSERT INTO `gen_table_column`
VALUES ('d9a5eb614171075d0cc9761b486f36cd', '5419e930e63aecec3b0266776cca0fbf', 'user_phone', '用户电话', NULL,
        'varchar(255)', 'String', 'userPhone', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 90, 0,
        NULL, '1', '2020-08-12 15:35:16.459', '1', '2020-08-12 15:35:16.459', '0');
INSERT INTO `gen_table_column`
VALUES ('db17a81c6381a6cc60d27f1e09a0b435', '201a2bb8de59d0e0c2a9743f60f6ec11', 'created_by', 'created_by', NULL,
        'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 80, 0,
        NULL, '1', '2020-08-12 15:59:25.214', '1', '2020-08-12 15:59:25.214', '0');
INSERT INTO `gen_table_column`
VALUES ('dbcfcfeca4d302756fa9f64ff2388434', '8012923c1e3bdf0ed8c3071a32d32685', 'origin_url', 'origin_url', NULL,
        'varchar(255)', 'String', 'originUrl', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 30, 0,
        NULL, '1', '2020-08-12 15:59:12.765', '1', '2020-08-12 15:40:26.696', '1');
INSERT INTO `gen_table_column`
VALUES ('dd5d52142c9c92d84c1726e5e3f09c8a', '201a2bb8de59d0e0c2a9743f60f6ec11', 'logo_url', 'logo的地址', NULL,
        'varchar(255)', 'String', 'logoUrl', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 0,
        NULL, '1', '2020-08-12 15:59:25.211', '1', '2020-08-12 15:59:25.211', '0');
INSERT INTO `gen_table_column`
VALUES ('e15897830eb44b927258c414c9af7745', '31b4af23fe3bd30452e7a8b4c367034a', 'created_by', 'created_by', NULL,
        'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 40, 0,
        NULL, '1', '2020-08-12 10:46:39.624', '1', '2020-08-12 10:46:39.624', '0');
INSERT INTO `gen_table_column`
VALUES ('e32b473d29b40ce5df840f2475914421', 'ff7056ae6be7d5994b8d870549fc1c6a', 'template_code', '模板代码？', NULL,
        'varchar(255)', 'String', 'templateCode', b'0', b'0', b'0', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 50,
        0, NULL, '1', '2020-08-12 15:45:52.529', '1', '2020-08-12 15:45:52.529', '0');
INSERT INTO `gen_table_column`
VALUES ('e40f4edc415e64e1e3acdb9d680c2013', '0788ece2109b1485ab5d53f7fa14f9ab', 'created_date', '创建时间', NULL,
        'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect',
        '', NULL, 100, 0, NULL, '1', '2020-08-12 10:46:17.982', '1', '2020-08-12 10:46:11.306', '1');
INSERT INTO `gen_table_column`
VALUES ('e7ba63640e181f3d8778718c9c6b8c03', '6ecc39110e24a46af9df21ae5c725155', 'version', 'version', NULL, 'int',
        'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 0, NULL, '1',
        '2020-08-12 11:17:04.945', '1', '2020-08-12 10:46:11.499', '1');
INSERT INTO `gen_table_column`
VALUES ('e811026943a2a57f4e7f537745a5a07c', '201a2bb8de59d0e0c2a9743f60f6ec11', 'created_date', '创建时间', NULL,
        'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect',
        '', NULL, 90, 0, NULL, '1', '2020-08-12 15:59:25.214', '1', '2020-08-12 15:59:25.214', '0');
INSERT INTO `gen_table_column`
VALUES ('e92900abbf84e0164e3dc277042b4bac', '7dbc0aa32d25dbffcba0ff2940842b1c', 'name', '前端页面名字', NULL, 'varchar(64)',
        'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 0, NULL, '1',
        '2020-08-12 10:23:42.175', '1', '2020-08-12 10:23:42.175', '0');
INSERT INTO `gen_table_column`
VALUES ('ea0fd16f8762a129041e58874b29cc9c', '5419e930e63aecec3b0266776cca0fbf', 'video_id', '视频id，等视频上传后更新', NULL,
        'varchar(32)', 'String', 'videoId', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 50, 0,
        NULL, '1', '2020-08-12 15:35:16.454', '1', '2020-08-12 15:35:16.454', '0');
INSERT INTO `gen_table_column`
VALUES ('f1426cbaf3455f0c0d60b16e145f1453', '0291c0ba2aeb9b7e290a5d73f3751189', 'name', '企业名称/个人名称', NULL,
        'varchar(255)', 'String', 'name', b'0', b'0', b'0', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 0,
        NULL, '1', '2020-08-12 11:17:26.586', '1', '2020-08-12 11:17:26.586', '0');
INSERT INTO `gen_table_column`
VALUES ('f2a4f1e1d94fabe7e9ad916448d37aab', '5419e930e63aecec3b0266776cca0fbf', 'price', '支付金额', NULL, 'decimal(20,2)',
        'Double', 'price', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL, 70, 0, NULL, '1',
        '2020-08-12 15:35:16.457', '1', '2020-08-12 15:35:16.457', '0');
INSERT INTO `gen_table_column`
VALUES ('f3319ffdda208e2605d572d5b0b26b84', '31b4af23fe3bd30452e7a8b4c367034a', 'last_modified_by', 'last_modified_by',
        NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '',
        NULL, 60, 0, NULL, '1', '2020-08-12 10:46:39.625', '1', '2020-08-12 10:46:39.625', '0');
INSERT INTO `gen_table_column`
VALUES ('f36511cd513e5ded69f45dd5ec2ebd88', '0788ece2109b1485ab5d53f7fa14f9ab', 'account_number', '开户账号', NULL,
        'varchar(32)', 'String', 'accountNumber', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80,
        0, NULL, '1', '2020-08-12 10:46:17.982', '1', '2020-08-12 10:46:11.305', '1');
INSERT INTO `gen_table_column`
VALUES ('f3fab63e1415cafebf5e0b08e3bc7477', '201a2bb8de59d0e0c2a9743f60f6ec11', 'name', '视频名字', NULL, 'varchar(255)',
        'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 30, 0, NULL, '1',
        '2020-08-12 15:59:25.210', '1', '2020-08-12 15:59:25.210', '0');
INSERT INTO `gen_table_column`
VALUES ('f596b920c8fd31595d7949281639ce7b', '0291c0ba2aeb9b7e290a5d73f3751189', 'last_modified_by', 'last_modified_by',
        NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '',
        NULL, 120, 0, NULL, '1', '2020-08-12 11:17:26.593', '1', '2020-08-12 11:17:26.593', '0');
INSERT INTO `gen_table_column`
VALUES ('f82509fbd3323babad1146c24583aca8', 'e51850e0e9e0444fb581fb6bf65dd11e', 'created_by', 'created_by', NULL,
        'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 90, 0,
        NULL, '1', '2020-08-12 15:55:21.179', '1', '2020-08-12 15:53:36.831', '1');
INSERT INTO `gen_table_column`
VALUES ('f927ae71a50d476e93fc2698792625ab', '31b4af23fe3bd30452e7a8b4c367034a', 'id', 'id', NULL, 'varchar(32)',
        'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1',
        '2020-08-12 10:46:39.620', '1', '2020-08-12 10:46:39.620', '0');
INSERT INTO `gen_table_column`
VALUES ('fa454091d04dc2b3c6870e4567defe29', '0291c0ba2aeb9b7e290a5d73f3751189', 'company_location', '注册地址', NULL,
        'varchar(255)', 'String', 'companyLocation', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL,
        60, 0, NULL, '1', '2020-08-12 11:17:26.589', '1', '2020-08-12 11:17:26.589', '0');
INSERT INTO `gen_table_column`
VALUES ('fb26d361859a0e8f189e277537a466b2', '31b4af23fe3bd30452e7a8b4c367034a', 'invoice_id', '发票id(数量统计用后台加一下就好)',
        NULL, 'varchar(32)', 'String', 'invoiceId', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'eq', 'input', '', NULL,
        30, 0, NULL, '1', '2020-08-12 10:46:39.623', '1', '2020-08-12 10:46:39.623', '0');

-- ----------------------------
-- Table structure for gen_table_fk
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_fk`;
CREATE TABLE `gen_table_fk`
(
    `id`                 varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL COMMENT '编号',
    `gen_table_id`       varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL     DEFAULT NULL COMMENT '归属表编号',
    `name`               varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '名称',
    `comments`           varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '描述',
    `jdbc_type`          varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '列的数据类型的字节长度',
    `java_type`          varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT 'JAVA类型',
    `java_field`         varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT 'JAVA字段名',
    `is_pk`              char(1) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL     DEFAULT NULL COMMENT '是否主键',
    `is_unique`          char(1) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL     DEFAULT '0' COMMENT '是否唯一（1：是；0：否）',
    `is_null`            char(1) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL     DEFAULT NULL COMMENT '是否可为空',
    `is_insert`          char(1) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL     DEFAULT NULL COMMENT '是否为插入字段',
    `is_edit`            char(1) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL     DEFAULT NULL COMMENT '是否编辑字段',
    `is_list`            char(1) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL     DEFAULT NULL COMMENT '是否列表字段',
    `is_query`           char(1) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL     DEFAULT NULL COMMENT '是否查询字段',
    `query_type`         varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
    `show_type`          varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
    `dict_type`          varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '字典类型',
    `settings`           varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL     DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
    `sort`               decimal(10, 0)                                           NULL     DEFAULT NULL COMMENT '排序（升序）',
    `version`            int(0)                                                   NULL     DEFAULT 0 COMMENT '默认0，必填，离线乐观锁',
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '描述',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL,
    `created_date`       timestamp(3)                                             NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL     DEFAULT NULL,
    `last_modified_date` timestamp(3)                                             NULL     DEFAULT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin        NULL     DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `gen_table_column_table_id` (`gen_table_id`) USING BTREE,
    INDEX `gen_table_column_name` (`name`) USING BTREE,
    INDEX `gen_table_column_sort` (`sort`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '业务表字段'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`
(
    `sched_name`    varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `trigger_name`  varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `blob_data`     blob                                                          NULL,
    PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
    CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`
(
    `sched_name`    varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `calendar`      blob                                                          NOT NULL,
    PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`
(
    `sched_name`      varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `trigger_name`    varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `trigger_group`   varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `time_zone_id`    varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL,
    PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
    CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`
(
    `sched_name`        varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `entry_id`          varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `trigger_name`      varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `trigger_group`     varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `instance_name`     varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `fired_time`        bigint(0)                                                     NOT NULL,
    `sched_time`        bigint(0)                                                     NOT NULL,
    `priority`          int(0)                                                        NOT NULL,
    `state`             varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `job_name`          varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `job_group`         varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `is_nonconcurrent`  varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NULL DEFAULT NULL,
    `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NULL DEFAULT NULL,
    PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`
(
    `sched_name`        varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `job_name`          varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `job_group`         varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `description`       varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `job_class_name`    varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `is_durable`        varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NOT NULL,
    `is_nonconcurrent`  varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NOT NULL,
    `is_update_data`    varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NOT NULL,
    `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NOT NULL,
    `job_data`          blob                                                          NULL,
    PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`
(
    `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `lock_name`  varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`
(
    `sched_name`    varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`
(
    `sched_name`        varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `instance_name`     varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `last_checkin_time` bigint(0)                                                     NOT NULL,
    `checkin_interval`  bigint(0)                                                     NOT NULL,
    PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`
(
    `sched_name`      varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `trigger_name`    varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `trigger_group`   varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `repeat_count`    bigint(0)                                                     NOT NULL,
    `repeat_interval` bigint(0)                                                     NOT NULL,
    `times_triggered` bigint(0)                                                     NOT NULL,
    PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
    CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`
(
    `sched_name`    varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `trigger_name`  varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `str_prop_1`    varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `str_prop_2`    varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `str_prop_3`    varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `int_prop_1`    int(0)                                                        NULL DEFAULT NULL,
    `int_prop_2`    int(0)                                                        NULL DEFAULT NULL,
    `long_prop_1`   bigint(0)                                                     NULL DEFAULT NULL,
    `long_prop_2`   bigint(0)                                                     NULL DEFAULT NULL,
    `dec_prop_1`    decimal(13, 4)                                                NULL DEFAULT NULL,
    `dec_prop_2`    decimal(13, 4)                                                NULL DEFAULT NULL,
    `bool_prop_1`   varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NULL DEFAULT NULL,
    `bool_prop_2`   varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NULL DEFAULT NULL,
    PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
    CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`
(
    `sched_name`     varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `trigger_name`   varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `trigger_group`  varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `job_name`       varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `job_group`      varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `description`    varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `next_fire_time` bigint(0)                                                     NULL DEFAULT NULL,
    `prev_fire_time` bigint(0)                                                     NULL DEFAULT NULL,
    `priority`       int(0)                                                        NULL DEFAULT NULL,
    `trigger_state`  varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `trigger_type`   varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NOT NULL,
    `start_time`     bigint(0)                                                     NOT NULL,
    `end_time`       bigint(0)                                                     NULL DEFAULT NULL,
    `calendar_name`  varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `misfire_instr`  smallint(0)                                                   NULL DEFAULT NULL,
    `job_data`       blob                                                          NULL,
    PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
    INDEX `sched_name` (`sched_name`, `job_name`, `job_group`) USING BTREE,
    CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`
(
    `id`                 varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL,
    `parent_id`          varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL DEFAULT NULL,
    `parent_ids`         varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单IDs',
    `name`               varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL DEFAULT NULL COMMENT '部门名称',
    `sort`               int(0)                                                   NULL DEFAULT NULL COMMENT '排序',
    `leaf`               bit(1)                                                   NULL DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
    `available`          char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin        NULL DEFAULT '1' COMMENT '1-正常，0-锁定',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL,
    `created_date`       timestamp(3)                                             NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL DEFAULT NULL,
    `last_modified_date` timestamp(3)                                             NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
    `version`            int(0)                                                   NOT NULL,
    `description`        varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL DEFAULT NULL COMMENT '描述',
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin        NULL DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '部门管理'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept`
VALUES ('1', '-1', NULL, '总部', 30, b'0', '1', '1', '2020-05-15 11:26:57.020', '1', '2020-05-20 12:09:24.266', 12, '',
        '0');
INSERT INTO `sys_dept`
VALUES ('4981e65fbb6059f3a5ceddd6b3426e6d', '9e4dcac1683359bfeac1871ccdc29e9f', '9e4dcac1683359bfeac1871ccdc29e9f,',
        'ddd', 1, b'1', '1', '1', '2020-05-15 12:05:18.140', '1', '2020-05-15 12:05:23.939', 0, NULL, '1');
INSERT INTO `sys_dept`
VALUES ('6304292a4ecb1448c33447adc0c35f08', '1', '1,', '运营部', 30, b'1', '1', '1', '2020-05-15 12:03:46.542', '1',
        '2020-05-15 14:27:11.787', 2, '', '0');
INSERT INTO `sys_dept`
VALUES ('701903b72179df2c79d383f621eab9c8', '1', '1,', 'AI部', 30, b'1', '1', '1', '2020-05-15 12:04:11.395', '1',
        '2020-05-15 12:04:11.395', 0, NULL, '0');
INSERT INTO `sys_dept`
VALUES ('9e4dcac1683359bfeac1871ccdc29e9f', '-1', NULL, 'test', 1, b'0', '1', '1', '2020-05-15 12:05:05.919', '1',
        '2020-05-15 12:05:23.939', 1, NULL, '1');
INSERT INTO `sys_dept`
VALUES ('c095173c3aebcd7ff9c6177fbf7a8b69', '-1', NULL, '平台', 30, b'1', '1', '1', '2020-05-15 11:28:08.383', '1',
        '2020-05-15 12:04:55.462', 2, NULL, '0');
INSERT INTO `sys_dept`
VALUES ('db32c981785f619401518127c48b6247', '1', '1,', '测试部', 30, b'1', '1', '1', '2020-05-15 12:03:57.184', '1',
        '2020-05-15 12:03:57.184', 0, NULL, '0');
INSERT INTO `sys_dept`
VALUES ('f52e1e844bf0fbadf5213214fb621e27', '1', '1,', '开发部', 30, b'1', '1', '1', '2020-05-15 12:03:23.518', '1',
        '2020-05-20 12:09:24.277', 3, NULL, '0');

-- ----------------------------
-- Table structure for sys_dept_relation
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_relation`;
CREATE TABLE `sys_dept_relation`
(
    `ancestor`   varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '祖先节点',
    `descendant` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL COMMENT '后代节点',
    `del_flag`   char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin          NULL DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`ancestor`, `descendant`) USING BTREE,
    INDEX `idx1` (`ancestor`) USING BTREE,
    INDEX `idx2` (`descendant`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = latin1
  COLLATE = latin1_swedish_ci COMMENT = '部门关系表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept_relation
-- ----------------------------
INSERT INTO `sys_dept_relation`
VALUES ('1', '1', '0');
INSERT INTO `sys_dept_relation`
VALUES ('1', '6304292a4ecb1448c33447adc0c35f08', '0');
INSERT INTO `sys_dept_relation`
VALUES ('1', '701903b72179df2c79d383f621eab9c8', '0');
INSERT INTO `sys_dept_relation`
VALUES ('1', 'db32c981785f619401518127c48b6247', '0');
INSERT INTO `sys_dept_relation`
VALUES ('1', 'f52e1e844bf0fbadf5213214fb621e27', '0');
INSERT INTO `sys_dept_relation`
VALUES ('4981e65fbb6059f3a5ceddd6b3426e6d', '4981e65fbb6059f3a5ceddd6b3426e6d', '1');
INSERT INTO `sys_dept_relation`
VALUES ('6304292a4ecb1448c33447adc0c35f08', '6304292a4ecb1448c33447adc0c35f08', '0');
INSERT INTO `sys_dept_relation`
VALUES ('701903b72179df2c79d383f621eab9c8', '701903b72179df2c79d383f621eab9c8', '0');
INSERT INTO `sys_dept_relation`
VALUES ('9e4dcac1683359bfeac1871ccdc29e9f', '4981e65fbb6059f3a5ceddd6b3426e6d', '1');
INSERT INTO `sys_dept_relation`
VALUES ('9e4dcac1683359bfeac1871ccdc29e9f', '9e4dcac1683359bfeac1871ccdc29e9f', '1');
INSERT INTO `sys_dept_relation`
VALUES ('c095173c3aebcd7ff9c6177fbf7a8b69', 'c095173c3aebcd7ff9c6177fbf7a8b69', '0');
INSERT INTO `sys_dept_relation`
VALUES ('db32c981785f619401518127c48b6247', 'db32c981785f619401518127c48b6247', '0');
INSERT INTO `sys_dept_relation`
VALUES ('f52e1e844bf0fbadf5213214fb621e27', 'f52e1e844bf0fbadf5213214fb621e27', '0');

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`
(
    `id`                 varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL COMMENT '编号',
    `name`               varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL COMMENT '标签名',
    `val`                varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '数据值',
    `code`               varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL COMMENT '类型',
    `parent_id`          varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL     DEFAULT NULL COMMENT '父菜单ID',
    `parent_ids`         varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL     DEFAULT NULL COMMENT '父菜单IDs',
    `sort`               int(0)                                                   NOT NULL COMMENT '排序（升序）',
    `available`          bit(1)                                                   NULL     DEFAULT b'1' COMMENT '是否显示1 是0否',
    `leaf`               bit(1)                                                   NULL     DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL,
    `created_date`       timestamp(3)                                             NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL     DEFAULT NULL,
    `last_modified_date` timestamp(3)                                             NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
    `version`            int(0)                                                   NOT NULL DEFAULT 0,
    `description`        varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '描述',
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin        NULL     DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `sys_dict_value` (`val`) USING BTREE,
    INDEX `sys_dict_label` (`name`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '字典表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict`
VALUES ('05d01334ecdbe94b856038a32a42512b', '任务分组', NULL, 'quartz_job_group', 'cfd5f62f601817a3b0f38f5ccb1f5128',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-15 16:33:54.745', '1',
        '2020-05-16 10:24:03.237', 9, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('0b2420638683f1eec41242beb9912069', '在线', 'on_line', 'sys_online_status_on_line',
        'f3592a047c466e348279983336ebaf28', '1,cfd5f62f601817a3b0f38f5ccb1f5128,f3592a047c466e348279983336ebaf28,', 30,
        b'1', b'1', '1', '2019-08-11 11:17:28.210', '1', '2020-05-15 20:54:54.622', 2, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('0da02abef85f0c0b4350eaeefb4ca78d', '仅本人数据', '4', 'sys_data_scope_4', 'aa294a48211a2deb5c7d76c5e90dc28e',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 40, b'1', b'1', '1',
        '2019-07-14 06:00:03.000', '1', '2020-05-15 20:54:54.622', 7, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('0ef7242f2bb88fdbdcbc56e7a879efb0', '查看', 'VIEW', 'sys_business_type_view', 'e0696db908c87ad57a85c6b326348dbd',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 10, b'1', b'1', '1',
        '2019-08-07 16:49:39.000', '1', '2020-05-17 13:48:58.580', 8, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('0fdd548394368b4969136f32c435fd98', '菜单', '1', 'sys_menu_type_1', 'e26ee931e276a099fb876541ca18756f',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 20, b'1', b'1', '1',
        '2019-07-14 06:04:44.000', '1', '2020-05-15 21:02:26.017', 7, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('1', '数据字典', '', 'base', '-1', NULL, 1, b'1', b'0', '1', '2018-07-09 06:16:14.000', '1',
        '2020-05-25 11:30:54.943', 16, '', '0');
INSERT INTO `sys_dict`
VALUES ('13276f100593667c3bd40ab8fea734b4', '立即执行', '1', 'quartz_misfire_policy_1', 'cb3d07975904460c94e9e2b30755c04b',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,cb3d07975904460c94e9e2b30755c04b,', 10, b'1', b'1', '1',
        '2019-08-15 10:24:19.706', '1', '2020-05-16 11:22:07.230', 5, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('181dd29afa852bd47a5ae8dd2e02a623', '正常', '1', 'sys_status_1', '952c07b027bf0be298a9243af701b8c5',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,952c07b027bf0be298a9243af701b8c5,', 30, b'1', b'1', '1',
        '2019-08-14 11:28:01.693', '1', '2020-05-15 20:54:54.622', 2, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('2', '是否标识', '', 'sys_flag', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 10,
        b'1', b'0', '1', '2019-06-02 17:17:44.000', '1', '2020-05-15 20:54:54.622', 19, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('269ebbfff898cf1db0d243e3f7774d2c', '业务数据', 'biz', 'biz', '1', '1,', 30, b'1', b'1', '1',
        '2019-07-14 04:01:51.000', '1', '2020-05-25 11:30:54.952', 5, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('2ec9dffe7cb0dea12c8e4e2a90279711', '强退', 'FORCE_LOGOUT', 'sys_business_type_force_logout',
        'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 70,
        b'1', b'1', '1', '2019-08-07 16:52:15.681', '1', '2020-05-17 13:50:42.409', 5, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('3', '是', '1', 'sys_flag_yes', '2', '1,cfd5f62f601817a3b0f38f5ccb1f5128,2,', 10, b'1', b'1', '1',
        '2018-07-09 06:15:40.000', '1', '2020-05-15 20:54:54.622', 7, '', '0');
INSERT INTO `sys_dict`
VALUES ('3190c222f999f9493e5773deec2d84f1', '登录', 'LOGIN', 'sys_business_type_login',
        'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 100,
        b'0', b'1', '1', '2020-05-27 11:41:37.787', '1', '2020-05-29 22:29:29.992', 1, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('31d677b181cebb9bde79b78f32e1e8a3', '其他', 'OTHER', 'sys_operate_type_other', '6b8211aef2fec451b0398b19857443a7',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 10, b'1', b'1', '1',
        '2019-08-07 16:48:21.644', '1', '2020-05-20 12:09:36.021', 6, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('356f3304462386a8827d44b9e6c9482c', '运行中', '1', 'quartz_job_status_1', 'c7243dfd9599957c281be8be786708d5',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,c7243dfd9599957c281be8be786708d5,', 10, b'1', b'1', '1',
        '2020-05-16 10:14:46.614', '1', '2020-05-16 10:31:32.619', 2, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('3e949b67e0c5be3357bdcce9705f7433', '放弃执行', '3', 'quartz_misfire_policy_3', 'cb3d07975904460c94e9e2b30755c04b',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,cb3d07975904460c94e9e2b30755c04b,', 30, b'1', b'1', '1',
        '2019-08-15 10:24:54.175', '1', '2020-05-16 11:21:48.328', 4, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('4', '否', '0', 'sys_flag_no', '2', '1,cfd5f62f601817a3b0f38f5ccb1f5128,2,', 30, b'1', b'1', '1',
        '2019-06-02 17:26:40.000', '1', '2020-05-15 20:54:54.622', 8, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('4198b5e10fe052546ebb689b4103590e', '所在机构数据', '3', 'sys_data_scope_3', 'aa294a48211a2deb5c7d76c5e90dc28e',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 30, b'1', b'1', '1',
        '2019-07-14 05:59:13.000', '1', '2020-05-15 20:54:54.622', 9, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('4ebd555fb352328cb2db93e15d3243ad', '系统', 'SYSTEM', 'quartz_job_group_system',
        '05d01334ecdbe94b856038a32a42512b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,05d01334ecdbe94b856038a32a42512b,', 20,
        b'1', b'1', '1', '2019-08-15 16:34:47.139', '1', '2020-05-16 10:23:56.949', 5, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('51828811168cd9f0ee1d118068a7d0b9', '编辑', 'EDIT', 'sys_business_type_edit', 'e0696db908c87ad57a85c6b326348dbd',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 20, b'1', b'1', '1',
        '2019-08-07 16:50:20.634', '1', '2020-05-17 13:49:05.059', 6, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('5933a853cd0199b00424d66f4b92dda3', '所在机构及以下数据', '2', 'sys_data_scope_2', 'aa294a48211a2deb5c7d76c5e90dc28e',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 20, b'1', b'1', '1',
        '2019-07-14 05:53:55.000', '1', '2020-05-15 20:54:54.622', 9, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('5f2414b2670c9a66c1d5364613caa654', '后台用户', 'MANAGE', 'sys_operate_type_manage',
        '6b8211aef2fec451b0398b19857443a7', '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 20,
        b'1', b'1', '1', '2019-08-07 16:48:40.344', '1', '2020-05-20 12:09:36.024', 6, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('6b8211aef2fec451b0398b19857443a7', '操作人类别', NULL, 'sys_operator_type', 'cfd5f62f601817a3b0f38f5ccb1f5128',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-07 15:37:09.613', '1',
        '2020-05-20 12:09:36.011', 12, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('6e4bba74f32df9149d69f8e9bb19cd9d', '目录', '0', 'sys_menu_type_0', 'e26ee931e276a099fb876541ca18756f',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 10, b'1', b'1', '1',
        '2019-07-14 06:04:10.000', '1', '2020-05-15 21:02:15.230', 7, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('764d1eaf8a39698fc85a7204c96e7089', '生成代码', 'GEN_CODE', 'sys_business_type_gen_code',
        'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 80,
        b'1', b'1', '1', '2019-08-07 16:52:36.997', '1', '2020-05-17 13:51:07.250', 6, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('80b084e162b0a30b348a45ff29e5b326', '导出', 'EXPORT', 'sys_business_type_export',
        'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 50,
        b'1', b'1', '1', '2019-08-07 16:51:33.286', '1', '2020-05-17 13:49:43.288', 5, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('8153bd2af73b6d59eed9f34d2bc05bb9', '删除', 'DELETE', 'sys_business_type_delete',
        'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 40,
        b'1', b'1', '1', '2019-08-07 16:50:45.270', '1', '2020-05-17 13:48:51.169', 5, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('8883abe4dcf9390df69a5740050abf74', '离线', 'off_line', 'sys_online_status_off_line',
        'f3592a047c466e348279983336ebaf28', '1,cfd5f62f601817a3b0f38f5ccb1f5128,f3592a047c466e348279983336ebaf28,', 30,
        b'1', b'1', '1', '2019-08-11 11:17:50.132', '1', '2020-05-15 20:54:54.622', 2, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('8c4589d0a32c9b84b6254507354a195b', 'test', 'test', 'test', '-1', NULL, 30, b'1', b'1', '1',
        '2019-07-14 03:59:38.000', '1', '2019-07-14 04:00:28.000', 0, NULL, '1');
INSERT INTO `sys_dict`
VALUES ('94e00baf14b640d793c133fb7bfa4c9a', '默认', 'DEFAULT', 'quartz_job_group_default',
        '05d01334ecdbe94b856038a32a42512b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,05d01334ecdbe94b856038a32a42512b,', 10,
        b'1', b'1', '1', '2019-08-15 16:34:28.547', '1', '2020-05-16 10:24:03.248', 5, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('952c07b027bf0be298a9243af701b8c5', '状态', NULL, 'sys_status', 'cfd5f62f601817a3b0f38f5ccb1f5128',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-14 11:26:50.424', '1',
        '2020-05-15 20:54:54.622', 5, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('a5dfce34bdb7aa99560e8c0d393a632f', '全部', '1', 'sys_data_scope_1', 'aa294a48211a2deb5c7d76c5e90dc28e',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 10, b'1', b'1', '1',
        '2019-07-14 05:52:44.000', '1', '2020-05-15 20:54:54.622', 9, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('aa294a48211a2deb5c7d76c5e90dc28e', '数据范围', '', 'sys_data_scope', 'cfd5f62f601817a3b0f38f5ccb1f5128',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-07-14 05:50:08.000', '1',
        '2020-05-20 11:11:12.915', 19, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('b672448a74c1d1a47eb1378e3d8c6dc9', '导入', 'IMPORT', 'sys_business_type_import',
        'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 60,
        b'1', b'1', '1', '2019-08-07 16:51:45.855', '1', '2020-05-17 13:50:08.748', 5, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('bec679404aedc7e75eeeef2ac68d9107', '其他', 'OTHER', 'sys_business_type_other',
        'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 90,
        b'1', b'1', '1', '2020-05-17 13:45:33.764', '1', '2020-05-17 13:49:14.282', 1, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('c46ec99af2c1f967bf10cf2c0d96a6c5', '按明细设置', '5', 'sys_data_scope_5', 'aa294a48211a2deb5c7d76c5e90dc28e',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 50, b'1', b'1', '1',
        '2019-07-14 06:01:11.000', '1', '2020-05-20 11:11:12.927', 8, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('c7243dfd9599957c281be8be786708d5', '任务状态', NULL, 'quartz_job_status', 'cfd5f62f601817a3b0f38f5ccb1f5128',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2020-05-16 10:13:18.543', '1',
        '2020-05-16 10:31:43.851', 6, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('cb3d07975904460c94e9e2b30755c04b', '计划执行错误策略', NULL, 'quartz_misfire_policy',
        'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1',
        '2019-08-15 10:23:54.460', '1', '2020-05-16 11:22:16.976', 11, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('cfd5f62f601817a3b0f38f5ccb1f5128', '系统数据', 'sys', 'sys', '1', '1,', 30, b'1', b'0', '1',
        '2019-07-14 01:13:12.000', '1', '2020-05-20 12:09:35.998', 28, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('decc4b5f8996c755ba6e5a097486e362', '已暂停', '0', 'quartz_job_status_0', 'c7243dfd9599957c281be8be786708d5',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,c7243dfd9599957c281be8be786708d5,', 20, b'1', b'1', '1',
        '2020-05-16 10:15:08.604', '1', '2020-05-16 10:31:43.863', 2, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('e0696db908c87ad57a85c6b326348dbd', '业务操作类型', NULL, 'sys_business_type', 'cfd5f62f601817a3b0f38f5ccb1f5128',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-07 15:33:35.000', '1',
        '2020-05-27 11:41:57.261', 36, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('e26ee931e276a099fb876541ca18756f', '菜单类型', '', 'sys_menu_type', 'cfd5f62f601817a3b0f38f5ccb1f5128',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-07-14 06:01:48.000', '1',
        '2020-05-15 21:02:34.965', 14, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('e7891a6351a2e143899849b2955851b2', '锁定', 'LOCK', 'sys_business_type_lock', 'e0696db908c87ad57a85c6b326348dbd',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 30, b'1', b'1', '1',
        '2019-08-07 16:50:32.457', '1', '2020-05-17 13:49:23.225', 6, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('ef0368c6fd52ee8f1f4270869da00f18', '按钮', '2', 'sys_menu_type_2', 'e26ee931e276a099fb876541ca18756f',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 30, b'1', b'1', '1',
        '2019-08-07 13:55:24.531', '1', '2020-05-15 21:02:34.974', 8, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('f3592a047c466e348279983336ebaf28', '在线状态', NULL, 'sys_online_status', 'cfd5f62f601817a3b0f38f5ccb1f5128',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-11 11:16:52.095', '1',
        '2020-05-15 20:54:54.622', 4, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('f35adf75d9ab0ca5cec43815b7db5274', '执行一次', '2', 'quartz_misfire_policy_2', 'cb3d07975904460c94e9e2b30755c04b',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,cb3d07975904460c94e9e2b30755c04b,', 20, b'1', b'1', '1',
        '2019-08-15 10:24:39.273', '1', '2020-05-16 11:22:16.986', 5, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('f83a718756762758707c67db3d271c9d', '手机端用户', 'MOBILE', 'sys_operate_type_moblie',
        '6b8211aef2fec451b0398b19857443a7', '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 30,
        b'1', b'1', '1', '2019-08-07 16:49:00.766', '1', '2020-05-20 12:09:36.025', 6, NULL, '0');
INSERT INTO `sys_dict`
VALUES ('fafe8843b2f4091f8096dc0df09c300c', '失败', '0', 'sys_status_0', '952c07b027bf0be298a9243af701b8c5',
        '1,cfd5f62f601817a3b0f38f5ccb1f5128,952c07b027bf0be298a9243af701b8c5,', 30, b'1', b'1', '1',
        '2019-08-14 11:28:11.000', '1', '2020-05-15 20:54:54.622', 3, NULL, '0');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`
(
    `id`                 int(0)                                                        NOT NULL AUTO_INCREMENT COMMENT '任务ID',
    `name`               varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL DEFAULT '' COMMENT '任务名称',
    `group`              varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
    `invoke_target`      varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
    `cron_expression`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL     DEFAULT '' COMMENT 'cron执行表达式',
    `misfire_policy`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL     DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
    `concurrent`         char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci      NULL     DEFAULT '1' COMMENT '是否并发执行（1允许 0禁止）',
    `sub_task`           varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL     DEFAULT NULL COMMENT '子任务id 多个用逗号隔开',
    `email`              varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL     DEFAULT NULL COMMENT '报警邮箱',
    `status`             char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci      NULL     DEFAULT '0' COMMENT '状态(1-运行中，0-暂停)',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci        NOT NULL,
    `created_date`       datetime(3)                                                   NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci        NULL     DEFAULT NULL,
    `last_modified_date` datetime(3)                                                   NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3),
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL     DEFAULT NULL COMMENT '描述',
    `version`            int(0)                                                        NOT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin             NULL     DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job`
VALUES (1, '系统默认（无参）', 'DEFAULT', 'simpleTask.doNoParams', '0/10 * * * * ?', '3', '1', '2', NULL, '0', '',
        '2019-08-14 10:21:36.000', '1', '2020-05-16 15:38:24.728', NULL, 9, '0');
INSERT INTO `sys_job`
VALUES (2, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '0/15 * * * * ?', '3', '1', NULL, NULL, '0', '',
        '2019-08-14 10:21:36.950', '1', '2020-05-16 15:28:24.387', NULL, 18, '0');
INSERT INTO `sys_job`
VALUES (3, '系统默认（多参）', 'DEFAULT', 'simpleTask.doMultipleParams(\'albedo\', true, 2000L, 316.50D, 100)',
        '0/20 * * * * ?', '3', '1', NULL, NULL, '0', '', '2019-08-14 10:21:36.000', '1', '2020-05-16 15:12:50.258',
        NULL, 4, '0');
INSERT INTO `sys_job`
VALUES (4, 'test', 'DEFAULT', 'test', '0/20 * * * * ?', '2', '1', '1', NULL, '0', '1', '2020-05-16 15:06:05.098', '1',
        '2020-05-16 15:21:10.516', NULL, 1, '1');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`
(
    `id`              bigint(0)                                                      NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
    `job_name`        varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NOT NULL COMMENT '任务名称',
    `job_group`       varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NOT NULL COMMENT '任务组名',
    `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT '' COMMENT 'cron执行表达式',
    `invoke_target`   varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '调用目标字符串',
    `job_message`     varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '日志信息',
    `status`          char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci       NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
    `start_time`      datetime(3)                                                    NULL DEFAULT NULL COMMENT '开始时间',
    `end_time`        datetime(3)                                                    NULL DEFAULT NULL COMMENT '结束时间',
    `create_time`     datetime(3)                                                    NULL DEFAULT NULL COMMENT '创建时间',
    `exception_info`  varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
    `description`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci        NULL DEFAULT NULL COMMENT '描述',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_log_operate
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_operate`;
CREATE TABLE `sys_log_operate`
(
    `id`            bigint(0)                                                     NOT NULL AUTO_INCREMENT COMMENT '编号',
    `title`         varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT '' COMMENT '日志标题',
    `log_type`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL COMMENT '日志类型',
    `username`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL COMMENT '用户名',
    `service_id`    varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci        NULL DEFAULT NULL COMMENT '服务ID',
    `ip_address`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL COMMENT 'IP地址',
    `ip_location`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
    `browser`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT '' COMMENT '浏览器类型',
    `os`            varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT '' COMMENT '操作系统',
    `user_agent`    varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci      NULL DEFAULT NULL COMMENT '用户代理',
    `request_uri`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL COMMENT '请求URI',
    `method`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL COMMENT '请求方法',
    `params`        text CHARACTER SET utf8 COLLATE utf8_general_ci               NULL COMMENT '操作提交的数据',
    `time`          mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci         NULL COMMENT '执行时间',
    `operator_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci        NULL DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
    `business_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci        NULL DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
    `exception`     text CHARACTER SET utf8 COLLATE utf8_general_ci               NULL COMMENT '异常信息',
    `created_by`    varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci        NULL DEFAULT NULL COMMENT '创建者',
    `created_date`  timestamp(3)                                                  NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `description`   varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL COMMENT '描述',
    `del_flag`      char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin             NULL DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `sys_log_create_by` (`created_by`) USING BTREE,
    INDEX `sys_log_request_uri` (`request_uri`) USING BTREE,
    INDEX `sys_log_create_date` (`created_date`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 703
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '操作日志表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log_operate
-- ----------------------------
INSERT INTO `sys_log_operate`
VALUES (668, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/authenticate', NULL,
        'password=111111&randomStr=91461597022704314&code=8x44&rememberMe=false&username=admin', NULL, 'MANAGE', '0',
        NULL, '1', '2020-08-10 09:25:10.978', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (669, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '547', 'MANAGE', '0', NULL, '1', '2020-08-10 09:25:17.736', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (670, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/authenticate', NULL,
        'password=111111&randomStr=86871597043556367&code=226w&rememberMe=false&username=admin', NULL, 'MANAGE', '0',
        NULL, '1', '2020-08-10 15:12:42.848', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (671, '令牌管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/persistent-token/', 'com.albedo.java.modules.sys.web.PersistentTokenResource.findPage()',
        '{\"persistentTokenQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '51', 'MANAGE', '0', NULL, '1', '2020-08-10 15:12:49.320', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (672, '在线用户查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/user-online/', 'com.albedo.java.modules.sys.web.UserOnlineResource.findPage()',
        '{\"userOnlineQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '23', 'MANAGE', '0', NULL, '1', '2020-08-10 15:12:54.736', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (673, '用户管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.findPage()',
        '{\"userQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '42', 'MANAGE', '0', NULL, '1', '2020-08-10 15:14:33.086', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (674, '用户管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.findPage()',
        '{\"userQueryCriteria\":{\"deptId\":\"c095173c3aebcd7ff9c6177fbf7a8b69\"},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '24', 'MANAGE', '0', NULL, '1', '2020-08-10 15:14:45.019', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (675, '用户管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.findPage()',
        '{\"userQueryCriteria\":{\"deptId\":\"6304292a4ecb1448c33447adc0c35f08\"},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '8', 'MANAGE', '0', NULL, '1', '2020-08-10 15:14:46.419', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (676, '用户管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.findPage()',
        '{\"userQueryCriteria\":{\"deptId\":\"6304292a4ecb1448c33447adc0c35f08\"},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-10 15:14:48.082', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (677, '用户管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.findPage()',
        '{\"userQueryCriteria\":{\"deptId\":\"db32c981785f619401518127c48b6247\"},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-10 15:14:48.757', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (678, '用户管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.findPage()',
        '{\"userQueryCriteria\":{\"deptId\":\"db32c981785f619401518127c48b6247\"},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-10 15:14:49.922', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (679, '用户管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.findPage()',
        '{\"userQueryCriteria\":{\"deptId\":\"f52e1e844bf0fbadf5213214fb621e27\"},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-10 15:14:50.537', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (680, '用户管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.findPage()',
        '{\"userQueryCriteria\":{\"deptId\":\"f52e1e844bf0fbadf5213214fb621e27\"},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-10 15:14:51.520', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (681, '用户管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.findPage()',
        '{\"userQueryCriteria\":{\"deptId\":\"6304292a4ecb1448c33447adc0c35f08\"},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-10 15:14:51.988', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (682, '用户管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.findPage()',
        '{\"userQueryCriteria\":{\"deptId\":\"6304292a4ecb1448c33447adc0c35f08\"},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-10 15:14:52.795', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (683, '用户管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.findPage()',
        '{\"userQueryCriteria\":{\"deptId\":\"1\"},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '23', 'MANAGE', '0', NULL, '1', '2020-08-10 15:14:53.642', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (684, '用户管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.findPage()',
        '{\"userQueryCriteria\":{\"deptId\":\"1\"},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '22', 'MANAGE', '0', NULL, '1', '2020-08-10 15:14:54.369', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (685, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-10 15:19:14.176', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (686, '用户管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.findPage()',
        '{\"userQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '32', 'MANAGE', '0', NULL, '1', '2020-08-10 15:19:16.981', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (687, '部门管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/dept/', 'com.albedo.java.modules.sys.web.DeptResource.findTreeList()', '{\"deptQueryCriteria\":{}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-10 15:19:23.396', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (688, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '11', 'MANAGE', '0', NULL, '1', '2020-08-10 15:19:44.801', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (689, '部门管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/dept/', 'com.albedo.java.modules.sys.web.DeptResource.findTreeList()', '{\"deptQueryCriteria\":{}}',
        '6', 'MANAGE', '0', NULL, '1', '2020-08-10 15:19:50.536', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (690, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '11', 'MANAGE', '0', NULL, '1', '2020-08-10 15:44:18.660', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (691, '部门管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/dept/', 'com.albedo.java.modules.sys.web.DeptResource.findTreeList()', '{\"deptQueryCriteria\":{}}',
        '6', 'MANAGE', '0', NULL, '1', '2020-08-10 15:44:19.506', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (692, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.48 Safari/537.36 Edg/85.0.564.23',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-10 15:44:22.411', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (693, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=31941597120889719&code=1&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-11 12:41:32.927', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (694, '配置支付宝', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/tool/aliPay', 'com.albedo.java.modules.tool.web.AliPayResource.updateConfig()',
        '{\"charset\":\"utf-8\",\"privateKey\":\"MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC5js8sInU10AJ0cAQ8UMMyXrQ+oHZEkVt5lBwsStmTJ7YikVYgbskx1YYEXTojRsWCb+SH/kDmDU4pK/u91SJ4KFCRMF2411piYuXU/jF96zKrADznYh/zAraqT6hvAIVtQAlMHN53nx16rLzZ/8jDEkaSwT7+HvHiS+7sxSojnu/3oV7BtgISoUNstmSe8WpWHOaWv19xyS+Mce9MY4BfseFhzTICUymUQdd/8hXA28/H6osUfAgsnxAKv7Wil3aJSgaJczWuflYOve0dJ3InZkhw5Cvr0atwpk8YKBQjy5CdkoHqvkOcIB+cYHXJKzOE5tqU7inSwVbHzOLQ3XbnAgMBAAECggEAVJp5eT0Ixg1eYSqFs9568WdetUNCSUchNxDBu6wxAbhUgfRUGZuJnnAll63OCTGGck+EGkFh48JjRcBpGoeoHLL88QXlZZbC/iLrea6gcDIhuvfzzOffe1RcZtDFEj9hlotg8dQj1tS0gy9pN9g4+EBH7zeu+fyv+qb2e/v1l6FkISXUjpkD7RLQr3ykjiiEw9BpeKb7j5s7Kdx1NNIzhkcQKNqlk8JrTGDNInbDM6inZfwwIO2R1DHinwdfKWkvOTODTYa2MoAvVMFT9Bec9FbLpoWp7ogv1JMV9svgrcF9XLzANZ/OQvkbe9TV9GWYvIbxN6qwQioKCWO4GPnCAQKBgQDgW5MgfhX8yjXqoaUy/d1VjI8dHeIyw8d+OBAYwaxRSlCfyQ+tieWcR2HdTzPca0T0GkWcKZm0ei5xRURgxt4DUDLXNh26HG0qObbtLJdu/AuBUuCqgOiLqJ2f1uIbrz6OZUHns+bT/jGW2Ws8+C13zTCZkZt9CaQsrp3QOGDx5wKBgQDTul39hp3ZPwGNFeZdkGoUoViOSd5Lhowd5wYMGAEXWRLlU8z+smT5v0POz9JnIbCRchIY2FAPKRdVTICzmPk2EPJFxYTcwaNbVqL6lN7J2IlXXMiit5QbiLauo55w7plwV6LQmKm9KV7JsZs5XwqF7CEovI7GevFzyD3w+uizAQKBgC3LY1eRhOlpWOIAhpjG6qOoohmeXOphvdmMlfSHq6WYFqbWwmV4rS5d/6LNpNdL6fItXqIGd8I34jzql49taCmi+A2nlR/E559j0mvM20gjGDIYeZUz5MOE8k+K6/IcrhcgofgqZ2ZED1ksHdB/E8DNWCswZl16V1FrfvjeWSNnAoGAMrBplCrIW5xz+J0Hm9rZKrs+AkK5D4fUv8vxbK/KgxZ2KaUYbNm0xv39c+PZUYuFRCz1HDGdaSPDTE6WeWjkMQd5mS6ikl9hhpqFRkyh0d0fdGToO9yLftQKOGE/q3XUEktI1XvXF0xyPwNgUCnq0QkpHyGVZPtGFxwXiDvpvgECgYA5PoB+nY8iDiRaJNko9w0hL4AeKogwf+4TbCw+KWVEn6jhuJa4LFTdSqp89PktQaoVpwv92el/AhYjWOl/jVCm122f9b7GyoelbjMNolToDwe5pF5RnSpEuDdLy9MfE8LnE3PlbE7E5BipQ3UjSebkgNboLHH/lNZA5qvEtvbfvQ==\",\"gatewayUrl\":\"https://openapi.alipaydev.com/gateway.do\",\"appId\":\"2016091700532697\",\"format\":\"JSON\",\"notifyUrl\":\"http://api.auauz.net/api/aliPay/notify\",\"signType\":\"RSA2\",\"id\":1,\"publicKey\":\"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAut9evKRuHJ/2QNfDlLwvN/S8l9hRAgPbb0u61bm4AtzaTGsLeMtScetxTWJnVvAVpMS9luhEJjt+Sbk5TNLArsgzzwARgaTKOLMT1TvWAK5EbHyI+eSrc3s7Awe1VYGwcubRFWDm16eQLv0k7iqiw+4mweHSz/wWyvBJVgwLoQ02btVtAQErCfSJCOmt0Q/oJQjj08YNRV4EKzB19+f5A+HQVAKy72dSybTzAK+3FPtTtNen/+b5wGeat7c32dhYHnGorPkPeXLtsqqUTp1su5fMfd4lElNdZaoCI7osZxWWUo17vBCZnyeXc9fk0qwD9mK6yRAxNbrY72Xx5VqIqwIDAQAB\",\"returnUrl\":\"http://localhost:8014/a/tool/aliPay/return\",\"sysServiceProviderId\":\"2088102176044281\"}',
        '21', 'MANAGE', '0', NULL, '1', '2020-08-11 12:42:29.929', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (695, '支付宝PC网页支付', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/tool/aliPay/toPayAsPC', 'com.albedo.java.modules.tool.web.AliPayResource.toPayAsPc()',
        '{\"totalAmount\":\"1\",\"subject\":\"1\",\"body\":\"111\"}', '67', 'MANAGE', '0', NULL, '1',
        '2020-08-11 12:42:34.767', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (696, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=33201597121014510&code=1&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-11 12:43:37.572', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (697, '支付宝PC网页支付', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/tool/aliPay/toPayAsPC', 'com.albedo.java.modules.tool.web.AliPayResource.toPayAsPc()',
        '{\"totalAmount\":\"1\",\"subject\":\"1\",\"body\":\"111\"}', '56', 'MANAGE', '0', NULL, '1',
        '2020-08-11 12:43:41.340', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (698, '支付宝PC网页支付', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/tool/aliPay/toPayAsPC', 'com.albedo.java.modules.tool.web.AliPayResource.toPayAsPc()',
        '{\"totalAmount\":\"1\",\"subject\":\"1\",\"body\":\"111\"}', '20', 'MANAGE', '0', NULL, '1',
        '2020-08-11 12:44:54.482', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (699, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=77081597130623294&code=12&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-11 15:23:47.276', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (700, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=80521597190820269&code=1&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-12 08:07:04.206', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (701, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '267', 'MANAGE', '0', NULL, '1', '2020-08-12 08:07:11.778', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (702, '用户管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/user/', 'com.albedo.java.modules.sys.web.UserResource.findPage()',
        '{\"userQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '72', 'MANAGE', '0', NULL, '1', '2020-08-12 08:12:03.678', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (703, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=31721597198768415&code=1&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-12 10:19:31.985', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (704, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=82421597198786968&code=11&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-12 10:21:20.446', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (705, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '38', 'MANAGE', '0', NULL, '1', '2020-08-12 10:22:58.611', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (706, '业务表编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.save()',
        '{\"childList\":[],\"className\":\"TFront\",\"importList\":[\"com.baomidou.mybatisplus.annotation.*\",\"com.albedo.java.common.persistence.domain.IdEntity\",\"javax.validation.constraints.Size\",\"javax.validation.constraints.NotBlank\",\"com.albedo.java.common.core.annotation.DictType\"],\"statusExists\":false,\"createTimeExists\":false,\"pkColumn\":{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"主键id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  主键id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"主键id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"主键id\",\"unique\":false},\"parentExists\":false,\"pkList\":[\"id\"],\"comments\":\"t_front\",\"pkSqlName\":\"id\",\"updateTimeExists\":false,\"columnList\":[{\"$ref\":\"$.pkColumn\"},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=64, message=\\\"前端页面名字长度必须介于 1 和 64 之间\\\")\"],\"constantJavaField\":\"NAME\",\"dataLength\":64,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=64)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaField\":\"name\",\"javaFieldAttrs\":[],\"javaFieldId\":\"name\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(64)\",\"list\":true,\"name\":\"name\",\"nameAndTitle\":\"name  :  前端页面名字\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"like\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=64, message=\\\"前端页面名字长度必须介于 1 和 64 之间\\\")\"],\"simpleJavaField\":\"name\",\"size\":\"64\",\"sort\":20,\"title\":\"前端页面名字\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"前端页面地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"PATH\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"path\",\"javaFieldAttrs\":[],\"javaFieldId\":\"path\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"path\",\"nameAndTitle\":\"path  :  前端页面地址\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"前端页面地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"path\",\"size\":\"255\",\"sort\":30,\"title\":\"前端页面地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"广告语内容长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"ADWORD\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"adWord\",\"javaFieldAttrs\":[],\"javaFieldId\":\"adWord\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"ad_word\",\"nameAndTitle\":\"ad_word  :  广告语内容\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"广告语内容长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"adWord\",\"size\":\"255\",\"sort\":40,\"title\":\"广告语内容\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":50,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":60,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":70,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":80,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":90,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":100,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":110,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"childeExists\":false,\"notCompositeId\":true,\"pkColumnList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"主键id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  主键id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"主键id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"主键id\",\"unique\":false}],\"columnFormList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"主键id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  主键id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"主键id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"主键id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=64, message=\\\"前端页面名字长度必须介于 1 和 64 之间\\\")\"],\"constantJavaField\":\"NAME\",\"dataLength\":64,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=64)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaField\":\"name\",\"javaFieldAttrs\":[],\"javaFieldId\":\"name\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(64)\",\"list\":true,\"name\":\"name\",\"nameAndTitle\":\"name  :  前端页面名字\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"like\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=64, message=\\\"前端页面名字长度必须介于 1 和 64 之间\\\")\"],\"simpleJavaField\":\"name\",\"size\":\"64\",\"sort\":20,\"title\":\"前端页面名字\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"前端页面地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"PATH\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"path\",\"javaFieldAttrs\":[],\"javaFieldId\":\"path\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"path\",\"nameAndTitle\":\"path  :  前端页面地址\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"前端页面地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"path\",\"size\":\"255\",\"sort\":30,\"title\":\"前端页面地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"广告语内容长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"ADWORD\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"adWord\",\"javaFieldAttrs\":[],\"javaFieldId\":\"adWord\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"ad_word\",\"nameAndTitle\":\"ad_word  :  广告语内容\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"广告语内容长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"adWord\",\"size\":\"255\",\"sort\":40,\"title\":\"广告语内容\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":50,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":60,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":70,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":80,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":90,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":100,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":110,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"pkSize\":\"32\",\"name\":\"t_front\",\"compositeId\":false,\"nameAndTitle\":\"t_front  :  \",\"pkJavaType\":\"String\"}',
        '205', 'MANAGE', '0', NULL, '1', '2020-08-12 10:23:41.978', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (707, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '23', 'MANAGE', '0', NULL, '1', '2020-08-12 10:23:42.938', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (708, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '13', 'MANAGE', '0', NULL, '1', '2020-08-12 10:23:46.639', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (709, '生成方案编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.save()',
        '{\"functionAuthor\":\"admin\",\"functionName\":\"控制前端页面内容\",\"functionNameSimple\":\"t_front\",\"modalView\":false,\"moduleName\":\"t_front\",\"replaceFile\":false,\"genCode\":true,\"name\":\"前端内容控制\",\"tableId\":\"7dbc0aa32d25dbffcba0ff2940842b1c\",\"packageName\":\"com.albedo.java.modules\",\"category\":\"curd\"}',
        '382', 'MANAGE', '0', NULL, '1', '2020-08-12 10:24:39.669', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (710, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '13', 'MANAGE', '0', NULL, '1', '2020-08-12 10:24:43.592', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (711, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '11', 'MANAGE', '0', NULL, '1', '2020-08-12 10:24:45.905', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (712, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '263', 'MANAGE', '0', NULL, '1', '2020-08-12 10:24:53.277', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (713, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '8', 'MANAGE', '0', NULL, '1', '2020-08-12 10:24:54.942', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (714, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '232', 'MANAGE', '0', NULL, '1', '2020-08-12 10:24:58.310', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (715, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"fwb\",\"sort\":30,\"type\":\"0\",\"parentId\":\"-1\",\"path\":\"t_front/t-front\",\"component\":\"Layout\",\"name\":\"前端内容控制\",\"iframe\":0}',
        '22', 'MANAGE', '0', NULL, '1', '2020-08-12 10:25:52.830', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (716, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '252', 'MANAGE', '0', NULL, '1', '2020-08-12 10:25:53.041', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (717, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '231', 'MANAGE', '0', NULL, '1', '2020-08-12 10:26:05.469', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (718, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '237', 'MANAGE', '0', NULL, '1', '2020-08-12 10:26:12.287', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (719, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"fwb\",\"sort\":130,\"type\":\"0\",\"parentId\":\"-1\",\"path\":\"t_front/t-front\",\"component\":\"Layout\",\"name\":\"前端内容控制\",\"id\":\"1120fe9bc06066fae0aec08325bdf56e\",\"iframe\":0}',
        '38', 'MANAGE', '0', NULL, '1', '2020-08-12 10:26:20.927', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (720, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '245', 'MANAGE', '0', NULL, '1', '2020-08-12 10:26:21.369', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (721, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"fwb\",\"sort\":130,\"type\":\"0\",\"parentId\":\"-1\",\"path\":\"/t_front\",\"component\":\"Layout\",\"name\":\"前端内容控制\",\"id\":\"1120fe9bc06066fae0aec08325bdf56e\",\"iframe\":0}',
        '42', 'MANAGE', '0', NULL, '1', '2020-08-12 10:26:38.440', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (722, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '230', 'MANAGE', '0', NULL, '1', '2020-08-12 10:26:38.911', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (723, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"dev\",\"permission\":\"t_front_tFront_view\",\"sort\":30,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t_front/t-front\",\"name\":\"内容控制\",\"iframe\":0}',
        '21', 'MANAGE', '0', NULL, '1', '2020-08-12 10:27:33.450', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (724, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '247', 'MANAGE', '0', NULL, '1', '2020-08-12 10:27:33.703', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (725, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"dev\",\"permission\":\"t_front_tFront_view\",\"sort\":30,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t_front/t-front\",\"component\":\"t_front/t-front/index\",\"name\":\"内容控制\",\"id\":\"5af0ff6dd036af1f1bfdcc13c42023b3\",\"iframe\":0}',
        '38', 'MANAGE', '0', NULL, '1', '2020-08-12 10:28:21.815', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (726, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '258', 'MANAGE', '0', NULL, '1', '2020-08-12 10:28:22.068', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (727, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"hidden\":0,\"description\":\"\",\"permission\":\"t_front_tFront_edit\",\"sort\":30,\"type\":\"2\",\"parentId\":\"5af0ff6dd036af1f1bfdcc13c42023b3\",\"name\":\"编辑\"}',
        '21', 'MANAGE', '0', NULL, '1', '2020-08-12 10:28:52.775', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (728, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '255', 'MANAGE', '0', NULL, '1', '2020-08-12 10:28:53.032', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (729, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"hidden\":0,\"permission\":\"t_front_tFront_del\",\"sort\":30,\"type\":\"2\",\"parentId\":\"5af0ff6dd036af1f1bfdcc13c42023b3\",\"name\":\"删除\"}',
        '20', 'MANAGE', '0', NULL, '1', '2020-08-12 10:29:10.727', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (730, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '323', 'MANAGE', '0', NULL, '1', '2020-08-12 10:29:10.976', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (731, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '7', 'MANAGE', '0', NULL, '1', '2020-08-12 10:29:17.089', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (732, '角色管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/menu', 'com.albedo.java.modules.sys.web.RoleResource.saveRoleMenus()',
        '{\"roleId\":\"1\",\"menuIdList\":[\"92f78825551a22fa130c03066f398448\",\"413892fe8d52c1163d6659f51299dc96\",\"bb9dd4b7a2a462193d0f01517308f812\",\"e086c4aa4943a883b29cf94680608b89\",\"a18b33e15bde209a3c9115517c56d9ec\",\"618ee4b9660265a85a8b61277de2a579\",\"d9d87cf8ed7c29ed2eda06d5dec4dcda\",\"b963a451117f430703817b3b6c87402a\",\"2500\",\"29de79df95e70d8e8fbdc7945acf214a\",\"795b4d5cf0eb3ed80e24cbab39727b9d\",\"18d6b5e0f6b986cd074bf23de11ecd34\",\"2101\",\"ef2382c0cc2d99ee73444e684237a88a\",\"e710a66583fe0e324492462adb16014e\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"247071d42ff40267c8d8c44eac92da67\",\"13093fb658c1806ad5bd0600316158f2\",\"2000\",\"9763343d9cce11ce9eb4f21c8e49122b\",\"0d0be247863fcbf08b3db943e5f45992\",\"5404c3df9f771dbc0237578814bbe44b\",\"1303\",\"1302\",\"1103\",\"1301\",\"1102\",\"1300\",\"1101\",\"1100\",\"f15e2186907d22765cd149a94905842a\",\"1120fe9bc06066fae0aec08325bdf56e\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"5b39ca5a25c772105c71f8c51d1f19d4\",\"1ae562534a64d4473899e52497c40b2e\",\"1000\",\"52715698214e88cb09fa4dd1ea5ad348\",\"64b61b8966e1c74d9b309069b2f622d1\",\"133f1408f5e3187d3e1a00b0260b7165\",\"2601\",\"2600\",\"2202\",\"10bd98f30a42427dd7ef75418ad3da6b\",\"2201\",\"2200\",\"e5ea38c1f97dee0043e78f3fb27b25d6\",\"7b14af9e9fbff286856338a194422b07\",\"74f2b2a8871a298e0acc4d7129d10e9c\",\"fe4c7938e146ec223e99d426aaa87109\",\"76d6087052dc26b32f3efa71b9cc119b\",\"bd62904371247f56594741ff8e9bded9\",\"2100\",\"5af0ff6dd036af1f1bfdcc13c42023b3\",\"eb17cee437ea6b630dad59fff2a059ca\",\"1403\",\"1402\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"bc7a2552fa2dbca2abc36fb6b73f695f\",\"1401\",\"1203\",\"1400\",\"1202\",\"1201\",\"b961670cbf3454f5927c4bd2a327e915\",\"1200\",\"621e50e1c7d66a1febeb699bebb2fe35\",\"d4c16faad8f883650a3a8eab829ebad9\",\"0d857a3a2e3b3b67bba0a9b4dcd80b55\",\"7754b1457826c48290bc189bb1289740\",\"9f02e346b5350366968f217daef3f1b7\",\"b8eafb6c3a8bf0919230f0bfa59d86b6\",\"caaec41413c5713c6f290efe08c11415\"]}',
        '45', 'MANAGE', '0', NULL, '1', '2020-08-12 10:29:23.952', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (733, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=40811597199403710&code=l&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-12 10:30:09.227', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (734, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '34', 'MANAGE', '0', NULL, '1', '2020-08-12 10:30:10.294', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (735, '控制前端页面内容查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t_front/t-front/', 'com.albedo.java.modules.t_front.web.TFrontResource.getPage()',
        '{\"tFrontQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '9', 'MANAGE', '0', NULL, '1', '2020-08-12 10:30:13.618', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (736, '控制前端页面内容编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t_front/t-front', 'com.albedo.java.modules.t_front.web.TFrontResource.save()',
        '{\"path\":\"/src/url\",\"name\":\"testname\",\"description\":\"other\",\"adWord\":\"你好\"}', '34', 'MANAGE',
        '0', NULL, '1', '2020-08-12 10:30:29.914', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (737, '控制前端页面内容查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t_front/t-front/', 'com.albedo.java.modules.t_front.web.TFrontResource.getPage()',
        '{\"tFrontQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '10', 'MANAGE', '0', NULL, '1', '2020-08-12 10:30:30.074', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (738, '任务调度查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/quartz/job/', 'com.albedo.java.modules.quartz.web.JobResource.getPage()',
        '{\"jobQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '13', 'MANAGE', '0', NULL, '1', '2020-08-12 10:41:23.068', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (739, '部门管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/dept/', 'com.albedo.java.modules.sys.web.DeptResource.findTreeList()', '{\"deptQueryCriteria\":{}}',
        '13', 'MANAGE', '0', NULL, '1', '2020-08-12 10:41:27.257', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (740, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '260', 'MANAGE', '0', NULL, '1', '2020-08-12 10:41:38.958', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (741, '控制前端页面内容查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t_front/t-front/', 'com.albedo.java.modules.t_front.web.TFrontResource.getPage()',
        '{\"tFrontQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-12 10:44:13.179', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (742, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '235', 'MANAGE', '0', NULL, '1', '2020-08-12 10:44:26.549', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (743, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '12', 'MANAGE', '0', NULL, '1', '2020-08-12 10:45:10.482', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (744, '业务表编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.save()',
        '{\"childList\":[],\"className\":\"TInvoice\",\"importList\":[\"com.baomidou.mybatisplus.annotation.*\",\"com.albedo.java.common.persistence.domain.IdEntity\",\"javax.validation.constraints.Size\",\"javax.validation.constraints.NotBlank\",\"com.albedo.java.common.core.annotation.DictType\"],\"statusExists\":false,\"createTimeExists\":false,\"pkColumn\":{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  user_id或dept_id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"user_id或dept_id\",\"unique\":false},\"parentExists\":false,\"pkList\":[\"id\"],\"comments\":\"t_invoice\",\"pkSqlName\":\"id\",\"updateTimeExists\":false,\"columnList\":[{\"$ref\":\"$.pkColumn\"},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-个人，1-企业长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"TYPE\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"type\",\"javaFieldAttrs\":[],\"javaFieldId\":\"type\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(1)\",\"list\":true,\"name\":\"type\",\"nameAndTitle\":\"type  :  0-个人，1-企业\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-个人，1-企业长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"type\",\"size\":\"1\",\"sort\":20,\"title\":\"0-个人，1-企业\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"企业名称/个人名称长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"NAME\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaField\":\"name\",\"javaFieldAttrs\":[],\"javaFieldId\":\"name\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"name\",\"nameAndTitle\":\"name  :  企业名称/个人名称\",\"null\":false,\"pk\":false,\"query\":true,\"queryType\":\"like\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"企业名称/个人名称长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"name\",\"size\":\"255\",\"sort\":30,\"title\":\"企业名称/个人名称\",\"unique\":false},{\"annotationList\":[],\"constantJavaField\":\"TAXNUM\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=0)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"taxNum\",\"javaFieldAttrs\":[],\"javaFieldId\":\"taxNum\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(0)\",\"list\":true,\"name\":\"tax_num\",\"nameAndTitle\":\"tax_num  :  公司税号\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[],\"simpleJavaField\":\"taxNum\",\"size\":\"0\",\"sort\":40,\"title\":\"公司税号\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"注册地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"COMPANYLOCATION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"companyLocation\",\"javaFieldAttrs\":[],\"javaFieldId\":\"companyLocation\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"company_location\",\"nameAndTitle\":\"company_location  :  注册地址\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"注册地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"companyLocation\",\"size\":\"255\",\"sort\":50,\"title\":\"注册地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"公司电话长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"COMPANYPHONE\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"companyPhone\",\"javaFieldAttrs\":[],\"javaFieldId\":\"companyPhone\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"company_phone\",\"nameAndTitle\":\"company_phone  :  公司电话\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"公司电话长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"companyPhone\",\"size\":\"255\",\"sort\":60,\"title\":\"公司电话\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"开户公司长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"ACCOUNTBANK\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"accountBank\",\"javaFieldAttrs\":[],\"javaFieldId\":\"accountBank\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"account_bank\",\"nameAndTitle\":\"account_bank  :  开户公司\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"开户公司长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"accountBank\",\"size\":\"255\",\"sort\":70,\"title\":\"开户公司\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"开户账号长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ACCOUNTNUMBER\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"accountNumber\",\"javaFieldAttrs\":[],\"javaFieldId\":\"accountNumber\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"account_number\",\"nameAndTitle\":\"account_number  :  开户账号\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"开户账号长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"accountNumber\",\"size\":\"32\",\"sort\":80,\"title\":\"开户账号\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":90,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":100,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":110,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":120,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":130,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":140,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":150,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"childeExists\":false,\"notCompositeId\":true,\"pkColumnList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  user_id或dept_id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"user_id或dept_id\",\"unique\":false}],\"columnFormList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  user_id或dept_id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"user_id或dept_id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-个人，1-企业长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"TYPE\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"type\",\"javaFieldAttrs\":[],\"javaFieldId\":\"type\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(1)\",\"list\":true,\"name\":\"type\",\"nameAndTitle\":\"type  :  0-个人，1-企业\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-个人，1-企业长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"type\",\"size\":\"1\",\"sort\":20,\"title\":\"0-个人，1-企业\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"企业名称/个人名称长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"NAME\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaField\":\"name\",\"javaFieldAttrs\":[],\"javaFieldId\":\"name\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"name\",\"nameAndTitle\":\"name  :  企业名称/个人名称\",\"null\":false,\"pk\":false,\"query\":true,\"queryType\":\"like\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"企业名称/个人名称长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"name\",\"size\":\"255\",\"sort\":30,\"title\":\"企业名称/个人名称\",\"unique\":false},{\"annotationList\":[],\"constantJavaField\":\"TAXNUM\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=0)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"taxNum\",\"javaFieldAttrs\":[],\"javaFieldId\":\"taxNum\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(0)\",\"list\":true,\"name\":\"tax_num\",\"nameAndTitle\":\"tax_num  :  公司税号\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[],\"simpleJavaField\":\"taxNum\",\"size\":\"0\",\"sort\":40,\"title\":\"公司税号\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"注册地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"COMPANYLOCATION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"companyLocation\",\"javaFieldAttrs\":[],\"javaFieldId\":\"companyLocation\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"company_location\",\"nameAndTitle\":\"company_location  :  注册地址\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"注册地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"companyLocation\",\"size\":\"255\",\"sort\":50,\"title\":\"注册地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"公司电话长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"COMPANYPHONE\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"companyPhone\",\"javaFieldAttrs\":[],\"javaFieldId\":\"companyPhone\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"company_phone\",\"nameAndTitle\":\"company_phone  :  公司电话\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"公司电话长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"companyPhone\",\"size\":\"255\",\"sort\":60,\"title\":\"公司电话\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"开户公司长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"ACCOUNTBANK\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"accountBank\",\"javaFieldAttrs\":[],\"javaFieldId\":\"accountBank\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"account_bank\",\"nameAndTitle\":\"account_bank  :  开户公司\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"开户公司长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"accountBank\",\"size\":\"255\",\"sort\":70,\"title\":\"开户公司\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"开户账号长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ACCOUNTNUMBER\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"accountNumber\",\"javaFieldAttrs\":[],\"javaFieldId\":\"accountNumber\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"account_number\",\"nameAndTitle\":\"account_number  :  开户账号\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"开户账号长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"accountNumber\",\"size\":\"32\",\"sort\":80,\"title\":\"开户账号\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":90,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":100,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":110,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":120,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":130,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":140,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":150,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"pkSize\":\"32\",\"name\":\"t_invoice\",\"compositeId\":false,\"nameAndTitle\":\"t_invoice  :  \",\"pkJavaType\":\"String\"}',
        '261', 'MANAGE', '0', NULL, '1', '2020-08-12 10:46:11.047', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (745, '业务表编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.save()',
        '{\"childList\":[],\"className\":\"TInvoice\",\"importList\":[\"com.baomidou.mybatisplus.annotation.*\",\"com.albedo.java.common.persistence.domain.IdEntity\",\"javax.validation.constraints.Size\",\"javax.validation.constraints.NotBlank\",\"com.albedo.java.common.core.annotation.DictType\"],\"statusExists\":false,\"createTimeExists\":false,\"pkColumn\":{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  user_id或dept_id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"user_id或dept_id\",\"unique\":false},\"parentExists\":false,\"pkList\":[\"id\"],\"comments\":\"t_invoice\",\"pkSqlName\":\"id\",\"updateTimeExists\":false,\"columnList\":[{\"$ref\":\"$.pkColumn\"},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-个人，1-企业长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"TYPE\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"type\",\"javaFieldAttrs\":[],\"javaFieldId\":\"type\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(1)\",\"list\":true,\"name\":\"type\",\"nameAndTitle\":\"type  :  0-个人，1-企业\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-个人，1-企业长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"type\",\"size\":\"1\",\"sort\":20,\"title\":\"0-个人，1-企业\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"企业名称/个人名称长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"NAME\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaField\":\"name\",\"javaFieldAttrs\":[],\"javaFieldId\":\"name\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"name\",\"nameAndTitle\":\"name  :  企业名称/个人名称\",\"null\":false,\"pk\":false,\"query\":true,\"queryType\":\"like\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"企业名称/个人名称长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"name\",\"size\":\"255\",\"sort\":30,\"title\":\"企业名称/个人名称\",\"unique\":false},{\"annotationList\":[],\"constantJavaField\":\"TAXNUM\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=0)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"taxNum\",\"javaFieldAttrs\":[],\"javaFieldId\":\"taxNum\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(0)\",\"list\":true,\"name\":\"tax_num\",\"nameAndTitle\":\"tax_num  :  公司税号\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[],\"simpleJavaField\":\"taxNum\",\"size\":\"0\",\"sort\":40,\"title\":\"公司税号\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"注册地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"COMPANYLOCATION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"companyLocation\",\"javaFieldAttrs\":[],\"javaFieldId\":\"companyLocation\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"company_location\",\"nameAndTitle\":\"company_location  :  注册地址\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"注册地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"companyLocation\",\"size\":\"255\",\"sort\":50,\"title\":\"注册地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"公司电话长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"COMPANYPHONE\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"companyPhone\",\"javaFieldAttrs\":[],\"javaFieldId\":\"companyPhone\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"company_phone\",\"nameAndTitle\":\"company_phone  :  公司电话\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"公司电话长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"companyPhone\",\"size\":\"255\",\"sort\":60,\"title\":\"公司电话\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"开户公司长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"ACCOUNTBANK\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"accountBank\",\"javaFieldAttrs\":[],\"javaFieldId\":\"accountBank\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"account_bank\",\"nameAndTitle\":\"account_bank  :  开户公司\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"开户公司长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"accountBank\",\"size\":\"255\",\"sort\":70,\"title\":\"开户公司\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"开户账号长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ACCOUNTNUMBER\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"accountNumber\",\"javaFieldAttrs\":[],\"javaFieldId\":\"accountNumber\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"account_number\",\"nameAndTitle\":\"account_number  :  开户账号\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"开户账号长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"accountNumber\",\"size\":\"32\",\"sort\":80,\"title\":\"开户账号\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":90,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":100,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":110,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":120,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":130,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":140,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":150,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"childeExists\":false,\"notCompositeId\":true,\"pkColumnList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  user_id或dept_id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"user_id或dept_id\",\"unique\":false}],\"columnFormList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  user_id或dept_id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"user_id或dept_id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-个人，1-企业长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"TYPE\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"type\",\"javaFieldAttrs\":[],\"javaFieldId\":\"type\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(1)\",\"list\":true,\"name\":\"type\",\"nameAndTitle\":\"type  :  0-个人，1-企业\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-个人，1-企业长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"type\",\"size\":\"1\",\"sort\":20,\"title\":\"0-个人，1-企业\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"企业名称/个人名称长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"NAME\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaField\":\"name\",\"javaFieldAttrs\":[],\"javaFieldId\":\"name\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"name\",\"nameAndTitle\":\"name  :  企业名称/个人名称\",\"null\":false,\"pk\":false,\"query\":true,\"queryType\":\"like\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"企业名称/个人名称长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"name\",\"size\":\"255\",\"sort\":30,\"title\":\"企业名称/个人名称\",\"unique\":false},{\"annotationList\":[],\"constantJavaField\":\"TAXNUM\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=0)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"taxNum\",\"javaFieldAttrs\":[],\"javaFieldId\":\"taxNum\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(0)\",\"list\":true,\"name\":\"tax_num\",\"nameAndTitle\":\"tax_num  :  公司税号\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[],\"simpleJavaField\":\"taxNum\",\"size\":\"0\",\"sort\":40,\"title\":\"公司税号\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"注册地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"COMPANYLOCATION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"companyLocation\",\"javaFieldAttrs\":[],\"javaFieldId\":\"companyLocation\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"company_location\",\"nameAndTitle\":\"company_location  :  注册地址\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"注册地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"companyLocation\",\"size\":\"255\",\"sort\":50,\"title\":\"注册地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"公司电话长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"COMPANYPHONE\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"companyPhone\",\"javaFieldAttrs\":[],\"javaFieldId\":\"companyPhone\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"company_phone\",\"nameAndTitle\":\"company_phone  :  公司电话\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"公司电话长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"companyPhone\",\"size\":\"255\",\"sort\":60,\"title\":\"公司电话\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"开户公司长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"ACCOUNTBANK\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"accountBank\",\"javaFieldAttrs\":[],\"javaFieldId\":\"accountBank\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"account_bank\",\"nameAndTitle\":\"account_bank  :  开户公司\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"开户公司长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"accountBank\",\"size\":\"255\",\"sort\":70,\"title\":\"开户公司\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"开户账号长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ACCOUNTNUMBER\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"accountNumber\",\"javaFieldAttrs\":[],\"javaFieldId\":\"accountNumber\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"account_number\",\"nameAndTitle\":\"account_number  :  开户账号\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"开户账号长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"accountNumber\",\"size\":\"32\",\"sort\":80,\"title\":\"开户账号\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":90,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":100,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":110,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":120,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":130,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":140,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":150,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"pkSize\":\"32\",\"name\":\"t_invoice\",\"compositeId\":false,\"nameAndTitle\":\"t_invoice  :  \",\"pkJavaType\":\"String\"}',
        '238', 'MANAGE', '0', NULL, '1', '2020-08-12 10:46:11.263', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (746, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-12 10:46:12.071', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (747, '业务表删除', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.delete()', '{\"empty\":false}', '20', 'MANAGE',
        '0', NULL, '1', '2020-08-12 10:46:17.965', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (748, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '6', 'MANAGE', '0', NULL, '1', '2020-08-12 10:46:18.210', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (749, '业务表编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.save()',
        '{\"childList\":[],\"className\":\"TInvoiceHistory\",\"importList\":[\"com.baomidou.mybatisplus.annotation.*\",\"com.albedo.java.common.persistence.domain.IdEntity\",\"javax.validation.constraints.Size\",\"javax.validation.constraints.NotBlank\",\"com.albedo.java.common.core.annotation.DictType\"],\"statusExists\":false,\"createTimeExists\":false,\"pkColumn\":{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false},\"parentExists\":false,\"pkList\":[\"id\"],\"comments\":\"t_invoice_history\",\"pkSqlName\":\"id\",\"updateTimeExists\":false,\"columnList\":[{\"$ref\":\"$.pkColumn\"},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"USERID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"userId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"userId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"user_id\",\"nameAndTitle\":\"user_id  :  用户id\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"userId\",\"size\":\"32\",\"sort\":20,\"title\":\"用户id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"发票id(数量统计用后台加一下就好)长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"INVOICEID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"invoiceId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"invoiceId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"invoice_id\",\"nameAndTitle\":\"invoice_id  :  发票id(数量统计用后台加一下就好)\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"发票id(数量统计用后台加一下就好)长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"invoiceId\",\"size\":\"32\",\"sort\":30,\"title\":\"发票id(数量统计用后台加一下就好)\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":40,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":50,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":60,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":70,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":80,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":90,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":100,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"childeExists\":false,\"notCompositeId\":true,\"pkColumnList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false}],\"columnFormList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"USERID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"userId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"userId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"user_id\",\"nameAndTitle\":\"user_id  :  用户id\",\"null\":false,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"userId\",\"size\":\"32\",\"sort\":20,\"title\":\"用户id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"发票id(数量统计用后台加一下就好)长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"INVOICEID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"invoiceId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"invoiceId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"invoice_id\",\"nameAndTitle\":\"invoice_id  :  发票id(数量统计用后台加一下就好)\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"发票id(数量统计用后台加一下就好)长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"invoiceId\",\"size\":\"32\",\"sort\":30,\"title\":\"发票id(数量统计用后台加一下就好)\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":40,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":50,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":60,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":70,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":80,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":90,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":100,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"pkSize\":\"32\",\"name\":\"t_invoice_history\",\"compositeId\":false,\"nameAndTitle\":\"t_invoice_history  :  \",\"pkJavaType\":\"String\"}',
        '153', 'MANAGE', '0', NULL, '1', '2020-08-12 10:46:39.476', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (750, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '14', 'MANAGE', '0', NULL, '1', '2020-08-12 10:46:40.326', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (751, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '18', 'MANAGE', '0', NULL, '1', '2020-08-12 10:46:46.903', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (752, '生成方案编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.save()',
        '{\"functionAuthor\":\"admin\",\"functionName\":\"控制前端页面内容\",\"functionNameSimple\":\"t_front\",\"modalView\":false,\"moduleName\":\"t\",\"replaceFile\":true,\"genCode\":true,\"name\":\"前端内容控制\",\"tableId\":\"7dbc0aa32d25dbffcba0ff2940842b1c\",\"id\":\"8710dca982407997268fd52546029e42\",\"packageName\":\"com.albedo.java.modules\",\"category\":\"curd\"}',
        '379', 'MANAGE', '0', NULL, '1', '2020-08-12 10:47:45.880', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (753, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '8', 'MANAGE', '0', NULL, '1', '2020-08-12 10:47:47.890', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (754, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '11', 'MANAGE', '0', NULL, '1', '2020-08-12 10:47:50.933', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (755, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '246', 'MANAGE', '0', NULL, '1', '2020-08-12 10:48:08.261', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (756, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"fwb\",\"sort\":130,\"type\":\"0\",\"parentId\":\"-1\",\"path\":\"/t\",\"component\":\"Layout\",\"name\":\"前端内容控制\",\"id\":\"1120fe9bc06066fae0aec08325bdf56e\",\"iframe\":0}',
        '36', 'MANAGE', '0', NULL, '1', '2020-08-12 10:48:16.964', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (757, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '264', 'MANAGE', '0', NULL, '1', '2020-08-12 10:48:17.172', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (758, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"dev\",\"permission\":\"t_front_tFront_view\",\"sort\":30,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t/t-front\",\"component\":\"t/t-front/index\",\"name\":\"内容控制\",\"id\":\"5af0ff6dd036af1f1bfdcc13c42023b3\",\"iframe\":0}',
        '45', 'MANAGE', '0', NULL, '1', '2020-08-12 10:48:33.508', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (759, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '276', 'MANAGE', '0', NULL, '1', '2020-08-12 10:48:33.764', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (760, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=20681597200607403&code=1&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-12 10:50:10.109', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (761, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '284', 'MANAGE', '0', NULL, '1', '2020-08-12 10:50:11.169', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (762, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '229', 'MANAGE', '0', NULL, '1', '2020-08-12 10:50:27.263', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (763, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '38', 'MANAGE', '0', NULL, '1', '2020-08-12 10:50:47.488', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (764, '部门管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/dept/', 'com.albedo.java.modules.sys.web.DeptResource.findTreeList()', '{\"deptQueryCriteria\":{}}',
        '13', 'MANAGE', '0', NULL, '1', '2020-08-12 10:50:57.052', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (765, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '241', 'MANAGE', '0', NULL, '1', '2020-08-12 10:51:00.648', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (766, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=39711597200736467&code=111&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-12 10:52:18.709', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (767, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '257', 'MANAGE', '0', NULL, '1', '2020-08-12 10:53:12.028', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (768, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"dev\",\"permission\":\"t_tFront_view\",\"sort\":30,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t/t-front\",\"component\":\"t/t-front/index\",\"name\":\"内容控制\",\"id\":\"5af0ff6dd036af1f1bfdcc13c42023b3\",\"iframe\":0}',
        '62', 'MANAGE', '0', NULL, '1', '2020-08-12 10:53:35.011', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (769, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '273', 'MANAGE', '0', NULL, '1', '2020-08-12 10:53:35.195', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (770, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"description\":\"\",\"permission\":\"t_tFront_edit\",\"sort\":30,\"type\":\"2\",\"parentId\":\"5af0ff6dd036af1f1bfdcc13c42023b3\",\"name\":\"编辑\",\"id\":\"0d857a3a2e3b3b67bba0a9b4dcd80b55\",\"iframe\":0}',
        '43', 'MANAGE', '0', NULL, '1', '2020-08-12 10:53:44.717', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (771, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '264', 'MANAGE', '0', NULL, '1', '2020-08-12 10:53:44.969', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (772, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"permission\":\"t_tFront_del\",\"sort\":30,\"type\":\"2\",\"parentId\":\"5af0ff6dd036af1f1bfdcc13c42023b3\",\"name\":\"删除\",\"id\":\"bc7a2552fa2dbca2abc36fb6b73f695f\",\"iframe\":0}',
        '38', 'MANAGE', '0', NULL, '1', '2020-08-12 10:53:53.178', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (773, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '263', 'MANAGE', '0', NULL, '1', '2020-08-12 10:53:53.431', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (774, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=17511597201120289&code=1&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-12 10:58:43.141', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (775, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '282', 'MANAGE', '0', NULL, '1', '2020-08-12 10:58:44.149', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (776, '控制前端页面内容查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-front/', 'com.albedo.java.modules.t.web.TFrontResource.getPage()',
        '{\"tFrontQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '38', 'MANAGE', '0', NULL, '1', '2020-08-12 10:58:47.398', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (777, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '228', 'MANAGE', '0', NULL, '1', '2020-08-12 10:59:28.349', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (778, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"fwb\",\"sort\":130,\"type\":\"0\",\"parentId\":\"-1\",\"path\":\"/t\",\"component\":\"Layout\",\"name\":\"t的一级菜单\",\"id\":\"1120fe9bc06066fae0aec08325bdf56e\",\"iframe\":0}',
        '36', 'MANAGE', '0', NULL, '1', '2020-08-12 10:59:50.119', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (779, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '278', 'MANAGE', '0', NULL, '1', '2020-08-12 10:59:50.266', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (780, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '249', 'MANAGE', '0', NULL, '1', '2020-08-12 10:59:54.073', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (781, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"dev\",\"permission\":\"t_tFront_view\",\"sort\":30,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t/t-front\",\"component\":\"t/t-front/index\",\"name\":\"前端内容控制\",\"id\":\"5af0ff6dd036af1f1bfdcc13c42023b3\",\"iframe\":0}',
        '51', 'MANAGE', '0', NULL, '1', '2020-08-12 11:00:05.765', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (782, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '310', 'MANAGE', '0', NULL, '1', '2020-08-12 11:00:06.019', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (783, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '11', 'MANAGE', '0', NULL, '1', '2020-08-12 11:00:20.486', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (784, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '17', 'MANAGE', '0', NULL, '1', '2020-08-12 11:00:24.106', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (785, '生成方案编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.save()',
        '{\"functionAuthor\":\"admin\",\"functionName\":\"管理发票抬头\",\"functionNameSimple\":\"t_invoice\",\"modalView\":false,\"moduleName\":\"t\",\"replaceFile\":false,\"genCode\":true,\"name\":\"发票抬头管理\",\"tableId\":\"6ecc39110e24a46af9df21ae5c725155\",\"packageName\":\"com.albedo.java.modules\",\"category\":\"curd\"}',
        '497', 'MANAGE', '0', NULL, '1', '2020-08-12 11:01:11.034', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (786, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '9', 'MANAGE', '0', NULL, '1', '2020-08-12 11:01:14.437', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (787, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '12', 'MANAGE', '0', NULL, '1', '2020-08-12 11:01:17.672', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (788, '生成方案编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.save()',
        '{\"functionAuthor\":\"admin\",\"functionName\":\"查看发票申请历史\",\"functionNameSimple\":\"t_invoice_history\",\"modalView\":false,\"moduleName\":\"t\",\"replaceFile\":false,\"genCode\":true,\"name\":\"发票历史\",\"tableId\":\"31b4af23fe3bd30452e7a8b4c367034a\",\"packageName\":\"com.albedo.java.modules\",\"category\":\"curd\"}',
        '158', 'MANAGE', '0', NULL, '1', '2020-08-12 11:02:01.708', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (789, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '7', 'MANAGE', '0', NULL, '1', '2020-08-12 11:02:03.462', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (790, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '8', 'MANAGE', '0', NULL, '1', '2020-08-12 11:02:05.916', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (791, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '240', 'MANAGE', '0', NULL, '1', '2020-08-12 11:04:47.542', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (792, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"permission\":\"t_tInvoice_view\",\"sort\":30,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t/t-invoice\",\"component\":\"t/t-invoice/index\",\"name\":\"发票抬头管理\",\"iframe\":0}',
        '23', 'MANAGE', '0', NULL, '1', '2020-08-12 11:06:32.903', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (793, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '270', 'MANAGE', '0', NULL, '1', '2020-08-12 11:06:33.158', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (794, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"permission\":\"t_tInvoice_view\",\"sort\":30,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t/t-invoice\",\"component\":\"t/t-invoice/index\",\"name\":\"发票抬头管理\",\"id\":\"671fa1206a2446b046d4a91deceddd0f\",\"iframe\":0}',
        '54', 'MANAGE', '0', NULL, '1', '2020-08-12 11:06:48.247', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (795, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '241', 'MANAGE', '0', NULL, '1', '2020-08-12 11:06:48.719', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (796, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '264', 'MANAGE', '0', NULL, '1', '2020-08-12 11:07:01.021', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (797, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '241', 'MANAGE', '0', NULL, '1', '2020-08-12 11:07:04.768', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (798, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"hidden\":0,\"permission\":\"t_tInvoice_edit\",\"sort\":30,\"type\":\"2\",\"parentId\":\"671fa1206a2446b046d4a91deceddd0f\",\"name\":\"编辑\"}',
        '21', 'MANAGE', '0', NULL, '1', '2020-08-12 11:08:33.471', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (799, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '269', 'MANAGE', '0', NULL, '1', '2020-08-12 11:08:33.725', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (800, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"hidden\":0,\"permission\":\"t_tInvoice_del\",\"sort\":30,\"type\":\"2\",\"parentId\":\"671fa1206a2446b046d4a91deceddd0f\",\"name\":\"删除\"}',
        '22', 'MANAGE', '0', NULL, '1', '2020-08-12 11:09:01.020', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (801, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '312', 'MANAGE', '0', NULL, '1', '2020-08-12 11:09:01.271', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (802, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '260', 'MANAGE', '0', NULL, '1', '2020-08-12 11:12:13.449', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (803, '控制前端页面内容查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-front/', 'com.albedo.java.modules.t.web.TFrontResource.getPage()',
        '{\"tFrontQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '6', 'MANAGE', '0', NULL, '1', '2020-08-12 11:12:20.120', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (804, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-12 11:16:49.081', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (805, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '7', 'MANAGE', '0', NULL, '1', '2020-08-12 11:17:00.273', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (806, '业务表删除', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.delete()', '{\"empty\":false}', '19', 'MANAGE',
        '0', NULL, '1', '2020-08-12 11:17:04.929', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (807, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-12 11:17:05.175', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (808, '业务表编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.save()',
        '{\"childList\":[],\"className\":\"TInvoice\",\"importList\":[\"com.baomidou.mybatisplus.annotation.*\",\"com.albedo.java.common.persistence.domain.IdEntity\",\"javax.validation.constraints.Size\",\"javax.validation.constraints.NotBlank\",\"com.albedo.java.common.core.annotation.DictType\"],\"statusExists\":false,\"createTimeExists\":false,\"pkColumn\":{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  user_id或dept_id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"user_id或dept_id\",\"unique\":false},\"parentExists\":false,\"pkList\":[\"id\"],\"comments\":\"t_invoice\",\"pkSqlName\":\"id\",\"updateTimeExists\":false,\"columnList\":[{\"$ref\":\"$.pkColumn\"},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"USERID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"userId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"userId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"user_id\",\"nameAndTitle\":\"user_id  :  用户id\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"userId\",\"size\":\"32\",\"sort\":20,\"title\":\"用户id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-个人，1-企业长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"TYPE\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"type\",\"javaFieldAttrs\":[],\"javaFieldId\":\"type\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(1)\",\"list\":true,\"name\":\"type\",\"nameAndTitle\":\"type  :  0-个人，1-企业\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-个人，1-企业长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"type\",\"size\":\"1\",\"sort\":30,\"title\":\"0-个人，1-企业\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"企业名称/个人名称长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"NAME\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaField\":\"name\",\"javaFieldAttrs\":[],\"javaFieldId\":\"name\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"name\",\"nameAndTitle\":\"name  :  企业名称/个人名称\",\"null\":false,\"pk\":false,\"query\":true,\"queryType\":\"like\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"企业名称/个人名称长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"name\",\"size\":\"255\",\"sort\":40,\"title\":\"企业名称/个人名称\",\"unique\":false},{\"annotationList\":[],\"constantJavaField\":\"TAXNUM\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=0)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"taxNum\",\"javaFieldAttrs\":[],\"javaFieldId\":\"taxNum\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(0)\",\"list\":true,\"name\":\"tax_num\",\"nameAndTitle\":\"tax_num  :  公司税号\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[],\"simpleJavaField\":\"taxNum\",\"size\":\"0\",\"sort\":50,\"title\":\"公司税号\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"注册地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"COMPANYLOCATION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"companyLocation\",\"javaFieldAttrs\":[],\"javaFieldId\":\"companyLocation\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"company_location\",\"nameAndTitle\":\"company_location  :  注册地址\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"注册地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"companyLocation\",\"size\":\"255\",\"sort\":60,\"title\":\"注册地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"公司电话长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"COMPANYPHONE\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"companyPhone\",\"javaFieldAttrs\":[],\"javaFieldId\":\"companyPhone\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"company_phone\",\"nameAndTitle\":\"company_phone  :  公司电话\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"公司电话长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"companyPhone\",\"size\":\"255\",\"sort\":70,\"title\":\"公司电话\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"开户公司长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"ACCOUNTBANK\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"accountBank\",\"javaFieldAttrs\":[],\"javaFieldId\":\"accountBank\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"account_bank\",\"nameAndTitle\":\"account_bank  :  开户公司\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"开户公司长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"accountBank\",\"size\":\"255\",\"sort\":80,\"title\":\"开户公司\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"开户账号长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ACCOUNTNUMBER\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"accountNumber\",\"javaFieldAttrs\":[],\"javaFieldId\":\"accountNumber\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"account_number\",\"nameAndTitle\":\"account_number  :  开户账号\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"开户账号长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"accountNumber\",\"size\":\"32\",\"sort\":90,\"title\":\"开户账号\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":100,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":110,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":120,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":130,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":140,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":150,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":160,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"childeExists\":false,\"notCompositeId\":true,\"pkColumnList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  user_id或dept_id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"user_id或dept_id\",\"unique\":false}],\"columnFormList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  user_id或dept_id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"user_id或dept_id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"user_id或dept_id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"USERID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"userId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"userId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"user_id\",\"nameAndTitle\":\"user_id  :  用户id\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"userId\",\"size\":\"32\",\"sort\":20,\"title\":\"用户id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-个人，1-企业长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"TYPE\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"type\",\"javaFieldAttrs\":[],\"javaFieldId\":\"type\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(1)\",\"list\":true,\"name\":\"type\",\"nameAndTitle\":\"type  :  0-个人，1-企业\",\"null\":false,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-个人，1-企业长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"type\",\"size\":\"1\",\"sort\":30,\"title\":\"0-个人，1-企业\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"企业名称/个人名称长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"NAME\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaField\":\"name\",\"javaFieldAttrs\":[],\"javaFieldId\":\"name\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"name\",\"nameAndTitle\":\"name  :  企业名称/个人名称\",\"null\":false,\"pk\":false,\"query\":true,\"queryType\":\"like\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"企业名称/个人名称长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"name\",\"size\":\"255\",\"sort\":40,\"title\":\"企业名称/个人名称\",\"unique\":false},{\"annotationList\":[],\"constantJavaField\":\"TAXNUM\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=0)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"taxNum\",\"javaFieldAttrs\":[],\"javaFieldId\":\"taxNum\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(0)\",\"list\":true,\"name\":\"tax_num\",\"nameAndTitle\":\"tax_num  :  公司税号\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[],\"simpleJavaField\":\"taxNum\",\"size\":\"0\",\"sort\":50,\"title\":\"公司税号\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"注册地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"COMPANYLOCATION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"companyLocation\",\"javaFieldAttrs\":[],\"javaFieldId\":\"companyLocation\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"company_location\",\"nameAndTitle\":\"company_location  :  注册地址\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"注册地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"companyLocation\",\"size\":\"255\",\"sort\":60,\"title\":\"注册地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"公司电话长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"COMPANYPHONE\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"companyPhone\",\"javaFieldAttrs\":[],\"javaFieldId\":\"companyPhone\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"company_phone\",\"nameAndTitle\":\"company_phone  :  公司电话\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"公司电话长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"companyPhone\",\"size\":\"255\",\"sort\":70,\"title\":\"公司电话\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"开户公司长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"ACCOUNTBANK\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"accountBank\",\"javaFieldAttrs\":[],\"javaFieldId\":\"accountBank\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"account_bank\",\"nameAndTitle\":\"account_bank  :  开户公司\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"开户公司长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"accountBank\",\"size\":\"255\",\"sort\":80,\"title\":\"开户公司\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"开户账号长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ACCOUNTNUMBER\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"accountNumber\",\"javaFieldAttrs\":[],\"javaFieldId\":\"accountNumber\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"account_number\",\"nameAndTitle\":\"account_number  :  开户账号\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"开户账号长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"accountNumber\",\"size\":\"32\",\"sort\":90,\"title\":\"开户账号\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":100,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":110,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":120,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":130,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":140,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":150,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":160,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"pkSize\":\"32\",\"name\":\"t_invoice\",\"compositeId\":false,\"nameAndTitle\":\"t_invoice  :  \",\"pkJavaType\":\"String\"}',
        '246', 'MANAGE', '0', NULL, '1', '2020-08-12 11:17:26.349', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (809, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '6', 'MANAGE', '0', NULL, '1', '2020-08-12 11:17:27.348', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (810, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '6', 'MANAGE', '0', NULL, '1', '2020-08-12 11:17:29.756', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (811, '生成方案编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.save()',
        '{\"functionAuthor\":\"admin\",\"functionName\":\"管理发票抬头\",\"functionNameSimple\":\"t_invoice\",\"modalView\":false,\"moduleName\":\"t\",\"replaceFile\":true,\"genCode\":true,\"name\":\"发票抬头管理\",\"tableId\":\"0291c0ba2aeb9b7e290a5d73f3751189\",\"id\":\"ef1398de9f8aa2803fe374b44200a381\",\"packageName\":\"com.albedo.java.modules\",\"category\":\"curd\"}',
        '184', 'MANAGE', '0', NULL, '1', '2020-08-12 11:17:40.396', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (812, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '6', 'MANAGE', '0', NULL, '1', '2020-08-12 11:17:42.189', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (813, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=45381597202292218&code=1&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-12 11:18:15.479', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (814, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '49', 'MANAGE', '0', NULL, '1', '2020-08-12 11:18:16.614', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (815, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '17', 'MANAGE', '0', NULL, '1', '2020-08-12 11:18:23.595', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (816, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '270', 'MANAGE', '0', NULL, '1', '2020-08-12 11:18:42.271', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (817, '字典管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/dict/', 'com.albedo.java.modules.sys.web.DictResource.findTreeList()', '{\"dictQueryCriteria\":{}}',
        '10', 'MANAGE', '0', NULL, '1', '2020-08-12 11:18:43.240', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (818, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '236', 'MANAGE', '0', NULL, '1', '2020-08-12 11:18:53.022', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (819, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"permission\":\"t_tInvoice_view\",\"sort\":30,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t/t-invoice\",\"component\":\"t/t-invoice/index\",\"name\":\"发票抬头管理\",\"id\":\"671fa1206a2446b046d4a91deceddd0f\",\"iframe\":0}',
        '58', 'MANAGE', '0', NULL, '1', '2020-08-12 11:19:40.291', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (820, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '248', 'MANAGE', '0', NULL, '1', '2020-08-12 11:19:40.775', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (821, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=80281597202417402&code=1&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-12 11:20:18.884', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (822, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '291', 'MANAGE', '0', NULL, '1', '2020-08-12 11:21:04.604', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (823, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '7', 'MANAGE', '0', NULL, '1', '2020-08-12 11:21:06.437', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (824, '角色管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/menu', 'com.albedo.java.modules.sys.web.RoleResource.saveRoleMenus()',
        '{\"roleId\":\"1\",\"menuIdList\":[\"92f78825551a22fa130c03066f398448\",\"413892fe8d52c1163d6659f51299dc96\",\"bb9dd4b7a2a462193d0f01517308f812\",\"e086c4aa4943a883b29cf94680608b89\",\"a18b33e15bde209a3c9115517c56d9ec\",\"618ee4b9660265a85a8b61277de2a579\",\"d9d87cf8ed7c29ed2eda06d5dec4dcda\",\"b963a451117f430703817b3b6c87402a\",\"2500\",\"29de79df95e70d8e8fbdc7945acf214a\",\"795b4d5cf0eb3ed80e24cbab39727b9d\",\"18d6b5e0f6b986cd074bf23de11ecd34\",\"2101\",\"ef2382c0cc2d99ee73444e684237a88a\",\"e710a66583fe0e324492462adb16014e\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"247071d42ff40267c8d8c44eac92da67\",\"13093fb658c1806ad5bd0600316158f2\",\"2000\",\"9763343d9cce11ce9eb4f21c8e49122b\",\"0d0be247863fcbf08b3db943e5f45992\",\"5404c3df9f771dbc0237578814bbe44b\",\"1303\",\"1302\",\"1103\",\"1301\",\"1102\",\"1300\",\"1101\",\"1100\",\"f15e2186907d22765cd149a94905842a\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"5b39ca5a25c772105c71f8c51d1f19d4\",\"1ae562534a64d4473899e52497c40b2e\",\"1000\",\"52715698214e88cb09fa4dd1ea5ad348\",\"64b61b8966e1c74d9b309069b2f622d1\",\"133f1408f5e3187d3e1a00b0260b7165\",\"2601\",\"2600\",\"2202\",\"10bd98f30a42427dd7ef75418ad3da6b\",\"2201\",\"2200\",\"e5ea38c1f97dee0043e78f3fb27b25d6\",\"7b14af9e9fbff286856338a194422b07\",\"74f2b2a8871a298e0acc4d7129d10e9c\",\"fe4c7938e146ec223e99d426aaa87109\",\"76d6087052dc26b32f3efa71b9cc119b\",\"bd62904371247f56594741ff8e9bded9\",\"2100\",\"eb17cee437ea6b630dad59fff2a059ca\",\"1403\",\"1402\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"1401\",\"1203\",\"1400\",\"1202\",\"1201\",\"b961670cbf3454f5927c4bd2a327e915\",\"1200\",\"621e50e1c7d66a1febeb699bebb2fe35\",\"d4c16faad8f883650a3a8eab829ebad9\",\"7754b1457826c48290bc189bb1289740\",\"9f02e346b5350366968f217daef3f1b7\",\"b8eafb6c3a8bf0919230f0bfa59d86b6\",\"caaec41413c5713c6f290efe08c11415\"]}',
        '53', 'MANAGE', '0', NULL, '1', '2020-08-12 11:21:09.982', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (825, '角色管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/menu', 'com.albedo.java.modules.sys.web.RoleResource.saveRoleMenus()',
        '{\"roleId\":\"1\",\"menuIdList\":[\"92f78825551a22fa130c03066f398448\",\"413892fe8d52c1163d6659f51299dc96\",\"bb9dd4b7a2a462193d0f01517308f812\",\"e086c4aa4943a883b29cf94680608b89\",\"a18b33e15bde209a3c9115517c56d9ec\",\"618ee4b9660265a85a8b61277de2a579\",\"d9d87cf8ed7c29ed2eda06d5dec4dcda\",\"b963a451117f430703817b3b6c87402a\",\"2500\",\"29de79df95e70d8e8fbdc7945acf214a\",\"795b4d5cf0eb3ed80e24cbab39727b9d\",\"18d6b5e0f6b986cd074bf23de11ecd34\",\"2101\",\"ef2382c0cc2d99ee73444e684237a88a\",\"e710a66583fe0e324492462adb16014e\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"247071d42ff40267c8d8c44eac92da67\",\"671fa1206a2446b046d4a91deceddd0f\",\"13093fb658c1806ad5bd0600316158f2\",\"2000\",\"9763343d9cce11ce9eb4f21c8e49122b\",\"0d0be247863fcbf08b3db943e5f45992\",\"5404c3df9f771dbc0237578814bbe44b\",\"1303\",\"1302\",\"1103\",\"1301\",\"956393c3e3d73714c0facc7ed628c371\",\"1102\",\"1300\",\"1101\",\"1100\",\"f15e2186907d22765cd149a94905842a\",\"1120fe9bc06066fae0aec08325bdf56e\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"5b39ca5a25c772105c71f8c51d1f19d4\",\"1ae562534a64d4473899e52497c40b2e\",\"1000\",\"52715698214e88cb09fa4dd1ea5ad348\",\"64b61b8966e1c74d9b309069b2f622d1\",\"133f1408f5e3187d3e1a00b0260b7165\",\"8591bd99f07ad86cc3bf6debb65fc799\",\"2601\",\"2600\",\"2202\",\"10bd98f30a42427dd7ef75418ad3da6b\",\"2201\",\"2200\",\"e5ea38c1f97dee0043e78f3fb27b25d6\",\"7b14af9e9fbff286856338a194422b07\",\"74f2b2a8871a298e0acc4d7129d10e9c\",\"fe4c7938e146ec223e99d426aaa87109\",\"76d6087052dc26b32f3efa71b9cc119b\",\"bd62904371247f56594741ff8e9bded9\",\"2100\",\"5af0ff6dd036af1f1bfdcc13c42023b3\",\"eb17cee437ea6b630dad59fff2a059ca\",\"1403\",\"1402\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"bc7a2552fa2dbca2abc36fb6b73f695f\",\"1401\",\"1203\",\"1400\",\"1202\",\"1201\",\"b961670cbf3454f5927c4bd2a327e915\",\"1200\",\"621e50e1c7d66a1febeb699bebb2fe35\",\"d4c16faad8f883650a3a8eab829ebad9\",\"0d857a3a2e3b3b67bba0a9b4dcd80b55\",\"7754b1457826c48290bc189bb1289740\",\"9f02e346b5350366968f217daef3f1b7\",\"b8eafb6c3a8bf0919230f0bfa59d86b6\",\"caaec41413c5713c6f290efe08c11415\"]}',
        '40', 'MANAGE', '0', NULL, '1', '2020-08-12 11:21:15.013', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (826, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '10', 'MANAGE', '0', NULL, '1', '2020-08-12 11:21:17.580', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (827, '控制前端页面内容查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-front/', 'com.albedo.java.modules.t.web.TFrontResource.getPage()',
        '{\"tFrontQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '13', 'MANAGE', '0', NULL, '1', '2020-08-12 11:21:31.602', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (828, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '259', 'MANAGE', '0', NULL, '1', '2020-08-12 11:21:45.970', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (829, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"permission\":\"t_tInvoice_view\",\"sort\":35,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t/t-invoice\",\"component\":\"t/t-invoice/index\",\"name\":\"发票抬头管理\",\"id\":\"671fa1206a2446b046d4a91deceddd0f\",\"iframe\":0}',
        '47', 'MANAGE', '0', NULL, '1', '2020-08-12 11:22:04.562', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (830, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '248', 'MANAGE', '0', NULL, '1', '2020-08-12 11:22:05.024', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (831, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"permission\":\"t_tInvoice_edit\",\"sort\":30,\"type\":\"2\",\"parentId\":\"671fa1206a2446b046d4a91deceddd0f\",\"name\":\"编辑\",\"id\":\"956393c3e3d73714c0facc7ed628c371\",\"iframe\":0}',
        '50', 'MANAGE', '0', NULL, '1', '2020-08-12 11:22:47.815', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (832, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '258', 'MANAGE', '0', NULL, '1', '2020-08-12 11:22:48.282', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (833, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"permission\":\"t_tInvoiceHistory_view\",\"sort\":30,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t/t-invoice-history\",\"component\":\"t/t-invoice-history/index\",\"name\":\"发票历史\",\"iframe\":0}',
        '22', 'MANAGE', '0', NULL, '1', '2020-08-12 11:23:48.874', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (834, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '275', 'MANAGE', '0', NULL, '1', '2020-08-12 11:23:49.114', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (835, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"permission\":\"t_tInvoiceHistory_view\",\"sort\":40,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t/t-invoice-history\",\"component\":\"t/t-invoice-history/index\",\"name\":\"发票历史\",\"id\":\"f9153fa246f209a70a97e51edd31ace5\",\"iframe\":0}',
        '42', 'MANAGE', '0', NULL, '1', '2020-08-12 11:24:06.491', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (836, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '257', 'MANAGE', '0', NULL, '1', '2020-08-12 11:24:06.953', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (837, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"hidden\":0,\"permission\":\"t_tInvoiceHistory_edit\",\"sort\":30,\"type\":\"2\",\"parentId\":\"f9153fa246f209a70a97e51edd31ace5\",\"name\":\"编辑\"}',
        '20', 'MANAGE', '0', NULL, '1', '2020-08-12 11:24:27.159', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (838, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '269', 'MANAGE', '0', NULL, '1', '2020-08-12 11:24:27.410', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (839, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"hidden\":0,\"permission\":\"t_tInvoiceHistory_del\",\"sort\":35,\"type\":\"2\",\"parentId\":\"f9153fa246f209a70a97e51edd31ace5\",\"name\":\"删除\"}',
        '20', 'MANAGE', '0', NULL, '1', '2020-08-12 11:24:59.363', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (840, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '281', 'MANAGE', '0', NULL, '1', '2020-08-12 11:24:59.616', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (841, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '286', 'MANAGE', '0', NULL, '1', '2020-08-12 11:25:02.226', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (842, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=63811597202801715&code=1&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-12 11:26:44.078', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (843, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '305', 'MANAGE', '0', NULL, '1', '2020-08-12 11:26:45.126', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (844, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '84', 'MANAGE', '0', NULL, '1', '2020-08-12 11:26:54.745', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (845, '角色管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/menu', 'com.albedo.java.modules.sys.web.RoleResource.saveRoleMenus()',
        '{\"roleId\":\"1\",\"menuIdList\":[\"92f78825551a22fa130c03066f398448\",\"413892fe8d52c1163d6659f51299dc96\",\"bb9dd4b7a2a462193d0f01517308f812\",\"e086c4aa4943a883b29cf94680608b89\",\"a18b33e15bde209a3c9115517c56d9ec\",\"618ee4b9660265a85a8b61277de2a579\",\"d9d87cf8ed7c29ed2eda06d5dec4dcda\",\"b963a451117f430703817b3b6c87402a\",\"2500\",\"29de79df95e70d8e8fbdc7945acf214a\",\"795b4d5cf0eb3ed80e24cbab39727b9d\",\"18d6b5e0f6b986cd074bf23de11ecd34\",\"2101\",\"ef2382c0cc2d99ee73444e684237a88a\",\"e710a66583fe0e324492462adb16014e\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"247071d42ff40267c8d8c44eac92da67\",\"13093fb658c1806ad5bd0600316158f2\",\"2000\",\"9763343d9cce11ce9eb4f21c8e49122b\",\"0d0be247863fcbf08b3db943e5f45992\",\"5404c3df9f771dbc0237578814bbe44b\",\"1303\",\"1302\",\"1103\",\"1301\",\"1102\",\"1300\",\"1101\",\"1100\",\"f15e2186907d22765cd149a94905842a\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"5b39ca5a25c772105c71f8c51d1f19d4\",\"1ae562534a64d4473899e52497c40b2e\",\"1000\",\"52715698214e88cb09fa4dd1ea5ad348\",\"64b61b8966e1c74d9b309069b2f622d1\",\"133f1408f5e3187d3e1a00b0260b7165\",\"2601\",\"2600\",\"2202\",\"10bd98f30a42427dd7ef75418ad3da6b\",\"2201\",\"2200\",\"e5ea38c1f97dee0043e78f3fb27b25d6\",\"7b14af9e9fbff286856338a194422b07\",\"74f2b2a8871a298e0acc4d7129d10e9c\",\"fe4c7938e146ec223e99d426aaa87109\",\"76d6087052dc26b32f3efa71b9cc119b\",\"bd62904371247f56594741ff8e9bded9\",\"2100\",\"eb17cee437ea6b630dad59fff2a059ca\",\"1403\",\"1402\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"1401\",\"1203\",\"1400\",\"1202\",\"1201\",\"b961670cbf3454f5927c4bd2a327e915\",\"1200\",\"621e50e1c7d66a1febeb699bebb2fe35\",\"d4c16faad8f883650a3a8eab829ebad9\",\"7754b1457826c48290bc189bb1289740\",\"9f02e346b5350366968f217daef3f1b7\",\"b8eafb6c3a8bf0919230f0bfa59d86b6\",\"caaec41413c5713c6f290efe08c11415\"]}',
        '56', 'MANAGE', '0', NULL, '1', '2020-08-12 11:26:59.124', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (846, '角色管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/menu', 'com.albedo.java.modules.sys.web.RoleResource.saveRoleMenus()',
        '{\"roleId\":\"1\",\"menuIdList\":[\"92f78825551a22fa130c03066f398448\",\"413892fe8d52c1163d6659f51299dc96\",\"bb9dd4b7a2a462193d0f01517308f812\",\"e086c4aa4943a883b29cf94680608b89\",\"a18b33e15bde209a3c9115517c56d9ec\",\"618ee4b9660265a85a8b61277de2a579\",\"d9d87cf8ed7c29ed2eda06d5dec4dcda\",\"b963a451117f430703817b3b6c87402a\",\"2500\",\"29de79df95e70d8e8fbdc7945acf214a\",\"795b4d5cf0eb3ed80e24cbab39727b9d\",\"18d6b5e0f6b986cd074bf23de11ecd34\",\"2101\",\"ef2382c0cc2d99ee73444e684237a88a\",\"e710a66583fe0e324492462adb16014e\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"247071d42ff40267c8d8c44eac92da67\",\"671fa1206a2446b046d4a91deceddd0f\",\"13093fb658c1806ad5bd0600316158f2\",\"2000\",\"9763343d9cce11ce9eb4f21c8e49122b\",\"0d3216078a1006368af2131743325926\",\"0d0be247863fcbf08b3db943e5f45992\",\"5404c3df9f771dbc0237578814bbe44b\",\"1303\",\"1302\",\"1103\",\"1301\",\"956393c3e3d73714c0facc7ed628c371\",\"1102\",\"1300\",\"1101\",\"1100\",\"f15e2186907d22765cd149a94905842a\",\"1120fe9bc06066fae0aec08325bdf56e\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"5b39ca5a25c772105c71f8c51d1f19d4\",\"1ae562534a64d4473899e52497c40b2e\",\"1000\",\"52715698214e88cb09fa4dd1ea5ad348\",\"64b61b8966e1c74d9b309069b2f622d1\",\"133f1408f5e3187d3e1a00b0260b7165\",\"8591bd99f07ad86cc3bf6debb65fc799\",\"2601\",\"2600\",\"2202\",\"10bd98f30a42427dd7ef75418ad3da6b\",\"2201\",\"2200\",\"e5ea38c1f97dee0043e78f3fb27b25d6\",\"7b14af9e9fbff286856338a194422b07\",\"74f2b2a8871a298e0acc4d7129d10e9c\",\"fe4c7938e146ec223e99d426aaa87109\",\"76d6087052dc26b32f3efa71b9cc119b\",\"f9153fa246f209a70a97e51edd31ace5\",\"bd62904371247f56594741ff8e9bded9\",\"2100\",\"5af0ff6dd036af1f1bfdcc13c42023b3\",\"eb17cee437ea6b630dad59fff2a059ca\",\"1403\",\"1402\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"bc7a2552fa2dbca2abc36fb6b73f695f\",\"1401\",\"1203\",\"1400\",\"1202\",\"1201\",\"b961670cbf3454f5927c4bd2a327e915\",\"1200\",\"621e50e1c7d66a1febeb699bebb2fe35\",\"2f95c888121de9aae1bc8f61c5fd508c\",\"d4c16faad8f883650a3a8eab829ebad9\",\"0d857a3a2e3b3b67bba0a9b4dcd80b55\",\"7754b1457826c48290bc189bb1289740\",\"9f02e346b5350366968f217daef3f1b7\",\"b8eafb6c3a8bf0919230f0bfa59d86b6\",\"caaec41413c5713c6f290efe08c11415\"]}',
        '55', 'MANAGE', '0', NULL, '1', '2020-08-12 11:27:01.213', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (847, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-12 11:27:03.391', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (848, '控制前端页面内容查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-front/', 'com.albedo.java.modules.t.web.TFrontResource.getPage()',
        '{\"tFrontQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '12', 'MANAGE', '0', NULL, '1', '2020-08-12 11:27:13.944', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (849, '管理发票抬头查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice/', 'com.albedo.java.modules.t.web.TInvoiceResource.getPage()',
        '{\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0},\"tInvoiceQueryCriteria\":{}}',
        '8', 'MANAGE', '0', NULL, '1', '2020-08-12 11:27:16.433', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (850, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=50001597202915273&code=1&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-12 11:28:38.266', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (851, '管理发票抬头查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice/', 'com.albedo.java.modules.t.web.TInvoiceResource.getPage()',
        '{\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0},\"tInvoiceQueryCriteria\":{}}',
        '33', 'MANAGE', '0', NULL, '1', '2020-08-12 11:28:41.682', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (852, '查看发票申请历史查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice-history/', 'com.albedo.java.modules.t.web.TInvoiceHistoryResource.getPage()',
        '{\"tInvoiceHistoryQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '11', 'MANAGE', '0', NULL, '1', '2020-08-12 11:28:43.243', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (853, '控制前端页面内容查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-front/', 'com.albedo.java.modules.t.web.TFrontResource.getPage()',
        '{\"tFrontQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '19', 'MANAGE', '0', NULL, '1', '2020-08-12 11:28:45.563', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (854, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '288', 'MANAGE', '0', NULL, '1', '2020-08-12 11:28:54.794', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (855, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"list\",\"permission\":\"t_tInvoice_view\",\"sort\":35,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t/t-invoice\",\"component\":\"t/t-invoice/index\",\"name\":\"发票抬头管理\",\"id\":\"671fa1206a2446b046d4a91deceddd0f\",\"iframe\":0}',
        '61', 'MANAGE', '0', NULL, '1', '2020-08-12 11:29:08.008', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (856, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '286', 'MANAGE', '0', NULL, '1', '2020-08-12 11:29:08.185', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (857, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"list\",\"permission\":\"t_tInvoiceHistory_view\",\"sort\":40,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t/t-invoice-history\",\"component\":\"t/t-invoice-history/index\",\"name\":\"发票历史\",\"id\":\"f9153fa246f209a70a97e51edd31ace5\",\"iframe\":0}',
        '63', 'MANAGE', '0', NULL, '1', '2020-08-12 11:29:14.231', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (858, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '264', 'MANAGE', '0', NULL, '1', '2020-08-12 11:29:14.706', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (859, '管理发票抬头查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice/', 'com.albedo.java.modules.t.web.TInvoiceResource.getPage()',
        '{\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0},\"tInvoiceQueryCriteria\":{}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-12 11:29:35.002', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (860, '管理发票抬头查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice/', 'com.albedo.java.modules.t.web.TInvoiceResource.getPage()',
        '{\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0},\"tInvoiceQueryCriteria\":{}}',
        '3', 'MANAGE', '0', NULL, '1', '2020-08-12 11:29:36.394', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (861, '控制前端页面内容查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-front/', 'com.albedo.java.modules.t.web.TFrontResource.getPage()',
        '{\"tFrontQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '6', 'MANAGE', '0', NULL, '1', '2020-08-12 11:30:23.963', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (862, '查看发票申请历史查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice-history/', 'com.albedo.java.modules.t.web.TInvoiceHistoryResource.getPage()',
        '{\"tInvoiceHistoryQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-12 11:30:36.251', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (863, '管理发票抬头查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice/', 'com.albedo.java.modules.t.web.TInvoiceResource.getPage()',
        '{\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0},\"tInvoiceQueryCriteria\":{}}',
        '3', 'MANAGE', '0', NULL, '1', '2020-08-12 11:30:52.177', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (864, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=98171597214230536&code=1&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-12 14:37:13.765', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (865, '管理发票抬头查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice/', 'com.albedo.java.modules.t.web.TInvoiceResource.getPage()',
        '{\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0},\"tInvoiceQueryCriteria\":{}}',
        '16163', 'MANAGE', '0', NULL, '1', '2020-08-12 14:37:17.678', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (866, '管理发票抬头查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice/', 'com.albedo.java.modules.t.web.TInvoiceResource.getPage()',
        '{\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0},\"tInvoiceQueryCriteria\":{}}',
        '50876', 'MANAGE', '0', NULL, '1', '2020-08-12 14:37:38.922', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (867, '控制前端页面内容查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-front/', 'com.albedo.java.modules.t.web.TFrontResource.getPage()',
        '{\"tFrontQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '37', 'MANAGE', '0', NULL, '1', '2020-08-12 14:38:29.813', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (868, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=54311597214337454&code=123&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-12 14:39:01.252', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (869, '管理发票抬头查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice/', 'com.albedo.java.modules.t.web.TInvoiceResource.getPage()',
        '{\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0},\"tInvoiceQueryCriteria\":{}}',
        '36', 'MANAGE', '0', NULL, '1', '2020-08-12 14:39:12.126', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (870, '管理发票抬头编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice', 'com.albedo.java.modules.t.web.TInvoiceResource.save()',
        '{\"name\":\"超级管理员\",\"type\":\"0\",\"userId\":\"1\"}', '29', 'MANAGE', '0', NULL, '1',
        '2020-08-12 14:39:44.519', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (871, '管理发票抬头查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice/', 'com.albedo.java.modules.t.web.TInvoiceResource.getPage()',
        '{\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0},\"tInvoiceQueryCriteria\":{}}',
        '15', 'MANAGE', '0', NULL, '1', '2020-08-12 14:39:44.651', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (872, '管理发票抬头编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice', 'com.albedo.java.modules.t.web.TInvoiceResource.save()',
        '{\"name\":\"test\",\"type\":\"1\",\"userId\":\"49f40b21c1dbdc83255d5c64119fcd4d\"}', '21', 'MANAGE', '0', NULL,
        '1', '2020-08-12 14:40:00.495', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (873, '管理发票抬头查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice/', 'com.albedo.java.modules.t.web.TInvoiceResource.getPage()',
        '{\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0},\"tInvoiceQueryCriteria\":{}}',
        '7', 'MANAGE', '0', NULL, '1', '2020-08-12 14:40:00.751', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (874, '管理发票抬头编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice', 'com.albedo.java.modules.t.web.TInvoiceResource.save()',
        '{\"name\":\"test\",\"id\":\"a76955c87a9bdbb9c8079124c1ed721a\",\"type\":\"1\",\"userId\":\"49f40b21c1dbdc83255d5c64119fcd4d\"}',
        '16', 'MANAGE', '0', NULL, '1', '2020-08-12 14:40:11.016', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (875, '管理发票抬头查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice/', 'com.albedo.java.modules.t.web.TInvoiceResource.getPage()',
        '{\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0},\"tInvoiceQueryCriteria\":{}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-12 14:40:11.266', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (876, '管理发票抬头查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice/', 'com.albedo.java.modules.t.web.TInvoiceResource.getPage()',
        '{\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0},\"tInvoiceQueryCriteria\":{}}',
        '9', 'MANAGE', '0', NULL, '1', '2020-08-12 14:41:58.652', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (877, '查看发票申请历史查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice-history/', 'com.albedo.java.modules.t.web.TInvoiceHistoryResource.getPage()',
        '{\"tInvoiceHistoryQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '9', 'MANAGE', '0', NULL, '1', '2020-08-12 14:44:12.022', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (878, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL,
        'password=111111&randomStr=15811597215055875&code=1223&rememberMe=false&username=admin', NULL, 'MANAGE', '0',
        NULL, '1', '2020-08-12 14:50:59.141', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (879, '查看发票申请历史查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice-history/', 'com.albedo.java.modules.t.web.TInvoiceHistoryResource.getPage()',
        '{\"tInvoiceHistoryQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '37', 'MANAGE', '0', NULL, '1', '2020-08-12 14:51:00.209', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (880, '查看发票申请历史编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice-history', 'com.albedo.java.modules.t.web.TInvoiceHistoryResource.save()',
        '{\"invoiceId\":\"66006f534d15db4414297b94bf28ae7c\",\"userId\":\"1\"}', '25', 'MANAGE', '0', NULL, '1',
        '2020-08-12 14:51:22.655', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (881, '查看发票申请历史查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice-history/', 'com.albedo.java.modules.t.web.TInvoiceHistoryResource.getPage()',
        '{\"tInvoiceHistoryQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '14', 'MANAGE', '0', NULL, '1', '2020-08-12 14:51:22.809', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (882, '查看发票申请历史编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice-history', 'com.albedo.java.modules.t.web.TInvoiceHistoryResource.save()',
        '{\"invoiceId\":\"a76955c87a9bdbb9c8079124c1ed721a\",\"userId\":\"1\"}', '11', 'MANAGE', '0', NULL, '1',
        '2020-08-12 14:51:34.778', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (883, '查看发票申请历史查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice-history/', 'com.albedo.java.modules.t.web.TInvoiceHistoryResource.getPage()',
        '{\"tInvoiceHistoryQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '8', 'MANAGE', '0', NULL, '1', '2020-08-12 14:51:35.031', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (884, '查看发票申请历史查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice-history/', 'com.albedo.java.modules.t.web.TInvoiceHistoryResource.getPage()',
        '{\"tInvoiceHistoryQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '8', 'MANAGE', '0', NULL, '1', '2020-08-12 14:51:53.541', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (885, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=44151597217522517&code=123&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-12 15:32:06.935', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (886, '管理发票抬头查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice/', 'com.albedo.java.modules.t.web.TInvoiceResource.getPage()',
        '{\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0},\"tInvoiceQueryCriteria\":{}}',
        '44', 'MANAGE', '0', NULL, '1', '2020-08-12 15:32:13.025', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (887, '查看发票申请历史查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice-history/', 'com.albedo.java.modules.t.web.TInvoiceHistoryResource.getPage()',
        '{\"tInvoiceHistoryQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '13', 'MANAGE', '0', NULL, '1', '2020-08-12 15:32:14.405', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (888, '管理发票抬头查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice/', 'com.albedo.java.modules.t.web.TInvoiceResource.getPage()',
        '{\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0},\"tInvoiceQueryCriteria\":{}}',
        '7', 'MANAGE', '0', NULL, '1', '2020-08-12 15:32:15.709', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (889, '查看发票申请历史查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice-history/', 'com.albedo.java.modules.t.web.TInvoiceHistoryResource.getPage()',
        '{\"tInvoiceHistoryQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '9', 'MANAGE', '0', NULL, '1', '2020-08-12 15:32:17.006', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (890, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '12', 'MANAGE', '0', NULL, '1', '2020-08-12 15:33:21.585', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (891, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '6', 'MANAGE', '0', NULL, '1', '2020-08-12 15:33:48.161', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (892, '业务表编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.save()',
        '{\"childList\":[],\"className\":\"TOrder\",\"importList\":[\"com.baomidou.mybatisplus.annotation.*\",\"com.albedo.java.common.persistence.domain.IdEntity\",\"javax.validation.constraints.Size\",\"javax.validation.constraints.NotBlank\",\"javax.validation.constraints.NotNull\",\"com.albedo.java.common.core.annotation.DictType\"],\"statusExists\":true,\"createTimeExists\":false,\"pkColumn\":{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false},\"parentExists\":false,\"pkList\":[\"id\"],\"comments\":\"t_order\",\"pkSqlName\":\"id\",\"updateTimeExists\":false,\"columnList\":[{\"$ref\":\"$.pkColumn\"},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"USERID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"userId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"userId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"user_id\",\"nameAndTitle\":\"user_id  :  用户id\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"userId\",\"size\":\"32\",\"sort\":20,\"title\":\"用户id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"订单状态（具体细节后面再说）长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"STATUS\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"status\",\"javaFieldAttrs\":[],\"javaFieldId\":\"status\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"status\",\"nameAndTitle\":\"status  :  订单状态（具体细节后面再说）\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"订单状态（具体细节后面再说）长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"status\",\"size\":\"255\",\"sort\":30,\"title\":\"订单状态（具体细节后面再说）\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"订单类型（加速卡，单次，多次）长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"TYPE\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"type\",\"javaFieldAttrs\":[],\"javaFieldId\":\"type\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"type\",\"nameAndTitle\":\"type  :  订单类型（加速卡，单次，多次）\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"订单类型（加速卡，单次，多次）长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"type\",\"size\":\"255\",\"sort\":40,\"title\":\"订单类型（加速卡，单次，多次）\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"视频id，等视频上传后更新长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"VIDEOID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"videoId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"videoId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"video_id\",\"nameAndTitle\":\"video_id  :  视频id，等视频上传后更新\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"视频id，等视频上传后更新长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"videoId\",\"size\":\"32\",\"sort\":50,\"title\":\"视频id，等视频上传后更新\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"支付宝订单交易号长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"TRADENO\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"tradeNo\",\"javaFieldAttrs\":[],\"javaFieldId\":\"tradeNo\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":true,\"name\":\"trade_no\",\"nameAndTitle\":\"trade_no  :  支付宝订单交易号\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"支付宝订单交易号长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"tradeNo\",\"size\":\"50\",\"sort\":60,\"title\":\"支付宝订单交易号\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"支付金额不能为空\\\")\"],\"constantJavaField\":\"PRICE\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"price\",\"javaFieldAttrs\":[],\"javaFieldId\":\"price\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Double\",\"jdbcType\":\"decimal(20,2)\",\"list\":true,\"name\":\"price\",\"nameAndTitle\":\"price  :  支付金额\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"支付金额不能为空\\\")\"],\"simpleJavaField\":\"price\",\"size\":\"20,2\",\"sort\":70,\"title\":\"支付金额\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"用户名字长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"USERNAME\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"userName\",\"javaFieldAttrs\":[],\"javaFieldId\":\"userName\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"user_name\",\"nameAndTitle\":\"user_name  :  用户名字\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"用户名字长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"userName\",\"size\":\"255\",\"sort\":80,\"title\":\"用户名字\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"用户电话长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"USERPHONE\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"userPhone\",\"javaFieldAttrs\":[],\"javaFieldId\":\"userPhone\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"user_phone\",\"nameAndTitle\":\"user_phone  :  用户电话\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"用户电话长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"userPhone\",\"size\":\"255\",\"sort\":90,\"title\":\"用户电话\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":100,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":110,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":120,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":130,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":140,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":150,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":160,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"childeExists\":false,\"notCompositeId\":true,\"pkColumnList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false}],\"columnFormList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"USERID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"userId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"userId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"user_id\",\"nameAndTitle\":\"user_id  :  用户id\",\"null\":false,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"userId\",\"size\":\"32\",\"sort\":20,\"title\":\"用户id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"订单状态（具体细节后面再说）长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"STATUS\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"status\",\"javaFieldAttrs\":[],\"javaFieldId\":\"status\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"status\",\"nameAndTitle\":\"status  :  订单状态（具体细节后面再说）\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"订单状态（具体细节后面再说）长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"status\",\"size\":\"255\",\"sort\":30,\"title\":\"订单状态（具体细节后面再说）\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"订单类型（加速卡，单次，多次）长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"TYPE\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"type\",\"javaFieldAttrs\":[],\"javaFieldId\":\"type\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"type\",\"nameAndTitle\":\"type  :  订单类型（加速卡，单次，多次）\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"订单类型（加速卡，单次，多次）长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"type\",\"size\":\"255\",\"sort\":40,\"title\":\"订单类型（加速卡，单次，多次）\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"视频id，等视频上传后更新长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"VIDEOID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"videoId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"videoId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"video_id\",\"nameAndTitle\":\"video_id  :  视频id，等视频上传后更新\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"视频id，等视频上传后更新长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"videoId\",\"size\":\"32\",\"sort\":50,\"title\":\"视频id，等视频上传后更新\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"支付宝订单交易号长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"TRADENO\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"tradeNo\",\"javaFieldAttrs\":[],\"javaFieldId\":\"tradeNo\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":true,\"name\":\"trade_no\",\"nameAndTitle\":\"trade_no  :  支付宝订单交易号\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"支付宝订单交易号长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"tradeNo\",\"size\":\"50\",\"sort\":60,\"title\":\"支付宝订单交易号\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"支付金额不能为空\\\")\"],\"constantJavaField\":\"PRICE\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"price\",\"javaFieldAttrs\":[],\"javaFieldId\":\"price\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Double\",\"jdbcType\":\"decimal(20,2)\",\"list\":true,\"name\":\"price\",\"nameAndTitle\":\"price  :  支付金额\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"支付金额不能为空\\\")\"],\"simpleJavaField\":\"price\",\"size\":\"20,2\",\"sort\":70,\"title\":\"支付金额\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"用户名字长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"USERNAME\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"userName\",\"javaFieldAttrs\":[],\"javaFieldId\":\"userName\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"user_name\",\"nameAndTitle\":\"user_name  :  用户名字\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"用户名字长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"userName\",\"size\":\"255\",\"sort\":80,\"title\":\"用户名字\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"用户电话长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"USERPHONE\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"userPhone\",\"javaFieldAttrs\":[],\"javaFieldId\":\"userPhone\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"user_phone\",\"nameAndTitle\":\"user_phone  :  用户电话\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"用户电话长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"userPhone\",\"size\":\"255\",\"sort\":90,\"title\":\"用户电话\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":100,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":110,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":120,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":130,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":140,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":150,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":160,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"pkSize\":\"32\",\"name\":\"t_order\",\"compositeId\":false,\"nameAndTitle\":\"t_order  :  \",\"pkJavaType\":\"String\"}',
        '273', 'MANAGE', '0', NULL, '1', '2020-08-12 15:35:16.194', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (893, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '6', 'MANAGE', '0', NULL, '1', '2020-08-12 15:35:17.271', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (894, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '20', 'MANAGE', '0', NULL, '1', '2020-08-12 15:35:27.712', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (895, '生成方案编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.save()',
        '{\"functionAuthor\":\"admin\",\"functionName\":\"订单管理\",\"functionNameSimple\":\"t_order\",\"modalView\":false,\"moduleName\":\"t\",\"replaceFile\":false,\"genCode\":true,\"name\":\"订单\",\"tableId\":\"5419e930e63aecec3b0266776cca0fbf\",\"packageName\":\"com.albedo.java.modules\",\"category\":\"curd\"}',
        '420', 'MANAGE', '0', NULL, '1', '2020-08-12 15:36:12.700', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (896, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '9', 'MANAGE', '0', NULL, '1', '2020-08-12 15:36:16.403', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (897, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '10', 'MANAGE', '0', NULL, '1', '2020-08-12 15:36:19.137', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (898, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '291', 'MANAGE', '0', NULL, '1', '2020-08-12 15:36:25.100', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (899, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"alipay\",\"permission\":\"t_tOrder_view\",\"sort\":30,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t/t-order/\",\"component\":\"t/t-order/index\",\"name\":\"订单管理\",\"iframe\":0}',
        '30', 'MANAGE', '0', NULL, '1', '2020-08-12 15:37:34.554', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (900, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '338', 'MANAGE', '0', NULL, '1', '2020-08-12 15:37:34.793', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (901, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"alipay\",\"permission\":\"t_tOrder_view\",\"sort\":30,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t/t-order\",\"component\":\"t/t-order/index\",\"name\":\"订单管理\",\"id\":\"55b8af86fa4b4e53680a652f83ad1c3a\",\"iframe\":0}',
        '54', 'MANAGE', '0', NULL, '1', '2020-08-12 15:37:48.712', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (902, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '271', 'MANAGE', '0', NULL, '1', '2020-08-12 15:37:49.204', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (903, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"hidden\":0,\"permission\":\"t_tOrder_edit\",\"sort\":30,\"type\":\"2\",\"parentId\":\"55b8af86fa4b4e53680a652f83ad1c3a\",\"name\":\"编辑\"}',
        '20', 'MANAGE', '0', NULL, '1', '2020-08-12 15:38:14.625', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (904, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '280', 'MANAGE', '0', NULL, '1', '2020-08-12 15:38:14.876', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (905, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"hidden\":0,\"permission\":\"t_tOrder_del\",\"sort\":35,\"type\":\"2\",\"parentId\":\"55b8af86fa4b4e53680a652f83ad1c3a\",\"name\":\"删除\"}',
        '22', 'MANAGE', '0', NULL, '1', '2020-08-12 15:38:33.599', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (906, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '289', 'MANAGE', '0', NULL, '1', '2020-08-12 15:38:33.849', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (907, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '9', 'MANAGE', '0', NULL, '1', '2020-08-12 15:38:41.085', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (908, '角色管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/menu', 'com.albedo.java.modules.sys.web.RoleResource.saveRoleMenus()',
        '{\"roleId\":\"1\",\"menuIdList\":[\"92f78825551a22fa130c03066f398448\",\"413892fe8d52c1163d6659f51299dc96\",\"bb9dd4b7a2a462193d0f01517308f812\",\"e086c4aa4943a883b29cf94680608b89\",\"a18b33e15bde209a3c9115517c56d9ec\",\"618ee4b9660265a85a8b61277de2a579\",\"d9d87cf8ed7c29ed2eda06d5dec4dcda\",\"b963a451117f430703817b3b6c87402a\",\"2500\",\"29de79df95e70d8e8fbdc7945acf214a\",\"795b4d5cf0eb3ed80e24cbab39727b9d\",\"18d6b5e0f6b986cd074bf23de11ecd34\",\"2101\",\"ef2382c0cc2d99ee73444e684237a88a\",\"e710a66583fe0e324492462adb16014e\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"247071d42ff40267c8d8c44eac92da67\",\"13093fb658c1806ad5bd0600316158f2\",\"2000\",\"9763343d9cce11ce9eb4f21c8e49122b\",\"0d0be247863fcbf08b3db943e5f45992\",\"5404c3df9f771dbc0237578814bbe44b\",\"1303\",\"1302\",\"1103\",\"1301\",\"1102\",\"1300\",\"1101\",\"1100\",\"f15e2186907d22765cd149a94905842a\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"5b39ca5a25c772105c71f8c51d1f19d4\",\"1ae562534a64d4473899e52497c40b2e\",\"1000\",\"52715698214e88cb09fa4dd1ea5ad348\",\"64b61b8966e1c74d9b309069b2f622d1\",\"133f1408f5e3187d3e1a00b0260b7165\",\"2601\",\"2600\",\"2202\",\"10bd98f30a42427dd7ef75418ad3da6b\",\"2201\",\"2200\",\"e5ea38c1f97dee0043e78f3fb27b25d6\",\"7b14af9e9fbff286856338a194422b07\",\"74f2b2a8871a298e0acc4d7129d10e9c\",\"fe4c7938e146ec223e99d426aaa87109\",\"76d6087052dc26b32f3efa71b9cc119b\",\"bd62904371247f56594741ff8e9bded9\",\"2100\",\"eb17cee437ea6b630dad59fff2a059ca\",\"1403\",\"1402\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"1401\",\"1203\",\"1400\",\"1202\",\"1201\",\"b961670cbf3454f5927c4bd2a327e915\",\"1200\",\"621e50e1c7d66a1febeb699bebb2fe35\",\"d4c16faad8f883650a3a8eab829ebad9\",\"7754b1457826c48290bc189bb1289740\",\"9f02e346b5350366968f217daef3f1b7\",\"b8eafb6c3a8bf0919230f0bfa59d86b6\",\"caaec41413c5713c6f290efe08c11415\"]}',
        '50', 'MANAGE', '0', NULL, '1', '2020-08-12 15:38:45.538', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (909, '角色管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/menu', 'com.albedo.java.modules.sys.web.RoleResource.saveRoleMenus()',
        '{\"roleId\":\"1\",\"menuIdList\":[\"92f78825551a22fa130c03066f398448\",\"413892fe8d52c1163d6659f51299dc96\",\"bb9dd4b7a2a462193d0f01517308f812\",\"e086c4aa4943a883b29cf94680608b89\",\"c26df9cff6e0a72ccd966ff8b7c841d4\",\"a18b33e15bde209a3c9115517c56d9ec\",\"618ee4b9660265a85a8b61277de2a579\",\"d9d87cf8ed7c29ed2eda06d5dec4dcda\",\"b963a451117f430703817b3b6c87402a\",\"2500\",\"29de79df95e70d8e8fbdc7945acf214a\",\"795b4d5cf0eb3ed80e24cbab39727b9d\",\"18d6b5e0f6b986cd074bf23de11ecd34\",\"2101\",\"ef2382c0cc2d99ee73444e684237a88a\",\"e710a66583fe0e324492462adb16014e\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"55b8af86fa4b4e53680a652f83ad1c3a\",\"247071d42ff40267c8d8c44eac92da67\",\"671fa1206a2446b046d4a91deceddd0f\",\"13093fb658c1806ad5bd0600316158f2\",\"2000\",\"9763343d9cce11ce9eb4f21c8e49122b\",\"0d3216078a1006368af2131743325926\",\"0d0be247863fcbf08b3db943e5f45992\",\"5404c3df9f771dbc0237578814bbe44b\",\"1303\",\"1302\",\"1103\",\"1301\",\"956393c3e3d73714c0facc7ed628c371\",\"1102\",\"1300\",\"1101\",\"1100\",\"f15e2186907d22765cd149a94905842a\",\"1120fe9bc06066fae0aec08325bdf56e\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"5b39ca5a25c772105c71f8c51d1f19d4\",\"1ae562534a64d4473899e52497c40b2e\",\"1000\",\"52715698214e88cb09fa4dd1ea5ad348\",\"64b61b8966e1c74d9b309069b2f622d1\",\"133f1408f5e3187d3e1a00b0260b7165\",\"10b8dc68308ed1f3eb1096d8be4e0fc1\",\"8591bd99f07ad86cc3bf6debb65fc799\",\"2601\",\"2600\",\"2202\",\"10bd98f30a42427dd7ef75418ad3da6b\",\"2201\",\"2200\",\"e5ea38c1f97dee0043e78f3fb27b25d6\",\"7b14af9e9fbff286856338a194422b07\",\"74f2b2a8871a298e0acc4d7129d10e9c\",\"fe4c7938e146ec223e99d426aaa87109\",\"76d6087052dc26b32f3efa71b9cc119b\",\"f9153fa246f209a70a97e51edd31ace5\",\"bd62904371247f56594741ff8e9bded9\",\"2100\",\"5af0ff6dd036af1f1bfdcc13c42023b3\",\"eb17cee437ea6b630dad59fff2a059ca\",\"1403\",\"1402\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"bc7a2552fa2dbca2abc36fb6b73f695f\",\"1401\",\"1203\",\"1400\",\"1202\",\"1201\",\"b961670cbf3454f5927c4bd2a327e915\",\"1200\",\"621e50e1c7d66a1febeb699bebb2fe35\",\"2f95c888121de9aae1bc8f61c5fd508c\",\"d4c16faad8f883650a3a8eab829ebad9\",\"0d857a3a2e3b3b67bba0a9b4dcd80b55\",\"7754b1457826c48290bc189bb1289740\",\"9f02e346b5350366968f217daef3f1b7\",\"b8eafb6c3a8bf0919230f0bfa59d86b6\",\"caaec41413c5713c6f290efe08c11415\"]}',
        '44', 'MANAGE', '0', NULL, '1', '2020-08-12 15:38:47.724', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (910, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '17', 'MANAGE', '0', NULL, '1', '2020-08-12 15:39:55.384', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (911, '业务表编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.save()',
        '{\"childList\":[],\"className\":\"TVideo\",\"importList\":[\"com.baomidou.mybatisplus.annotation.*\",\"com.albedo.java.common.persistence.domain.IdEntity\",\"javax.validation.constraints.Size\",\"javax.validation.constraints.NotNull\",\"javax.validation.constraints.NotBlank\",\"com.albedo.java.common.core.annotation.DictType\"],\"statusExists\":false,\"createTimeExists\":false,\"pkColumn\":{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false},\"parentExists\":false,\"pkList\":[\"id\"],\"comments\":\"t_video\",\"pkSqlName\":\"id\",\"updateTimeExists\":false,\"columnList\":[{\"$ref\":\"$.pkColumn\"},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"视频名字长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"NAME\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaField\":\"name\",\"javaFieldAttrs\":[],\"javaFieldId\":\"name\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"name\",\"nameAndTitle\":\"name  :  视频名字\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"like\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"视频名字长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"name\",\"size\":\"255\",\"sort\":20,\"title\":\"视频名字\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"origin_url长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"ORIGINURL\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"originUrl\",\"javaFieldAttrs\":[],\"javaFieldId\":\"originUrl\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"origin_url\",\"nameAndTitle\":\"origin_url  :  origin_url\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"origin_url长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"originUrl\",\"size\":\"255\",\"sort\":30,\"title\":\"origin_url\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"logo的地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"LOGOURL\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"logoUrl\",\"javaFieldAttrs\":[],\"javaFieldId\":\"logoUrl\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"logo_url\",\"nameAndTitle\":\"logo_url  :  logo的地址\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"logo的地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"logoUrl\",\"size\":\"255\",\"sort\":40,\"title\":\"logo的地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"输出地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"OUTPUTURL\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"outputUrl\",\"javaFieldAttrs\":[],\"javaFieldId\":\"outputUrl\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"output_url\",\"nameAndTitle\":\"output_url  :  输出地址\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"输出地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"outputUrl\",\"size\":\"255\",\"sort\":50,\"title\":\"输出地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"视频长度，单位是秒不能为空\\\")\"],\"constantJavaField\":\"DURATION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"duration\",\"javaFieldAttrs\":[],\"javaFieldId\":\"duration\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":true,\"name\":\"duration\",\"nameAndTitle\":\"duration  :  视频长度，单位是秒\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"视频长度，单位是秒不能为空\\\")\"],\"simpleJavaField\":\"duration\",\"size\":\"\",\"sort\":60,\"title\":\"视频长度，单位是秒\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":70,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":80,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":90,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":100,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":110,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":120,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":130,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"childeExists\":false,\"notCompositeId\":true,\"pkColumnList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false}],\"columnFormList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"视频名字长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"NAME\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaField\":\"name\",\"javaFieldAttrs\":[],\"javaFieldId\":\"name\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"name\",\"nameAndTitle\":\"name  :  视频名字\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"like\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"视频名字长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"name\",\"size\":\"255\",\"sort\":20,\"title\":\"视频名字\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"origin_url长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"ORIGINURL\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"originUrl\",\"javaFieldAttrs\":[],\"javaFieldId\":\"originUrl\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"origin_url\",\"nameAndTitle\":\"origin_url  :  origin_url\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"origin_url长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"originUrl\",\"size\":\"255\",\"sort\":30,\"title\":\"origin_url\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"logo的地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"LOGOURL\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"logoUrl\",\"javaFieldAttrs\":[],\"javaFieldId\":\"logoUrl\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"logo_url\",\"nameAndTitle\":\"logo_url  :  logo的地址\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"logo的地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"logoUrl\",\"size\":\"255\",\"sort\":40,\"title\":\"logo的地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"输出地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"OUTPUTURL\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"outputUrl\",\"javaFieldAttrs\":[],\"javaFieldId\":\"outputUrl\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"output_url\",\"nameAndTitle\":\"output_url  :  输出地址\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"输出地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"outputUrl\",\"size\":\"255\",\"sort\":50,\"title\":\"输出地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"视频长度，单位是秒不能为空\\\")\"],\"constantJavaField\":\"DURATION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"duration\",\"javaFieldAttrs\":[],\"javaFieldId\":\"duration\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":true,\"name\":\"duration\",\"nameAndTitle\":\"duration  :  视频长度，单位是秒\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"视频长度，单位是秒不能为空\\\")\"],\"simpleJavaField\":\"duration\",\"size\":\"\",\"sort\":60,\"title\":\"视频长度，单位是秒\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":70,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":80,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":90,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":100,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":110,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":120,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":130,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"pkSize\":\"32\",\"name\":\"t_video\",\"compositeId\":false,\"nameAndTitle\":\"t_video  :  \",\"pkJavaType\":\"String\"}',
        '196', 'MANAGE', '0', NULL, '1', '2020-08-12 15:40:26.508', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (912, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-12 15:40:27.430', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (913, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '17', 'MANAGE', '0', NULL, '1', '2020-08-12 15:40:31.112', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (914, '生成方案编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.save()',
        '{\"functionAuthor\":\"admin\",\"functionName\":\"视频管理\",\"functionNameSimple\":\"t_video\",\"modalView\":false,\"moduleName\":\"t\",\"replaceFile\":false,\"genCode\":true,\"name\":\"视频\",\"tableId\":\"8012923c1e3bdf0ed8c3071a32d32685\",\"packageName\":\"com.albedo.java.modules\",\"category\":\"curd\"}',
        '163', 'MANAGE', '0', NULL, '1', '2020-08-12 15:41:01.676', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (915, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '7', 'MANAGE', '0', NULL, '1', '2020-08-12 15:41:03.502', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (916, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '9', 'MANAGE', '0', NULL, '1', '2020-08-12 15:41:05.843', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (917, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '271', 'MANAGE', '0', NULL, '1', '2020-08-12 15:41:09.234', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (918, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"menu\",\"permission\":\"t_tVideo_view\",\"sort\":30,\"type\":\"1\",\"parentId\":\"-1\",\"path\":\"t/t-video/index\",\"name\":\"视频管理\",\"iframe\":0}',
        '17', 'MANAGE', '0', NULL, '1', '2020-08-12 15:42:49.885', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (919, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '295', 'MANAGE', '0', NULL, '1', '2020-08-12 15:42:50.137', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (920, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"menu\",\"permission\":\"t_tVideo_view\",\"sort\":30,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t/t-video/index\",\"component\":\"t/t-video\",\"name\":\"视频管理\",\"id\":\"8c0d687c64b90afb0c0d80bc23fcd718\",\"iframe\":0}',
        '31', 'MANAGE', '0', NULL, '1', '2020-08-12 15:43:16.894', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (921, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '305', 'MANAGE', '0', NULL, '1', '2020-08-12 15:43:17.144', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (922, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"menu\",\"permission\":\"t_tVideo_view\",\"sort\":30,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t/t-video\",\"component\":\"t/t-video/index\",\"name\":\"视频管理\",\"id\":\"8c0d687c64b90afb0c0d80bc23fcd718\",\"iframe\":0}',
        '44', 'MANAGE', '0', NULL, '1', '2020-08-12 15:43:32.428', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (923, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '275', 'MANAGE', '0', NULL, '1', '2020-08-12 15:43:32.902', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (924, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"hidden\":0,\"permission\":\"t_tVideo_edit\",\"sort\":30,\"type\":\"2\",\"parentId\":\"8c0d687c64b90afb0c0d80bc23fcd718\",\"name\":\"编辑\"}',
        '20', 'MANAGE', '0', NULL, '1', '2020-08-12 15:44:14.814', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (925, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '297', 'MANAGE', '0', NULL, '1', '2020-08-12 15:44:15.068', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (926, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"hidden\":0,\"permission\":\"t_tVideo_del\",\"sort\":30,\"type\":\"2\",\"parentId\":\"8c0d687c64b90afb0c0d80bc23fcd718\",\"name\":\"删除\"}',
        '19', 'MANAGE', '0', NULL, '1', '2020-08-12 15:44:30.875', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (927, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '304', 'MANAGE', '0', NULL, '1', '2020-08-12 15:44:31.126', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (928, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '7', 'MANAGE', '0', NULL, '1', '2020-08-12 15:44:35.975', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (929, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '16', 'MANAGE', '0', NULL, '1', '2020-08-12 15:44:42.319', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (930, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-12 15:45:03.040', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (931, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-12 15:45:15.595', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (932, '角色管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/menu', 'com.albedo.java.modules.sys.web.RoleResource.saveRoleMenus()',
        '{\"roleId\":\"1\",\"menuIdList\":[\"92f78825551a22fa130c03066f398448\",\"413892fe8d52c1163d6659f51299dc96\",\"bb9dd4b7a2a462193d0f01517308f812\",\"e086c4aa4943a883b29cf94680608b89\",\"a18b33e15bde209a3c9115517c56d9ec\",\"618ee4b9660265a85a8b61277de2a579\",\"d9d87cf8ed7c29ed2eda06d5dec4dcda\",\"b963a451117f430703817b3b6c87402a\",\"2500\",\"29de79df95e70d8e8fbdc7945acf214a\",\"795b4d5cf0eb3ed80e24cbab39727b9d\",\"18d6b5e0f6b986cd074bf23de11ecd34\",\"2101\",\"ef2382c0cc2d99ee73444e684237a88a\",\"e710a66583fe0e324492462adb16014e\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"247071d42ff40267c8d8c44eac92da67\",\"13093fb658c1806ad5bd0600316158f2\",\"2000\",\"9763343d9cce11ce9eb4f21c8e49122b\",\"0d0be247863fcbf08b3db943e5f45992\",\"5404c3df9f771dbc0237578814bbe44b\",\"1303\",\"1302\",\"1103\",\"1301\",\"1102\",\"1300\",\"1101\",\"1100\",\"f15e2186907d22765cd149a94905842a\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"5b39ca5a25c772105c71f8c51d1f19d4\",\"1ae562534a64d4473899e52497c40b2e\",\"1000\",\"52715698214e88cb09fa4dd1ea5ad348\",\"64b61b8966e1c74d9b309069b2f622d1\",\"133f1408f5e3187d3e1a00b0260b7165\",\"2601\",\"2600\",\"2202\",\"10bd98f30a42427dd7ef75418ad3da6b\",\"2201\",\"2200\",\"e5ea38c1f97dee0043e78f3fb27b25d6\",\"7b14af9e9fbff286856338a194422b07\",\"74f2b2a8871a298e0acc4d7129d10e9c\",\"fe4c7938e146ec223e99d426aaa87109\",\"76d6087052dc26b32f3efa71b9cc119b\",\"bd62904371247f56594741ff8e9bded9\",\"2100\",\"eb17cee437ea6b630dad59fff2a059ca\",\"1403\",\"1402\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"1401\",\"1203\",\"1400\",\"1202\",\"1201\",\"b961670cbf3454f5927c4bd2a327e915\",\"1200\",\"621e50e1c7d66a1febeb699bebb2fe35\",\"d4c16faad8f883650a3a8eab829ebad9\",\"7754b1457826c48290bc189bb1289740\",\"9f02e346b5350366968f217daef3f1b7\",\"b8eafb6c3a8bf0919230f0bfa59d86b6\",\"caaec41413c5713c6f290efe08c11415\"]}',
        '39', 'MANAGE', '0', NULL, '1', '2020-08-12 15:45:21.772', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (933, '角色管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/menu', 'com.albedo.java.modules.sys.web.RoleResource.saveRoleMenus()',
        '{\"roleId\":\"1\",\"menuIdList\":[\"92f78825551a22fa130c03066f398448\",\"413892fe8d52c1163d6659f51299dc96\",\"bb9dd4b7a2a462193d0f01517308f812\",\"e086c4aa4943a883b29cf94680608b89\",\"c26df9cff6e0a72ccd966ff8b7c841d4\",\"a18b33e15bde209a3c9115517c56d9ec\",\"618ee4b9660265a85a8b61277de2a579\",\"d9d87cf8ed7c29ed2eda06d5dec4dcda\",\"b963a451117f430703817b3b6c87402a\",\"2500\",\"29de79df95e70d8e8fbdc7945acf214a\",\"795b4d5cf0eb3ed80e24cbab39727b9d\",\"18d6b5e0f6b986cd074bf23de11ecd34\",\"2101\",\"ef2382c0cc2d99ee73444e684237a88a\",\"e710a66583fe0e324492462adb16014e\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"55b8af86fa4b4e53680a652f83ad1c3a\",\"247071d42ff40267c8d8c44eac92da67\",\"671fa1206a2446b046d4a91deceddd0f\",\"13093fb658c1806ad5bd0600316158f2\",\"8c0d687c64b90afb0c0d80bc23fcd718\",\"2000\",\"9763343d9cce11ce9eb4f21c8e49122b\",\"0d3216078a1006368af2131743325926\",\"0d0be247863fcbf08b3db943e5f45992\",\"5404c3df9f771dbc0237578814bbe44b\",\"1303\",\"1302\",\"1103\",\"1301\",\"956393c3e3d73714c0facc7ed628c371\",\"1102\",\"1300\",\"1101\",\"1100\",\"f15e2186907d22765cd149a94905842a\",\"2abc3f5d5c38ace4cf491fa16928639d\",\"1120fe9bc06066fae0aec08325bdf56e\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"5b39ca5a25c772105c71f8c51d1f19d4\",\"1ae562534a64d4473899e52497c40b2e\",\"1000\",\"52715698214e88cb09fa4dd1ea5ad348\",\"64b61b8966e1c74d9b309069b2f622d1\",\"133f1408f5e3187d3e1a00b0260b7165\",\"10b8dc68308ed1f3eb1096d8be4e0fc1\",\"8591bd99f07ad86cc3bf6debb65fc799\",\"2601\",\"2600\",\"2202\",\"10bd98f30a42427dd7ef75418ad3da6b\",\"2201\",\"2200\",\"e5ea38c1f97dee0043e78f3fb27b25d6\",\"7b14af9e9fbff286856338a194422b07\",\"74f2b2a8871a298e0acc4d7129d10e9c\",\"fe4c7938e146ec223e99d426aaa87109\",\"76d6087052dc26b32f3efa71b9cc119b\",\"f9153fa246f209a70a97e51edd31ace5\",\"bd62904371247f56594741ff8e9bded9\",\"2100\",\"5af0ff6dd036af1f1bfdcc13c42023b3\",\"eb17cee437ea6b630dad59fff2a059ca\",\"83401bedafe0bdb0c01cc14f64ac8c0b\",\"1403\",\"1402\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"bc7a2552fa2dbca2abc36fb6b73f695f\",\"1401\",\"1203\",\"1400\",\"1202\",\"1201\",\"b961670cbf3454f5927c4bd2a327e915\",\"1200\",\"621e50e1c7d66a1febeb699bebb2fe35\",\"2f95c888121de9aae1bc8f61c5fd508c\",\"d4c16faad8f883650a3a8eab829ebad9\",\"0d857a3a2e3b3b67bba0a9b4dcd80b55\",\"7754b1457826c48290bc189bb1289740\",\"9f02e346b5350366968f217daef3f1b7\",\"b8eafb6c3a8bf0919230f0bfa59d86b6\",\"caaec41413c5713c6f290efe08c11415\"]}',
        '40', 'MANAGE', '0', NULL, '1', '2020-08-12 15:45:23.816', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (934, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-12 15:45:29.018', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (935, '业务表编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.save()',
        '{\"childList\":[],\"className\":\"SysSms\",\"importList\":[\"com.baomidou.mybatisplus.annotation.*\",\"com.albedo.java.common.persistence.domain.IdEntity\",\"javax.validation.constraints.NotNull\",\"javax.validation.constraints.Size\",\"javax.validation.constraints.NotBlank\",\"com.albedo.java.common.core.annotation.DictType\"],\"statusExists\":true,\"createTimeExists\":false,\"pkColumn\":{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false},\"parentExists\":false,\"pkList\":[\"id\"],\"comments\":\"sys_sms\",\"pkSqlName\":\"id\",\"updateTimeExists\":false,\"columnList\":[{\"$ref\":\"$.pkColumn\"},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"phone_number不能为空\\\")\"],\"constantJavaField\":\"PHONENUMBER\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"phoneNumber\",\"javaFieldAttrs\":[],\"javaFieldId\":\"phoneNumber\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":true,\"name\":\"phone_number\",\"nameAndTitle\":\"phone_number  :  phone_number\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"phone_number不能为空\\\")\"],\"simpleJavaField\":\"phoneNumber\",\"size\":\"\",\"sort\":20,\"title\":\"phone_number\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"开发票的userid长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"USERID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"userId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"userId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"user_id\",\"nameAndTitle\":\"user_id  :  开发票的userid\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"开发票的userid长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"userId\",\"size\":\"32\",\"sort\":30,\"title\":\"开发票的userid\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"类型？长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"TYPE\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"type\",\"javaFieldAttrs\":[],\"javaFieldId\":\"type\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(1)\",\"list\":true,\"name\":\"type\",\"nameAndTitle\":\"type  :  类型？\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"类型？长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"type\",\"size\":\"1\",\"sort\":40,\"title\":\"类型？\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"模板代码？长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"TEMPLATECODE\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"templateCode\",\"javaFieldAttrs\":[],\"javaFieldId\":\"templateCode\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"template_code\",\"nameAndTitle\":\"template_code  :  模板代码？\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"模板代码？长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"templateCode\",\"size\":\"255\",\"sort\":50,\"title\":\"模板代码？\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"template_param长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"TEMPLATEPARAM\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"templateParam\",\"javaFieldAttrs\":[],\"javaFieldId\":\"templateParam\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"template_param\",\"nameAndTitle\":\"template_param  :  template_param\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"template_param长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"templateParam\",\"size\":\"255\",\"sort\":60,\"title\":\"template_param\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"状态长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"STATUS\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"status\",\"javaFieldAttrs\":[],\"javaFieldId\":\"status\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"status\",\"nameAndTitle\":\"status  :  状态\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"状态长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"status\",\"size\":\"255\",\"sort\":70,\"title\":\"状态\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":80,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":90,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":100,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":110,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":120,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":130,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":140,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"childeExists\":false,\"notCompositeId\":true,\"pkColumnList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false}],\"columnFormList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"phone_number不能为空\\\")\"],\"constantJavaField\":\"PHONENUMBER\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"phoneNumber\",\"javaFieldAttrs\":[],\"javaFieldId\":\"phoneNumber\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":true,\"name\":\"phone_number\",\"nameAndTitle\":\"phone_number  :  phone_number\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"phone_number不能为空\\\")\"],\"simpleJavaField\":\"phoneNumber\",\"size\":\"\",\"sort\":20,\"title\":\"phone_number\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"开发票的userid长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"USERID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"userId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"userId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"user_id\",\"nameAndTitle\":\"user_id  :  开发票的userid\",\"null\":false,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"开发票的userid长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"userId\",\"size\":\"32\",\"sort\":30,\"title\":\"开发票的userid\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"类型？长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"TYPE\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"type\",\"javaFieldAttrs\":[],\"javaFieldId\":\"type\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(1)\",\"list\":true,\"name\":\"type\",\"nameAndTitle\":\"type  :  类型？\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"类型？长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"type\",\"size\":\"1\",\"sort\":40,\"title\":\"类型？\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"模板代码？长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"TEMPLATECODE\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"templateCode\",\"javaFieldAttrs\":[],\"javaFieldId\":\"templateCode\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"template_code\",\"nameAndTitle\":\"template_code  :  模板代码？\",\"null\":false,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"模板代码？长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"templateCode\",\"size\":\"255\",\"sort\":50,\"title\":\"模板代码？\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"template_param长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"TEMPLATEPARAM\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"templateParam\",\"javaFieldAttrs\":[],\"javaFieldId\":\"templateParam\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"template_param\",\"nameAndTitle\":\"template_param  :  template_param\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"template_param长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"templateParam\",\"size\":\"255\",\"sort\":60,\"title\":\"template_param\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"状态长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"STATUS\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"status\",\"javaFieldAttrs\":[],\"javaFieldId\":\"status\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"status\",\"nameAndTitle\":\"status  :  状态\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"状态长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"status\",\"size\":\"255\",\"sort\":70,\"title\":\"状态\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":80,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":90,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":100,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":110,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":120,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":130,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":140,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"pkSize\":\"32\",\"name\":\"sys_sms\",\"compositeId\":false,\"nameAndTitle\":\"sys_sms  :  \",\"pkJavaType\":\"String\"}',
        '205', 'MANAGE', '0', NULL, '1', '2020-08-12 15:45:52.333', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (936, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '3', 'MANAGE', '0', NULL, '1', '2020-08-12 15:45:53.285', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (937, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-12 15:45:56.085', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (938, '生成方案编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.save()',
        '{\"functionAuthor\":\"admin\",\"functionName\":\"管理短信\",\"functionNameSimple\":\"sys_sms\",\"modalView\":false,\"moduleName\":\"sys\",\"replaceFile\":false,\"genCode\":true,\"name\":\"短信管理\",\"tableId\":\"ff7056ae6be7d5994b8d870549fc1c6a\",\"packageName\":\"com.albedo.java.modules\",\"category\":\"curd\"}',
        '161', 'MANAGE', '0', NULL, '1', '2020-08-12 15:46:27.832', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (939, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '6', 'MANAGE', '0', NULL, '1', '2020-08-12 15:46:29.592', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (940, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '9', 'MANAGE', '0', NULL, '1', '2020-08-12 15:46:32.138', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (941, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '278', 'MANAGE', '0', NULL, '1', '2020-08-12 15:46:35.687', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (942, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"chain\",\"permission\":\"sys_sysSms_view\",\"sort\":30,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"sys/sys-sms\",\"component\":\"sys/sys-sms/index\",\"name\":\"短信管理\",\"iframe\":0}',
        '18', 'MANAGE', '0', NULL, '1', '2020-08-12 15:48:13.355', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (943, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '326', 'MANAGE', '0', NULL, '1', '2020-08-12 15:48:13.606', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (944, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"hidden\":0,\"permission\":\"sys_sysSms_edit\",\"sort\":30,\"type\":\"2\",\"parentId\":\"2a13e56860d4aced7a2b12881b139710\",\"name\":\"编辑\"}',
        '23', 'MANAGE', '0', NULL, '1', '2020-08-12 15:48:41.791', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (945, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '318', 'MANAGE', '0', NULL, '1', '2020-08-12 15:48:42.043', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (946, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"hidden\":0,\"permission\":\"sys_sysSms_del\",\"sort\":30,\"type\":\"2\",\"parentId\":\"2a13e56860d4aced7a2b12881b139710\",\"name\":\"删除\"}',
        '21', 'MANAGE', '0', NULL, '1', '2020-08-12 15:48:56.662', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (947, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '323', 'MANAGE', '0', NULL, '1', '2020-08-12 15:48:56.916', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (948, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '3', 'MANAGE', '0', NULL, '1', '2020-08-12 15:49:12.019', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (949, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-12 15:49:28.245', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (950, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '7', 'MANAGE', '0', NULL, '1', '2020-08-12 15:49:40.959', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (951, '角色管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/menu', 'com.albedo.java.modules.sys.web.RoleResource.saveRoleMenus()',
        '{\"roleId\":\"1\",\"menuIdList\":[\"92f78825551a22fa130c03066f398448\",\"413892fe8d52c1163d6659f51299dc96\",\"bb9dd4b7a2a462193d0f01517308f812\",\"e086c4aa4943a883b29cf94680608b89\",\"a18b33e15bde209a3c9115517c56d9ec\",\"618ee4b9660265a85a8b61277de2a579\",\"d9d87cf8ed7c29ed2eda06d5dec4dcda\",\"b963a451117f430703817b3b6c87402a\",\"2500\",\"29de79df95e70d8e8fbdc7945acf214a\",\"795b4d5cf0eb3ed80e24cbab39727b9d\",\"18d6b5e0f6b986cd074bf23de11ecd34\",\"2101\",\"ef2382c0cc2d99ee73444e684237a88a\",\"e710a66583fe0e324492462adb16014e\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"247071d42ff40267c8d8c44eac92da67\",\"13093fb658c1806ad5bd0600316158f2\",\"2000\",\"9763343d9cce11ce9eb4f21c8e49122b\",\"0d0be247863fcbf08b3db943e5f45992\",\"5404c3df9f771dbc0237578814bbe44b\",\"1303\",\"1302\",\"1103\",\"1301\",\"1102\",\"1300\",\"1101\",\"1100\",\"f15e2186907d22765cd149a94905842a\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"5b39ca5a25c772105c71f8c51d1f19d4\",\"1ae562534a64d4473899e52497c40b2e\",\"1000\",\"52715698214e88cb09fa4dd1ea5ad348\",\"64b61b8966e1c74d9b309069b2f622d1\",\"133f1408f5e3187d3e1a00b0260b7165\",\"2601\",\"2600\",\"2202\",\"10bd98f30a42427dd7ef75418ad3da6b\",\"2201\",\"2200\",\"e5ea38c1f97dee0043e78f3fb27b25d6\",\"7b14af9e9fbff286856338a194422b07\",\"74f2b2a8871a298e0acc4d7129d10e9c\",\"fe4c7938e146ec223e99d426aaa87109\",\"76d6087052dc26b32f3efa71b9cc119b\",\"bd62904371247f56594741ff8e9bded9\",\"2100\",\"eb17cee437ea6b630dad59fff2a059ca\",\"1403\",\"1402\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"1401\",\"1203\",\"1400\",\"1202\",\"1201\",\"b961670cbf3454f5927c4bd2a327e915\",\"1200\",\"621e50e1c7d66a1febeb699bebb2fe35\",\"d4c16faad8f883650a3a8eab829ebad9\",\"7754b1457826c48290bc189bb1289740\",\"9f02e346b5350366968f217daef3f1b7\",\"b8eafb6c3a8bf0919230f0bfa59d86b6\",\"caaec41413c5713c6f290efe08c11415\"]}',
        '33', 'MANAGE', '0', NULL, '1', '2020-08-12 15:49:45.175', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (952, '角色管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/menu', 'com.albedo.java.modules.sys.web.RoleResource.saveRoleMenus()',
        '{\"roleId\":\"1\",\"menuIdList\":[\"edc01fe5edb70ebb040b2acb428e5821\",\"92f78825551a22fa130c03066f398448\",\"413892fe8d52c1163d6659f51299dc96\",\"bb9dd4b7a2a462193d0f01517308f812\",\"e086c4aa4943a883b29cf94680608b89\",\"c26df9cff6e0a72ccd966ff8b7c841d4\",\"a18b33e15bde209a3c9115517c56d9ec\",\"618ee4b9660265a85a8b61277de2a579\",\"d9d87cf8ed7c29ed2eda06d5dec4dcda\",\"b963a451117f430703817b3b6c87402a\",\"2500\",\"29de79df95e70d8e8fbdc7945acf214a\",\"795b4d5cf0eb3ed80e24cbab39727b9d\",\"18d6b5e0f6b986cd074bf23de11ecd34\",\"2101\",\"ef2382c0cc2d99ee73444e684237a88a\",\"e710a66583fe0e324492462adb16014e\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"55b8af86fa4b4e53680a652f83ad1c3a\",\"247071d42ff40267c8d8c44eac92da67\",\"2a13e56860d4aced7a2b12881b139710\",\"671fa1206a2446b046d4a91deceddd0f\",\"13093fb658c1806ad5bd0600316158f2\",\"8c0d687c64b90afb0c0d80bc23fcd718\",\"2000\",\"9763343d9cce11ce9eb4f21c8e49122b\",\"0d3216078a1006368af2131743325926\",\"0d0be247863fcbf08b3db943e5f45992\",\"5404c3df9f771dbc0237578814bbe44b\",\"1303\",\"1302\",\"1103\",\"1301\",\"956393c3e3d73714c0facc7ed628c371\",\"1102\",\"1300\",\"1101\",\"1100\",\"f15e2186907d22765cd149a94905842a\",\"2abc3f5d5c38ace4cf491fa16928639d\",\"1120fe9bc06066fae0aec08325bdf56e\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"5b39ca5a25c772105c71f8c51d1f19d4\",\"1ae562534a64d4473899e52497c40b2e\",\"1000\",\"52715698214e88cb09fa4dd1ea5ad348\",\"64b61b8966e1c74d9b309069b2f622d1\",\"133f1408f5e3187d3e1a00b0260b7165\",\"10b8dc68308ed1f3eb1096d8be4e0fc1\",\"8591bd99f07ad86cc3bf6debb65fc799\",\"2601\",\"2600\",\"2202\",\"10bd98f30a42427dd7ef75418ad3da6b\",\"2201\",\"2200\",\"e5ea38c1f97dee0043e78f3fb27b25d6\",\"7b14af9e9fbff286856338a194422b07\",\"74f2b2a8871a298e0acc4d7129d10e9c\",\"fe4c7938e146ec223e99d426aaa87109\",\"76d6087052dc26b32f3efa71b9cc119b\",\"d12f44379df45c21e30dda4cfd27d710\",\"f9153fa246f209a70a97e51edd31ace5\",\"bd62904371247f56594741ff8e9bded9\",\"2100\",\"5af0ff6dd036af1f1bfdcc13c42023b3\",\"eb17cee437ea6b630dad59fff2a059ca\",\"83401bedafe0bdb0c01cc14f64ac8c0b\",\"1403\",\"1402\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"bc7a2552fa2dbca2abc36fb6b73f695f\",\"1401\",\"1203\",\"1400\",\"1202\",\"1201\",\"b961670cbf3454f5927c4bd2a327e915\",\"1200\",\"621e50e1c7d66a1febeb699bebb2fe35\",\"2f95c888121de9aae1bc8f61c5fd508c\",\"d4c16faad8f883650a3a8eab829ebad9\",\"0d857a3a2e3b3b67bba0a9b4dcd80b55\",\"7754b1457826c48290bc189bb1289740\",\"9f02e346b5350366968f217daef3f1b7\",\"b8eafb6c3a8bf0919230f0bfa59d86b6\",\"caaec41413c5713c6f290efe08c11415\"]}',
        '44', 'MANAGE', '0', NULL, '1', '2020-08-12 15:49:46.879', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (953, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '16', 'MANAGE', '0', NULL, '1', '2020-08-12 15:49:53.133', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (954, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/authenticate', NULL, 'password=111111&randomStr=63541597218636797&code=1&rememberMe=false&username=admin',
        NULL, 'MANAGE', '0', NULL, '1', '2020-08-12 15:50:39.850', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (955, '查看发票申请历史查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-invoice-history/', 'com.albedo.java.modules.t.web.TInvoiceHistoryResource.getPage()',
        '{\"tInvoiceHistoryQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '47', 'MANAGE', '0', NULL, '1', '2020-08-12 15:50:44.201', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (956, '管理短信查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/sys-sms/', 'com.albedo.java.modules.sys.web.SysSmsResource.getPage()',
        '{\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0},\"sysSmsQueryCriteria\":{}}',
        '11', 'MANAGE', '0', NULL, '1', '2020-08-12 15:50:45.375', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (957, '控制前端页面内容查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-front/', 'com.albedo.java.modules.t.web.TFrontResource.getPage()',
        '{\"tFrontQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '12', 'MANAGE', '0', NULL, '1', '2020-08-12 15:50:47.081', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (958, '视频管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-video/', 'com.albedo.java.modules.t.web.TVideoResource.getPage()',
        '{\"tVideoQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '8', 'MANAGE', '0', NULL, '1', '2020-08-12 15:50:48.321', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (959, '订单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-order/', 'com.albedo.java.modules.t.web.TOrderResource.getPage()',
        '{\"tOrderQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '9', 'MANAGE', '0', NULL, '1', '2020-08-12 15:50:49.607', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (960, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '31', 'MANAGE', '0', NULL, '1', '2020-08-12 15:50:55.521', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (961, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '12', 'MANAGE', '0', NULL, '1', '2020-08-12 15:50:55.839', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (962, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '6', 'MANAGE', '0', NULL, '1', '2020-08-12 15:51:54.462', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (963, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '7', 'MANAGE', '0', NULL, '1', '2020-08-12 15:52:02.169', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (964, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-12 15:53:14.315', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (965, '业务表编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.save()',
        '{\"childList\":[],\"className\":\"TGoods\",\"importList\":[\"com.baomidou.mybatisplus.annotation.*\",\"com.albedo.java.common.persistence.domain.IdEntity\",\"javax.validation.constraints.Size\",\"javax.validation.constraints.NotNull\",\"javax.validation.constraints.NotBlank\",\"com.albedo.java.common.core.annotation.DictType\"],\"statusExists\":false,\"createTimeExists\":false,\"pkColumn\":{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false},\"parentExists\":false,\"pkList\":[\"id\"],\"comments\":\"t_goods\",\"pkSqlName\":\"id\",\"updateTimeExists\":false,\"columnList\":[{\"$ref\":\"$.pkColumn\"},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"商品名字长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"NAME\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaField\":\"name\",\"javaFieldAttrs\":[],\"javaFieldId\":\"name\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"name\",\"nameAndTitle\":\"name  :  商品名字\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"like\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"商品名字长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"name\",\"size\":\"255\",\"sort\":20,\"title\":\"商品名字\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"视频id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"VIDEOID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"videoId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"videoId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"video_id\",\"nameAndTitle\":\"video_id  :  视频id\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"视频id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"videoId\",\"size\":\"32\",\"sort\":30,\"title\":\"视频id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"这一小段文本的音频地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"VOICEURL\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"voiceUrl\",\"javaFieldAttrs\":[],\"javaFieldId\":\"voiceUrl\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"voice_url\",\"nameAndTitle\":\"voice_url  :  这一小段文本的音频地址\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"这一小段文本的音频地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"voiceUrl\",\"size\":\"255\",\"sort\":40,\"title\":\"这一小段文本的音频地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"音频时间，单位是秒不能为空\\\")\"],\"constantJavaField\":\"VOICETIME\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"voiceTime\",\"javaFieldAttrs\":[],\"javaFieldId\":\"voiceTime\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":true,\"name\":\"voice_time\",\"nameAndTitle\":\"voice_time  :  音频时间，单位是秒\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"音频时间，单位是秒不能为空\\\")\"],\"simpleJavaField\":\"voiceTime\",\"size\":\"\",\"sort\":50,\"title\":\"音频时间，单位是秒\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"文本介绍长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"ADWORDS\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"adWords\",\"javaFieldAttrs\":[],\"javaFieldId\":\"adWords\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"ad_words\",\"nameAndTitle\":\"ad_words  :  文本介绍\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"文本介绍长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"adWords\",\"size\":\"255\",\"sort\":60,\"title\":\"文本介绍\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"这是啥意思？长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"TEMPLATEWORDS\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"templateWords\",\"javaFieldAttrs\":[],\"javaFieldId\":\"templateWords\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"template_words\",\"nameAndTitle\":\"template_words  :  这是啥意思？\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"这是啥意思？长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"templateWords\",\"size\":\"255\",\"sort\":70,\"title\":\"这是啥意思？\",\"unique\":false},{\"annotationList\":[],\"constantJavaField\":\"PHOTOURLS\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=65535)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"photoUrls\",\"javaFieldAttrs\":[],\"javaFieldId\":\"photoUrls\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"text\",\"list\":true,\"name\":\"photo_urls\",\"nameAndTitle\":\"photo_urls  :  多个图片，用英文逗号分开。怕太长用longtext\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[],\"simpleJavaField\":\"photoUrls\",\"size\":\"65535\",\"sort\":80,\"title\":\"多个图片，用英文逗号分开。怕太长用longtext\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":90,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":100,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":110,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":120,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":130,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":140,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":150,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"childeExists\":false,\"notCompositeId\":true,\"pkColumnList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false}],\"columnFormList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"商品名字长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"NAME\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaField\":\"name\",\"javaFieldAttrs\":[],\"javaFieldId\":\"name\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"name\",\"nameAndTitle\":\"name  :  商品名字\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"like\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"商品名字长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"name\",\"size\":\"255\",\"sort\":20,\"title\":\"商品名字\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"视频id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"VIDEOID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"videoId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"videoId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"video_id\",\"nameAndTitle\":\"video_id  :  视频id\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"视频id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"videoId\",\"size\":\"32\",\"sort\":30,\"title\":\"视频id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"这一小段文本的音频地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"VOICEURL\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"voiceUrl\",\"javaFieldAttrs\":[],\"javaFieldId\":\"voiceUrl\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"voice_url\",\"nameAndTitle\":\"voice_url  :  这一小段文本的音频地址\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"这一小段文本的音频地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"voiceUrl\",\"size\":\"255\",\"sort\":40,\"title\":\"这一小段文本的音频地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"音频时间，单位是秒不能为空\\\")\"],\"constantJavaField\":\"VOICETIME\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"voiceTime\",\"javaFieldAttrs\":[],\"javaFieldId\":\"voiceTime\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":true,\"name\":\"voice_time\",\"nameAndTitle\":\"voice_time  :  音频时间，单位是秒\",\"null\":false,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"音频时间，单位是秒不能为空\\\")\"],\"simpleJavaField\":\"voiceTime\",\"size\":\"\",\"sort\":50,\"title\":\"音频时间，单位是秒\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"文本介绍长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"ADWORDS\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"adWords\",\"javaFieldAttrs\":[],\"javaFieldId\":\"adWords\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"ad_words\",\"nameAndTitle\":\"ad_words  :  文本介绍\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"文本介绍长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"adWords\",\"size\":\"255\",\"sort\":60,\"title\":\"文本介绍\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"这是啥意思？长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"TEMPLATEWORDS\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"templateWords\",\"javaFieldAttrs\":[],\"javaFieldId\":\"templateWords\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"template_words\",\"nameAndTitle\":\"template_words  :  这是啥意思？\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"这是啥意思？长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"templateWords\",\"size\":\"255\",\"sort\":70,\"title\":\"这是啥意思？\",\"unique\":false},{\"annotationList\":[],\"constantJavaField\":\"PHOTOURLS\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=65535)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"photoUrls\",\"javaFieldAttrs\":[],\"javaFieldId\":\"photoUrls\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"text\",\"list\":true,\"name\":\"photo_urls\",\"nameAndTitle\":\"photo_urls  :  多个图片，用英文逗号分开。怕太长用longtext\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[],\"simpleJavaField\":\"photoUrls\",\"size\":\"65535\",\"sort\":80,\"title\":\"多个图片，用英文逗号分开。怕太长用longtext\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":90,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":100,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":110,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":120,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":130,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":140,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":150,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"pkSize\":\"32\",\"name\":\"t_goods\",\"compositeId\":false,\"nameAndTitle\":\"t_goods  :  \",\"pkJavaType\":\"String\"}',
        '251', 'MANAGE', '0', NULL, '1', '2020-08-12 15:53:36.581', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (966, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-12 15:53:37.546', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (967, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '8', 'MANAGE', '0', NULL, '1', '2020-08-12 15:53:41.621', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (968, '生成方案编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.save()',
        '{\"functionAuthor\":\"admin\",\"functionName\":\"商品管理\",\"functionNameSimple\":\"t_goods\",\"modalView\":false,\"moduleName\":\"t\",\"replaceFile\":false,\"genCode\":true,\"name\":\"商品管理\",\"tableId\":\"e51850e0e9e0444fb581fb6bf65dd11e\",\"packageName\":\"com.albedo.java.modules\",\"category\":\"curd\"}',
        '397', 'MANAGE', '0', NULL, '1', '2020-08-12 15:54:10.533', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (969, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '9', 'MANAGE', '0', NULL, '1', '2020-08-12 15:54:12.760', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (970, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '9', 'MANAGE', '0', NULL, '1', '2020-08-12 15:54:15.215', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (971, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-12 15:55:15.264', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (972, '业务表删除', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.delete()', '{\"empty\":false}', '20', 'MANAGE',
        '0', NULL, '1', '2020-08-12 15:55:21.162', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (973, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-12 15:55:21.511', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (974, '业务表编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.save()',
        '{\"childList\":[],\"className\":\"TGoods\",\"importList\":[\"com.baomidou.mybatisplus.annotation.*\",\"com.albedo.java.common.persistence.domain.IdEntity\",\"javax.validation.constraints.Size\",\"javax.validation.constraints.NotNull\",\"javax.validation.constraints.NotBlank\",\"com.albedo.java.common.core.annotation.DictType\"],\"statusExists\":false,\"createTimeExists\":false,\"pkColumn\":{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false},\"parentExists\":false,\"pkList\":[\"id\"],\"comments\":\"t_goods\",\"pkSqlName\":\"id\",\"updateTimeExists\":false,\"columnList\":[{\"$ref\":\"$.pkColumn\"},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"USERID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"userId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"userId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"user_id\",\"nameAndTitle\":\"user_id  :  用户id\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"userId\",\"size\":\"32\",\"sort\":20,\"title\":\"用户id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"商品名字长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"NAME\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaField\":\"name\",\"javaFieldAttrs\":[],\"javaFieldId\":\"name\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"name\",\"nameAndTitle\":\"name  :  商品名字\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"like\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"商品名字长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"name\",\"size\":\"255\",\"sort\":30,\"title\":\"商品名字\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"视频id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"VIDEOID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"videoId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"videoId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"video_id\",\"nameAndTitle\":\"video_id  :  视频id\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"视频id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"videoId\",\"size\":\"32\",\"sort\":40,\"title\":\"视频id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"这一小段文本的音频地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"VOICEURL\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"voiceUrl\",\"javaFieldAttrs\":[],\"javaFieldId\":\"voiceUrl\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"voice_url\",\"nameAndTitle\":\"voice_url  :  这一小段文本的音频地址\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"这一小段文本的音频地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"voiceUrl\",\"size\":\"255\",\"sort\":50,\"title\":\"这一小段文本的音频地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"音频时间，单位是秒不能为空\\\")\"],\"constantJavaField\":\"VOICETIME\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"voiceTime\",\"javaFieldAttrs\":[],\"javaFieldId\":\"voiceTime\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":true,\"name\":\"voice_time\",\"nameAndTitle\":\"voice_time  :  音频时间，单位是秒\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"音频时间，单位是秒不能为空\\\")\"],\"simpleJavaField\":\"voiceTime\",\"size\":\"\",\"sort\":60,\"title\":\"音频时间，单位是秒\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"文本介绍长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"ADWORDS\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"adWords\",\"javaFieldAttrs\":[],\"javaFieldId\":\"adWords\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"ad_words\",\"nameAndTitle\":\"ad_words  :  文本介绍\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"文本介绍长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"adWords\",\"size\":\"255\",\"sort\":70,\"title\":\"文本介绍\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"这是啥意思？长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"TEMPLATEWORDS\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"templateWords\",\"javaFieldAttrs\":[],\"javaFieldId\":\"templateWords\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"template_words\",\"nameAndTitle\":\"template_words  :  这是啥意思？\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"这是啥意思？长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"templateWords\",\"size\":\"255\",\"sort\":80,\"title\":\"这是啥意思？\",\"unique\":false},{\"annotationList\":[],\"constantJavaField\":\"PHOTOURLS\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=65535)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"photoUrls\",\"javaFieldAttrs\":[],\"javaFieldId\":\"photoUrls\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"text\",\"list\":true,\"name\":\"photo_urls\",\"nameAndTitle\":\"photo_urls  :  多个图片，用英文逗号分开。怕太长用longtext\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[],\"simpleJavaField\":\"photoUrls\",\"size\":\"65535\",\"sort\":90,\"title\":\"多个图片，用英文逗号分开。怕太长用longtext\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":100,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":110,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":120,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":130,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":140,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":150,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":160,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"childeExists\":false,\"notCompositeId\":true,\"pkColumnList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false}],\"columnFormList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"USERID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"userId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"userId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"user_id\",\"nameAndTitle\":\"user_id  :  用户id\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"userId\",\"size\":\"32\",\"sort\":20,\"title\":\"用户id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"商品名字长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"NAME\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaField\":\"name\",\"javaFieldAttrs\":[],\"javaFieldId\":\"name\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"name\",\"nameAndTitle\":\"name  :  商品名字\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"like\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"商品名字长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"name\",\"size\":\"255\",\"sort\":30,\"title\":\"商品名字\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"视频id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"VIDEOID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"videoId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"videoId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"video_id\",\"nameAndTitle\":\"video_id  :  视频id\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"视频id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"videoId\",\"size\":\"32\",\"sort\":40,\"title\":\"视频id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"这一小段文本的音频地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"VOICEURL\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"voiceUrl\",\"javaFieldAttrs\":[],\"javaFieldId\":\"voiceUrl\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"voice_url\",\"nameAndTitle\":\"voice_url  :  这一小段文本的音频地址\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"这一小段文本的音频地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"voiceUrl\",\"size\":\"255\",\"sort\":50,\"title\":\"这一小段文本的音频地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"音频时间，单位是秒不能为空\\\")\"],\"constantJavaField\":\"VOICETIME\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"voiceTime\",\"javaFieldAttrs\":[],\"javaFieldId\":\"voiceTime\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":true,\"name\":\"voice_time\",\"nameAndTitle\":\"voice_time  :  音频时间，单位是秒\",\"null\":false,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"音频时间，单位是秒不能为空\\\")\"],\"simpleJavaField\":\"voiceTime\",\"size\":\"\",\"sort\":60,\"title\":\"音频时间，单位是秒\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"文本介绍长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"ADWORDS\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"adWords\",\"javaFieldAttrs\":[],\"javaFieldId\":\"adWords\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"ad_words\",\"nameAndTitle\":\"ad_words  :  文本介绍\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"文本介绍长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"adWords\",\"size\":\"255\",\"sort\":70,\"title\":\"文本介绍\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"这是啥意思？长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"TEMPLATEWORDS\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"templateWords\",\"javaFieldAttrs\":[],\"javaFieldId\":\"templateWords\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"template_words\",\"nameAndTitle\":\"template_words  :  这是啥意思？\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"这是啥意思？长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"templateWords\",\"size\":\"255\",\"sort\":80,\"title\":\"这是啥意思？\",\"unique\":false},{\"annotationList\":[],\"constantJavaField\":\"PHOTOURLS\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=65535)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"photoUrls\",\"javaFieldAttrs\":[],\"javaFieldId\":\"photoUrls\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"text\",\"list\":true,\"name\":\"photo_urls\",\"nameAndTitle\":\"photo_urls  :  多个图片，用英文逗号分开。怕太长用longtext\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[],\"simpleJavaField\":\"photoUrls\",\"size\":\"65535\",\"sort\":90,\"title\":\"多个图片，用英文逗号分开。怕太长用longtext\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":100,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":110,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":120,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":130,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":140,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":150,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":160,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"pkSize\":\"32\",\"name\":\"t_goods\",\"compositeId\":false,\"nameAndTitle\":\"t_goods  :  \",\"pkJavaType\":\"String\"}',
        '229', 'MANAGE', '0', NULL, '1', '2020-08-12 15:55:39.253', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (975, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-12 15:55:40.543', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (976, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '6', 'MANAGE', '0', NULL, '1', '2020-08-12 15:55:42.466', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (977, '生成方案编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.save()',
        '{\"functionAuthor\":\"admin\",\"functionName\":\"商品管理\",\"functionNameSimple\":\"t_goods\",\"modalView\":false,\"moduleName\":\"t\",\"replaceFile\":true,\"genCode\":true,\"name\":\"商品管理\",\"tableId\":\"303003236467e4dc970d8eed90e565eb\",\"id\":\"8add8646b2599ccfebacd90d8e9a2096\",\"packageName\":\"com.albedo.java.modules\",\"category\":\"curd\"}',
        '193', 'MANAGE', '0', NULL, '1', '2020-08-12 15:55:52.301', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (978, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '7', 'MANAGE', '0', NULL, '1', '2020-08-12 15:55:54.158', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (979, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-12 15:56:30.893', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (980, '部门管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/dept/', 'com.albedo.java.modules.sys.web.DeptResource.findTreeList()', '{\"deptQueryCriteria\":{}}',
        '11', 'MANAGE', '0', NULL, '1', '2020-08-12 15:56:31.183', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (981, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '314', 'MANAGE', '0', NULL, '1', '2020-08-12 15:56:33.530', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (982, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"cache\":0,\"hidden\":0,\"icon\":\"date\",\"permission\":\"t_tGoods_view\",\"sort\":30,\"type\":\"1\",\"parentId\":\"1120fe9bc06066fae0aec08325bdf56e\",\"path\":\"t/t-goods\",\"component\":\"t/t-goods/index\",\"name\":\"商品管理\",\"iframe\":0}',
        '27', 'MANAGE', '0', NULL, '1', '2020-08-12 15:57:08.452', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (983, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '317', 'MANAGE', '0', NULL, '1', '2020-08-12 15:57:08.663', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (984, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"hidden\":0,\"permission\":\"t_tGoods_edit\",\"sort\":30,\"type\":\"2\",\"parentId\":\"545e9d0ccf70d946f66b835348af18ba\",\"name\":\"编辑\"}',
        '25', 'MANAGE', '0', NULL, '1', '2020-08-12 15:57:38.382', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (985, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '362', 'MANAGE', '0', NULL, '1', '2020-08-12 15:57:38.635', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (986, '菜单管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu', 'com.albedo.java.modules.sys.web.MenuResource.save()',
        '{\"hidden\":0,\"permission\":\"t_tGoods_del\",\"sort\":30,\"type\":\"2\",\"parentId\":\"545e9d0ccf70d946f66b835348af18ba\",\"name\":\"删除\"}',
        '30', 'MANAGE', '0', NULL, '1', '2020-08-12 15:57:55.361', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (987, '菜单管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/menu/', 'com.albedo.java.modules.sys.web.MenuResource.findTreeList()', '{\"menuQueryCriteria\":{}}',
        '328', 'MANAGE', '0', NULL, '1', '2020-08-12 15:57:55.613', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (988, '角色管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/', 'com.albedo.java.modules.sys.web.RoleResource.getPage()',
        '{\"roleQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '17', 'MANAGE', '0', NULL, '1', '2020-08-12 15:57:59.097', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (989, '角色管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/menu', 'com.albedo.java.modules.sys.web.RoleResource.saveRoleMenus()',
        '{\"roleId\":\"1\",\"menuIdList\":[\"92f78825551a22fa130c03066f398448\",\"413892fe8d52c1163d6659f51299dc96\",\"bb9dd4b7a2a462193d0f01517308f812\",\"e086c4aa4943a883b29cf94680608b89\",\"a18b33e15bde209a3c9115517c56d9ec\",\"618ee4b9660265a85a8b61277de2a579\",\"d9d87cf8ed7c29ed2eda06d5dec4dcda\",\"b963a451117f430703817b3b6c87402a\",\"2500\",\"29de79df95e70d8e8fbdc7945acf214a\",\"795b4d5cf0eb3ed80e24cbab39727b9d\",\"18d6b5e0f6b986cd074bf23de11ecd34\",\"2101\",\"ef2382c0cc2d99ee73444e684237a88a\",\"e710a66583fe0e324492462adb16014e\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"247071d42ff40267c8d8c44eac92da67\",\"13093fb658c1806ad5bd0600316158f2\",\"2000\",\"9763343d9cce11ce9eb4f21c8e49122b\",\"0d0be247863fcbf08b3db943e5f45992\",\"5404c3df9f771dbc0237578814bbe44b\",\"1303\",\"1302\",\"1103\",\"1301\",\"1102\",\"1300\",\"1101\",\"1100\",\"f15e2186907d22765cd149a94905842a\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"5b39ca5a25c772105c71f8c51d1f19d4\",\"1ae562534a64d4473899e52497c40b2e\",\"1000\",\"52715698214e88cb09fa4dd1ea5ad348\",\"64b61b8966e1c74d9b309069b2f622d1\",\"133f1408f5e3187d3e1a00b0260b7165\",\"2601\",\"2600\",\"2202\",\"10bd98f30a42427dd7ef75418ad3da6b\",\"2201\",\"2200\",\"e5ea38c1f97dee0043e78f3fb27b25d6\",\"7b14af9e9fbff286856338a194422b07\",\"74f2b2a8871a298e0acc4d7129d10e9c\",\"fe4c7938e146ec223e99d426aaa87109\",\"76d6087052dc26b32f3efa71b9cc119b\",\"bd62904371247f56594741ff8e9bded9\",\"2100\",\"eb17cee437ea6b630dad59fff2a059ca\",\"1403\",\"1402\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"1401\",\"1203\",\"1400\",\"1202\",\"1201\",\"b961670cbf3454f5927c4bd2a327e915\",\"1200\",\"621e50e1c7d66a1febeb699bebb2fe35\",\"d4c16faad8f883650a3a8eab829ebad9\",\"7754b1457826c48290bc189bb1289740\",\"9f02e346b5350366968f217daef3f1b7\",\"b8eafb6c3a8bf0919230f0bfa59d86b6\",\"caaec41413c5713c6f290efe08c11415\"]}',
        '45', 'MANAGE', '0', NULL, '1', '2020-08-12 15:58:03.039', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (990, '角色管理编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/sys/role/menu', 'com.albedo.java.modules.sys.web.RoleResource.saveRoleMenus()',
        '{\"roleId\":\"1\",\"menuIdList\":[\"edc01fe5edb70ebb040b2acb428e5821\",\"92f78825551a22fa130c03066f398448\",\"413892fe8d52c1163d6659f51299dc96\",\"bb9dd4b7a2a462193d0f01517308f812\",\"e086c4aa4943a883b29cf94680608b89\",\"c26df9cff6e0a72ccd966ff8b7c841d4\",\"a18b33e15bde209a3c9115517c56d9ec\",\"618ee4b9660265a85a8b61277de2a579\",\"d9d87cf8ed7c29ed2eda06d5dec4dcda\",\"b963a451117f430703817b3b6c87402a\",\"2500\",\"29de79df95e70d8e8fbdc7945acf214a\",\"795b4d5cf0eb3ed80e24cbab39727b9d\",\"18d6b5e0f6b986cd074bf23de11ecd34\",\"2101\",\"ef2382c0cc2d99ee73444e684237a88a\",\"e710a66583fe0e324492462adb16014e\",\"c0ba37c10abaecd89a738c5cf2a2fd24\",\"55b8af86fa4b4e53680a652f83ad1c3a\",\"247071d42ff40267c8d8c44eac92da67\",\"2a13e56860d4aced7a2b12881b139710\",\"545e9d0ccf70d946f66b835348af18ba\",\"671fa1206a2446b046d4a91deceddd0f\",\"13093fb658c1806ad5bd0600316158f2\",\"8c0d687c64b90afb0c0d80bc23fcd718\",\"2000\",\"9763343d9cce11ce9eb4f21c8e49122b\",\"0d3216078a1006368af2131743325926\",\"0d0be247863fcbf08b3db943e5f45992\",\"5404c3df9f771dbc0237578814bbe44b\",\"1303\",\"1302\",\"1103\",\"1301\",\"956393c3e3d73714c0facc7ed628c371\",\"1102\",\"1300\",\"1101\",\"1100\",\"f15e2186907d22765cd149a94905842a\",\"2abc3f5d5c38ace4cf491fa16928639d\",\"1120fe9bc06066fae0aec08325bdf56e\",\"6e3f89cda84ac2c6e715e7812c102ae8\",\"5b39ca5a25c772105c71f8c51d1f19d4\",\"1ae562534a64d4473899e52497c40b2e\",\"1000\",\"52715698214e88cb09fa4dd1ea5ad348\",\"64b61b8966e1c74d9b309069b2f622d1\",\"133f1408f5e3187d3e1a00b0260b7165\",\"10b8dc68308ed1f3eb1096d8be4e0fc1\",\"8591bd99f07ad86cc3bf6debb65fc799\",\"2601\",\"2600\",\"2202\",\"10bd98f30a42427dd7ef75418ad3da6b\",\"2201\",\"2200\",\"e5ea38c1f97dee0043e78f3fb27b25d6\",\"7b14af9e9fbff286856338a194422b07\",\"33eef3f9266d54142105eec44d9f2f15\",\"74f2b2a8871a298e0acc4d7129d10e9c\",\"fe4c7938e146ec223e99d426aaa87109\",\"76d6087052dc26b32f3efa71b9cc119b\",\"d12f44379df45c21e30dda4cfd27d710\",\"f9153fa246f209a70a97e51edd31ace5\",\"bd62904371247f56594741ff8e9bded9\",\"2100\",\"5af0ff6dd036af1f1bfdcc13c42023b3\",\"eb17cee437ea6b630dad59fff2a059ca\",\"83401bedafe0bdb0c01cc14f64ac8c0b\",\"1403\",\"1402\",\"97722c6d56c8b9990cc3c1a6eea3d6bb\",\"bc7a2552fa2dbca2abc36fb6b73f695f\",\"1401\",\"1203\",\"1400\",\"1202\",\"eef94eb9d762816360f7560f0be2ec34\",\"1201\",\"b961670cbf3454f5927c4bd2a327e915\",\"1200\",\"621e50e1c7d66a1febeb699bebb2fe35\",\"2f95c888121de9aae1bc8f61c5fd508c\",\"d4c16faad8f883650a3a8eab829ebad9\",\"0d857a3a2e3b3b67bba0a9b4dcd80b55\",\"7754b1457826c48290bc189bb1289740\",\"9f02e346b5350366968f217daef3f1b7\",\"b8eafb6c3a8bf0919230f0bfa59d86b6\",\"caaec41413c5713c6f290efe08c11415\"]}',
        '47', 'MANAGE', '0', NULL, '1', '2020-08-12 15:58:04.936', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (991, '视频管理查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/t/t-video/', 'com.albedo.java.modules.t.web.TVideoResource.getPage()',
        '{\"tVideoQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-12 15:58:16.099', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (992, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '5', 'MANAGE', '0', NULL, '1', '2020-08-12 15:59:06.182', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (993, '业务表删除', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.delete()', '{\"empty\":false}', '15', 'MANAGE',
        '0', NULL, '1', '2020-08-12 15:59:12.752', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (994, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-12 15:59:13.002', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (995, '业务表编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table', 'com.albedo.java.modules.gen.web.TableResource.save()',
        '{\"childList\":[],\"className\":\"TVideo\",\"importList\":[\"com.baomidou.mybatisplus.annotation.*\",\"com.albedo.java.common.persistence.domain.IdEntity\",\"javax.validation.constraints.Size\",\"javax.validation.constraints.NotNull\",\"javax.validation.constraints.NotBlank\",\"com.albedo.java.common.core.annotation.DictType\"],\"statusExists\":false,\"createTimeExists\":false,\"pkColumn\":{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false},\"parentExists\":false,\"pkList\":[\"id\"],\"comments\":\"t_video\",\"pkSqlName\":\"id\",\"updateTimeExists\":false,\"columnList\":[{\"$ref\":\"$.pkColumn\"},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"USERID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"userId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"userId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"user_id\",\"nameAndTitle\":\"user_id  :  用户id\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"userId\",\"size\":\"32\",\"sort\":20,\"title\":\"用户id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"视频名字长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"NAME\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaField\":\"name\",\"javaFieldAttrs\":[],\"javaFieldId\":\"name\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"name\",\"nameAndTitle\":\"name  :  视频名字\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"like\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"视频名字长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"name\",\"size\":\"255\",\"sort\":30,\"title\":\"视频名字\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"origin_url长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"ORIGINURL\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"originUrl\",\"javaFieldAttrs\":[],\"javaFieldId\":\"originUrl\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"origin_url\",\"nameAndTitle\":\"origin_url  :  origin_url\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"origin_url长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"originUrl\",\"size\":\"255\",\"sort\":40,\"title\":\"origin_url\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"logo的地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"LOGOURL\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"logoUrl\",\"javaFieldAttrs\":[],\"javaFieldId\":\"logoUrl\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"logo_url\",\"nameAndTitle\":\"logo_url  :  logo的地址\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"logo的地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"logoUrl\",\"size\":\"255\",\"sort\":50,\"title\":\"logo的地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"输出地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"OUTPUTURL\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"outputUrl\",\"javaFieldAttrs\":[],\"javaFieldId\":\"outputUrl\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"output_url\",\"nameAndTitle\":\"output_url  :  输出地址\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"输出地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"outputUrl\",\"size\":\"255\",\"sort\":60,\"title\":\"输出地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"视频长度，单位是秒不能为空\\\")\"],\"constantJavaField\":\"DURATION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"duration\",\"javaFieldAttrs\":[],\"javaFieldId\":\"duration\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":true,\"name\":\"duration\",\"nameAndTitle\":\"duration  :  视频长度，单位是秒\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"视频长度，单位是秒不能为空\\\")\"],\"simpleJavaField\":\"duration\",\"size\":\"\",\"sort\":70,\"title\":\"视频长度，单位是秒\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":80,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":90,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":100,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":110,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":120,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":130,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":140,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"childeExists\":false,\"notCompositeId\":true,\"pkColumnList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false}],\"columnFormList\":[{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"ID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"id\",\"javaFieldAttrs\":[],\"javaFieldId\":\"id\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":false,\"name\":\"id\",\"nameAndTitle\":\"id  :  id\",\"null\":false,\"pk\":true,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"id\",\"size\":\"32\",\"sort\":10,\"title\":\"id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"constantJavaField\":\"USERID\",\"dataLength\":32,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=32)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"userId\",\"javaFieldAttrs\":[],\"javaFieldId\":\"userId\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(32)\",\"list\":true,\"name\":\"user_id\",\"nameAndTitle\":\"user_id  :  用户id\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=32, message=\\\"用户id长度必须介于 1 和 32 之间\\\")\"],\"simpleJavaField\":\"userId\",\"size\":\"32\",\"sort\":20,\"title\":\"用户id\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"视频名字长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"NAME\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":false,\"javaField\":\"name\",\"javaFieldAttrs\":[],\"javaFieldId\":\"name\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"name\",\"nameAndTitle\":\"name  :  视频名字\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"like\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"视频名字长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"name\",\"size\":\"255\",\"sort\":30,\"title\":\"视频名字\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"origin_url长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"ORIGINURL\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"originUrl\",\"javaFieldAttrs\":[],\"javaFieldId\":\"originUrl\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"origin_url\",\"nameAndTitle\":\"origin_url  :  origin_url\",\"null\":true,\"pk\":false,\"query\":true,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"origin_url长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"originUrl\",\"size\":\"255\",\"sort\":40,\"title\":\"origin_url\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"logo的地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"LOGOURL\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"logoUrl\",\"javaFieldAttrs\":[],\"javaFieldId\":\"logoUrl\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"logo_url\",\"nameAndTitle\":\"logo_url  :  logo的地址\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"logo的地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"logoUrl\",\"size\":\"255\",\"sort\":50,\"title\":\"logo的地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"输出地址长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"OUTPUTURL\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"outputUrl\",\"javaFieldAttrs\":[],\"javaFieldId\":\"outputUrl\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":true,\"name\":\"output_url\",\"nameAndTitle\":\"output_url  :  输出地址\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"输出地址长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"outputUrl\",\"size\":\"255\",\"sort\":60,\"title\":\"输出地址\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"视频长度，单位是秒不能为空\\\")\"],\"constantJavaField\":\"DURATION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":true,\"isNotBaseTreeField\":true,\"javaField\":\"duration\",\"javaFieldAttrs\":[],\"javaFieldId\":\"duration\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":true,\"name\":\"duration\",\"nameAndTitle\":\"duration  :  视频长度，单位是秒\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"视频长度，单位是秒不能为空\\\")\"],\"simpleJavaField\":\"duration\",\"size\":\"\",\"sort\":70,\"title\":\"视频长度，单位是秒\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"CREATEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"created_by\",\"nameAndTitle\":\"created_by  :  created_by\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"created_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"createdBy\",\"size\":\"50\",\"sort\":80,\"title\":\"created_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"创建时间不能为空\\\")\"],\"constantJavaField\":\"CREATEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"createdDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"createdDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"created_date\",\"nameAndTitle\":\"created_date  :  创建时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"创建时间不能为空\\\")\"],\"simpleJavaField\":\"createdDate\",\"size\":\"3\",\"sort\":90,\"title\":\"创建时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"constantJavaField\":\"LASTMODIFIEDBY\",\"dataLength\":50,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@Size(max=50)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedBy\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedBy\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(50)\",\"list\":false,\"name\":\"last_modified_by\",\"nameAndTitle\":\"last_modified_by  :  last_modified_by\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=50, message=\\\"last_modified_by长度必须介于 1 和 50 之间\\\")\"],\"simpleJavaField\":\"lastModifiedBy\",\"size\":\"50\",\"sort\":100,\"title\":\"last_modified_by\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"修改时间不能为空\\\")\"],\"constantJavaField\":\"LASTMODIFIEDDATE\",\"dataLength\":3,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"\",\"insert\":true,\"isDateTimeColumn\":true,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"lastModifiedDate\",\"javaFieldAttrs\":[],\"javaFieldId\":\"lastModifiedDate\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"java.util.Date\",\"jdbcType\":\"timestamp(3)\",\"list\":false,\"name\":\"last_modified_date\",\"nameAndTitle\":\"last_modified_date  :  修改时间\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"dateselect\",\"simpleAnnotationList\":[\"NotNull(message=\\\"修改时间不能为空\\\")\"],\"simpleJavaField\":\"lastModifiedDate\",\"size\":\"3\",\"sort\":110,\"title\":\"修改时间\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"constantJavaField\":\"DESCRIPTION\",\"dataLength\":255,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":true,\"hibernateValidatorExprssion\":\"@Size(max=255)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"description\",\"javaFieldAttrs\":[],\"javaFieldId\":\"description\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"varchar(255)\",\"list\":false,\"name\":\"description\",\"nameAndTitle\":\"description  :  备注\",\"null\":true,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"Size(min=1, max=255, message=\\\"备注长度必须介于 1 和 255 之间\\\")\"],\"simpleJavaField\":\"description\",\"size\":\"255\",\"sort\":120,\"title\":\"备注\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.NotNull(message=\\\"version不能为空\\\")\"],\"constantJavaField\":\"VERSION\",\"dataLength\":0,\"defaultJavaFieldName\":\"name\",\"dictType\":\"\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotNull \",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"version\",\"javaFieldAttrs\":[],\"javaFieldId\":\"version\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"Long\",\"jdbcType\":\"int\",\"list\":false,\"name\":\"version\",\"nameAndTitle\":\"version  :  version\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"input\",\"simpleAnnotationList\":[\"NotNull(message=\\\"version不能为空\\\")\"],\"simpleJavaField\":\"version\",\"size\":\"\",\"sort\":130,\"title\":\"version\",\"unique\":false},{\"annotationList\":[\"javax.validation.constraints.Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"constantJavaField\":\"DELFLAG\",\"dataLength\":1,\"defaultJavaFieldName\":\"name\",\"dictType\":\"sys_flag\",\"edit\":false,\"hibernateValidatorExprssion\":\"@NotBlank @Size(max=1)\",\"insert\":true,\"isDateTimeColumn\":false,\"isNotBaseField\":false,\"isNotBaseTreeField\":true,\"javaField\":\"delFlag\",\"javaFieldAttrs\":[],\"javaFieldId\":\"delFlag\",\"javaFieldName\":\"\",\"javaFieldShowName\":\"\",\"javaType\":\"String\",\"jdbcType\":\"char(1)\",\"list\":false,\"name\":\"del_flag\",\"nameAndTitle\":\"del_flag  :  0-正常，1-删除\",\"null\":false,\"pk\":false,\"query\":false,\"queryType\":\"eq\",\"showType\":\"radio\",\"simpleAnnotationList\":[\"Size(min=1, max=1, message=\\\"0-正常，1-删除长度必须介于 1 和 1 之间\\\")\"],\"simpleJavaField\":\"delFlag\",\"size\":\"1\",\"sort\":140,\"title\":\"0-正常，1-删除\",\"unique\":false}],\"pkSize\":\"32\",\"name\":\"t_video\",\"compositeId\":false,\"nameAndTitle\":\"t_video  :  \",\"pkJavaType\":\"String\"}',
        '204', 'MANAGE', '0', NULL, '1', '2020-08-12 15:59:25.016', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (996, '业务表查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/table/', 'com.albedo.java.modules.gen.web.TableResource.getPage()',
        '{\"tableQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '4', 'MANAGE', '0', NULL, '1', '2020-08-12 15:59:25.945', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (997, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '8', 'MANAGE', '0', NULL, '1', '2020-08-12 15:59:27.666', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (998, '生成方案编辑', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.save()',
        '{\"functionAuthor\":\"admin\",\"functionName\":\"视频管理\",\"functionNameSimple\":\"t_video\",\"modalView\":false,\"moduleName\":\"t\",\"replaceFile\":true,\"genCode\":true,\"name\":\"视频\",\"tableId\":\"201a2bb8de59d0e0c2a9743f60f6ec11\",\"id\":\"01f1d49348ef63a0558f439ca090d412\",\"packageName\":\"com.albedo.java.modules\",\"category\":\"curd\"}',
        '173', 'MANAGE', '0', NULL, '1', '2020-08-12 15:59:38.264', NULL, '0');
INSERT INTO `sys_log_operate`
VALUES (999, '生成方案查看', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.59 Safari/537.36 Edg/85.0.564.30',
        '/a/gen/scheme/', 'com.albedo.java.modules.gen.web.SchemeResource.getPage()',
        '{\"schemeQueryCriteria\":{},\"pm\":{\"current\":1,\"hitCount\":false,\"orders\":[],\"pages\":0,\"records\":[],\"searchCount\":true,\"size\":10,\"total\":0}}',
        '6', 'MANAGE', '0', NULL, '1', '2020-08-12 15:59:40.025', NULL, '0');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`
(
    `id`                 varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL COMMENT '菜单ID',
    `name`               varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL COMMENT '菜单名称',
    `type`               char(1) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL COMMENT '菜单类型 （0目录 1菜单 2按钮）',
    `permission`         varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL DEFAULT NULL COMMENT '菜单权限标识',
    `path`               varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL DEFAULT NULL COMMENT '前端URL',
    `parent_id`          varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL DEFAULT NULL COMMENT '父菜单ID',
    `parent_ids`         varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单IDs',
    `icon`               varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL DEFAULT NULL COMMENT '图标',
    `component`          varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL DEFAULT NULL COMMENT 'VUE页面',
    `hidden`             bit(1)                                                   NULL DEFAULT b'0' COMMENT '隐藏',
    `iframe`             bit(1)                                                   NULL DEFAULT b'0' COMMENT '是否外链',
    `cache`              bit(1)                                                   NULL DEFAULT b'0' COMMENT '缓存',
    `leaf`               bit(1)                                                   NULL DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
    `sort`               int(0)                                                   NULL DEFAULT 1 COMMENT '排序值',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL,
    `created_date`       timestamp(3)                                             NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL DEFAULT NULL,
    `last_modified_date` timestamp(3)                                             NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL DEFAULT NULL COMMENT '描述',
    `version`            int(0)                                                   NOT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin        NULL DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '菜单权限表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu`
VALUES ('06874adacf1f272be7928badd4fe8ed1', '配置日志', '1', NULL, 'log', 'ef2382c0cc2d99ee73444e684237a88a',
        'ef2382c0cc2d99ee73444e684237a88a,', 'dev', 'admin/log/index', b'0', b'0', b'0', b'1', 30, '1',
        '2019-08-05 16:16:06.000', '1', '2020-05-17 17:54:34.755', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('0747d9d8f651f19e49748ba68f18c6f5', '任务调度方案编辑', '2', 'quartz_job_edit', NULL,
        'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1',
        '2019-08-14 10:36:03.602', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('0a160cff2d071eeec3db97f0cb0b30d6', '测试树编辑', '2', 'test_testTreeBook_edit', NULL,
        '3956b4690e4f49cfb1e065384c1dc0b9', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 40, '1',
        '2020-05-25 09:35:47.308', '1', '2020-05-25 10:12:00.658', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('0b934688321b1db735c3bf6ec3e7cdc7', 'test', '2', 'test', 'test', '-1', NULL, 'date', NULL, b'0', b'0', b'0',
        b'1', 999, '1', '2020-05-14 17:47:36.261', '1', '2020-05-15 21:06:35.180', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('0d0be247863fcbf08b3db943e5f45992', '在线用户查看', '2', 'sys_userOnline_view', NULL,
        '6e3f89cda84ac2c6e715e7812c102ae8', '2000,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', b'0', b'0',
        b'1', 30, '1', '2019-08-07 09:05:28.000', '1', '2020-05-16 17:55:59.725', NULL, 6, '0');
INSERT INTO `sys_menu`
VALUES ('0d3216078a1006368af2131743325926', '删除', '2', 't_tInvoiceHistory_del', NULL,
        'f9153fa246f209a70a97e51edd31ace5', '1120fe9bc06066fae0aec08325bdf56e,f9153fa246f209a70a97e51edd31ace5,', NULL,
        NULL, b'0', b'0', b'0', b'1', 35, '1', '2020-08-12 11:24:59.379', '1', '2020-08-12 11:29:14.278', NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('0d857a3a2e3b3b67bba0a9b4dcd80b55', '编辑', '2', 't_tFront_edit', NULL, '5af0ff6dd036af1f1bfdcc13c42023b3',
        '1120fe9bc06066fae0aec08325bdf56e,5af0ff6dd036af1f1bfdcc13c42023b3,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2020-08-12 10:28:52.791', '1', '2020-08-12 11:00:05.799', '', 4, '0');
INSERT INTO `sys_menu`
VALUES ('1000', '系统管理', '0', NULL, '/perm', '-1', NULL, 'menu', 'Layout', b'0', b'0', b'0', b'0', 10, '',
        '2018-09-28 08:29:53.000', '1', '2020-05-16 17:55:32.580', NULL, 36, '0');
INSERT INTO `sys_menu`
VALUES ('10b8dc68308ed1f3eb1096d8be4e0fc1', '编辑', '2', 't_tOrder_edit', NULL, '55b8af86fa4b4e53680a652f83ad1c3a',
        '1120fe9bc06066fae0aec08325bdf56e,55b8af86fa4b4e53680a652f83ad1c3a,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2020-08-12 15:38:14.640', '1', '2020-08-12 15:38:14.640', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('10bd98f30a42427dd7ef75418ad3da6b', '邮件工具', '1', NULL, 'email', 'ef2382c0cc2d99ee73444e684237a88a',
        'ef2382c0cc2d99ee73444e684237a88a,', 'email', 'tool/email/index', b'0', b'0', b'0', b'1', 30, '1',
        '2020-05-17 17:56:56.008', '1', '2020-05-19 02:17:42.461', NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('1100', '用户管理', '1', 'sys_user_view', 'user', '1000', '1000,', 'peoples', 'sys/user/index', b'0', b'0', b'0',
        b'0', 10, '', '2017-11-02 22:24:37.000', '1', '2020-05-20 06:19:27.618', NULL, 16, '0');
INSERT INTO `sys_menu`
VALUES ('1101', '用户编辑', '2', 'sys_user_edit', NULL, '1100', '1000,1100,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '',
        '2017-11-08 09:52:09.000', '1', '2020-05-20 06:19:27.630', NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('1102', '用户锁定', '2', 'sys_user_lock', NULL, '1100', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2017-11-08 09:52:48.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1103', '用户删除', '2', 'sys_user_del', NULL, '1100', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2017-11-08 09:54:01.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1120fe9bc06066fae0aec08325bdf56e', 't的一级菜单', '0', NULL, '/t', '-1', NULL, 'fwb', 'Layout', b'0', b'0', b'0',
        b'0', 130, '1', '2020-08-12 10:25:52.847', '1', '2020-08-12 15:57:08.471', NULL, 23, '0');
INSERT INTO `sys_menu`
VALUES ('11b9ae870fb0fc89c52236faf43f3d96', '任务调度方案查看', '2', 'quartz_job_view', NULL,
        '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1',
        '2019-08-14 10:35:56.085', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('1200', '菜单管理', '1', 'sys_menu_view', 'menu', '1000', '1000,', 'menu', 'sys/menu/index', b'0', b'0', b'0', b'0',
        40, '', '2017-11-08 09:57:27.000', '1', '2020-05-16 17:56:34.959', NULL, 8, '0');
INSERT INTO `sys_menu`
VALUES ('1201', '菜单编辑', '2', 'sys_menu_edit', NULL, '1200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2017-11-08 10:15:53.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1202', '菜单锁定', '2', 'sys_menu_lock', NULL, '1200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2017-11-08 10:16:23.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1203', '菜单删除', '2', 'sys_menu_del', NULL, '1200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2017-11-08 10:16:43.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1300', '角色管理', '1', 'sys_role_view', 'role', '1000', '1000,', 'role', 'sys/role/index', b'0', b'0', b'0', b'0',
        20, '', '2017-11-08 10:13:37.000', '1', '2020-05-16 17:56:34.949', NULL, 7, '0');
INSERT INTO `sys_menu`
VALUES ('1301', '角色编辑', '2', 'sys_role_edit', NULL, '1300', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2017-11-08 10:14:18.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1302', '角色锁定', '2', 'sys_role_lock', NULL, '1300', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2017-11-08 10:14:41.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1303', '角色删除', '2', 'sys_role_del', NULL, '1300', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2017-11-08 10:14:59.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1304', '角色查看', '2', 'sys_role_view', NULL, '1300', '1300,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '',
        '2018-04-20 07:22:55.000', '1', '2020-05-15 21:06:35.180', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('13093fb658c1806ad5bd0600316158f2', '操作日志导出', '2', 'sys_logOperate_export', NULL, '2100', '2000,2100,', NULL,
        NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 17:50:46.973', '1', '2020-05-17 10:23:57.541', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('133f1408f5e3187d3e1a00b0260b7165', '字典可用', '2', 'sys_dict_lock', NULL, '2200', '1000,2200,', NULL, NULL, b'0',
        NULL, b'0', b'1', 999, '1', '2020-05-15 17:24:57.559', '1', '2020-05-16 17:55:19.915', NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('1400', '部门管理', '1', 'sys_dept_view', 'dept', '1000', '1000,', 'dept', 'sys/dept/index', b'0', b'0', b'0', b'0',
        30, '', '2018-01-20 13:17:19.000', '1', '2020-05-16 17:56:34.955', NULL, 5, '0');
INSERT INTO `sys_menu`
VALUES ('1401', '部门编辑', '2', 'sys_dept_edit', NULL, '1400', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2018-01-20 14:56:16.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1402', '部门锁定', '2', 'sys_dept_lock', NULL, '1400', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2018-01-20 14:56:59.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('1403', '部门删除', '2', 'sys_dept_del', NULL, '1400', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2018-01-20 14:57:28.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('17a713e918513ecd42d3e915d1fc79c1', '测试书籍删除', '2', 'test_testBook_del', NULL,
        '4f5c94e30f3a64e8e1f1bf10e7247e7e', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1',
        '2020-05-25 10:15:07.791', '1', '2020-05-29 16:36:27.004', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('18d6b5e0f6b986cd074bf23de11ecd34', '任务调度删除', '2', 'quartz_job_del', NULL, '74f2b2a8871a298e0acc4d7129d10e9c',
        NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2019-08-14 10:36:47.091', '1', '2020-05-16 13:24:22.873',
        NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('1a900c3f10ef5b0987e0a8ee4445316d', '用户查看', '2', 'sys_user_view', NULL, '1100', '1000,1100,', NULL, NULL, b'0',
        b'0', b'0', b'1', 10, '1', '2019-08-07 17:27:34.000', '1', '2020-05-15 21:06:35.180', NULL, 4, '1');
INSERT INTO `sys_menu`
VALUES ('1ae562534a64d4473899e52497c40b2e', '二级菜单1', '1', NULL, 'menu1', 'eb17cee437ea6b630dad59fff2a059ca',
        'eb17cee437ea6b630dad59fff2a059ca,', 'dev', 'nested/menu1/index', b'0', b'0', b'0', b'0', 10, '1',
        '2020-05-18 11:10:06.354', '1', '2020-05-25 10:13:50.580', NULL, 9, '0');
INSERT INTO `sys_menu`
VALUES ('2000', '系统监控', '0', NULL, '/sys', '-1', NULL, 'system', 'Layout', b'0', b'0', b'0', b'0', 20, '',
        '2017-11-07 20:56:00.000', '1', '2020-05-17 16:52:02.575', NULL, 39, '0');
INSERT INTO `sys_menu`
VALUES ('2100', '操作日志', '1', NULL, 'log-operate', '2000', '2000,', 'log', 'monitor/log-operate/index', b'0', b'0', b'0',
        b'0', 40, '', '2017-11-20 14:06:22.000', '1', '2020-05-17 10:23:57.530', NULL, 12, '0');
INSERT INTO `sys_menu`
VALUES ('2101', '操作日志删除', '2', 'sys_logOperate_del', NULL, '2100', '2000,2100,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '', '2017-11-20 20:37:37.000', '1', '2020-05-17 10:23:57.545', NULL, 3, '0');
INSERT INTO `sys_menu`
VALUES ('2200', '字典管理', '1', 'sys_dict_view', 'dict', '1000', '1000,', 'dictionary', 'sys/dict/index', b'0', b'0', b'0',
        b'0', 50, '', '2017-11-29 11:30:52.000', '1', '2020-05-16 17:56:34.943', NULL, 11, '0');
INSERT INTO `sys_menu`
VALUES ('2201', '字典删除', '2', 'sys_dict_del', NULL, '2200', '1000,2200,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '',
        '2017-11-29 11:30:11.000', '1', '2020-05-16 17:55:19.918', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('2202', '字典编辑', '2', 'sys_dict_edit', NULL, '2200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '',
        '2018-05-11 22:34:55.000', '1', '2020-05-16 13:24:22.800', NULL, 3, '0');
INSERT INTO `sys_menu`
VALUES ('2245134851ecd3537c454ba8a3ef915c', '测试书籍查看', '2', 'test_testBook_view', NULL,
        '8ce9f148e5720ace1b7cf24e0985c47e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1',
        '2020-05-25 10:12:05.954', '1', '2020-05-25 10:15:07.779', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('23430df88fb72179c2a85c39eaf4d50b', '任务调度日志清空', '2', 'quartz_jobLog_clean', NULL,
        '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 80,
        '1', '2019-08-15 16:12:26.285', '1', '2020-05-16 15:40:21.370', NULL, 2, '1');
INSERT INTO `sys_menu`
VALUES ('247071d42ff40267c8d8c44eac92da67', '生成方案', '1', NULL, 'scheme', '413892fe8d52c1163d6659f51299dc96',
        '413892fe8d52c1163d6659f51299dc96,', 'dev', 'gen/scheme/index', b'0', b'0', b'0', b'0', 30, '1',
        '2019-07-21 13:27:35.000', '1', '2020-05-18 11:39:42.026', NULL, 21, '0');
INSERT INTO `sys_menu`
VALUES ('2500', '接口文档', '1', NULL, 'swagger2', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,',
        'swagger', 'tool/swagger/index', b'0', b'0', b'0', b'1', 20, '', '2018-06-26 10:50:32.000', '1',
        '2020-05-19 02:17:26.914', NULL, 8, '0');
INSERT INTO `sys_menu`
VALUES ('2600', '令牌管理', '1', NULL, 'persistent-token', '2000', '2000,', 'dev', 'monitor/persistent-token/index', b'0',
        b'0', b'0', b'0', 20, '', '2018-09-04 05:58:41.000', '1', '2020-05-16 17:57:31.286', NULL, 14, '0');
INSERT INTO `sys_menu`
VALUES ('2601', '令牌删除', '2', 'sys_persistentToken_del', NULL, '2600', '2600,', NULL, NULL, b'0', b'0', b'0', b'1', 1,
        '', '2018-09-04 05:59:50.000', '1', '2020-05-16 17:57:31.293', NULL, 6, '0');
INSERT INTO `sys_menu`
VALUES ('2836ced373377be75936827ecddf7fad', '测试树管理编辑', '2', 'test_testTreeBook_edit', NULL,
        '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1',
        '2019-08-11 14:32:06.856', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('29de79df95e70d8e8fbdc7945acf214a', '任务调度查看', '2', 'quartz_job_view', NULL, '74f2b2a8871a298e0acc4d7129d10e9c',
        '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 10, '1', '2019-08-14 10:36:47.085',
        '1', '2020-05-16 12:10:40.648', NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('29fa5859c9418ab919e172b7d21162de', '测试树查看', '2', 'test_testTreeBook_view', NULL,
        'dab11e5104d690be6991002ae4da0cbd', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1',
        '2020-05-25 10:15:02.872', '1', '2020-05-29 16:36:26.994', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('2a13e56860d4aced7a2b12881b139710', '短信管理', '1', 'sys_sysSms_view', 'sys/sys-sms',
        '1120fe9bc06066fae0aec08325bdf56e', '1120fe9bc06066fae0aec08325bdf56e,', 'chain', 'sys/sys-sms/index', b'0',
        b'0', b'0', b'0', 30, '1', '2020-08-12 15:48:13.370', '1', '2020-08-12 15:48:56.673', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('2abc3f5d5c38ace4cf491fa16928639d', '编辑', '2', 't_tVideo_edit', NULL, '8c0d687c64b90afb0c0d80bc23fcd718',
        '1120fe9bc06066fae0aec08325bdf56e,8c0d687c64b90afb0c0d80bc23fcd718,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2020-08-12 15:44:14.831', '1', '2020-08-12 15:44:14.831', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('2af0268f695b79abdf6e8b10d559d081', '测试树管理删除', '2', 'test_testTreeBook_del', NULL,
        '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1',
        '2019-08-11 14:32:06.859', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('2c0688c2ad9259b9a7e7088a2f6ade4e', '测试书籍', '1', NULL, 'test-book', 'eb17cee437ea6b630dad59fff2a059ca', NULL,
        'icon-right-square', 'views/test/test-book/index', b'0', NULL, b'0', b'0', 80, '1', '2020-05-25 09:36:39.119',
        '1', '2020-05-25 10:12:05.946', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('2c8fdecfee63a310266b2e4b94fd3f4c', '任务调度日志删除', '2', 'quartz_jobLog_del', NULL,
        '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 70,
        '1', '2019-08-15 16:12:07.842', '1', '2020-05-16 15:40:08.708', NULL, 2, '1');
INSERT INTO `sys_menu`
VALUES ('2c90f69bccf0845b1aca8b072b730c39', '任务调度方案删除', '2', 'quartz_job_del', NULL, '322efc9833f2562f8862f882dabdf3d6',
        NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2019-08-14 10:35:56.092', '1', '2020-05-15 21:06:35.180',
        NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('2d9efe7ea66351a96da68e6a7cca5e00', '任务调度方案删除', '2', 'quartz_job_del', NULL, 'c77855e4171d00ae3f97563a8391f70a',
        NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2019-08-14 10:36:03.606', '1', '2020-05-15 21:06:35.180',
        NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('2f95c888121de9aae1bc8f61c5fd508c', '编辑', '2', 't_tInvoiceHistory_edit', NULL,
        'f9153fa246f209a70a97e51edd31ace5', '1120fe9bc06066fae0aec08325bdf56e,f9153fa246f209a70a97e51edd31ace5,', NULL,
        NULL, b'0', b'0', b'0', b'1', 30, '1', '2020-08-12 11:24:27.176', '1', '2020-08-12 11:29:14.280', NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('310c04e534c9af92935c54b4e1357447', 'tes', '1', 'te', 'te', '54cd27f34ca7e9a8848b92377468965d',
        '54cd27f34ca7e9a8848b92377468965d,', 'app', 'te', b'0', b'0', b'0', b'1', 999, '1', '2020-05-14 18:17:11.736',
        '1', '2020-05-15 21:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('322efc9833f2562f8862f882dabdf3d6', '任务调度方案', '1', NULL, 'job', '2000', NULL, 'timing', 'quartz/job/index',
        b'0', b'0', b'0', b'0', 30, '1', '2019-08-14 10:35:56.081', '1', '2020-05-15 21:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('33eef3f9266d54142105eec44d9f2f15', '编辑', '2', 't_tGoods_edit', NULL, '545e9d0ccf70d946f66b835348af18ba',
        '1120fe9bc06066fae0aec08325bdf56e,545e9d0ccf70d946f66b835348af18ba,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2020-08-12 15:57:38.403', '1', '2020-08-12 15:57:38.403', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('34acb71268387bb85c80849f7377c7fd', '任务日志导出', '2', 'quartz_jobLog_export', NULL,
        'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0',
        b'1', 40, '1', '2019-08-14 10:36:42.000', '1', '2020-05-16 13:43:17.758', NULL, 4, '1');
INSERT INTO `sys_menu`
VALUES ('34dae0db3f9c97482d598f964bd4c9c7', '配置管理', '1', NULL, 'configuration', 'ef2382c0cc2d99ee73444e684237a88a',
        'ef2382c0cc2d99ee73444e684237a88a,', 'dev', 'admin/configuration/index', b'0', b'0', b'0', b'1', 50, '1',
        '2019-08-05 17:46:50.000', '1', '2020-05-17 17:54:41.694', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('365a9f74f847322d2b8a0eff2b426ef4', '登录日志导出', '2', 'sys_logLogin_export', NULL,
        'a41d4ac1a6cc179696e0dbf284e3efc4', 'a41d4ac1a6cc179696e0dbf284e3efc4,', NULL, NULL, b'0', b'0', b'0', b'1', 40,
        '1', '2019-08-15 09:26:02.000', '1', '2020-05-17 14:55:26.858', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('3956b4690e4f49cfb1e065384c1dc0b9', '测试树', '1', NULL, 'test-tree-book', 'eb17cee437ea6b630dad59fff2a059ca',
        NULL, 'icon-right-square', 'views/test/test-tree-book/index', b'0', NULL, b'0', b'0', 90, '1',
        '2020-05-25 09:35:47.300', '1', '2020-05-25 10:12:00.658', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('3c1c5a48888650b9a7ba5a1763f2e205', '任务日志查看', '2', 'quartz_jobLog_view', NULL,
        'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0',
        b'1', 20, '1', '2019-08-14 10:36:42.000', '1', '2020-05-16 13:43:17.732', NULL, 4, '1');
INSERT INTO `sys_menu`
VALUES ('413892fe8d52c1163d6659f51299dc96', '代码生成', '0', NULL, '/gen', 'ef2382c0cc2d99ee73444e684237a88a',
        'ef2382c0cc2d99ee73444e684237a88a,', 'codeConsole', 'gen/index', b'0', b'0', b'0', b'0', 10, '1',
        '2019-07-20 12:00:48.000', '1', '2020-05-18 11:39:41.987', NULL, 47, '0');
INSERT INTO `sys_menu`
VALUES ('48ffd1c39241ab2b4c206155bb2ae8b4', '测试书籍查看', '2', 'test_testBook_view', NULL,
        '4f5c94e30f3a64e8e1f1bf10e7247e7e', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1',
        '2020-05-25 10:15:07.785', '1', '2020-05-29 16:36:26.964', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('4f5c94e30f3a64e8e1f1bf10e7247e7e', '测试书籍', '1', NULL, 'test-book', 'eb17cee437ea6b630dad59fff2a059ca', NULL,
        'icon-right-square', 'test/test-book/index', b'0', b'0', b'0', b'0', 30, '1', '2020-05-25 10:15:07.782', '1',
        '2020-05-29 16:36:34.943', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('511c942a5770b6bfa10fbdb3e2fa9d10', '测试树删除', '2', 'test_testTreeBook_del', NULL,
        'c206444a1d18c7b505dea8ed5a617669', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1',
        '2020-05-25 10:12:00.674', '1', '2020-05-25 10:15:02.864', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('52715698214e88cb09fa4dd1ea5ad348', '生成方案菜单', '2', 'gen_scheme_menu', NULL, '247071d42ff40267c8d8c44eac92da67',
        '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2019-07-25 13:03:03.000', '1', '2020-05-18 11:39:42.037', NULL, 8, '0');
INSERT INTO `sys_menu`
VALUES ('5404c3df9f771dbc0237578814bbe44b', 'Yaml编辑器', '1', NULL, 'yaml', 'd9d87cf8ed7c29ed2eda06d5dec4dcda',
        'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'dev', 'components/YamlEdit', b'0', b'0', b'0', b'1', 50, '1',
        '2020-05-15 21:22:43.364', '1', '2020-05-15 21:22:43.364', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('5431004fa397e0280fd75c4a3b73c4aa', '登录日志查看', '2', 'sys_logLogin_view', NULL,
        'a41d4ac1a6cc179696e0dbf284e3efc4', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1',
        '2019-08-15 09:26:02.349', '1', '2020-05-17 14:55:26.848', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('545e9d0ccf70d946f66b835348af18ba', '商品管理', '1', 't_tGoods_view', 't/t-goods',
        '1120fe9bc06066fae0aec08325bdf56e', '1120fe9bc06066fae0aec08325bdf56e,', 'date', 't/t-goods/index', b'0', b'0',
        b'0', b'0', 30, '1', '2020-08-12 15:57:08.476', '1', '2020-08-12 15:57:55.384', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('54cd27f34ca7e9a8848b92377468965d', 'test', '1', 'test', 'tes', '-1', NULL, 'Steve-Jobs', 'tes', b'1', b'0',
        b'1', b'0', 999, '1', '2020-05-14 18:16:52.599', '1', '2020-05-15 21:07:50.836', NULL, 2, '1');
INSERT INTO `sys_menu`
VALUES ('55b8af86fa4b4e53680a652f83ad1c3a', '订单管理', '1', 't_tOrder_view', 't/t-order',
        '1120fe9bc06066fae0aec08325bdf56e', '1120fe9bc06066fae0aec08325bdf56e,', 'alipay', 't/t-order/index', b'0',
        b'0', b'0', b'0', 30, '1', '2020-08-12 15:37:34.579', '1', '2020-08-12 15:38:33.611', NULL, 3, '0');
INSERT INTO `sys_menu`
VALUES ('5af0ff6dd036af1f1bfdcc13c42023b3', '前端内容控制', '1', 't_tFront_view', 't/t-front',
        '1120fe9bc06066fae0aec08325bdf56e', '1120fe9bc06066fae0aec08325bdf56e,', 'dev', 't/t-front/index', b'0', b'0',
        b'0', b'0', 30, '1', '2020-08-12 10:27:33.468', '1', '2020-08-12 11:00:05.790', NULL, 8, '0');
INSERT INTO `sys_menu`
VALUES ('5b39ca5a25c772105c71f8c51d1f19d4', '三级菜单1', '1', NULL, 'menu1-1', '1ae562534a64d4473899e52497c40b2e',
        'eb17cee437ea6b630dad59fff2a059ca,1ae562534a64d4473899e52497c40b2e,', 'dev', 'nested/menu1/menu1-1', b'0', b'0',
        b'0', b'1', 30, '1', '2020-05-18 11:11:16.436', '1', '2020-05-25 10:13:50.586', NULL, 6, '0');
INSERT INTO `sys_menu`
VALUES ('5d94bc2151ec9572966e5e768824752d', '测试树查看', '2', 'test_testTreeBook_view', NULL,
        '3956b4690e4f49cfb1e065384c1dc0b9', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1',
        '2020-05-25 09:35:47.304', '1', '2020-05-25 10:12:00.658', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('5da31e19f05edeea6a7041e3101deefe', '任务日志删除', '2', 'quartz_jobLog_del', NULL,
        'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0',
        b'1', 80, '1', '2019-08-14 10:36:42.000', '1', '2020-05-16 13:43:17.702', NULL, 4, '1');
INSERT INTO `sys_menu`
VALUES ('618ee4b9660265a85a8b61277de2a579', '富文本', '1', NULL, 'editor', 'd9d87cf8ed7c29ed2eda06d5dec4dcda',
        'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'fwb', 'components/Editor', b'0', b'0', b'0', b'1', 30, '1',
        '2020-05-15 21:16:40.552', '1', '2020-05-15 21:16:50.233', NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('621e50e1c7d66a1febeb699bebb2fe35', '任务调度执行', '2', 'quartz_job_run', NULL, '74f2b2a8871a298e0acc4d7129d10e9c',
        '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 20, '1', '2019-08-15 16:10:59.000',
        '1', '2020-05-16 12:11:01.548', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('64b61b8966e1c74d9b309069b2f622d1', '图标库', '1', NULL, 'icons', 'd9d87cf8ed7c29ed2eda06d5dec4dcda',
        'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'icon', 'components/icons/index', b'0', b'0', b'0', b'1', 10, '1',
        '2020-05-15 21:14:28.945', '1', '2020-05-15 21:15:00.712', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('671fa1206a2446b046d4a91deceddd0f', '发票抬头管理', '1', 't_tInvoice_view', 't/t-invoice',
        '1120fe9bc06066fae0aec08325bdf56e', '1120fe9bc06066fae0aec08325bdf56e,', 'list', 't/t-invoice/index', b'0',
        b'0', b'0', b'0', 35, '1', '2020-08-12 11:06:32.921', '1', '2020-08-12 11:29:08.041', NULL, 7, '0');
INSERT INTO `sys_menu`
VALUES ('6e3f89cda84ac2c6e715e7812c102ae8', '在线用户', '1', '', 'user-online', '2000', '2000,', 'Steve-Jobs',
        'monitor/user-online/index', b'0', b'0', b'0', b'0', 30, '1', '2019-08-07 09:03:52.000', '1',
        '2020-05-16 17:55:59.718', NULL, 10, '0');
INSERT INTO `sys_menu`
VALUES ('74f2b2a8871a298e0acc4d7129d10e9c', '任务调度', '1', NULL, 'job', '1000', '1000,', 'timing', 'quartz/job/index',
        b'0', b'0', b'0', b'0', 60, '1', '2019-08-14 10:36:47.081', '1', '2020-05-16 17:56:34.966', NULL, 22, '0');
INSERT INTO `sys_menu`
VALUES ('76d6087052dc26b32f3efa71b9cc119b', '任务调度日志', '2', 'quartz_jobLog_view', NULL,
        '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 50,
        '1', '2019-08-15 16:11:30.986', '1', '2020-05-16 13:43:44.992', NULL, 3, '0');
INSERT INTO `sys_menu`
VALUES ('7754b1457826c48290bc189bb1289740', '支付宝工具', '1', NULL, 'alipay', 'ef2382c0cc2d99ee73444e684237a88a',
        'ef2382c0cc2d99ee73444e684237a88a,', 'alipay', 'tool/alipay/index', b'0', b'0', b'0', b'1', 40, '1',
        '2020-05-17 17:58:06.876', '1', '2020-05-19 02:17:53.063', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('795b4d5cf0eb3ed80e24cbab39727b9d', 'Markdown', '1', NULL, 'markdown', 'd9d87cf8ed7c29ed2eda06d5dec4dcda',
        'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'markdown', 'components/MarkDown', b'0', b'0', b'0', b'1', 40, '1',
        '2020-05-15 21:21:46.675', '1', '2020-05-15 21:22:53.122', NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('7b14af9e9fbff286856338a194422b07', '令牌查看', '2', 'sys_persistentToken_view', NULL, '2600', '2600,', NULL, NULL,
        b'0', b'0', b'0', b'1', 30, '1', '2019-08-08 09:44:25.617', '1', '2020-05-16 17:57:31.295', NULL, 4, '0');
INSERT INTO `sys_menu`
VALUES ('7c7a876f4cceba2dd92aa539dea6b6e5', '任务日志清空', '2', 'quartz_jobLog_clean', NULL,
        'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0',
        b'1', 30, '1', '2019-08-15 13:55:37.892', '1', '2020-05-16 13:43:17.774', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('83401bedafe0bdb0c01cc14f64ac8c0b', '删除', '2', 't_tVideo_del', NULL, '8c0d687c64b90afb0c0d80bc23fcd718',
        '1120fe9bc06066fae0aec08325bdf56e,8c0d687c64b90afb0c0d80bc23fcd718,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2020-08-12 15:44:30.890', '1', '2020-08-12 15:44:30.890', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('84f55c785ae71eb65e7325e148818041', '测试树查看', '2', 'test_testTreeBook_view', NULL,
        'c206444a1d18c7b505dea8ed5a617669', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1',
        '2020-05-25 10:12:00.667', '1', '2020-05-25 10:15:02.864', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('8591bd99f07ad86cc3bf6debb65fc799', '删除', '2', 't_tInvoice_del', NULL, '671fa1206a2446b046d4a91deceddd0f',
        '1120fe9bc06066fae0aec08325bdf56e,671fa1206a2446b046d4a91deceddd0f,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2020-08-12 11:09:01.037', '1', '2020-08-12 11:29:08.050', NULL, 3, '0');
INSERT INTO `sys_menu`
VALUES ('862fa87cbc10766da4de286804e01d13', '测试树删除', '2', 'test_testTreeBook_del', NULL,
        'dab11e5104d690be6991002ae4da0cbd', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1',
        '2020-05-25 10:15:02.877', '1', '2020-05-29 16:36:26.973', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('8c0d687c64b90afb0c0d80bc23fcd718', '视频管理', '1', 't_tVideo_view', 't/t-video',
        '1120fe9bc06066fae0aec08325bdf56e', '1120fe9bc06066fae0aec08325bdf56e,', 'menu', 't/t-video/index', b'0', b'0',
        b'0', b'0', 30, '1', '2020-08-12 15:42:49.899', '1', '2020-08-12 15:44:30.886', NULL, 4, '0');
INSERT INTO `sys_menu`
VALUES ('8ce9f148e5720ace1b7cf24e0985c47e', '测试书籍', '1', NULL, 'test-book', 'eb17cee437ea6b630dad59fff2a059ca', NULL,
        'icon-right-square', 'test/test-book/index', b'0', NULL, b'0', b'0', 90, '1', '2020-05-25 10:12:05.950', '1',
        '2020-05-25 10:15:07.779', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('8d3517427e527df11d51da528261c915', '测试树管理', '1', NULL, 'test-tree-book', '413892fe8d52c1163d6659f51299dc96',
        NULL, 'dev', 'test/test-tree-book/index', b'0', b'0', b'0', b'0', 30, '1', '2019-08-11 14:32:06.849', '1',
        '2020-05-15 21:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('92f78825551a22fa130c03066f398448', '在线用户删除', '2', 'sys_userOnline_del', NULL,
        '6e3f89cda84ac2c6e715e7812c102ae8', '2000,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', b'0', b'0',
        b'1', 30, '1', '2019-08-07 09:06:33.448', '1', '2020-05-16 17:55:59.728', NULL, 5, '0');
INSERT INTO `sys_menu`
VALUES ('94b57a562063d103423e2c6125cb30ad', '菜单查看', '2', 'sys_menu_view', NULL, '1200', '1200,', NULL, NULL, b'0', b'0',
        b'0', b'1', 30, '1', '2019-08-07 17:27:59.697', '1', '2020-05-15 21:06:35.180', NULL, 1, '1');
INSERT INTO `sys_menu`
VALUES ('956393c3e3d73714c0facc7ed628c371', '编辑', '2', 't_tInvoice_edit', NULL, '671fa1206a2446b046d4a91deceddd0f',
        '1120fe9bc06066fae0aec08325bdf56e,671fa1206a2446b046d4a91deceddd0f,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2020-08-12 11:08:33.487', '1', '2020-08-12 11:29:08.054', NULL, 4, '0');
INSERT INTO `sys_menu`
VALUES ('9763343d9cce11ce9eb4f21c8e49122b', '任务调度编辑', '2', 'quartz_job_edit', NULL, '74f2b2a8871a298e0acc4d7129d10e9c',
        '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-14 10:36:47.088',
        '1', '2020-05-16 12:11:35.820', NULL, 1, '0');
INSERT INTO `sys_menu`
VALUES ('97722c6d56c8b9990cc3c1a6eea3d6bb', '业务表编辑', '1', 'gen_table_edit', 'edit', '413892fe8d52c1163d6659f51299dc96',
        'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,', NULL, 'gen/table/edit', b'1', b'0', b'0',
        b'1', 20, '1', '2019-07-21 13:24:02.000', '1', '2020-05-18 11:39:42.048', NULL, 10, '0');
INSERT INTO `sys_menu`
VALUES ('9f02e346b5350366968f217daef3f1b7', '图表库', '1', NULL, 'Echarts', 'd9d87cf8ed7c29ed2eda06d5dec4dcda',
        'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'chart', 'components/Echarts', b'0', b'0', b'0', b'1', 20, '1',
        '2020-05-15 21:12:39.827', '1', '2020-05-15 21:15:09.128', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('a18b33e15bde209a3c9115517c56d9ec', '业务表', '1', '', 'table', '413892fe8d52c1163d6659f51299dc96',
        'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,', 'database', 'gen/table/index', b'0', b'0',
        b'0', b'0', 10, '1', '2019-07-20 12:02:02.000', '1', '2020-05-18 11:39:42.059', NULL, 23, '0');
INSERT INTO `sys_menu`
VALUES ('a41d4ac1a6cc179696e0dbf284e3efc4', '登录日志', '1', NULL, 'log-login', '2000', '2000,', 'log',
        'monitor//log-login/index', b'0', b'0', b'0', b'0', 50, '1', '2019-08-15 09:26:02.345', '1',
        '2020-05-17 14:55:36.150', NULL, 8, '1');
INSERT INTO `sys_menu`
VALUES ('b6bcb9fa8a3726bfbffb955dc9f56b91', '测试书籍编辑', '2', 'test_testBook_edit', NULL,
        '8ce9f148e5720ace1b7cf24e0985c47e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 40, '1',
        '2020-05-25 10:12:05.958', '1', '2020-05-25 10:15:07.779', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('b8eafb6c3a8bf0919230f0bfa59d86b6', '二级菜单2', '1', NULL, 'menu2', 'eb17cee437ea6b630dad59fff2a059ca',
        'eb17cee437ea6b630dad59fff2a059ca,', 'dev', 'nested/menu2/index', b'0', b'0', b'0', b'1', 30, '1',
        '2020-05-18 11:14:32.907', '1', '2020-05-18 11:15:14.535', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('b961670cbf3454f5927c4bd2a327e915', '生成方案删除', '2', 'gen_scheme_del', NULL, '247071d42ff40267c8d8c44eac92da67',
        '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2019-07-21 13:30:18.000', '1', '2020-05-18 11:39:42.072', NULL, 8, '0');
INSERT INTO `sys_menu`
VALUES ('b963a451117f430703817b3b6c87402a', '任务调度日志导出', '2', 'quartz_jobLog_export', NULL,
        '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 60,
        '1', '2019-08-15 16:13:16.742', '1', '2020-05-16 13:43:54.409', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('ba860cfe687fd01fd492c683907936aa', '测试树编辑', '2', 'test_testTreeBook_edit', NULL,
        'dab11e5104d690be6991002ae4da0cbd', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1',
        '2020-05-25 10:15:02.874', '1', '2020-05-29 16:36:27.013', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('bb9dd4b7a2a462193d0f01517308f812', '业务表查看', '2', 'gen_table_view', NULL, 'a18b33e15bde209a3c9115517c56d9ec',
        'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL,
        NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 08:47:39.828', '1', '2020-05-18 11:39:42.081', NULL, 5, '0');
INSERT INTO `sys_menu`
VALUES ('bc7a2552fa2dbca2abc36fb6b73f695f', '删除', '2', 't_tFront_del', NULL, '5af0ff6dd036af1f1bfdcc13c42023b3',
        '1120fe9bc06066fae0aec08325bdf56e,5af0ff6dd036af1f1bfdcc13c42023b3,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2020-08-12 10:29:10.744', '1', '2020-08-12 11:00:05.802', NULL, 4, '0');
INSERT INTO `sys_menu`
VALUES ('bceaa6c321109b9becd91e3eac3647c0', '测试书籍编辑', '2', 'test_testBook_edit', NULL,
        '4f5c94e30f3a64e8e1f1bf10e7247e7e', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1',
        '2020-05-25 10:15:07.788', '1', '2020-05-29 16:36:26.983', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('bd62904371247f56594741ff8e9bded9', '用户导出', '2', 'sys_user_export', NULL, '1100', '1000,1100,', NULL, NULL,
        b'0', b'0', b'0', b'1', 80, '1', '2019-08-07 17:50:02.000', '1', '2020-05-15 21:06:35.180', NULL, 7, '0');
INSERT INTO `sys_menu`
VALUES ('c0ba37c10abaecd89a738c5cf2a2fd24', '服务监控', '1', 'sys_monitor_view', 'server', '2000', '2000,', 'codeConsole',
        'monitor/server/index', b'0', b'0', b'0', b'1', 40, '1', '2019-08-05 17:21:10.000', '1',
        '2020-05-17 16:52:02.586', NULL, 5, '0');
INSERT INTO `sys_menu`
VALUES ('c206444a1d18c7b505dea8ed5a617669', '测试树', '1', NULL, 'test-tree-book', 'eb17cee437ea6b630dad59fff2a059ca',
        'eb17cee437ea6b630dad59fff2a059ca,', 'icon-right-square', 'test/test-tree-book/index', b'0', b'0', b'1', b'0',
        80, '1', '2020-05-25 10:12:00.664', '1', '2020-05-25 10:15:02.864', NULL, 2, '1');
INSERT INTO `sys_menu`
VALUES ('c26df9cff6e0a72ccd966ff8b7c841d4', '删除', '2', 't_tOrder_del', NULL, '55b8af86fa4b4e53680a652f83ad1c3a',
        '1120fe9bc06066fae0aec08325bdf56e,55b8af86fa4b4e53680a652f83ad1c3a,', NULL, NULL, b'0', b'0', b'0', b'1', 35,
        '1', '2020-08-12 15:38:33.615', '1', '2020-08-12 15:38:33.615', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('c77855e4171d00ae3f97563a8391f70a', '任务调度方案', '1', NULL, 'job', '2000', NULL, 'timing', 'quartz/job/index',
        b'0', b'0', b'0', b'0', 30, '1', '2019-08-14 10:36:03.593', '1', '2020-05-15 21:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('c7bc1d64972e77c15ed42d5cf21d9ec5', '测试树删除', '2', 'test_testTreeBook_del', NULL,
        '3956b4690e4f49cfb1e065384c1dc0b9', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1',
        '2020-05-25 09:35:47.314', '1', '2020-05-25 10:12:00.658', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('c8b84044eac87a2e2ed0e10da9e095d2', '测试书籍编辑', '2', 'test_testBook_edit', NULL,
        '2c0688c2ad9259b9a7e7088a2f6ade4e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 40, '1',
        '2020-05-25 09:36:39.128', '1', '2020-05-25 10:12:05.946', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('c93f8fca7ca6f8631d383b08ab67009a', '任务日志', '1', NULL, 'job-log', '2000', '2000,', 'log',
        'quartz/job-log/index', b'0', b'0', b'0', b'0', 60, '1', '2019-08-14 10:36:42.000', '1',
        '2020-05-16 13:43:26.449', NULL, 14, '1');
INSERT INTO `sys_menu`
VALUES ('caaec41413c5713c6f290efe08c11415', '生成方案查看', '2', 'gen_scheme_view', NULL, '247071d42ff40267c8d8c44eac92da67',
        '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2019-08-11 08:48:09.000', '1', '2020-05-18 11:39:42.095', NULL, 5, '0');
INSERT INTO `sys_menu`
VALUES ('d12f44379df45c21e30dda4cfd27d710', '删除', '2', 'sys_sysSms_del', NULL, '2a13e56860d4aced7a2b12881b139710',
        '1120fe9bc06066fae0aec08325bdf56e,2a13e56860d4aced7a2b12881b139710,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2020-08-12 15:48:56.677', '1', '2020-08-12 15:48:56.677', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('d4c16faad8f883650a3a8eab829ebad9', '操作日志查看', '2', 'sys_logOperate_view', NULL, '2100', '2000,2100,', NULL,
        NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 17:51:38.454', '1', '2020-05-17 10:23:57.546', NULL, 2, '0');
INSERT INTO `sys_menu`
VALUES ('d5642a62bb1dc261baaf7dc883bba7e1', '测试书籍删除', '2', 'test_testBook_del', NULL,
        '8ce9f148e5720ace1b7cf24e0985c47e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1',
        '2020-05-25 10:12:05.961', '1', '2020-05-25 10:15:07.779', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('d5897b78312e09024546530fd8b2e8fc', '任务调度方案查看', '2', 'quartz_job_view', NULL,
        'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1',
        '2019-08-14 10:36:03.598', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('d9d87cf8ed7c29ed2eda06d5dec4dcda', '组件管理', '0', NULL, '/components', '-1', NULL, 'zujian', 'Layout', b'0',
        b'0', b'0', b'0', 80, '1', '2020-05-15 20:57:28.521', '1', '2020-05-16 13:38:57.307', NULL, 26, '0');
INSERT INTO `sys_menu`
VALUES ('da5709484a056154e0e89891eea6d6ac', '测试书籍查看', '2', 'test_testBook_view', NULL,
        '2c0688c2ad9259b9a7e7088a2f6ade4e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1',
        '2020-05-25 09:36:39.124', '1', '2020-05-25 10:12:05.946', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('dab11e5104d690be6991002ae4da0cbd', '测试树', '1', NULL, 'test-tree-book', 'eb17cee437ea6b630dad59fff2a059ca',
        NULL, 'icon-right-square', 'test/test-tree-book/index', b'0', b'0', b'0', b'0', 30, '1',
        '2020-05-25 10:15:02.868', '1', '2020-05-29 16:36:34.931', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('e086c4aa4943a883b29cf94680608b89', '生成方案代码', '2', 'gen_scheme_code', NULL, '247071d42ff40267c8d8c44eac92da67',
        '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2019-08-11 08:55:37.000', '1', '2020-05-18 11:39:42.099', NULL, 3, '0');
INSERT INTO `sys_menu`
VALUES ('e590df103d3382d3091eae818f68626b', '测试树管理查看', '2', 'test_testTreeBook_view', NULL,
        '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1',
        '2019-08-11 14:32:06.853', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('e5ea38c1f97dee0043e78f3fb27b25d6', '生成方案编辑', '2', 'gen_scheme_edit', NULL, '247071d42ff40267c8d8c44eac92da67',
        '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2019-07-21 13:29:14.000', '1', '2020-05-18 11:39:42.102', NULL, 6, '0');
INSERT INTO `sys_menu`
VALUES ('e66c7efccb9e1a0519afc328339e9108', '登录日志删除', '2', 'sys_logLogin_del', NULL, 'a41d4ac1a6cc179696e0dbf284e3efc4',
        NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2019-08-15 09:26:02.357', '1', '2020-05-17 14:55:26.867',
        NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('e6ea0a5dc986c69852010e4a24329cf1', '任务调度方案编辑', '2', 'quartz_job_edit', NULL,
        '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1',
        '2019-08-14 10:35:56.089', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('e710a66583fe0e324492462adb16014e', '业务表删除', '2', 'gen_table_del', NULL, 'a18b33e15bde209a3c9115517c56d9ec',
        'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL,
        NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-21 13:24:45.000', '1', '2020-05-18 11:39:42.110', NULL, 6, '0');
INSERT INTO `sys_menu`
VALUES ('eb17cee437ea6b630dad59fff2a059ca', '多级菜单', '0', NULL, '/nested', '-1', NULL, 'dev', 'Layout', b'0', b'0', b'0',
        b'0', 100, '1', '2020-05-18 11:09:23.393', '1', '2020-05-25 10:13:50.571', NULL, 13, '0');
INSERT INTO `sys_menu`
VALUES ('edc01fe5edb70ebb040b2acb428e5821', '编辑', '2', 'sys_sysSms_edit', NULL, '2a13e56860d4aced7a2b12881b139710',
        '1120fe9bc06066fae0aec08325bdf56e,2a13e56860d4aced7a2b12881b139710,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2020-08-12 15:48:41.811', '1', '2020-08-12 15:48:41.811', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('eef94eb9d762816360f7560f0be2ec34', '删除', '2', 't_tGoods_del', NULL, '545e9d0ccf70d946f66b835348af18ba',
        '1120fe9bc06066fae0aec08325bdf56e,545e9d0ccf70d946f66b835348af18ba,', NULL, NULL, b'0', b'0', b'0', b'1', 30,
        '1', '2020-08-12 15:57:55.388', '1', '2020-08-12 15:57:55.388', NULL, 0, '0');
INSERT INTO `sys_menu`
VALUES ('ef2382c0cc2d99ee73444e684237a88a', '系统工具', '0', NULL, '/admin', '-1', NULL, 'sys-tools', 'Layout', b'0', b'0',
        b'0', b'0', 30, '1', '2019-08-05 15:58:12.000', '1', '2020-05-19 02:17:53.050', NULL, 46, '0');
INSERT INTO `sys_menu`
VALUES ('f15e2186907d22765cd149a94905842a', '在线用户强退', '2', 'sys_userOnline_logout', NULL,
        '6e3f89cda84ac2c6e715e7812c102ae8', '2000,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', b'0', b'0',
        b'1', 30, '1', '2019-08-11 10:57:51.502', '1', '2020-05-16 17:55:59.729', NULL, 5, '0');
INSERT INTO `sys_menu`
VALUES ('f6d6b0be40b21899380fd7983d371c3a', '测试书籍删除', '2', 'test_testBook_del', NULL,
        '2c0688c2ad9259b9a7e7088a2f6ade4e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1',
        '2020-05-25 09:36:39.132', '1', '2020-05-25 10:12:05.946', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('f9153fa246f209a70a97e51edd31ace5', '发票历史', '1', 't_tInvoiceHistory_view', 't/t-invoice-history',
        '1120fe9bc06066fae0aec08325bdf56e', '1120fe9bc06066fae0aec08325bdf56e,', 'list', 't/t-invoice-history/index',
        b'0', b'0', b'0', b'0', 40, '1', '2020-08-12 11:23:48.892', '1', '2020-08-12 11:29:14.269', NULL, 4, '0');
INSERT INTO `sys_menu`
VALUES ('f9ad900ea905f0d388d9d2da66a42aef', '测试树编辑', '2', 'test_testTreeBook_edit', NULL,
        'c206444a1d18c7b505dea8ed5a617669', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 40, '1',
        '2020-05-25 10:12:00.671', '1', '2020-05-25 10:15:02.864', NULL, 0, '1');
INSERT INTO `sys_menu`
VALUES ('fe4c7938e146ec223e99d426aaa87109', '三级菜单2', '1', NULL, 'menu1-2', '1ae562534a64d4473899e52497c40b2e',
        'eb17cee437ea6b630dad59fff2a059ca,1ae562534a64d4473899e52497c40b2e,', 'dev', 'nested/menu1/menu1-2', b'0', b'0',
        b'0', b'1', 30, '1', '2020-05-18 11:13:18.819', '1', '2020-05-25 10:13:50.588', NULL, 3, '0');

-- ----------------------------
-- Table structure for sys_persistent_token
-- ----------------------------
DROP TABLE IF EXISTS `sys_persistent_token`;
CREATE TABLE `sys_persistent_token`
(
    `series`         varchar(76) CHARACTER SET utf8 COLLATE utf8_general_ci        NOT NULL,
    `user_id`        varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci        NULL DEFAULT NULL,
    `username`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL COMMENT '用户名',
    `token_value`    varchar(76) CHARACTER SET utf8 COLLATE utf8_general_ci        NOT NULL,
    `token_date`     timestamp(3)                                                  NULL DEFAULT NULL,
    `ip_address`     varchar(39) CHARACTER SET utf8 COLLATE utf8_general_ci        NULL DEFAULT NULL,
    `user_agent`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL,
    `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
    `browser`        varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT '' COMMENT '浏览器类型',
    `os`             varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT '' COMMENT '操作系统',
    PRIMARY KEY (`series`) USING BTREE,
    INDEX `fk_user_persistent_token` (`user_id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_persistent_token
-- ----------------------------
INSERT INTO `sys_persistent_token`
VALUES ('jeg4tzpdr3bb1wghyq98', '1', 'admin', 'zy95xy6l8bxhuq8vkr4x', '2020-05-27 11:30:33.281', '127.0.0.1',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36',
        '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016');
INSERT INTO `sys_persistent_token`
VALUES ('snhdb8hbzvzfmb7fyl19', '1', 'admin', 'z69qbar0w0fltj4egbcs', '2020-05-29 22:29:15.595', '127.0.0.1',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36',
        '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`
(
    `id`                 varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin   NOT NULL,
    `name`               varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin   NOT NULL COMMENT '名称',
    `level`              int(0)                                                  NULL     DEFAULT NULL COMMENT '角色级别',
    `data_scope`         char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin       NULL     DEFAULT NULL COMMENT '数据权限 1全部 2所在机构及以下数据  3 所在机构数据  4仅本人数据 5 按明细设置',
    `available`          char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin       NULL     DEFAULT '1' COMMENT '1-正常，0-锁定',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL,
    `created_date`       timestamp(3)                                            NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL,
    `last_modified_date` timestamp(3)                                            NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3),
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL     DEFAULT NULL COMMENT '描述',
    `version`            int(0)                                                  NOT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin       NULL     DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_bin COMMENT = '系统角色表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role`
VALUES ('1', '超级管理员', 1, '1', '1', '', '2017-10-29 15:45:51.000', '1', '2020-05-14 11:00:00.741', NULL, 75, '0');
INSERT INTO `sys_role`
VALUES ('2', '机构管理员', 2, '2', '1', '', '2018-11-11 19:42:26.000', '1', '2020-05-14 11:01:14.154', NULL, 18, '0');
INSERT INTO `sys_role`
VALUES ('262da20a182dd09e70422cbca05503b7', 'tets', 3, '5', '1', '1', '2020-05-14 11:21:30.869', '1',
        '2020-05-14 11:28:55.628', NULL, 0, '1');
INSERT INTO `sys_role`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '部门管理员', 3, '3', '1', '1', '2020-05-14 11:02:13.389', '1',
        '2020-05-25 11:13:04.474', NULL, 3, '0');
INSERT INTO `sys_role`
VALUES ('4647a907ad1dd30b28cbdaa229b67fc1', '普通管理员', 4, '4', '1', '1', '2020-05-14 11:00:50.813', '1',
        '2020-05-14 11:30:26.577', '普通管理', 6, '0');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`
(
    `id`      varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色ID',
    `dept_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门ID',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '角色与部门对应关系'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept`
VALUES ('28e2bd6452d0aff99f014136336eab61', '1', '8');
INSERT INTO `sys_role_dept`
VALUES ('34481e9777757dd6ffe1c799749b4db5', '2', '5');
INSERT INTO `sys_role_dept`
VALUES ('5c5c58ad79db6edea88100e6491e5e30', '2', '4');
INSERT INTO `sys_role_dept`
VALUES ('64af22db5dbe5cf69de8fa7f2d917922', '2', '3');
INSERT INTO `sys_role_dept`
VALUES ('c3b5457350bb7a9be8201fa3f88d3c2c', '262da20a182dd09e70422cbca05503b7', NULL);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`
(
    `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色ID',
    `menu_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单ID',
    PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '角色菜单表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu`
VALUES ('1', '0d0be247863fcbf08b3db943e5f45992');
INSERT INTO `sys_role_menu`
VALUES ('1', '0d3216078a1006368af2131743325926');
INSERT INTO `sys_role_menu`
VALUES ('1', '0d857a3a2e3b3b67bba0a9b4dcd80b55');
INSERT INTO `sys_role_menu`
VALUES ('1', '1000');
INSERT INTO `sys_role_menu`
VALUES ('1', '10b8dc68308ed1f3eb1096d8be4e0fc1');
INSERT INTO `sys_role_menu`
VALUES ('1', '10bd98f30a42427dd7ef75418ad3da6b');
INSERT INTO `sys_role_menu`
VALUES ('1', '1100');
INSERT INTO `sys_role_menu`
VALUES ('1', '1101');
INSERT INTO `sys_role_menu`
VALUES ('1', '1102');
INSERT INTO `sys_role_menu`
VALUES ('1', '1103');
INSERT INTO `sys_role_menu`
VALUES ('1', '1120fe9bc06066fae0aec08325bdf56e');
INSERT INTO `sys_role_menu`
VALUES ('1', '1200');
INSERT INTO `sys_role_menu`
VALUES ('1', '1201');
INSERT INTO `sys_role_menu`
VALUES ('1', '1202');
INSERT INTO `sys_role_menu`
VALUES ('1', '1203');
INSERT INTO `sys_role_menu`
VALUES ('1', '1300');
INSERT INTO `sys_role_menu`
VALUES ('1', '1301');
INSERT INTO `sys_role_menu`
VALUES ('1', '1302');
INSERT INTO `sys_role_menu`
VALUES ('1', '1303');
INSERT INTO `sys_role_menu`
VALUES ('1', '13093fb658c1806ad5bd0600316158f2');
INSERT INTO `sys_role_menu`
VALUES ('1', '133f1408f5e3187d3e1a00b0260b7165');
INSERT INTO `sys_role_menu`
VALUES ('1', '1400');
INSERT INTO `sys_role_menu`
VALUES ('1', '1401');
INSERT INTO `sys_role_menu`
VALUES ('1', '1402');
INSERT INTO `sys_role_menu`
VALUES ('1', '1403');
INSERT INTO `sys_role_menu`
VALUES ('1', '18d6b5e0f6b986cd074bf23de11ecd34');
INSERT INTO `sys_role_menu`
VALUES ('1', '1ae562534a64d4473899e52497c40b2e');
INSERT INTO `sys_role_menu`
VALUES ('1', '2000');
INSERT INTO `sys_role_menu`
VALUES ('1', '2100');
INSERT INTO `sys_role_menu`
VALUES ('1', '2101');
INSERT INTO `sys_role_menu`
VALUES ('1', '2200');
INSERT INTO `sys_role_menu`
VALUES ('1', '2201');
INSERT INTO `sys_role_menu`
VALUES ('1', '2202');
INSERT INTO `sys_role_menu`
VALUES ('1', '247071d42ff40267c8d8c44eac92da67');
INSERT INTO `sys_role_menu`
VALUES ('1', '2500');
INSERT INTO `sys_role_menu`
VALUES ('1', '2600');
INSERT INTO `sys_role_menu`
VALUES ('1', '2601');
INSERT INTO `sys_role_menu`
VALUES ('1', '29de79df95e70d8e8fbdc7945acf214a');
INSERT INTO `sys_role_menu`
VALUES ('1', '2a13e56860d4aced7a2b12881b139710');
INSERT INTO `sys_role_menu`
VALUES ('1', '2abc3f5d5c38ace4cf491fa16928639d');
INSERT INTO `sys_role_menu`
VALUES ('1', '2f95c888121de9aae1bc8f61c5fd508c');
INSERT INTO `sys_role_menu`
VALUES ('1', '33eef3f9266d54142105eec44d9f2f15');
INSERT INTO `sys_role_menu`
VALUES ('1', '413892fe8d52c1163d6659f51299dc96');
INSERT INTO `sys_role_menu`
VALUES ('1', '52715698214e88cb09fa4dd1ea5ad348');
INSERT INTO `sys_role_menu`
VALUES ('1', '5404c3df9f771dbc0237578814bbe44b');
INSERT INTO `sys_role_menu`
VALUES ('1', '545e9d0ccf70d946f66b835348af18ba');
INSERT INTO `sys_role_menu`
VALUES ('1', '55b8af86fa4b4e53680a652f83ad1c3a');
INSERT INTO `sys_role_menu`
VALUES ('1', '5af0ff6dd036af1f1bfdcc13c42023b3');
INSERT INTO `sys_role_menu`
VALUES ('1', '5b39ca5a25c772105c71f8c51d1f19d4');
INSERT INTO `sys_role_menu`
VALUES ('1', '618ee4b9660265a85a8b61277de2a579');
INSERT INTO `sys_role_menu`
VALUES ('1', '621e50e1c7d66a1febeb699bebb2fe35');
INSERT INTO `sys_role_menu`
VALUES ('1', '64b61b8966e1c74d9b309069b2f622d1');
INSERT INTO `sys_role_menu`
VALUES ('1', '671fa1206a2446b046d4a91deceddd0f');
INSERT INTO `sys_role_menu`
VALUES ('1', '6e3f89cda84ac2c6e715e7812c102ae8');
INSERT INTO `sys_role_menu`
VALUES ('1', '74f2b2a8871a298e0acc4d7129d10e9c');
INSERT INTO `sys_role_menu`
VALUES ('1', '76d6087052dc26b32f3efa71b9cc119b');
INSERT INTO `sys_role_menu`
VALUES ('1', '7754b1457826c48290bc189bb1289740');
INSERT INTO `sys_role_menu`
VALUES ('1', '795b4d5cf0eb3ed80e24cbab39727b9d');
INSERT INTO `sys_role_menu`
VALUES ('1', '7b14af9e9fbff286856338a194422b07');
INSERT INTO `sys_role_menu`
VALUES ('1', '83401bedafe0bdb0c01cc14f64ac8c0b');
INSERT INTO `sys_role_menu`
VALUES ('1', '8591bd99f07ad86cc3bf6debb65fc799');
INSERT INTO `sys_role_menu`
VALUES ('1', '8c0d687c64b90afb0c0d80bc23fcd718');
INSERT INTO `sys_role_menu`
VALUES ('1', '92f78825551a22fa130c03066f398448');
INSERT INTO `sys_role_menu`
VALUES ('1', '956393c3e3d73714c0facc7ed628c371');
INSERT INTO `sys_role_menu`
VALUES ('1', '9763343d9cce11ce9eb4f21c8e49122b');
INSERT INTO `sys_role_menu`
VALUES ('1', '97722c6d56c8b9990cc3c1a6eea3d6bb');
INSERT INTO `sys_role_menu`
VALUES ('1', '9f02e346b5350366968f217daef3f1b7');
INSERT INTO `sys_role_menu`
VALUES ('1', 'a18b33e15bde209a3c9115517c56d9ec');
INSERT INTO `sys_role_menu`
VALUES ('1', 'b8eafb6c3a8bf0919230f0bfa59d86b6');
INSERT INTO `sys_role_menu`
VALUES ('1', 'b961670cbf3454f5927c4bd2a327e915');
INSERT INTO `sys_role_menu`
VALUES ('1', 'b963a451117f430703817b3b6c87402a');
INSERT INTO `sys_role_menu`
VALUES ('1', 'bb9dd4b7a2a462193d0f01517308f812');
INSERT INTO `sys_role_menu`
VALUES ('1', 'bc7a2552fa2dbca2abc36fb6b73f695f');
INSERT INTO `sys_role_menu`
VALUES ('1', 'bd62904371247f56594741ff8e9bded9');
INSERT INTO `sys_role_menu`
VALUES ('1', 'c0ba37c10abaecd89a738c5cf2a2fd24');
INSERT INTO `sys_role_menu`
VALUES ('1', 'c26df9cff6e0a72ccd966ff8b7c841d4');
INSERT INTO `sys_role_menu`
VALUES ('1', 'caaec41413c5713c6f290efe08c11415');
INSERT INTO `sys_role_menu`
VALUES ('1', 'd12f44379df45c21e30dda4cfd27d710');
INSERT INTO `sys_role_menu`
VALUES ('1', 'd4c16faad8f883650a3a8eab829ebad9');
INSERT INTO `sys_role_menu`
VALUES ('1', 'd9d87cf8ed7c29ed2eda06d5dec4dcda');
INSERT INTO `sys_role_menu`
VALUES ('1', 'e086c4aa4943a883b29cf94680608b89');
INSERT INTO `sys_role_menu`
VALUES ('1', 'e5ea38c1f97dee0043e78f3fb27b25d6');
INSERT INTO `sys_role_menu`
VALUES ('1', 'e710a66583fe0e324492462adb16014e');
INSERT INTO `sys_role_menu`
VALUES ('1', 'eb17cee437ea6b630dad59fff2a059ca');
INSERT INTO `sys_role_menu`
VALUES ('1', 'edc01fe5edb70ebb040b2acb428e5821');
INSERT INTO `sys_role_menu`
VALUES ('1', 'eef94eb9d762816360f7560f0be2ec34');
INSERT INTO `sys_role_menu`
VALUES ('1', 'ef2382c0cc2d99ee73444e684237a88a');
INSERT INTO `sys_role_menu`
VALUES ('1', 'f15e2186907d22765cd149a94905842a');
INSERT INTO `sys_role_menu`
VALUES ('1', 'f9153fa246f209a70a97e51edd31ace5');
INSERT INTO `sys_role_menu`
VALUES ('1', 'fe4c7938e146ec223e99d426aaa87109');
INSERT INTO `sys_role_menu`
VALUES ('2', '1000');
INSERT INTO `sys_role_menu`
VALUES ('2', '1100');
INSERT INTO `sys_role_menu`
VALUES ('2', '1101');
INSERT INTO `sys_role_menu`
VALUES ('2', '1102');
INSERT INTO `sys_role_menu`
VALUES ('2', '1200');
INSERT INTO `sys_role_menu`
VALUES ('2', '1201');
INSERT INTO `sys_role_menu`
VALUES ('2', '1202');
INSERT INTO `sys_role_menu`
VALUES ('2', '1203');
INSERT INTO `sys_role_menu`
VALUES ('2', '1300');
INSERT INTO `sys_role_menu`
VALUES ('2', '1301');
INSERT INTO `sys_role_menu`
VALUES ('2', '1302');
INSERT INTO `sys_role_menu`
VALUES ('2', '1303');
INSERT INTO `sys_role_menu`
VALUES ('2', '13093fb658c1806ad5bd0600316158f2');
INSERT INTO `sys_role_menu`
VALUES ('2', '1400');
INSERT INTO `sys_role_menu`
VALUES ('2', '1401');
INSERT INTO `sys_role_menu`
VALUES ('2', '1402');
INSERT INTO `sys_role_menu`
VALUES ('2', '1403');
INSERT INTO `sys_role_menu`
VALUES ('2', '18d6b5e0f6b986cd074bf23de11ecd34');
INSERT INTO `sys_role_menu`
VALUES ('2', '2000');
INSERT INTO `sys_role_menu`
VALUES ('2', '2100');
INSERT INTO `sys_role_menu`
VALUES ('2', '2101');
INSERT INTO `sys_role_menu`
VALUES ('2', '2200');
INSERT INTO `sys_role_menu`
VALUES ('2', '2201');
INSERT INTO `sys_role_menu`
VALUES ('2', '2202');
INSERT INTO `sys_role_menu`
VALUES ('2', '2600');
INSERT INTO `sys_role_menu`
VALUES ('2', '2601');
INSERT INTO `sys_role_menu`
VALUES ('2', '29de79df95e70d8e8fbdc7945acf214a');
INSERT INTO `sys_role_menu`
VALUES ('2', '621e50e1c7d66a1febeb699bebb2fe35');
INSERT INTO `sys_role_menu`
VALUES ('2', '74f2b2a8871a298e0acc4d7129d10e9c');
INSERT INTO `sys_role_menu`
VALUES ('2', '76d6087052dc26b32f3efa71b9cc119b');
INSERT INTO `sys_role_menu`
VALUES ('2', '7b14af9e9fbff286856338a194422b07');
INSERT INTO `sys_role_menu`
VALUES ('2', '9763343d9cce11ce9eb4f21c8e49122b');
INSERT INTO `sys_role_menu`
VALUES ('2', 'b963a451117f430703817b3b6c87402a');
INSERT INTO `sys_role_menu`
VALUES ('2', 'd4c16faad8f883650a3a8eab829ebad9');
INSERT INTO `sys_role_menu`
VALUES ('2', 'ef2382c0cc2d99ee73444e684237a88a');
INSERT INTO `sys_role_menu`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1100');
INSERT INTO `sys_role_menu`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1101');
INSERT INTO `sys_role_menu`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1102');
INSERT INTO `sys_role_menu`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1103');
INSERT INTO `sys_role_menu`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1300');
INSERT INTO `sys_role_menu`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1301');
INSERT INTO `sys_role_menu`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1302');
INSERT INTO `sys_role_menu`
VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1303');
INSERT INTO `sys_role_menu`
VALUES ('4647a907ad1dd30b28cbdaa229b67fc1', '1000');
INSERT INTO `sys_role_menu`
VALUES ('4647a907ad1dd30b28cbdaa229b67fc1', '1100');

-- ----------------------------
-- Table structure for sys_sms
-- ----------------------------
DROP TABLE IF EXISTS `sys_sms`;
CREATE TABLE `sys_sms`
(
    `id`                 varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `phone_number`       int(0)                                                        NULL DEFAULT NULL,
    `user_id`            varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '开发票的userid',
    `type`               varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NULL DEFAULT NULL COMMENT '类型？',
    `template_code`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '模板代码？',
    `template_param`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `status`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci        NOT NULL,
    `created_date`       timestamp(3)                                                  NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci        NULL DEFAULT NULL,
    `last_modified_date` timestamp(3)                                                  NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL COMMENT '描述',
    `version`            int(0)                                                        NOT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin             NULL DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`
(
    `id`                 varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin   NOT NULL DEFAULT '1' COMMENT '主键ID',
    `username`           varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin   NOT NULL COMMENT '用户名',
    `password`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin  NOT NULL,
    `nickname`           varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin   NULL     DEFAULT NULL COMMENT '昵称',
    `phone`              varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin   NULL     DEFAULT NULL COMMENT '简介',
    `email`              varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin   NULL     DEFAULT NULL COMMENT '邮箱',
    `avatar`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin  NULL     DEFAULT NULL COMMENT '头像',
    `dept_id`            varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin   NULL     DEFAULT NULL COMMENT '部门ID',
    `qq_open_id`         varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin   NULL     DEFAULT NULL COMMENT 'QQ openid',
    `wx_open_id`         varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin   NULL     DEFAULT NULL COMMENT '微信openid',
    `available`          char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin       NULL     DEFAULT '1' COMMENT '1-正常，0-锁定',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL,
    `created_date`       timestamp(3)                                            NULL     DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL,
    `last_modified_date` timestamp(3)                                            NULL     DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL     DEFAULT NULL COMMENT '描述',
    `version`            int(0)                                                  NOT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin       NULL     DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `user_wx_openid` (`wx_open_id`) USING BTREE,
    INDEX `user_qq_openid` (`qq_open_id`) USING BTREE,
    INDEX `user_idx1_username` (`username`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_bin COMMENT = '用户表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user`
VALUES ('1', 'admin', '$2a$10$6z14VGdfVnlWY2K1pvdzJOHkvjLmOuBrJXXeZ0mGIqB60Qd6WYDoC', 'albedo', '17034642999',
        '22@ss.com', '/asset-file/upload/2020/08/10/2c560e92e71a3ea60c5755987b094777.png', '1', NULL,
        'o_0FT0uyg_H1vVy2H0JpSwlVGhWQ', '1', '', '2018-04-20 07:15:18.000', '1', '2020-08-10 15:34:55.438', '11', 46,
        '0');
INSERT INTO `sys_user`
VALUES ('49f40b21c1dbdc83255d5c64119fcd4d', 'test1', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe',
        NULL, '13254642311', '13@qqx.om', NULL, '1', NULL, NULL, '1', '1', '2020-05-12 09:51:46.703', '1',
        '2020-05-29 16:42:57.177', NULL, 6, '0');
INSERT INTO `sys_user`
VALUES ('4c2796f3667e3e5907a04623d7fd8de4', 'ttttt', '$2a$10$KYuAjYBhucUG4GbYQTuRO.YOl6JJlGdEdD5zGLkfrSumnjEF59S7G',
        '1', '13245678975', '1@e.com', NULL, 'c095173c3aebcd7ff9c6177fbf7a8b69', NULL, NULL, '1', '1',
        '2020-05-29 16:41:21.126', '4c2796f3667e3e5907a04623d7fd8de4', '2020-05-29 16:48:48.526', NULL, 7, '0');
INSERT INTO `sys_user`
VALUES ('5168fcfd16b8bad9fb38edfab4409023', 'www', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe', NULL,
        '13258465211', 'qq@ee.com', NULL, '1', NULL, NULL, '1', '1', '2020-05-12 10:22:11.393', '1',
        '2020-05-29 16:42:57.181', NULL, 18, '0');
INSERT INTO `sys_user`
VALUES ('51e995c64ed5982b9ce8ad5d559f100c', 'dddd', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe',
        'dd', '13258465214', '1@1.com', NULL, '1', NULL, NULL, '1', '1', '2020-05-28 03:08:17.639', '1',
        '2020-05-29 16:42:57.184', NULL, 0, '0');
INSERT INTO `sys_user`
VALUES ('53fb3761bdd95ed3d03f4a07f78ea0eb', 'dsafdf', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe',
        NULL, '13258462101', '837158@qq.com', NULL, '1', NULL, NULL, '1', '1', '2019-07-07 14:32:17.000', '1',
        '2020-05-29 16:42:57.186', '11', 26, '0');
INSERT INTO `sys_user`
VALUES ('90da0206c39867a1b36ac36ced80c1a9', 'test', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe',
        NULL, '13258462222', 'ww@qq.com', NULL, '1', NULL, NULL, '1', '1', '2019-07-07 14:35:13.000', '1',
        '2020-05-29 16:42:57.187', NULL, 50, '0');
INSERT INTO `sys_user`
VALUES ('dcc5b57ad27014f1839a9f4bb2b568b1', 'ttt', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe', NULL,
        '13254732131', '2113@ed.bom', NULL, '1', NULL, NULL, '1', '1', '2020-05-12 10:06:21.381', '1',
        '2020-05-29 16:42:57.190', NULL, 1, '1');

-- ----------------------------
-- Table structure for sys_user_online
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_online`;
CREATE TABLE `sys_user_online`
(
    `session_id`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NOT NULL DEFAULT '' COMMENT '用户会话id',
    `user_id`          varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NULL     DEFAULT NULL COMMENT '登录ID',
    `username`         varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NULL     DEFAULT '' COMMENT '登录账号',
    `dept_id`          varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NULL     DEFAULT NULL COMMENT '部门ID',
    `dept_name`        varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NULL     DEFAULT '' COMMENT '部门名称',
    `ip_address`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NULL     DEFAULT '' COMMENT 'IP',
    `ip_location`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL     DEFAULT '' COMMENT 'IP地址',
    `user_agent`       varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL     DEFAULT NULL COMMENT '用户代理',
    `browser`          varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NULL     DEFAULT '' COMMENT '浏览器类型',
    `os`               varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NULL     DEFAULT '' COMMENT '操作系统',
    `status`           varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NULL     DEFAULT '' COMMENT '在线状态on_line在线off_line离线',
    `start_timestamp`  datetime(0)                                                    NULL     DEFAULT NULL COMMENT 'session创建时间',
    `last_access_time` datetime(0)                                                    NULL     DEFAULT NULL COMMENT 'session最后访问时间',
    `expire_time`      int(0)                                                         NULL     DEFAULT 0 COMMENT '超时时间，单位为分钟',
    `del_flag`         char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin              NULL     DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`session_id`) USING BTREE,
    UNIQUE INDEX `session_id` (`session_id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci COMMENT = '在线用户记录'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_online
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`
(
    `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户ID',
    `role_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色ID',
    PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '用户角色表'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role`
VALUES ('1', '1');
INSERT INTO `sys_user_role`
VALUES ('1', '2');
INSERT INTO `sys_user_role`
VALUES ('49f40b21c1dbdc83255d5c64119fcd4d', '2');
INSERT INTO `sys_user_role`
VALUES ('4c2796f3667e3e5907a04623d7fd8de4', '2');
INSERT INTO `sys_user_role`
VALUES ('5168fcfd16b8bad9fb38edfab4409023', '2');
INSERT INTO `sys_user_role`
VALUES ('51e995c64ed5982b9ce8ad5d559f100c', '4647a907ad1dd30b28cbdaa229b67fc1');
INSERT INTO `sys_user_role`
VALUES ('53fb3761bdd95ed3d03f4a07f78ea0eb', '1');
INSERT INTO `sys_user_role`
VALUES ('90da0206c39867a1b36ac36ced80c1a9', '2');
INSERT INTO `sys_user_role`
VALUES ('dcc5b57ad27014f1839a9f4bb2b568b1', '2');

-- ----------------------------
-- Table structure for t_front
-- ----------------------------
DROP TABLE IF EXISTS `t_front`;
CREATE TABLE `t_front`
(
    `id`                 varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '主键id',
    `name`               varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '前端页面名字',
    `path`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '前端页面地址',
    `ad_word`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '广告语内容',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci        NOT NULL,
    `created_date`       timestamp(3)                                                  NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci        NULL DEFAULT NULL,
    `last_modified_date` timestamp(3)                                                  NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL COMMENT '描述',
    `version`            int(0)                                                        NOT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin             NULL DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_front
-- ----------------------------
INSERT INTO `t_front`
VALUES ('93283781c79989bee5d32fa5cbb90dee', 'testname', '/src/url', '你好', '1', '2020-08-12 10:30:29.933', '1',
        '2020-08-12 10:30:29.933', 'other', 0, '0');

-- ----------------------------
-- Table structure for t_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods`
(
    `id`                 varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `user_id`            varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '用户id',
    `name`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名字',
    `video_id`           varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '视频id',
    `voice_url`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '这一小段文本的音频地址',
    `voice_time`         int(0)                                                        NOT NULL COMMENT '音频时间，单位是秒',
    `ad_words`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文本介绍',
    `template_words`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文本模板',
    `photo_urls`         text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci         NULL COMMENT '多个图片，用英文逗号分开。怕太长用longtext',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci        NOT NULL,
    `created_date`       timestamp(3)                                                  NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci        NULL DEFAULT NULL,
    `last_modified_date` timestamp(3)                                                  NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL COMMENT '描述',
    `version`            int(0)                                                        NOT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin             NULL DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_invoice
-- ----------------------------
DROP TABLE IF EXISTS `t_invoice`;
CREATE TABLE `t_invoice`
(
    `id`                 varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `user_id`            varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '用户id',
    `type`               int COLLATE utf8mb4_general_ci                                NOT NULL COMMENT '0-个人，1-企业',
    `name`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '企业名称/个人名称',
    `tax_num`            varchar(0) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci   NULL DEFAULT NULL COMMENT '公司税号',
    `company_location`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注册地址',
    `company_phone`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '公司电话',
    `account_bank`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开户公司',
    `account_number`     varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '开户账号',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci        NOT NULL,
    `created_date`       timestamp(3)                                                  NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci        NULL DEFAULT NULL,
    `last_modified_date` timestamp(3)                                                  NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL COMMENT '描述',
    `version`            int(0)                                                        NOT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin             NULL DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_invoice
-- ----------------------------
INSERT INTO `t_invoice`
VALUES ('66006f534d15db4414297b94bf28ae7c', '1', '0', '超级管理员', NULL, NULL, NULL, NULL, NULL, '1',
        '2020-08-12 14:39:44.544', '1', '2020-08-12 14:39:44.544', NULL, 0, '0');
INSERT INTO `t_invoice`
VALUES ('a76955c87a9bdbb9c8079124c1ed721a', '49f40b21c1dbdc83255d5c64119fcd4d', '1', 'test', NULL, NULL, NULL, NULL,
        NULL, '1', '2020-08-12 14:40:00.501', '1', '2020-08-12 14:41:53.194', NULL, 1, '0');

-- ----------------------------
-- Table structure for t_invoice_history
-- ----------------------------
DROP TABLE IF EXISTS `t_invoice_history`;
CREATE TABLE `t_invoice_history`
(
    `id`                 varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `user_id`            varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户id',
    `invoice_id`         varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发票id(数量统计用后台加一下就好)',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci       NOT NULL,
    `created_date`       timestamp(3)                                                 NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL,
    `last_modified_date` timestamp(3)                                                 NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci      NULL DEFAULT NULL COMMENT '描述',
    `version`            int(0)                                                       NOT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin            NULL DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_invoice_history
-- ----------------------------
INSERT INTO `t_invoice_history`
VALUES ('06624752702ad695493f9b8297b380fc', '1', '66006f534d15db4414297b94bf28ae7c', '1', '2020-08-12 14:51:22.674',
        '1', '2020-08-12 14:51:22.674', NULL, 0, '0');
INSERT INTO `t_invoice_history`
VALUES ('e02174bee569db503afd41d3464a954e', '49f40b21c1dbdc83255d5c64119fcd4d', 'a76955c87a9bdbb9c8079124c1ed721a', '1',
        '2020-08-12 14:51:34.783', '1', '2020-08-12 14:51:49.714', NULL, 0, '0');

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order`
(
    `id`                 varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `user_id`            varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL COMMENT '用户id',
    `status`             varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单状态（具体细节后面再说）',
    `type`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单类型（加速卡，单次，多次）',
    `video_id`           varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '视频id，等视频上传后更新',
    `user_name`          varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名字',
    `user_phone`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户电话',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci        NOT NULL,
    `created_date`       timestamp(3)                                                  NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci        NULL DEFAULT NULL,
    `last_modified_date` timestamp(3)                                                  NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL COMMENT '描述',
    `version`            int(0)                                                        NOT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin             NULL DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_video
-- ----------------------------
DROP TABLE IF EXISTS `t_video`;
CREATE TABLE `t_video`
(
    `id`                 varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NOT NULL,
    `user_id`            varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci  NULL DEFAULT NULL COMMENT '用户id',
    `name`               varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频名字',
    `origin_url`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
    `logo_url`           varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'logo的地址',
    `output_url`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '输出地址',
    `duration`           int(0)                                                        NULL DEFAULT NULL COMMENT '视频长度，单位是秒',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci        NOT NULL,
    `created_date`       timestamp(3)                                                  NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci        NULL DEFAULT NULL,
    `last_modified_date` timestamp(3)                                                  NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci       NULL DEFAULT NULL COMMENT '描述',
    `version`            int(0)                                                        NOT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin             NULL DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for test_book
-- ----------------------------
DROP TABLE IF EXISTS `test_book`;
CREATE TABLE `t_balance`
(
    `id`                 varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL,
    `user_id`            varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '用户ID',
    `times`              int(50)                                                 NOT NULL DEFAULT 0 COMMENT '次数',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL,
    `created_date`       timestamp(3)                                            NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL,
    `last_modified_date` timestamp(3)                                            NULL     DEFAULT NULL,
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL     DEFAULT NULL,
    `version`            int(0)                                                  NULL     DEFAULT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin       NULL     DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '次数表'
  ROW_FORMAT = Dynamic;



CREATE TABLE `t_balance_history`
(
    `id`                 varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL,
    `user_id`            varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL COMMENT '操作的用户ID',
    `amount`             int(0)                                                  NOT NULL DEFAULT 0 COMMENT '变更次数',
    `type`               int(0)                                                  NOT NULL DEFAULT 0 COMMENT '1为+，0为-',
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL,
    `created_date`       timestamp(3)                                            NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL,
    `last_modified_date` timestamp(3)                                            NULL     DEFAULT NULL,
    `description`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL     DEFAULT NULL,
    `version`            int(0)                                                  NULL     DEFAULT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin       NULL     DEFAULT '0' COMMENT '0-正常，1-删除',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '次数变更表'
  ROW_FORMAT = Dynamic;
-- ----------------------------
-- Records of test_book
-- ----------------------------
INSERT INTO `test_book`
VALUES ('06dc0473a0b69de240bfb01da89466d0', 'ddd', 'a', 'd', 'a@qq.com', '13', b'1', NULL, NULL, NULL,
        '2020-05-13 00:00:00.000', '1', '2020-05-25 13:10:40.846', '1', '2020-05-25 13:12:25.898', 'dd', 9, '0');
INSERT INTO `test_book`
VALUES ('f4780b34fd2f5494e9b8004096205768', NULL, '3', NULL, '3@e.com', '1', b'1', NULL, NULL, NULL, NULL, '1',
        '2020-05-25 13:10:42.217', '1', '2020-05-25 13:10:18.888', NULL, 53, '0');

-- ----------------------------
-- Table structure for test_tree_book
-- ----------------------------
DROP TABLE IF EXISTS `test_tree_book`;
CREATE TABLE `test_tree_book`
(
    `id`                 varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL,
    `parent_id`          varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL DEFAULT NULL,
    `parent_ids`         varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父菜单IDs',
    `name`               varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL DEFAULT NULL COMMENT '部门名称',
    `sort`               int(0)                                                   NULL DEFAULT NULL COMMENT '排序',
    `leaf`               bit(1)                                                   NULL DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
    `author_`            varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL COMMENT '作者',
    `email_`             varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL DEFAULT NULL COMMENT '邮箱',
    `phone_`             varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL DEFAULT NULL COMMENT '手机',
    `activated_`         bit(1)                                                   NOT NULL,
    `number_`            int(0)                                                   NULL DEFAULT NULL COMMENT 'key',
    `money_`             decimal(20, 2)                                           NULL DEFAULT NULL,
    `amount_`            double(11, 2)                                            NULL DEFAULT NULL,
    `reset_date`         timestamp(3)                                             NULL DEFAULT NULL,
    `created_by`         varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NOT NULL,
    `created_date`       timestamp(3)                                             NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
    `last_modified_by`   varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci   NULL DEFAULT NULL,
    `del_flag`           char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin        NULL DEFAULT '0' COMMENT '0-正常，1-删除',
    `last_modified_date` timestamp(3)                                             NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
    `version`            int(0)                                                   NOT NULL,
    `description`        varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL DEFAULT NULL COMMENT '描述',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '  测试树书'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test_tree_book
-- ----------------------------
INSERT INTO `test_tree_book`
VALUES ('29327df8d7a9d2749b5c7f991551816f', 'c270b41ce6087ea7b5be1446bd9d04cf', 'c270b41ce6087ea7b5be1446bd9d04cf,',
        '1', 30, b'0', '1', 'q@d.e', NULL, b'1', NULL, NULL, NULL, NULL, '1', '2020-05-25 14:02:30.865', '1', '0',
        '2020-05-25 14:45:07.197', 1, NULL);
INSERT INTO `test_tree_book`
VALUES ('c03a5aff7e9c2760d5f4c3617061b16d', '-1', NULL, '2', 30, b'1', '1', '1@1.nom', NULL, b'1', NULL, NULL, NULL,
        NULL, '1', '2020-05-25 14:37:22.540', '1', '0', '2020-05-25 14:44:42.649', 2, NULL);
INSERT INTO `test_tree_book`
VALUES ('c270b41ce6087ea7b5be1446bd9d04cf', '-1', NULL, 't', 30, b'0', 't', '2@q.com', NULL, b'1', NULL, NULL, NULL,
        NULL, '1', '2020-05-25 13:50:26.500', '1', '0', '2020-05-25 14:43:36.315', 2, NULL);
INSERT INTO `test_tree_book`
VALUES ('c9c8e389deec9bc526e178dd98a10f7f', 'c270b41ce6087ea7b5be1446bd9d04cf', 'c270b41ce6087ea7b5be1446bd9d04cf,',
        '3', 30, b'1', '3', '3@3.nim', '3', b'1', NULL, NULL, NULL, NULL, '1', '2020-05-25 14:37:37.629', '1', '0',
        '2020-05-25 14:45:08.720', 1, NULL);

-- ----------------------------
-- Table structure for tool_alipay_config
-- ----------------------------
DROP TABLE IF EXISTS `tool_alipay_config`;
CREATE TABLE `tool_alipay_config`
(
    `id`                      bigint(0)                                               NOT NULL COMMENT 'ID',
    `app_id`                  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '应用ID',
    `charset`                 varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编码',
    `format`                  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型 固定格式json',
    `gateway_url`             varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '网关地址',
    `notify_url`              varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '异步回调',
    `private_key`             text CHARACTER SET utf8 COLLATE utf8_general_ci         NULL COMMENT '私钥',
    `public_key`              text CHARACTER SET utf8 COLLATE utf8_general_ci         NULL COMMENT '公钥',
    `return_url`              varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回调地址',
    `sign_type`               varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '签名方式',
    `sys_service_provider_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商户号',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '支付宝配置类'
  ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tool_alipay_config
-- ----------------------------
INSERT INTO `tool_alipay_config`
VALUES (1, '2016091700532697', 'utf-8', 'JSON', 'https://openapi.alipaydev.com/gateway.do',
        'http://api.auauz.net/api/aliPay/notify',
        'MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC5js8sInU10AJ0cAQ8UMMyXrQ+oHZEkVt5lBwsStmTJ7YikVYgbskx1YYEXTojRsWCb+SH/kDmDU4pK/u91SJ4KFCRMF2411piYuXU/jF96zKrADznYh/zAraqT6hvAIVtQAlMHN53nx16rLzZ/8jDEkaSwT7+HvHiS+7sxSojnu/3oV7BtgISoUNstmSe8WpWHOaWv19xyS+Mce9MY4BfseFhzTICUymUQdd/8hXA28/H6osUfAgsnxAKv7Wil3aJSgaJczWuflYOve0dJ3InZkhw5Cvr0atwpk8YKBQjy5CdkoHqvkOcIB+cYHXJKzOE5tqU7inSwVbHzOLQ3XbnAgMBAAECggEAVJp5eT0Ixg1eYSqFs9568WdetUNCSUchNxDBu6wxAbhUgfRUGZuJnnAll63OCTGGck+EGkFh48JjRcBpGoeoHLL88QXlZZbC/iLrea6gcDIhuvfzzOffe1RcZtDFEj9hlotg8dQj1tS0gy9pN9g4+EBH7zeu+fyv+qb2e/v1l6FkISXUjpkD7RLQr3ykjiiEw9BpeKb7j5s7Kdx1NNIzhkcQKNqlk8JrTGDNInbDM6inZfwwIO2R1DHinwdfKWkvOTODTYa2MoAvVMFT9Bec9FbLpoWp7ogv1JMV9svgrcF9XLzANZ/OQvkbe9TV9GWYvIbxN6qwQioKCWO4GPnCAQKBgQDgW5MgfhX8yjXqoaUy/d1VjI8dHeIyw8d+OBAYwaxRSlCfyQ+tieWcR2HdTzPca0T0GkWcKZm0ei5xRURgxt4DUDLXNh26HG0qObbtLJdu/AuBUuCqgOiLqJ2f1uIbrz6OZUHns+bT/jGW2Ws8+C13zTCZkZt9CaQsrp3QOGDx5wKBgQDTul39hp3ZPwGNFeZdkGoUoViOSd5Lhowd5wYMGAEXWRLlU8z+smT5v0POz9JnIbCRchIY2FAPKRdVTICzmPk2EPJFxYTcwaNbVqL6lN7J2IlXXMiit5QbiLauo55w7plwV6LQmKm9KV7JsZs5XwqF7CEovI7GevFzyD3w+uizAQKBgC3LY1eRhOlpWOIAhpjG6qOoohmeXOphvdmMlfSHq6WYFqbWwmV4rS5d/6LNpNdL6fItXqIGd8I34jzql49taCmi+A2nlR/E559j0mvM20gjGDIYeZUz5MOE8k+K6/IcrhcgofgqZ2ZED1ksHdB/E8DNWCswZl16V1FrfvjeWSNnAoGAMrBplCrIW5xz+J0Hm9rZKrs+AkK5D4fUv8vxbK/KgxZ2KaUYbNm0xv39c+PZUYuFRCz1HDGdaSPDTE6WeWjkMQd5mS6ikl9hhpqFRkyh0d0fdGToO9yLftQKOGE/q3XUEktI1XvXF0xyPwNgUCnq0QkpHyGVZPtGFxwXiDvpvgECgYA5PoB+nY8iDiRaJNko9w0hL4AeKogwf+4TbCw+KWVEn6jhuJa4LFTdSqp89PktQaoVpwv92el/AhYjWOl/jVCm122f9b7GyoelbjMNolToDwe5pF5RnSpEuDdLy9MfE8LnE3PlbE7E5BipQ3UjSebkgNboLHH/lNZA5qvEtvbfvQ==',
        'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAut9evKRuHJ/2QNfDlLwvN/S8l9hRAgPbb0u61bm4AtzaTGsLeMtScetxTWJnVvAVpMS9luhEJjt+Sbk5TNLArsgzzwARgaTKOLMT1TvWAK5EbHyI+eSrc3s7Awe1VYGwcubRFWDm16eQLv0k7iqiw+4mweHSz/wWyvBJVgwLoQ02btVtAQErCfSJCOmt0Q/oJQjj08YNRV4EKzB19+f5A+HQVAKy72dSybTzAK+3FPtTtNen/+b5wGeat7c32dhYHnGorPkPeXLtsqqUTp1su5fMfd4lElNdZaoCI7osZxWWUo17vBCZnyeXc9fk0qwD9mK6yRAxNbrY72Xx5VqIqwIDAQAB',
        'http://localhost:8014/a/tool/aliPay/return', 'RSA2', '2088102176044281');

-- ----------------------------
-- Table structure for tool_email_config
-- ----------------------------
DROP TABLE IF EXISTS `tool_email_config`;
CREATE TABLE `tool_email_config`
(
    `id`        bigint(0)                                               NOT NULL COMMENT 'ID',
    `from_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收件人',
    `host`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮件服务器SMTP地址',
    `pass`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
    `port`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '端口',
    `user`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发件者用户名',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci COMMENT = '邮箱配置'
  ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;