/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50727
 Source Host           : localhost:3306
 Source Schema         : albedo

 Target Server Type    : MySQL
 Target Server Version : 50727
 File Encoding         : 65001

 Date: 05/09/2020 01:29:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_scheme
-- ----------------------------
DROP TABLE IF EXISTS `gen_scheme`;
CREATE TABLE `gen_scheme` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `name` varchar(200) DEFAULT NULL COMMENT '名称',
  `category` varchar(2000) DEFAULT NULL COMMENT '分类',
  `view_type` char(2) DEFAULT NULL COMMENT '视图类型 0  普通表格 1  表格采用ajax刷新',
  `package_name` varchar(500) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `sub_module_name` varchar(30) DEFAULT NULL COMMENT '生成子模块名',
  `function_name` varchar(500) DEFAULT NULL COMMENT '生成功能名',
  `function_name_simple` varchar(100) DEFAULT NULL COMMENT '生成功能名（简写）',
  `function_author` varchar(100) DEFAULT NULL COMMENT '生成功能作者',
  `gen_table_id` varchar(200) DEFAULT NULL COMMENT '生成表编号',
  `version` int(11) DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='生成方案';

-- ----------------------------
-- Records of gen_scheme
-- ----------------------------
BEGIN;
INSERT INTO `gen_scheme` VALUES ('145be4d808589aabed3d28fd6ce38f5c', '表单', 'curd', NULL, 'com.albedo.java.modules', 'biz', NULL, '表单', 'OrderForm', 'admin', 'ce24de2f484575934f17dc1efe204b15', 0, NULL, '1', '2020-08-18 10:19:40.036', '1', '2020-08-18 10:19:40.036', '0');
INSERT INTO `gen_scheme` VALUES ('3a00af7846a8ab0ab657b8e244ef3bfb', '抬头', 'curd_front', NULL, 'com.albedo.java.modules', 'biz', NULL, '发票抬头管理', '发票抬头', 'arronshentu', '61253a55e25426b602fc9ad8ec1a0fe2', 1, NULL, '1', '2020-08-16 16:19:02.777', '1', '2020-08-16 16:33:12.437', '0');
INSERT INTO `gen_scheme` VALUES ('3ae90927ab74409c29c001fc35a969eb', '联系单', 'curd', NULL, 'com.albedo.java.modules', 'biz', NULL, '联系单', '联系单', 'arronshentu', '78fb5944ba909cadb39f40a777906027', 0, NULL, '1', '2020-09-02 13:51:29.402', '1', '2020-09-02 13:51:29.402', '0');
INSERT INTO `gen_scheme` VALUES ('4503bf9f5cdf64baaf74a6fc218f42ea', 'testBook', 'curd', NULL, 'com.albedo.java.modules', 'biz', NULL, 'test', 'test', 'admin', '3758a93f20975e49d4e7b70c94a3b48a', 2, NULL, '1', '2020-08-08 20:14:07.383', '1', '2020-08-08 21:20:40.484', '0');
INSERT INTO `gen_scheme` VALUES ('adcc9cb627053d421bb71ab736a37243', '套餐', 'curd_back', NULL, 'com.albedo.java.modules', 'biz', NULL, '套餐', '套餐', 'admin', 'ffb3c3a9e232ba193239368e8dde0bbc', 3, NULL, '1', '2020-08-29 20:49:54.281', '1', '2020-09-05 00:45:00.295', '0');
INSERT INTO `gen_scheme` VALUES ('c3c9294d84f0195c1f2c146fddd6e5fb', '配置项', 'curd_front', NULL, 'com.albedo.java.modules', 'biz', NULL, '配置项', '配置项', 'admin', 'feab203bec1c4a18ba5637fae1892fc7', 0, NULL, '1', '2020-09-04 20:36:12.007', '1', '2020-09-04 20:36:12.007', '0');
INSERT INTO `gen_scheme` VALUES ('e9f2a4c9fe574726ff029a1c2d4bd202', '购买记录', 'curd', NULL, 'com.albedo.java.modules', 'biz', NULL, '购买记录', 'PurchaseRecord', 'admin', '1eec05bedee2b1e0afea533a49692321', 0, NULL, '1', '2020-08-29 23:58:01.997', '1', '2020-08-29 23:58:01.997', '0');
COMMIT;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `name` varchar(200) DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) DEFAULT NULL COMMENT '描述',
  `coding` varchar(20) DEFAULT NULL COMMENT '字符编码',
  `engine` varchar(50) DEFAULT NULL COMMENT '数据库引擎',
  `class_name` varchar(100) DEFAULT NULL COMMENT '实体类名称',
  `parent_table` varchar(200) DEFAULT NULL COMMENT '关联父表',
  `parent_table_fk` varchar(100) DEFAULT NULL COMMENT '关联父表外键',
  `version` int(11) DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `gen_table_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
BEGIN;
INSERT INTO `gen_table` VALUES ('1eec05bedee2b1e0afea533a49692321', 't_purchase_record', '消费记录', NULL, NULL, 'PurchaseRecord', NULL, NULL, 0, NULL, '1', '2020-08-29 23:57:31.121', '1', '2020-08-29 23:57:31.121', '0');
INSERT INTO `gen_table` VALUES ('3758a93f20975e49d4e7b70c94a3b48a', 'test_book', '测试书籍', NULL, NULL, 'TestBook', NULL, NULL, 0, NULL, '1', '2020-08-08 20:13:49.014', '1', '2020-08-08 20:13:49.014', '0');
INSERT INTO `gen_table` VALUES ('61253a55e25426b602fc9ad8ec1a0fe2', 't_invoice', 't_invoice', NULL, NULL, 'Invoice', NULL, NULL, 1, NULL, '1', '2020-08-16 16:33:00.329', '1', '2020-08-16 16:33:00.327', '0');
INSERT INTO `gen_table` VALUES ('78fb5944ba909cadb39f40a777906027', 't_contact_info', '联系单', NULL, NULL, 'ContactInfo', NULL, NULL, 0, NULL, '1', '2020-09-02 13:51:05.262', '1', '2020-09-02 13:51:05.262', '0');
INSERT INTO `gen_table` VALUES ('ce24de2f484575934f17dc1efe204b15', 't_order_form', '表单temp', NULL, NULL, 'OrderForm', NULL, NULL, 0, NULL, '1', '2020-08-18 10:19:05.066', '1', '2020-08-18 10:19:05.066', '0');
INSERT INTO `gen_table` VALUES ('feab203bec1c4a18ba5637fae1892fc7', 't_config', '配置项', NULL, NULL, 'Config', NULL, NULL, 1, NULL, '1', '2020-09-04 20:35:42.546', '1', '2020-09-04 20:35:42.544', '0');
INSERT INTO `gen_table` VALUES ('ffb3c3a9e232ba193239368e8dde0bbc', 't_plan', '套餐表', NULL, NULL, 'Plan', NULL, NULL, 1, NULL, '1', '2020-09-05 00:35:41.113', '1', '2020-09-05 00:35:41.111', '0');
COMMIT;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `gen_table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
  `name` varchar(200) DEFAULT NULL COMMENT '名称',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `comments` varchar(500) DEFAULT NULL COMMENT '描述备注',
  `jdbc_type` varchar(100) DEFAULT NULL COMMENT '列的数据类型的字节长度',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` bit(1) DEFAULT NULL COMMENT '是否主键',
  `is_unique` bit(1) DEFAULT NULL COMMENT '是否唯一（1：是；0：否）',
  `is_null` bit(1) DEFAULT NULL COMMENT '是否可为空',
  `is_insert` bit(1) DEFAULT NULL COMMENT '是否为插入字段',
  `is_edit` bit(1) DEFAULT NULL COMMENT '是否编辑字段',
  `is_list` bit(1) DEFAULT NULL COMMENT '是否列表字段',
  `is_query` bit(1) DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
  `show_type` varchar(200) DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
  `dict_type` varchar(200) DEFAULT NULL COMMENT '字典类型',
  `settings` varchar(2000) DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `version` int(11) DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `gen_table_column_table_id` (`gen_table_id`) USING BTREE,
  KEY `gen_table_column_name` (`name`) USING BTREE,
  KEY `gen_table_column_sort` (`sort`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
BEGIN;
INSERT INTO `gen_table_column` VALUES ('00d16b875ffb249a767cbb860db7c19e', 'ce24de2f484575934f17dc1efe204b15', 'id', '编号', NULL, 'varchar(64)', 'String', 'id', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1', '2020-08-18 10:19:05.085', '1', '2020-08-18 10:19:05.085', '0');
INSERT INTO `gen_table_column` VALUES ('012cbbba8f195f917707d1ec1111fd21', '78fb5944ba909cadb39f40a777906027', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 110, 0, NULL, '1', '2020-09-02 13:51:05.293', '1', '2020-09-02 13:51:05.293', '0');
INSERT INTO `gen_table_column` VALUES ('0552ced021cfafad14a2a53d536218e5', '78fb5944ba909cadb39f40a777906027', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 80, 0, NULL, '1', '2020-09-02 13:51:05.289', '1', '2020-09-02 13:51:05.289', '0');
INSERT INTO `gen_table_column` VALUES ('062e0a5a2a11d457d7718ec14cfd9222', 'ffb3c3a9e232ba193239368e8dde0bbc', 'video_time', '单条视频最大时长', NULL, 'int(11)', 'Long', 'videoTime', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 40, 1, NULL, '1', '2020-09-05 00:35:41.222', '1', '2020-09-05 00:35:41.145', '0');
INSERT INTO `gen_table_column` VALUES ('0694064a05d1ae64f483355be7327e27', 'feab203bec1c4a18ba5637fae1892fc7', 'id', 'id', NULL, 'int(11)', 'Long', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 1, NULL, '1', '2020-09-04 20:35:42.602', '1', '2020-09-04 20:35:42.566', '0');
INSERT INTO `gen_table_column` VALUES ('069f04daa655dea14d64e1ef3fd0d6cc', 'ffb3c3a9e232ba193239368e8dde0bbc', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 190, 1, NULL, '1', '2020-09-05 00:35:41.225', '1', '2020-09-05 00:35:41.212', '0');
INSERT INTO `gen_table_column` VALUES ('0703e150b5825034a52869018b555979', 'ffb3c3a9e232ba193239368e8dde0bbc', 'id', '编号', NULL, 'varchar(64)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 1, NULL, '1', '2020-09-05 00:35:41.221', '1', '2020-09-05 00:35:41.129', '0');
INSERT INTO `gen_table_column` VALUES ('08475454f75c946e40140d7e8e36de59', '1eec05bedee2b1e0afea533a49692321', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 130, 0, NULL, '1', '2020-08-29 23:57:31.159', '1', '2020-08-29 23:57:31.159', '0');
INSERT INTO `gen_table_column` VALUES ('08ed1a8c6c0cf7547b0b2a5731512ec1', '61253a55e25426b602fc9ad8ec1a0fe2', 'company_location', '注册地址', NULL, 'varchar(255)', 'String', 'companyLocation', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 1, NULL, '1', '2020-08-16 16:33:00.414', '1', '2020-08-16 16:33:00.370', '0');
INSERT INTO `gen_table_column` VALUES ('0a82b80486eedf6d49273b4c1c76574f', '61253a55e25426b602fc9ad8ec1a0fe2', 'name', '企业名称/个人名称', NULL, 'varchar(255)', 'String', 'name', b'0', b'0', b'0', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 1, NULL, '1', '2020-08-16 16:33:00.413', '1', '2020-08-16 16:33:00.361', '0');
INSERT INTO `gen_table_column` VALUES ('0bd980a7ab9852c594c94145c0825502', 'ffb3c3a9e232ba193239368e8dde0bbc', 'version', '默认0，必填，离线乐观锁', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 1, NULL, '1', '2020-09-05 00:35:41.224', '1', '2020-09-05 00:35:41.190', '0');
INSERT INTO `gen_table_column` VALUES ('0c9ad7d7c64ee30ae9a4619078e61222', '3758a93f20975e49d4e7b70c94a3b48a', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1', '2020-08-08 20:13:49.054', '1', '2020-08-08 20:13:49.054', '0');
INSERT INTO `gen_table_column` VALUES ('0d4a8f4a2ba36d4c328f6d8ad4891e98', '1eec05bedee2b1e0afea533a49692321', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 100, 0, NULL, '1', '2020-08-29 23:57:31.155', '1', '2020-08-29 23:57:31.155', '0');
INSERT INTO `gen_table_column` VALUES ('13c481d2b9c16a718c16f415f1383b36', 'ce24de2f484575934f17dc1efe204b15', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 100, 0, NULL, '1', '2020-08-18 10:19:05.100', '1', '2020-08-18 10:19:05.100', '0');
INSERT INTO `gen_table_column` VALUES ('18b27ecc8926e5aa8ee73a621701ce25', '3758a93f20975e49d4e7b70c94a3b48a', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 150, 0, NULL, '1', '2020-08-08 20:13:49.077', '1', '2020-08-08 20:13:49.077', '0');
INSERT INTO `gen_table_column` VALUES ('1de1b7ccdfbb97b99813427b0a492066', 'ce24de2f484575934f17dc1efe204b15', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 90, 0, NULL, '1', '2020-08-18 10:19:05.099', '1', '2020-08-18 10:19:05.099', '0');
INSERT INTO `gen_table_column` VALUES ('1e21d9bc8edeabf7db9ed2387cf21d3c', 'ffb3c3a9e232ba193239368e8dde0bbc', 'goods_quantity', '可上传的商品数量', NULL, 'int(11)', 'Long', 'goodsQuantity', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 1, NULL, '1', '2020-09-05 00:35:41.221', '1', '2020-09-05 00:35:41.140', '0');
INSERT INTO `gen_table_column` VALUES ('1efd3fab0760584f415e88d8c8c09b14', '78fb5944ba909cadb39f40a777906027', 'name', '姓名', NULL, 'varchar(32)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 30, 0, NULL, '1', '2020-09-02 13:51:05.282', '1', '2020-09-02 13:51:05.282', '0');
INSERT INTO `gen_table_column` VALUES ('20d14e243549d6925949bab1fa27ab17', '3758a93f20975e49d4e7b70c94a3b48a', 'title_', '标题', NULL, 'varchar(32)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 0, NULL, '1', '2020-08-08 20:13:49.058', '1', '2020-08-08 20:13:49.058', '0');
INSERT INTO `gen_table_column` VALUES ('20e2e1247f067c92f81b4943b6a7a9f0', '78fb5944ba909cadb39f40a777906027', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 100, 0, NULL, '1', '2020-09-02 13:51:05.293', '1', '2020-09-02 13:51:05.293', '0');
INSERT INTO `gen_table_column` VALUES ('21a70e4b6087b4df2ebcd73bbd4a1c83', 'ffb3c3a9e232ba193239368e8dde0bbc', 'edit_time', '人物/场景可修改次数', NULL, 'int(1)', 'Integer', 'editTime', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 1, NULL, '1', '2020-09-05 00:35:41.222', '1', '2020-09-05 00:35:41.153', '0');
INSERT INTO `gen_table_column` VALUES ('23fb16dd9fd2931b4d60cf0ab7376c83', 'ffb3c3a9e232ba193239368e8dde0bbc', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 170, 1, NULL, '1', '2020-09-05 00:35:41.224', '1', '2020-09-05 00:35:41.203', '0');
INSERT INTO `gen_table_column` VALUES ('29c41a76d93f244fbd8f6d136ac09695', '3758a93f20975e49d4e7b70c94a3b48a', 'author', '作者', NULL, 'varchar(50)', 'String', 'author', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 0, NULL, '1', '2020-08-08 20:13:49.059', '1', '2020-08-08 20:13:49.059', '0');
INSERT INTO `gen_table_column` VALUES ('2a8341fe235de52f6c94e4634e402c68', 'ffb3c3a9e232ba193239368e8dde0bbc', 'anchor_amount_plus', '存储空间，单位GB', NULL, 'int(1)', 'Integer', 'anchorAmountPlus', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 110, 1, NULL, '1', '2020-09-05 00:35:41.223', '1', '2020-09-05 00:35:41.178', '0');
INSERT INTO `gen_table_column` VALUES ('2d53a53a34030094d595d755add52255', '78fb5944ba909cadb39f40a777906027', 'status', '处理状态', NULL, 'varchar(100)', 'String', 'status', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 0, NULL, '1', '2020-09-02 13:51:05.285', '1', '2020-09-02 13:51:05.285', '0');
INSERT INTO `gen_table_column` VALUES ('306041eb49e7456520b82fba6ba876fe', '78fb5944ba909cadb39f40a777906027', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 120, 0, NULL, '1', '2020-09-02 13:51:05.294', '1', '2020-09-02 13:51:05.294', '0');
INSERT INTO `gen_table_column` VALUES ('329367db994feb84d17cf7d4e3388ba2', '1eec05bedee2b1e0afea533a49692321', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 90, 0, NULL, '1', '2020-08-29 23:57:31.154', '1', '2020-08-29 23:57:31.154', '0');
INSERT INTO `gen_table_column` VALUES ('32c22c8318261bc5460a24bf69cc0ce4', 'ce24de2f484575934f17dc1efe204b15', 'anchor_type', '直播间风格', NULL, 'varchar(50)', 'String', 'anchorType', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 0, NULL, '1', '2020-08-18 10:19:05.095', '1', '2020-08-18 10:19:05.095', '0');
INSERT INTO `gen_table_column` VALUES ('379f20d2ec99755342599cf98479af35', '3758a93f20975e49d4e7b70c94a3b48a', 'amount', 'amount', NULL, 'double(11,2)', 'Double', 'amount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 0, NULL, '1', '2020-08-08 20:13:49.072', '1', '2020-08-08 20:13:49.072', '0');
INSERT INTO `gen_table_column` VALUES ('3a15e9fd79de242906a91e6c9050cc63', '3758a93f20975e49d4e7b70c94a3b48a', 'activated', 'activated', NULL, 'bit(1)', 'Integer', 'activated', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 0, NULL, '1', '2020-08-08 20:13:49.067', '1', '2020-08-08 20:13:49.067', '0');
INSERT INTO `gen_table_column` VALUES ('3baf8759104fa9bdab170caa448732bf', '3758a93f20975e49d4e7b70c94a3b48a', 'email', '邮箱', NULL, 'varchar(100)', 'String', 'email', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 0, NULL, '1', '2020-08-08 20:13:49.063', '1', '2020-08-08 20:13:49.063', '0');
INSERT INTO `gen_table_column` VALUES ('41dc4a080d2b2f14c325d2ac3a679280', '3758a93f20975e49d4e7b70c94a3b48a', 'money', 'money', NULL, 'decimal(20,2)', 'Double', 'money', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 0, NULL, '1', '2020-08-08 20:13:49.070', '1', '2020-08-08 20:13:49.070', '0');
INSERT INTO `gen_table_column` VALUES ('43cb9c0e2c54aedd7fd925418bdc24a2', '1eec05bedee2b1e0afea533a49692321', 'total_amount', '支付金额', NULL, 'varchar(30)', 'String', 'totalAmount', b'0', b'0', b'1', b'1', b'0', b'1', b'0', 'eq', 'input', '', NULL, 60, 0, NULL, '1', '2020-08-29 23:57:31.149', '1', '2020-08-29 23:57:31.149', '0');
INSERT INTO `gen_table_column` VALUES ('4569ad5837d694bf59673fdb9e792265', '78fb5944ba909cadb39f40a777906027', 'company_name', '企业名称', NULL, 'varchar(32)', 'String', 'companyName', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 20, 0, NULL, '1', '2020-09-02 13:51:05.281', '1', '2020-09-02 13:51:05.281', '0');
INSERT INTO `gen_table_column` VALUES ('48beef41b17356f85294f258b3276dac', 'ffb3c3a9e232ba193239368e8dde0bbc', 'anchor_amount', '虚拟人物', NULL, 'int(1)', 'Integer', 'anchorAmount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 1, NULL, '1', '2020-09-05 00:35:41.223', '1', '2020-09-05 00:35:41.168', '0');
INSERT INTO `gen_table_column` VALUES ('4a8e62ed38a78f8d4131a8b6e0477a6c', '1eec05bedee2b1e0afea533a49692321', 'version', '默认0，必填，离线乐观锁', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 70, 0, NULL, '1', '2020-08-29 23:57:31.150', '1', '2020-08-29 23:57:31.150', '0');
INSERT INTO `gen_table_column` VALUES ('4f7841b2c1fcd8ae740fc63a785b5f2b', 'ffb3c3a9e232ba193239368e8dde0bbc', 'name', '套餐名', NULL, 'varchar(32)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 210, 1, NULL, '1', '2020-09-05 00:35:41.225', '1', '2020-09-05 00:35:41.220', '0');
INSERT INTO `gen_table_column` VALUES ('4f9c599b6a7f16939783ee9dad262c9d', '61253a55e25426b602fc9ad8ec1a0fe2', 'created_date', '创建时间', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 110, 1, NULL, '1', '2020-08-16 16:33:00.415', '1', '2020-08-16 16:33:00.392', '0');
INSERT INTO `gen_table_column` VALUES ('50ac1d82b51a07e0a60d101eca38e635', '61253a55e25426b602fc9ad8ec1a0fe2', 'version', 'version', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 150, 1, NULL, '1', '2020-08-16 16:33:00.416', '1', '2020-08-16 16:33:00.408', '0');
INSERT INTO `gen_table_column` VALUES ('5143cd1cffbc915b5796c5668e12d72d', '3758a93f20975e49d4e7b70c94a3b48a', 'name', '名称', NULL, 'varchar(50)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 40, 0, NULL, '1', '2020-08-08 20:13:49.061', '1', '2020-08-08 20:13:49.061', '0');
INSERT INTO `gen_table_column` VALUES ('5347baea6984d90d09d93a6e8e8d9e66', '3758a93f20975e49d4e7b70c94a3b48a', 'reset_date', 'reset_date', NULL, 'timestamp(3)', 'java.util.Date', 'resetDate', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'dateselect', '', NULL, 110, 0, NULL, '1', '2020-08-08 20:13:49.073', '1', '2020-08-08 20:13:49.073', '0');
INSERT INTO `gen_table_column` VALUES ('542ddbae304942e0dfd2aff50879fe15', '78fb5944ba909cadb39f40a777906027', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 0, NULL, '1', '2020-09-02 13:51:05.288', '1', '2020-09-02 13:51:05.288', '0');
INSERT INTO `gen_table_column` VALUES ('58cf4c26609810773bd6748e223d7c87', '1eec05bedee2b1e0afea533a49692321', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 120, 0, NULL, '1', '2020-08-29 23:57:31.158', '1', '2020-08-29 23:57:31.158', '0');
INSERT INTO `gen_table_column` VALUES ('58ee7ccededdc0aa4f94c06c56f00a1d', '1eec05bedee2b1e0afea533a49692321', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 110, 0, NULL, '1', '2020-08-29 23:57:31.157', '1', '2020-08-29 23:57:31.157', '0');
INSERT INTO `gen_table_column` VALUES ('5dfd70106a436573b850457f5b138101', '3758a93f20975e49d4e7b70c94a3b48a', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 130, 0, NULL, '1', '2020-08-08 20:13:49.075', '1', '2020-08-08 20:13:49.075', '0');
INSERT INTO `gen_table_column` VALUES ('5f9b38b4aefc0dd1783144bdc5438b58', '61253a55e25426b602fc9ad8ec1a0fe2', 'last_modified_date', '修改时间', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 130, 1, NULL, '1', '2020-08-16 16:33:00.415', '1', '2020-08-16 16:33:00.400', '0');
INSERT INTO `gen_table_column` VALUES ('606f063821a67a1d5ea9c1787088ab9f', '3758a93f20975e49d4e7b70c94a3b48a', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 160, 0, NULL, '1', '2020-08-08 20:13:49.078', '1', '2020-08-08 20:13:49.078', '0');
INSERT INTO `gen_table_column` VALUES ('626d7f54f40e8babcf4dc04eefbce794', '78fb5944ba909cadb39f40a777906027', 'phone', '手机号', NULL, 'varchar(20)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 40, 0, NULL, '1', '2020-09-02 13:51:05.284', '1', '2020-09-02 13:51:05.284', '0');
INSERT INTO `gen_table_column` VALUES ('6480ee5226c0fdd4a190e165ff049bcc', '78fb5944ba909cadb39f40a777906027', 'id', '编号', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1', '2020-09-02 13:51:05.277', '1', '2020-09-02 13:51:05.277', '0');
INSERT INTO `gen_table_column` VALUES ('64e0b1b982baf11b0dc7ec1a61931765', '3758a93f20975e49d4e7b70c94a3b48a', 'number', 'key', NULL, 'int(11)', 'Long', 'number', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 0, NULL, '1', '2020-08-08 20:13:49.068', '1', '2020-08-08 20:13:49.068', '0');
INSERT INTO `gen_table_column` VALUES ('65e51a8ae8149ba24eb5db948bcce430', '1eec05bedee2b1e0afea533a49692321', 'outer_id', '购买id', NULL, 'varchar(500)', 'String', 'outerId', b'0', b'0', b'1', b'1', b'0', b'1', b'0', 'eq', 'input', '', NULL, 50, 0, NULL, '1', '2020-08-29 23:57:31.147', '1', '2020-08-29 23:57:31.147', '0');
INSERT INTO `gen_table_column` VALUES ('6c14d4a5f77d9122052128f52a96c70d', '61253a55e25426b602fc9ad8ec1a0fe2', 'id', 'id', NULL, 'varchar(32)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 1, NULL, '1', '2020-08-16 16:33:00.412', '1', '2020-08-16 16:33:00.346', '0');
INSERT INTO `gen_table_column` VALUES ('74a931121de3dfad68816564a7c8f22f', '3758a93f20975e49d4e7b70c94a3b48a', 'version', 'version', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 170, 0, NULL, '1', '2020-08-08 20:13:49.079', '1', '2020-08-08 20:13:49.079', '0');
INSERT INTO `gen_table_column` VALUES ('755d8e950e0bfd400ef6d870cf91d019', '3758a93f20975e49d4e7b70c94a3b48a', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 180, 0, NULL, '1', '2020-08-08 20:13:49.081', '1', '2020-08-08 20:13:49.081', '0');
INSERT INTO `gen_table_column` VALUES ('7a49d65551038de97ee4b4940d1d8f32', '61253a55e25426b602fc9ad8ec1a0fe2', 'company_phone', '公司电话', NULL, 'varchar(255)', 'String', 'companyPhone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 1, NULL, '1', '2020-08-16 16:33:00.414', '1', '2020-08-16 16:33:00.374', '0');
INSERT INTO `gen_table_column` VALUES ('7a730202e2e2876bd481706c99af8b01', 'ffb3c3a9e232ba193239368e8dde0bbc', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 150, 1, NULL, '1', '2020-09-05 00:35:41.224', '1', '2020-09-05 00:35:41.195', '0');
INSERT INTO `gen_table_column` VALUES ('7e1ab0101c8b87603b7c7d4c6b8a5aa0', 'ce24de2f484575934f17dc1efe204b15', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 130, 0, NULL, '1', '2020-08-18 10:19:05.102', '1', '2020-08-18 10:19:05.102', '0');
INSERT INTO `gen_table_column` VALUES ('7f116f8ab2b70f98ac4920c6eb97a01c', 'ffb3c3a9e232ba193239368e8dde0bbc', 'child_account', '子账户数量', NULL, 'int(1)', 'Integer', 'childAccount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 1, NULL, '1', '2020-09-05 00:35:41.222', '1', '2020-09-05 00:35:41.148', '0');
INSERT INTO `gen_table_column` VALUES ('8b87bdb55205bceed4997f60c2ed0555', 'ffb3c3a9e232ba193239368e8dde0bbc', 'storage', '存储空间，单位GB', NULL, 'int(1)', 'Integer', 'storage', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 70, 1, NULL, '1', '2020-09-05 00:35:41.222', '1', '2020-09-05 00:35:41.159', '0');
INSERT INTO `gen_table_column` VALUES ('8cedda980f0a34bc1bac826f9fc0d771', 'ce24de2f484575934f17dc1efe204b15', 'user_id', 'user_id', NULL, 'varchar(200)', 'String', 'userId', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 30, 0, NULL, '1', '2020-08-18 10:19:05.090', '1', '2020-08-18 10:19:05.090', '0');
INSERT INTO `gen_table_column` VALUES ('9017654f1397bf88fb65ca7ae07a4dbb', '61253a55e25426b602fc9ad8ec1a0fe2', 'account_number', '开户账号', NULL, 'varchar(32)', 'String', 'accountNumber', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 90, 1, NULL, '1', '2020-08-16 16:33:00.415', '1', '2020-08-16 16:33:00.384', '0');
INSERT INTO `gen_table_column` VALUES ('934093626299155157819045499afb9f', 'ffb3c3a9e232ba193239368e8dde0bbc', 'price', '套餐价格', NULL, 'decimal(18,2)', 'Double', 'price', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 20, 1, NULL, '1', '2020-09-05 00:35:41.221', '1', '2020-09-05 00:35:41.135', '0');
INSERT INTO `gen_table_column` VALUES ('936b7d7176eca6626aa8ca27570a0669', '61253a55e25426b602fc9ad8ec1a0fe2', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 100, 1, NULL, '1', '2020-08-16 16:33:00.415', '1', '2020-08-16 16:33:00.388', '0');
INSERT INTO `gen_table_column` VALUES ('97f71addc03895e06857fc6fa543e017', 'ffb3c3a9e232ba193239368e8dde0bbc', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 200, 1, NULL, '1', '2020-09-05 00:35:41.225', '1', '2020-09-05 00:35:41.216', '0');
INSERT INTO `gen_table_column` VALUES ('a0148bf818e1752d63610c6513f46266', 'feab203bec1c4a18ba5637fae1892fc7', 'name', '类型', NULL, 'varchar(20)', 'String', 'name', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 30, 1, NULL, '1', '2020-09-04 20:35:42.603', '1', '2020-09-04 20:35:42.581', '0');
INSERT INTO `gen_table_column` VALUES ('a17c7e8011ab26c825621133d05f64de', 'ffb3c3a9e232ba193239368e8dde0bbc', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 180, 1, NULL, '1', '2020-09-05 00:35:41.224', '1', '2020-09-05 00:35:41.208', '0');
INSERT INTO `gen_table_column` VALUES ('a1d6f9e1c84f9534e774f754a2116893', 'feab203bec1c4a18ba5637fae1892fc7', 'type', '增值服务类型', NULL, 'varchar(20)', 'String', 'type', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 40, 1, NULL, '1', '2020-09-04 20:35:42.603', '1', '2020-09-04 20:35:42.589', '0');
INSERT INTO `gen_table_column` VALUES ('a2ee40a54d651010937db3e7623ea8d3', '3758a93f20975e49d4e7b70c94a3b48a', 'phone', '手机', NULL, 'varchar(32)', 'String', 'phone', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 60, 0, NULL, '1', '2020-08-08 20:13:49.065', '1', '2020-08-08 20:13:49.065', '0');
INSERT INTO `gen_table_column` VALUES ('a7bf8acec683db646ecd18282cee992a', '1eec05bedee2b1e0afea533a49692321', 'user_id', '购买的用户id', NULL, 'varchar(64)', 'String', 'userId', b'0', b'0', b'1', b'1', b'0', b'1', b'0', 'eq', 'input', '', NULL, 20, 0, NULL, '1', '2020-08-29 23:57:31.142', '1', '2020-08-29 23:57:31.142', '0');
INSERT INTO `gen_table_column` VALUES ('a8cff26533d60f9cdcc7bcb90940711a', '78fb5944ba909cadb39f40a777906027', 'created_date', 'created_date', NULL, 'timestamp(3)', 'java.util.Date', 'createdDate', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 90, 0, NULL, '1', '2020-09-02 13:51:05.291', '1', '2020-09-02 13:51:05.291', '0');
INSERT INTO `gen_table_column` VALUES ('abf0cf86656265a71deb0d1020dca62c', 'ce24de2f484575934f17dc1efe204b15', 'last_modified_date', 'last_modified_date', NULL, 'timestamp(3)', 'java.util.Date', 'lastModifiedDate', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'dateselect', '', NULL, 120, 0, NULL, '1', '2020-08-18 10:19:05.101', '1', '2020-08-18 10:19:05.101', '0');
INSERT INTO `gen_table_column` VALUES ('ada9670b061c793ae860ee2452f127c4', 'ffb3c3a9e232ba193239368e8dde0bbc', 'env_amount', '虚拟场景个数', NULL, 'int(1)', 'Integer', 'envAmount', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 100, 1, NULL, '1', '2020-09-05 00:35:41.223', '1', '2020-09-05 00:35:41.173', '0');
INSERT INTO `gen_table_column` VALUES ('af237e589793dfc3e56b9365060e8eb3', '1eec05bedee2b1e0afea533a49692321', 'out_trade_no', '对接支付宝id', NULL, 'varchar(64)', 'String', 'outTradeNo', b'0', b'0', b'1', b'1', b'0', b'1', b'0', 'eq', 'input', '', NULL, 30, 0, NULL, '1', '2020-08-29 23:57:31.144', '1', '2020-08-29 23:57:31.144', '0');
INSERT INTO `gen_table_column` VALUES ('b8209cdc4a79e4de1eccef337d16bab8', '78fb5944ba909cadb39f40a777906027', 'version', '默认0，必填，离线乐观锁', NULL, 'int(11)', 'Long', 'version', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 60, 0, NULL, '1', '2020-09-02 13:51:05.287', '1', '2020-09-02 13:51:05.287', '0');
INSERT INTO `gen_table_column` VALUES ('b8a19ab6f74553a6aade179752939610', 'feab203bec1c4a18ba5637fae1892fc7', 'title', '表单名称', NULL, 'varchar(30)', 'String', 'title', b'0', b'0', b'1', b'1', b'1', b'1', b'1', 'like', 'input', '', NULL, 60, 1, NULL, '1', '2020-09-04 20:35:42.604', '1', '2020-09-04 20:35:42.601', '0');
INSERT INTO `gen_table_column` VALUES ('bb0cf806cf9a83746256943a8cf2a0fd', '61253a55e25426b602fc9ad8ec1a0fe2', 'account_bank', '开户公司', NULL, 'varchar(255)', 'String', 'accountBank', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 1, NULL, '1', '2020-08-16 16:33:00.414', '1', '2020-08-16 16:33:00.379', '0');
INSERT INTO `gen_table_column` VALUES ('be17f99651806ea08e2c82da1000907c', 'feab203bec1c4a18ba5637fae1892fc7', 'value', '具体名称', NULL, 'varchar(20)', 'String', 'value', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 20, 1, NULL, '1', '2020-09-04 20:35:42.602', '1', '2020-09-04 20:35:42.574', '0');
INSERT INTO `gen_table_column` VALUES ('c10aba3b3bc71c3efad1719ca4892f1c', 'feab203bec1c4a18ba5637fae1892fc7', 'url', '图片链接', NULL, 'varchar(20)', 'String', 'url', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 1, NULL, '1', '2020-09-04 20:35:42.604', '1', '2020-09-04 20:35:42.596', '0');
INSERT INTO `gen_table_column` VALUES ('c2de95e47a5d4be14826f9b1127aceaf', 'ffb3c3a9e232ba193239368e8dde0bbc', 'history', '历史版本数', NULL, 'int(1)', 'Integer', 'history', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 80, 1, NULL, '1', '2020-09-05 00:35:41.223', '1', '2020-09-05 00:35:41.163', '0');
INSERT INTO `gen_table_column` VALUES ('cc6add0b00a87e0ec7f6b716a347774a', '61253a55e25426b602fc9ad8ec1a0fe2', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'1', b'0', b'0', 'eq', 'input', '', NULL, 140, 1, NULL, '1', '2020-08-16 16:33:00.416', '1', '2020-08-16 16:33:00.404', '0');
INSERT INTO `gen_table_column` VALUES ('cee9a218e6a82853dd3ea563fbb82984', '61253a55e25426b602fc9ad8ec1a0fe2', 'del_flag', '0-正常，1-删除', NULL, 'char(1)', 'String', 'delFlag', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'radio', 'sys_flag', NULL, 160, 1, NULL, '1', '2020-08-16 16:33:00.416', '1', '2020-08-16 16:33:00.412', '0');
INSERT INTO `gen_table_column` VALUES ('d6c4cd3a59395c1de959d0c367fcc3d7', '1eec05bedee2b1e0afea533a49692321', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 80, 0, NULL, '1', '2020-08-29 23:57:31.152', '1', '2020-08-29 23:57:31.152', '0');
INSERT INTO `gen_table_column` VALUES ('db711bb3cf0ecc3482ba7a08ff5578a5', '61253a55e25426b602fc9ad8ec1a0fe2', 'tax_num', '公司税号', NULL, 'varchar(0)', 'String', 'taxNum', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 1, NULL, '1', '2020-08-16 16:33:00.414', '1', '2020-08-16 16:33:00.365', '0');
INSERT INTO `gen_table_column` VALUES ('e34b427c506ec16c3d1e7598facbbc20', 'ce24de2f484575934f17dc1efe204b15', 'labels', '标签文本', NULL, 'text', 'String', 'labels', b'0', b'0', b'0', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 20, 0, NULL, '1', '2020-08-18 10:19:05.089', '1', '2020-08-18 10:19:05.089', '0');
INSERT INTO `gen_table_column` VALUES ('e4974f6bccba16349313b9614602ce1f', '3758a93f20975e49d4e7b70c94a3b48a', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 140, 0, NULL, '1', '2020-08-08 20:13:49.076', '1', '2020-08-08 20:13:49.076', '0');
INSERT INTO `gen_table_column` VALUES ('eeb04a569c8034330c11878efc1e6fad', 'ce24de2f484575934f17dc1efe204b15', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 110, 0, NULL, '1', '2020-08-18 10:19:05.100', '1', '2020-08-18 10:19:05.100', '0');
INSERT INTO `gen_table_column` VALUES ('ef0a7646ab33bf706ade6b43da32714e', 'ce24de2f484575934f17dc1efe204b15', 'seat', '活力青春', NULL, 'varchar(20)', 'String', 'seat', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 50, 0, NULL, '1', '2020-08-18 10:19:05.092', '1', '2020-08-18 10:19:05.092', '0');
INSERT INTO `gen_table_column` VALUES ('f1b6733ef6ff05dc24537b7e756cd14a', 'ffb3c3a9e232ba193239368e8dde0bbc', 'env_amount_plus', '存储空间，单位GB', NULL, 'int(1)', 'Integer', 'envAmountPlus', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 120, 1, NULL, '1', '2020-09-05 00:35:41.223', '1', '2020-09-05 00:35:41.182', '0');
INSERT INTO `gen_table_column` VALUES ('f1bf06dc42fd71dbd416c6e691325e37', '1eec05bedee2b1e0afea533a49692321', 'id', '编号', NULL, 'varchar(64)', 'String', 'id', b'1', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 10, 0, NULL, '1', '2020-08-29 23:57:31.139', '1', '2020-08-29 23:57:31.139', '0');
INSERT INTO `gen_table_column` VALUES ('f3db85329d84e370812c61edc27434f3', 'ffb3c3a9e232ba193239368e8dde0bbc', 'times', '可下单次数', NULL, 'int(1)', 'Integer', 'times', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 130, 1, NULL, '1', '2020-09-05 00:35:41.224', '1', '2020-09-05 00:35:41.186', '0');
INSERT INTO `gen_table_column` VALUES ('f421007ba48e893e5fe549901c40a16e', '1eec05bedee2b1e0afea533a49692321', 'type', '购买类型', NULL, 'char(2)', 'String', 'type', b'0', b'0', b'1', b'1', b'0', b'1', b'0', 'eq', 'input', '', NULL, 40, 0, NULL, '1', '2020-08-29 23:57:31.145', '1', '2020-08-29 23:57:31.145', '0');
INSERT INTO `gen_table_column` VALUES ('f59973ea5cfe6ad750c2e0a281f37e83', 'ffb3c3a9e232ba193239368e8dde0bbc', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 160, 1, NULL, '1', '2020-09-05 00:35:41.224', '1', '2020-09-05 00:35:41.199', '0');
INSERT INTO `gen_table_column` VALUES ('f6325bff75fa2e8c4269937c7b6d623c', 'ce24de2f484575934f17dc1efe204b15', 'anchor_num', '是否站立，0站1坐', NULL, 'varchar(500)', 'String', 'anchorNum', b'0', b'0', b'1', b'1', b'1', b'1', b'0', 'eq', 'input', '', NULL, 40, 0, NULL, '1', '2020-08-18 10:19:05.091', '1', '2020-08-18 10:19:05.091', '0');
INSERT INTO `gen_table_column` VALUES ('f7466843afc4fbc1f62a110ade1fb01b', '3758a93f20975e49d4e7b70c94a3b48a', 'created_by', 'created_by', NULL, 'varchar(50)', 'String', 'createdBy', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 0, NULL, '1', '2020-08-08 20:13:49.074', '1', '2020-08-08 20:13:49.074', '0');
INSERT INTO `gen_table_column` VALUES ('f74d64b6c62c078e6d5bed58e05fffe9', 'ce24de2f484575934f17dc1efe204b15', 'description', '备注', NULL, 'varchar(255)', 'String', 'description', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 80, 0, NULL, '1', '2020-08-18 10:19:05.097', '1', '2020-08-18 10:19:05.097', '0');
INSERT INTO `gen_table_column` VALUES ('f8e52b7709cf81c6887ed6620fa939ff', '61253a55e25426b602fc9ad8ec1a0fe2', 'last_modified_by', 'last_modified_by', NULL, 'varchar(50)', 'String', 'lastModifiedBy', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 120, 1, NULL, '1', '2020-08-16 16:33:00.415', '1', '2020-08-16 16:33:00.396', '0');
INSERT INTO `gen_table_column` VALUES ('f982112df668deaeb05048067dbd9b18', '61253a55e25426b602fc9ad8ec1a0fe2', 'type', '税号类型', NULL, 'int(0)', 'Integer', 'type', b'0', b'0', b'0', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 30, 1, NULL, '1', '2020-08-16 16:33:00.413', '1', '2020-08-16 16:33:00.356', '0');
INSERT INTO `gen_table_column` VALUES ('fad54921ddaf7ca973080d0be1fc318e', '61253a55e25426b602fc9ad8ec1a0fe2', 'user_id', '用户', NULL, 'varchar(32)', 'String', 'userId', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 20, 1, NULL, '1', '2020-08-16 16:33:00.413', '1', '2020-08-16 16:33:00.352', '0');
INSERT INTO `gen_table_column` VALUES ('ff769f8751bd0699ba3f9eaeb30dcbe2', 'ce24de2f484575934f17dc1efe204b15', 'plus_service', 'vip服务', NULL, 'varchar(100)', 'String', 'plusService', b'0', b'0', b'1', b'1', b'0', b'0', b'0', 'eq', 'input', '', NULL, 70, 0, NULL, '1', '2020-08-18 10:19:05.096', '1', '2020-08-18 10:19:05.096', '0');
COMMIT;

-- ----------------------------
-- Table structure for gen_table_fk
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_fk`;
CREATE TABLE `gen_table_fk` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `gen_table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
  `name` varchar(200) DEFAULT NULL COMMENT '名称',
  `comments` varchar(500) DEFAULT NULL COMMENT '描述',
  `jdbc_type` varchar(100) DEFAULT NULL COMMENT '列的数据类型的字节长度',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键',
  `is_unique` char(1) DEFAULT '0' COMMENT '是否唯一（1：是；0：否）',
  `is_null` char(1) DEFAULT NULL COMMENT '是否可为空',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段',
  `query_type` varchar(200) DEFAULT NULL COMMENT '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
  `show_type` varchar(200) DEFAULT NULL COMMENT '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
  `dict_type` varchar(200) DEFAULT NULL COMMENT '字典类型',
  `settings` varchar(2000) DEFAULT NULL COMMENT '其它设置（扩展字段JSON）',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `version` int(11) DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `gen_table_column_table_id` (`gen_table_id`) USING BTREE,
  KEY `gen_table_column_name` (`name`) USING BTREE,
  KEY `gen_table_column_sort` (`sort`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='业务表字段';

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `blob_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL,
  `calendar_name` varchar(200) NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`,`calendar_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `cron_expression` varchar(200) NOT NULL,
  `time_zone_id` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `entry_id` varchar(95) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `fired_time` bigint(20) NOT NULL,
  `sched_time` bigint(20) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) NOT NULL,
  `job_name` varchar(200) DEFAULT NULL,
  `job_group` varchar(200) DEFAULT NULL,
  `is_nonconcurrent` varchar(1) DEFAULT NULL,
  `requests_recovery` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`entry_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `job_class_name` varchar(250) NOT NULL,
  `is_durable` varchar(1) NOT NULL,
  `is_nonconcurrent` varchar(1) NOT NULL,
  `is_update_data` varchar(1) NOT NULL,
  `requests_recovery` varchar(1) NOT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) NOT NULL,
  `lock_name` varchar(40) NOT NULL,
  PRIMARY KEY (`sched_name`,`lock_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_group`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `last_checkin_time` bigint(20) NOT NULL,
  `checkin_interval` bigint(20) NOT NULL,
  PRIMARY KEY (`sched_name`,`instance_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `repeat_count` bigint(20) NOT NULL,
  `repeat_interval` bigint(20) NOT NULL,
  `times_triggered` bigint(20) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `str_prop_1` varchar(512) DEFAULT NULL,
  `str_prop_2` varchar(512) DEFAULT NULL,
  `str_prop_3` varchar(512) DEFAULT NULL,
  `int_prop_1` int(11) DEFAULT NULL,
  `int_prop_2` int(11) DEFAULT NULL,
  `long_prop_1` bigint(20) DEFAULT NULL,
  `long_prop_2` bigint(20) DEFAULT NULL,
  `dec_prop_1` decimal(13,4) DEFAULT NULL,
  `dec_prop_2` decimal(13,4) DEFAULT NULL,
  `bool_prop_1` varchar(1) DEFAULT NULL,
  `bool_prop_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `next_fire_time` bigint(20) DEFAULT NULL,
  `prev_fire_time` bigint(20) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `trigger_state` varchar(16) NOT NULL,
  `trigger_type` varchar(8) NOT NULL,
  `start_time` bigint(20) NOT NULL,
  `end_time` bigint(20) DEFAULT NULL,
  `calendar_name` varchar(200) DEFAULT NULL,
  `misfire_instr` smallint(6) DEFAULT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `id` varchar(32) DEFAULT NULL,
  `parent_id` varchar(32) DEFAULT NULL,
  `parent_ids` varchar(2000) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `leaf` bit(1) DEFAULT NULL,
  `available` char(1) DEFAULT NULL,
  `created_by` varchar(50) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp NULL DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `del_flag` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='部门管理';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` VALUES ('1', '-1', NULL, '总部', 30, b'0', '1', '1', '2020-05-15 11:26:57', '1', '2020-05-20 12:09:24', 12, '', '0');
INSERT INTO `sys_dept` VALUES ('4981e65fbb6059f3a5ceddd6b3426e6d', '9e4dcac1683359bfeac1871ccdc29e9f', '9e4dcac1683359bfeac1871ccdc29e9f,', 'ddd', 1, b'1', '1', '1', '2020-05-15 12:05:18', '1', '2020-05-15 12:05:24', 0, NULL, '1');
INSERT INTO `sys_dept` VALUES ('6304292a4ecb1448c33447adc0c35f08', '1', '1,', '运营部', 30, b'1', '1', '1', '2020-05-15 12:03:47', '1', '2020-05-15 14:27:12', 2, '', '0');
INSERT INTO `sys_dept` VALUES ('701903b72179df2c79d383f621eab9c8', '1', '1,', 'AI部', 30, b'1', '1', '1', '2020-05-15 12:04:11', '1', '2020-05-15 12:04:11', 0, NULL, '0');
INSERT INTO `sys_dept` VALUES ('9e4dcac1683359bfeac1871ccdc29e9f', '-1', NULL, 'test', 1, b'0', '1', '1', '2020-05-15 12:05:06', '1', '2020-05-15 12:05:24', 1, NULL, '1');
INSERT INTO `sys_dept` VALUES ('c095173c3aebcd7ff9c6177fbf7a8b69', '-1', NULL, '平台', 30, b'1', '1', '1', '2020-05-15 11:28:08', '1', '2020-05-15 12:04:55', 2, NULL, '0');
INSERT INTO `sys_dept` VALUES ('db32c981785f619401518127c48b6247', '1', '1,', '测试部', 30, b'1', '1', '1', '2020-05-15 12:03:57', '1', '2020-05-15 12:03:57', 0, NULL, '0');
INSERT INTO `sys_dept` VALUES ('f52e1e844bf0fbadf5213214fb621e27', '1', '1,', '开发部', 30, b'1', '1', '1', '2020-05-15 12:03:24', '1', '2020-05-20 12:09:24', 3, NULL, '0');
INSERT INTO `sys_dept` VALUES ('4d20ae207d9c836a732480429af58273', '-1', NULL, '公共部门', 30, b'1', '1', '1', '2020-08-30 10:03:12', '1', '2020-08-30 10:03:12', 0, '无企业的用户', '0');
INSERT INTO `sys_dept` VALUES ('1e0a3c1bb3ee99bd69db293b4c487e30', NULL, NULL, 'ABC商城', 30, b'0', '1', 'system', '2020-09-04 23:31:57', 'system', '2020-09-04 23:31:57', 0, NULL, '0');
INSERT INTO `sys_dept` VALUES ('b44632273ec93e62595dee2c7b65c90a', NULL, NULL, 'ABC商城2', 30, b'0', '1', 'system', '2020-09-04 23:59:21', 'system', '2020-09-04 23:59:21', 0, NULL, '0');
INSERT INTO `sys_dept` VALUES ('4ec5d159e0c8196f2b4e0c8dc117639e', NULL, NULL, 'ABC商城', 30, b'0', '1', 'system', '2020-09-05 00:01:34', 'system', '2020-09-05 00:01:34', 0, NULL, '0');
INSERT INTO `sys_dept` VALUES ('5d675ff6a074c891fd1cd3e713198d34', NULL, NULL, 'ABC商城', 30, b'0', '1', 'system', '2020-09-05 00:06:15', 'system', '2020-09-05 00:06:15', 0, NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_dept_relation
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_relation`;
CREATE TABLE `sys_dept_relation` (
  `ancestor` varchar(32) NOT NULL COMMENT '祖先节点',
  `descendant` varchar(32) NOT NULL COMMENT '后代节点',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`ancestor`,`descendant`) USING BTREE,
  KEY `idx1` (`ancestor`) USING BTREE,
  KEY `idx2` (`descendant`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='部门关系表';

-- ----------------------------
-- Records of sys_dept_relation
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept_relation` VALUES ('1', '1', '0');
INSERT INTO `sys_dept_relation` VALUES ('1', '6304292a4ecb1448c33447adc0c35f08', '0');
INSERT INTO `sys_dept_relation` VALUES ('1', '701903b72179df2c79d383f621eab9c8', '0');
INSERT INTO `sys_dept_relation` VALUES ('1', 'db32c981785f619401518127c48b6247', '0');
INSERT INTO `sys_dept_relation` VALUES ('1', 'f52e1e844bf0fbadf5213214fb621e27', '0');
INSERT INTO `sys_dept_relation` VALUES ('4981e65fbb6059f3a5ceddd6b3426e6d', '4981e65fbb6059f3a5ceddd6b3426e6d', '1');
INSERT INTO `sys_dept_relation` VALUES ('4d20ae207d9c836a732480429af58273', '4d20ae207d9c836a732480429af58273', '0');
INSERT INTO `sys_dept_relation` VALUES ('6304292a4ecb1448c33447adc0c35f08', '6304292a4ecb1448c33447adc0c35f08', '0');
INSERT INTO `sys_dept_relation` VALUES ('701903b72179df2c79d383f621eab9c8', '701903b72179df2c79d383f621eab9c8', '0');
INSERT INTO `sys_dept_relation` VALUES ('9e4dcac1683359bfeac1871ccdc29e9f', '4981e65fbb6059f3a5ceddd6b3426e6d', '1');
INSERT INTO `sys_dept_relation` VALUES ('9e4dcac1683359bfeac1871ccdc29e9f', '9e4dcac1683359bfeac1871ccdc29e9f', '1');
INSERT INTO `sys_dept_relation` VALUES ('c095173c3aebcd7ff9c6177fbf7a8b69', 'c095173c3aebcd7ff9c6177fbf7a8b69', '0');
INSERT INTO `sys_dept_relation` VALUES ('db32c981785f619401518127c48b6247', 'db32c981785f619401518127c48b6247', '0');
INSERT INTO `sys_dept_relation` VALUES ('f1cdcc5e55db0fb446acc79596e2c39a', 'f1cdcc5e55db0fb446acc79596e2c39a', '0');
INSERT INTO `sys_dept_relation` VALUES ('f52e1e844bf0fbadf5213214fb621e27', 'f52e1e844bf0fbadf5213214fb621e27', '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` varchar(32) NOT NULL COMMENT '编号',
  `name` varchar(100) NOT NULL COMMENT '标签名',
  `val` varchar(100) DEFAULT NULL COMMENT '数据值',
  `code` varchar(100) NOT NULL COMMENT '类型',
  `parent_id` varchar(32) DEFAULT NULL COMMENT '父菜单ID',
  `parent_ids` varchar(2000) DEFAULT NULL COMMENT '父菜单IDs',
  `sort` int(11) NOT NULL COMMENT '排序（升序）',
  `available` bit(1) DEFAULT b'1' COMMENT '是否显示1 是0否',
  `leaf` bit(1) DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
  `version` int(11) NOT NULL DEFAULT '0',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_dict_value` (`val`) USING BTREE,
  KEY `sys_dict_label` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict` VALUES ('05d01334ecdbe94b856038a32a42512b', '任务分组', NULL, 'quartz_job_group', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-15 16:33:54.745', '1', '2020-05-16 10:24:03.237', 9, NULL, '0');
INSERT INTO `sys_dict` VALUES ('0b2420638683f1eec41242beb9912069', '在线', 'on_line', 'sys_online_status_on_line', 'f3592a047c466e348279983336ebaf28', '1,cfd5f62f601817a3b0f38f5ccb1f5128,f3592a047c466e348279983336ebaf28,', 30, b'1', b'1', '1', '2019-08-11 11:17:28.210', '1', '2020-05-15 20:54:54.622', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('0da02abef85f0c0b4350eaeefb4ca78d', '仅本人数据', '4', 'sys_data_scope_4', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 40, b'1', b'1', '1', '2019-07-14 06:00:03.000', '1', '2020-05-15 20:54:54.622', 7, NULL, '0');
INSERT INTO `sys_dict` VALUES ('0ef7242f2bb88fdbdcbc56e7a879efb0', '查看', 'VIEW', 'sys_business_type_view', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 10, b'1', b'1', '1', '2019-08-07 16:49:39.000', '1', '2020-05-17 13:48:58.580', 8, NULL, '0');
INSERT INTO `sys_dict` VALUES ('0fdd548394368b4969136f32c435fd98', '菜单', '1', 'sys_menu_type_1', 'e26ee931e276a099fb876541ca18756f', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 20, b'1', b'1', '1', '2019-07-14 06:04:44.000', '1', '2020-05-15 21:02:26.017', 7, NULL, '0');
INSERT INTO `sys_dict` VALUES ('1', '数据字典', '', 'base', '-1', NULL, 1, b'1', b'0', '1', '2018-07-09 06:16:14.000', '1', '2020-05-25 11:30:54.943', 16, '', '0');
INSERT INTO `sys_dict` VALUES ('13276f100593667c3bd40ab8fea734b4', '立即执行', '1', 'quartz_misfire_policy_1', 'cb3d07975904460c94e9e2b30755c04b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,cb3d07975904460c94e9e2b30755c04b,', 10, b'1', b'1', '1', '2019-08-15 10:24:19.706', '1', '2020-05-16 11:22:07.230', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('181dd29afa852bd47a5ae8dd2e02a623', '正常', '1', 'sys_status_1', '952c07b027bf0be298a9243af701b8c5', '1,cfd5f62f601817a3b0f38f5ccb1f5128,952c07b027bf0be298a9243af701b8c5,', 30, b'1', b'1', '1', '2019-08-14 11:28:01.693', '1', '2020-05-15 20:54:54.622', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('2', '是否标识', '', 'sys_flag', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 10, b'1', b'0', '1', '2019-06-02 17:17:44.000', '1', '2020-05-15 20:54:54.622', 19, NULL, '0');
INSERT INTO `sys_dict` VALUES ('269ebbfff898cf1db0d243e3f7774d2c', '业务数据', 'biz', 'biz', '1', '1,', 30, b'1', b'1', '1', '2019-07-14 04:01:51.000', '1', '2020-05-25 11:30:54.952', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('2ec9dffe7cb0dea12c8e4e2a90279711', '强退', 'FORCE_LOGOUT', 'sys_business_type_force_logout', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 70, b'1', b'1', '1', '2019-08-07 16:52:15.681', '1', '2020-05-17 13:50:42.409', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('3', '是', '1', 'sys_flag_yes', '2', '1,cfd5f62f601817a3b0f38f5ccb1f5128,2,', 10, b'1', b'1', '1', '2018-07-09 06:15:40.000', '1', '2020-05-15 20:54:54.622', 7, '', '0');
INSERT INTO `sys_dict` VALUES ('3190c222f999f9493e5773deec2d84f1', '登录', 'LOGIN', 'sys_business_type_login', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 100, b'0', b'1', '1', '2020-05-27 11:41:37.787', '1', '2020-05-29 22:29:29.992', 1, NULL, '0');
INSERT INTO `sys_dict` VALUES ('31d677b181cebb9bde79b78f32e1e8a3', '其他', 'OTHER', 'sys_operate_type_other', '6b8211aef2fec451b0398b19857443a7', '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 10, b'1', b'1', '1', '2019-08-07 16:48:21.644', '1', '2020-05-20 12:09:36.021', 6, NULL, '0');
INSERT INTO `sys_dict` VALUES ('356f3304462386a8827d44b9e6c9482c', '运行中', '1', 'quartz_job_status_1', 'c7243dfd9599957c281be8be786708d5', '1,cfd5f62f601817a3b0f38f5ccb1f5128,c7243dfd9599957c281be8be786708d5,', 10, b'1', b'1', '1', '2020-05-16 10:14:46.614', '1', '2020-05-16 10:31:32.619', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('3e949b67e0c5be3357bdcce9705f7433', '放弃执行', '3', 'quartz_misfire_policy_3', 'cb3d07975904460c94e9e2b30755c04b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,cb3d07975904460c94e9e2b30755c04b,', 30, b'1', b'1', '1', '2019-08-15 10:24:54.175', '1', '2020-05-16 11:21:48.328', 4, NULL, '0');
INSERT INTO `sys_dict` VALUES ('4', '否', '0', 'sys_flag_no', '2', '1,cfd5f62f601817a3b0f38f5ccb1f5128,2,', 30, b'1', b'1', '1', '2019-06-02 17:26:40.000', '1', '2020-05-15 20:54:54.622', 8, NULL, '0');
INSERT INTO `sys_dict` VALUES ('4198b5e10fe052546ebb689b4103590e', '所在机构数据', '3', 'sys_data_scope_3', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 30, b'1', b'1', '1', '2019-07-14 05:59:13.000', '1', '2020-05-15 20:54:54.622', 9, NULL, '0');
INSERT INTO `sys_dict` VALUES ('4ebd555fb352328cb2db93e15d3243ad', '系统', 'SYSTEM', 'quartz_job_group_system', '05d01334ecdbe94b856038a32a42512b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,05d01334ecdbe94b856038a32a42512b,', 20, b'1', b'1', '1', '2019-08-15 16:34:47.139', '1', '2020-05-16 10:23:56.949', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('51828811168cd9f0ee1d118068a7d0b9', '编辑', 'EDIT', 'sys_business_type_edit', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 20, b'1', b'1', '1', '2019-08-07 16:50:20.634', '1', '2020-05-17 13:49:05.059', 6, NULL, '0');
INSERT INTO `sys_dict` VALUES ('5933a853cd0199b00424d66f4b92dda3', '所在机构及以下数据', '2', 'sys_data_scope_2', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 20, b'1', b'1', '1', '2019-07-14 05:53:55.000', '1', '2020-05-15 20:54:54.622', 9, NULL, '0');
INSERT INTO `sys_dict` VALUES ('5f2414b2670c9a66c1d5364613caa654', '后台用户', 'MANAGE', 'sys_operate_type_manage', '6b8211aef2fec451b0398b19857443a7', '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 20, b'1', b'1', '1', '2019-08-07 16:48:40.344', '1', '2020-05-20 12:09:36.024', 6, NULL, '0');
INSERT INTO `sys_dict` VALUES ('6b8211aef2fec451b0398b19857443a7', '操作人类别', NULL, 'sys_operator_type', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-07 15:37:09.613', '1', '2020-05-20 12:09:36.011', 12, NULL, '0');
INSERT INTO `sys_dict` VALUES ('6e4bba74f32df9149d69f8e9bb19cd9d', '目录', '0', 'sys_menu_type_0', 'e26ee931e276a099fb876541ca18756f', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 10, b'1', b'1', '1', '2019-07-14 06:04:10.000', '1', '2020-05-15 21:02:15.230', 7, NULL, '0');
INSERT INTO `sys_dict` VALUES ('764d1eaf8a39698fc85a7204c96e7089', '生成代码', 'GEN_CODE', 'sys_business_type_gen_code', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 80, b'1', b'1', '1', '2019-08-07 16:52:36.997', '1', '2020-05-17 13:51:07.250', 6, NULL, '0');
INSERT INTO `sys_dict` VALUES ('80b084e162b0a30b348a45ff29e5b326', '导出', 'EXPORT', 'sys_business_type_export', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 50, b'1', b'1', '1', '2019-08-07 16:51:33.286', '1', '2020-05-17 13:49:43.288', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('8153bd2af73b6d59eed9f34d2bc05bb9', '删除', 'DELETE', 'sys_business_type_delete', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 40, b'1', b'1', '1', '2019-08-07 16:50:45.270', '1', '2020-05-17 13:48:51.169', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('8883abe4dcf9390df69a5740050abf74', '离线', 'off_line', 'sys_online_status_off_line', 'f3592a047c466e348279983336ebaf28', '1,cfd5f62f601817a3b0f38f5ccb1f5128,f3592a047c466e348279983336ebaf28,', 30, b'1', b'1', '1', '2019-08-11 11:17:50.132', '1', '2020-05-15 20:54:54.622', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('8c4589d0a32c9b84b6254507354a195b', 'test', 'test', 'test', '-1', NULL, 30, b'1', b'1', '1', '2019-07-14 03:59:38.000', '1', '2019-07-14 04:00:28.000', 0, NULL, '1');
INSERT INTO `sys_dict` VALUES ('94e00baf14b640d793c133fb7bfa4c9a', '默认', 'DEFAULT', 'quartz_job_group_default', '05d01334ecdbe94b856038a32a42512b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,05d01334ecdbe94b856038a32a42512b,', 10, b'1', b'1', '1', '2019-08-15 16:34:28.547', '1', '2020-05-16 10:24:03.248', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('952c07b027bf0be298a9243af701b8c5', '状态', NULL, 'sys_status', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-14 11:26:50.424', '1', '2020-05-15 20:54:54.622', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('a5dfce34bdb7aa99560e8c0d393a632f', '全部', '1', 'sys_data_scope_1', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 10, b'1', b'1', '1', '2019-07-14 05:52:44.000', '1', '2020-05-15 20:54:54.622', 9, NULL, '0');
INSERT INTO `sys_dict` VALUES ('aa294a48211a2deb5c7d76c5e90dc28e', '数据范围', '', 'sys_data_scope', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-07-14 05:50:08.000', '1', '2020-05-20 11:11:12.915', 19, NULL, '0');
INSERT INTO `sys_dict` VALUES ('b672448a74c1d1a47eb1378e3d8c6dc9', '导入', 'IMPORT', 'sys_business_type_import', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 60, b'1', b'1', '1', '2019-08-07 16:51:45.855', '1', '2020-05-17 13:50:08.748', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('bec679404aedc7e75eeeef2ac68d9107', '其他', 'OTHER', 'sys_business_type_other', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 90, b'1', b'1', '1', '2020-05-17 13:45:33.764', '1', '2020-05-17 13:49:14.282', 1, NULL, '0');
INSERT INTO `sys_dict` VALUES ('c46ec99af2c1f967bf10cf2c0d96a6c5', '按明细设置', '5', 'sys_data_scope_5', 'aa294a48211a2deb5c7d76c5e90dc28e', '1,cfd5f62f601817a3b0f38f5ccb1f5128,aa294a48211a2deb5c7d76c5e90dc28e,', 50, b'1', b'1', '1', '2019-07-14 06:01:11.000', '1', '2020-05-20 11:11:12.927', 8, NULL, '0');
INSERT INTO `sys_dict` VALUES ('c7243dfd9599957c281be8be786708d5', '任务状态', NULL, 'quartz_job_status', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2020-05-16 10:13:18.543', '1', '2020-05-16 10:31:43.851', 6, NULL, '0');
INSERT INTO `sys_dict` VALUES ('cb3d07975904460c94e9e2b30755c04b', '计划执行错误策略', NULL, 'quartz_misfire_policy', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-15 10:23:54.460', '1', '2020-05-16 11:22:16.976', 11, NULL, '0');
INSERT INTO `sys_dict` VALUES ('cfd5f62f601817a3b0f38f5ccb1f5128', '系统数据', 'sys', 'sys', '1', '1,', 30, b'1', b'0', '1', '2019-07-14 01:13:12.000', '1', '2020-05-20 12:09:35.998', 28, NULL, '0');
INSERT INTO `sys_dict` VALUES ('decc4b5f8996c755ba6e5a097486e362', '已暂停', '0', 'quartz_job_status_0', 'c7243dfd9599957c281be8be786708d5', '1,cfd5f62f601817a3b0f38f5ccb1f5128,c7243dfd9599957c281be8be786708d5,', 20, b'1', b'1', '1', '2020-05-16 10:15:08.604', '1', '2020-05-16 10:31:43.863', 2, NULL, '0');
INSERT INTO `sys_dict` VALUES ('e0696db908c87ad57a85c6b326348dbd', '业务操作类型', NULL, 'sys_business_type', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-07 15:33:35.000', '1', '2020-05-27 11:41:57.261', 36, NULL, '0');
INSERT INTO `sys_dict` VALUES ('e26ee931e276a099fb876541ca18756f', '菜单类型', '', 'sys_menu_type', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-07-14 06:01:48.000', '1', '2020-05-15 21:02:34.965', 14, NULL, '0');
INSERT INTO `sys_dict` VALUES ('e7891a6351a2e143899849b2955851b2', '锁定', 'LOCK', 'sys_business_type_lock', 'e0696db908c87ad57a85c6b326348dbd', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e0696db908c87ad57a85c6b326348dbd,', 30, b'1', b'1', '1', '2019-08-07 16:50:32.457', '1', '2020-05-17 13:49:23.225', 6, NULL, '0');
INSERT INTO `sys_dict` VALUES ('ef0368c6fd52ee8f1f4270869da00f18', '按钮', '2', 'sys_menu_type_2', 'e26ee931e276a099fb876541ca18756f', '1,cfd5f62f601817a3b0f38f5ccb1f5128,e26ee931e276a099fb876541ca18756f,', 30, b'1', b'1', '1', '2019-08-07 13:55:24.531', '1', '2020-05-15 21:02:34.974', 8, NULL, '0');
INSERT INTO `sys_dict` VALUES ('f3592a047c466e348279983336ebaf28', '在线状态', NULL, 'sys_online_status', 'cfd5f62f601817a3b0f38f5ccb1f5128', '1,cfd5f62f601817a3b0f38f5ccb1f5128,', 30, b'1', b'0', '1', '2019-08-11 11:16:52.095', '1', '2020-05-15 20:54:54.622', 4, NULL, '0');
INSERT INTO `sys_dict` VALUES ('f35adf75d9ab0ca5cec43815b7db5274', '执行一次', '2', 'quartz_misfire_policy_2', 'cb3d07975904460c94e9e2b30755c04b', '1,cfd5f62f601817a3b0f38f5ccb1f5128,cb3d07975904460c94e9e2b30755c04b,', 20, b'1', b'1', '1', '2019-08-15 10:24:39.273', '1', '2020-05-16 11:22:16.986', 5, NULL, '0');
INSERT INTO `sys_dict` VALUES ('f83a718756762758707c67db3d271c9d', '手机端用户', 'MOBILE', 'sys_operate_type_moblie', '6b8211aef2fec451b0398b19857443a7', '1,cfd5f62f601817a3b0f38f5ccb1f5128,6b8211aef2fec451b0398b19857443a7,', 30, b'1', b'1', '1', '2019-08-07 16:49:00.766', '1', '2020-05-20 12:09:36.025', 6, NULL, '0');
INSERT INTO `sys_dict` VALUES ('fafe8843b2f4091f8096dc0df09c300c', '失败', '0', 'sys_status_0', '952c07b027bf0be298a9243af701b8c5', '1,cfd5f62f601817a3b0f38f5ccb1f5128,952c07b027bf0be298a9243af701b8c5,', 30, b'1', b'1', '1', '2019-08-14 11:28:11.000', '1', '2020-05-15 20:54:54.622', 3, NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（1允许 0禁止）',
  `sub_task` varchar(100) DEFAULT NULL COMMENT '子任务id 多个用逗号隔开',
  `email` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '报警邮箱',
  `status` char(1) DEFAULT '0' COMMENT '状态(1-运行中，0-暂停)',
  `created_by` varchar(50) CHARACTER SET utf8 NOT NULL,
  `created_date` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `last_modified_date` datetime(3) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3),
  `description` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '描述',
  `version` int(11) NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
BEGIN;
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'simpleTask.doNoParams', '0/10 * * * * ?', '3', '1', '2', NULL, '0', '', '2019-08-14 10:21:36.000', '1', '2020-05-16 15:38:24.728', NULL, 9, '0');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(\'albedo\')', '0/15 * * * * ?', '3', '1', NULL, NULL, '0', '', '2019-08-14 10:21:36.950', '1', '2020-05-16 15:28:24.387', NULL, 18, '0');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'simpleTask.doMultipleParams(\'albedo\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', NULL, NULL, '0', '', '2019-08-14 10:21:36.000', '1', '2020-05-16 15:12:50.258', NULL, 4, '0');
INSERT INTO `sys_job` VALUES (4, 'test', 'DEFAULT', 'test', '0/20 * * * * ?', '2', '1', '1', NULL, '0', '1', '2020-05-16 15:06:05.098', '1', '2020-05-16 15:21:10.516', NULL, 1, '1');
COMMIT;

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `start_time` datetime(3) DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(3) DEFAULT NULL COMMENT '结束时间',
  `create_time` datetime(3) DEFAULT NULL COMMENT '创建时间',
  `exception_info` varchar(3000) DEFAULT '' COMMENT '异常信息',
  `description` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='定时任务调度日志表';

-- ----------------------------
-- Table structure for sys_log_operate
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_operate`;
CREATE TABLE `sys_log_operate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `title` varchar(255) DEFAULT '' COMMENT '日志标题',
  `log_type` varchar(255) DEFAULT NULL COMMENT '日志类型',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `service_id` varchar(32) DEFAULT NULL COMMENT '服务ID',
  `ip_address` varchar(255) DEFAULT NULL COMMENT 'IP地址',
  `ip_location` varchar(255) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '操作系统',
  `user_agent` varchar(1000) DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) DEFAULT NULL COMMENT '请求URI',
  `method` varchar(255) DEFAULT NULL COMMENT '请求方法',
  `params` text COMMENT '操作提交的数据',
  `time` mediumtext COMMENT '执行时间',
  `operator_type` varchar(20) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `business_type` varchar(20) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `exception` text COMMENT '异常信息',
  `created_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sys_log_create_by` (`created_by`) USING BTREE,
  KEY `sys_log_request_uri` (`request_uri`) USING BTREE,
  KEY `sys_log_create_date` (`created_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='操作日志表';

-- ----------------------------
-- Records of sys_log_operate
-- ----------------------------
BEGIN;
INSERT INTO `sys_log_operate` VALUES (1, '用户登录', 'INFO', 'account', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', '/a/authenticate', NULL, 'password=account&randomStr=85441599038944882&code=1&rememberMe=false&username=account', NULL, 'MANAGE', '0', NULL, '127713cfa8706e73721ae07748637508', '2020-09-02 17:29:24.594', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (2, '用户登录', 'INFO', 'account3', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', '/a/authenticate', NULL, 'password=account&randomStr=36091599039653312&code=1&rememberMe=false&username=account3', NULL, 'MANAGE', '0', NULL, '286cf7378ccb6d74f912f71387448199', '2020-09-02 17:41:55.006', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (3, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', '/a/authenticate', NULL, 'password=adminm&randomStr=74821599112518264&code=1&rememberMe=false&username=admin', NULL, 'MANAGE', '0', NULL, '1', '2020-09-03 13:55:24.768', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (4, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', '/a/authenticate', NULL, 'password=adminm&randomStr=48771599117602532&code=1&rememberMe=false&username=admin', NULL, 'MANAGE', '0', NULL, '1', '2020-09-03 15:20:04.052', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (5, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=adminm&randomStr=85931599218575962&code=1&rememberMe=false&username=admin', NULL, 'MANAGE', '0', NULL, '1', '2020-09-04 19:23:04.123', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (6, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=adminm&randomStr=44621599218621396&code=1&rememberMe=false&username=admin', NULL, 'MANAGE', '0', NULL, '1', '2020-09-04 19:23:49.148', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (7, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=adminm&randomStr=85691599223889074&code=1&rememberMe=false&username=admin', NULL, 'MANAGE', '0', NULL, '1', '2020-09-04 20:51:30.911', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (8, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=adminm&randomStr=98931599233269051&code=1&rememberMe=false&username=admin', NULL, 'MANAGE', '0', NULL, '1', '2020-09-04 23:28:11.617', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (9, '用户登录', 'INFO', 'backend', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=123456&randomStr=67651599233358708&code=1&rememberMe=false&username=backend', NULL, 'MANAGE', '0', NULL, '24b4bf2b0bcb7887f0e557d23d5c19a0', '2020-09-04 23:29:24.543', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (10, '用户登录', 'INFO', 'personal', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=personal&randomStr=61071599233372356&code=1&rememberMe=false&username=personal', NULL, 'MANAGE', '0', NULL, '18c4e11409918c5fe76ca18578807af2', '2020-09-04 23:29:47.750', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (11, '用户登录', 'INFO', 'personal', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=123456&randomStr=98381599233428580&code=1&rememberMe=false&username=personal', NULL, 'MANAGE', '0', NULL, '18c4e11409918c5fe76ca18578807af2', '2020-09-04 23:30:33.481', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (12, '用户登录', 'INFO', 'personal2', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=123456&randomStr=35991599233538087&code=1&rememberMe=false&username=personal2', NULL, 'MANAGE', '0', NULL, '099ba5bc557a68c539e13f1df73586ac', '2020-09-04 23:35:06.236', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (13, '用户登录', 'INFO', 'abcAccount3', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=123456&randomStr=11571599235177988&code=1&rememberMe=false&username=abcAccount3', NULL, 'MANAGE', '0', NULL, 'ed3c0d82f9c9f26c3212eb6093262ef1', '2020-09-05 00:00:14.875', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (14, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=adminm&randomStr=41951599235228268&code=1&rememberMe=false&username=admin', NULL, 'MANAGE', '0', NULL, '1', '2020-09-05 00:00:30.284', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (15, '用户登录', 'INFO', 'abcAccount2', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=123456&randomStr=11441599235569187&code=1&rememberMe=false&username=abcAccount2', NULL, 'MANAGE', '0', NULL, '9bc1afb81c83a33337a359ff41328cff', '2020-09-05 00:06:24.855', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (16, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=adminm&randomStr=84891599235590863&code=1&rememberMe=false&username=admin', NULL, 'MANAGE', '0', NULL, '1', '2020-09-05 00:06:41.436', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (17, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=adminm&randomStr=13631599235675843&code=1&rememberMe=false&username=admin', NULL, 'MANAGE', '0', NULL, '1', '2020-09-05 00:08:03.789', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (18, '用户登录', 'INFO', 'abcAccount2', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=123456&randomStr=58051599235805286&code=1&rememberMe=false&username=abcAccount2', NULL, 'MANAGE', '0', NULL, '9bc1afb81c83a33337a359ff41328cff', '2020-09-05 00:10:43.261', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (19, '用户登录', 'INFO', 'abcAccount2', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=123456&randomStr=43751599236238447&code=1&rememberMe=false&username=abcAccount2', NULL, 'MANAGE', '0', NULL, '9bc1afb81c83a33337a359ff41328cff', '2020-09-05 00:17:24.597', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (20, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=adminm&randomStr=71691599236252962&code=1&rememberMe=false&username=admin', NULL, 'MANAGE', '0', NULL, '1', '2020-09-05 00:17:36.172', NULL, '0');
INSERT INTO `sys_log_operate` VALUES (21, '用户登录', 'INFO', 'admin', NULL, '127.0.0.1', '内网IP', 'Chrome', 'OSX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', '/a/authenticate', NULL, 'password=adminm&randomStr=38861599238903209&code=1&rememberMe=false&username=admin', NULL, 'MANAGE', '0', NULL, '1', '2020-09-05 01:01:45.485', NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` varchar(32) NOT NULL COMMENT '菜单ID',
  `name` varchar(32) NOT NULL COMMENT '菜单名称',
  `type` char(1) DEFAULT NULL COMMENT '菜单类型 （0目录 1菜单 2按钮）',
  `permission` varchar(32) DEFAULT NULL COMMENT '菜单权限标识',
  `path` varchar(128) DEFAULT NULL COMMENT '前端URL',
  `parent_id` varchar(32) DEFAULT NULL COMMENT '父菜单ID',
  `parent_ids` varchar(2000) DEFAULT NULL COMMENT '父菜单IDs',
  `icon` varchar(32) DEFAULT NULL COMMENT '图标',
  `component` varchar(64) DEFAULT NULL COMMENT 'VUE页面',
  `hidden` bit(1) DEFAULT b'0' COMMENT '隐藏',
  `iframe` bit(1) DEFAULT b'0' COMMENT '是否外链',
  `cache` bit(1) DEFAULT b'0' COMMENT '缓存',
  `leaf` bit(1) DEFAULT b'0' COMMENT '1 叶子节点 0 非叶子节点',
  `sort` int(11) DEFAULT '1' COMMENT '排序值',
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '更新时间',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `version` int(11) NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` VALUES ('04c21fed93d35764a3feebf9e30f50e5', '抬头查看', '2', 'biz_invoice_view', NULL, '5e7e7140a49eb205075fb31205ddccbf', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2020-08-16 16:21:38.480', '1', '2020-08-16 16:21:38.480', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('065e7fc71db385c778b4965d34bf731e', 'testBook查看', '2', 'biz_testBook_view', NULL, '8a4be91b99e5798043eafac6a3ba102c', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2020-08-08 20:19:50.212', '1', '2020-08-08 20:22:50.150', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('06874adacf1f272be7928badd4fe8ed1', '配置日志', '1', NULL, 'log', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'dev', 'admin/log/index', b'0', b'0', b'0', b'1', 30, '1', '2019-08-05 16:16:06.000', '1', '2020-05-17 17:54:34.755', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('0747d9d8f651f19e49748ba68f18c6f5', '任务调度方案编辑', '2', 'quartz_job_edit', NULL, 'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2019-08-14 10:36:03.602', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('096d58aaf7e893e7ee655bae823bd3fe', '联系单编辑', '2', 'biz_contactInfo_edit', NULL, '6d066d50173c42d31d5b46a9fea82fb7', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2020-09-04 20:44:42.039', '1', '2020-09-04 20:44:42.039', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('0a160cff2d071eeec3db97f0cb0b30d6', '测试树编辑', '2', 'test_testTreeBook_edit', NULL, '3956b4690e4f49cfb1e065384c1dc0b9', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 40, '1', '2020-05-25 09:35:47.308', '1', '2020-05-25 10:12:00.658', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('0b934688321b1db735c3bf6ec3e7cdc7', 'test', '2', 'test', 'test', '-1', NULL, 'date', NULL, b'0', b'0', b'0', b'1', 999, '1', '2020-05-14 17:47:36.261', '1', '2020-05-15 21:06:35.180', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('0c3be2aeb338898b2508e5f075cf5c38', '配置项', '1', NULL, 'config', '1000', NULL, 'icon-right-square', 'biz/config/index', b'0', b'0', b'0', b'0', 30, '1', '2020-09-04 20:46:32.463', '1', '2020-09-04 20:46:32.463', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('0d0be247863fcbf08b3db943e5f45992', '在线用户查看', '2', 'sys_userOnline_view', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', '2000,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 09:05:28.000', '1', '2020-05-16 17:55:59.725', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('1000', '系统管理', '0', NULL, '/perm', '-1', NULL, 'menu', 'Layout', b'0', b'0', b'0', b'0', 10, '', '2018-09-28 08:29:53.000', '1', '2020-05-16 17:55:32.580', NULL, 36, '0');
INSERT INTO `sys_menu` VALUES ('10bd98f30a42427dd7ef75418ad3da6b', '邮件工具', '1', NULL, 'email', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'email', 'tool/email/index', b'0', b'0', b'0', b'1', 30, '1', '2020-05-17 17:56:56.008', '1', '2020-05-19 02:17:42.461', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('1100', '用户管理', '1', 'sys_user_view', 'user', '1000', '1000,', 'peoples', 'sys/user/index', b'0', b'0', b'0', b'0', 10, '', '2017-11-02 22:24:37.000', '1', '2020-05-20 06:19:27.618', NULL, 16, '0');
INSERT INTO `sys_menu` VALUES ('1101', '用户编辑', '2', 'sys_user_edit', NULL, '1100', '1000,1100,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '', '2017-11-08 09:52:09.000', '1', '2020-05-20 06:19:27.630', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('1102', '用户锁定', '2', 'sys_user_lock', NULL, '1100', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 09:52:48.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1103', '用户删除', '2', 'sys_user_del', NULL, '1100', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 09:54:01.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('11b9ae870fb0fc89c52236faf43f3d96', '任务调度方案查看', '2', 'quartz_job_view', NULL, '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2019-08-14 10:35:56.085', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('1200', '菜单管理', '1', 'sys_menu_view', 'menu', '1000', '1000,', 'menu', 'sys/menu/index', b'0', b'0', b'0', b'0', 40, '', '2017-11-08 09:57:27.000', '1', '2020-05-16 17:56:34.959', NULL, 8, '0');
INSERT INTO `sys_menu` VALUES ('1201', '菜单编辑', '2', 'sys_menu_edit', NULL, '1200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 10:15:53.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1202', '菜单锁定', '2', 'sys_menu_lock', NULL, '1200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 10:16:23.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1203', '菜单删除', '2', 'sys_menu_del', NULL, '1200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 10:16:43.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1300', '角色管理', '1', 'sys_role_view', 'role', '1000', '1000,', 'role', 'sys/role/index', b'0', b'0', b'0', b'0', 20, '', '2017-11-08 10:13:37.000', '1', '2020-05-16 17:56:34.949', NULL, 7, '0');
INSERT INTO `sys_menu` VALUES ('1301', '角色编辑', '2', 'sys_role_edit', NULL, '1300', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 10:14:18.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1302', '角色锁定', '2', 'sys_role_lock', NULL, '1300', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 10:14:41.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1303', '角色删除', '2', 'sys_role_del', NULL, '1300', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2017-11-08 10:14:59.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1304', '角色查看', '2', 'sys_role_view', NULL, '1300', '1300,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '', '2018-04-20 07:22:55.000', '1', '2020-05-15 21:06:35.180', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('13093fb658c1806ad5bd0600316158f2', '操作日志导出', '2', 'sys_logOperate_export', NULL, '2100', '2000,2100,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 17:50:46.973', '1', '2020-05-17 10:23:57.541', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('133f1408f5e3187d3e1a00b0260b7165', '字典可用', '2', 'sys_dict_lock', NULL, '2200', '1000,2200,', NULL, NULL, b'0', NULL, b'0', b'1', 999, '1', '2020-05-15 17:24:57.559', '1', '2020-05-16 17:55:19.915', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('1400', '部门管理', '1', 'sys_dept_view', 'dept', '1000', '1000,', 'dept', 'sys/dept/index', b'0', b'0', b'0', b'0', 30, '', '2018-01-20 13:17:19.000', '1', '2020-05-16 17:56:34.955', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('1401', '部门编辑', '2', 'sys_dept_edit', NULL, '1400', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2018-01-20 14:56:16.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1402', '部门锁定', '2', 'sys_dept_lock', NULL, '1400', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2018-01-20 14:56:59.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('1403', '部门删除', '2', 'sys_dept_del', NULL, '1400', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2018-01-20 14:57:28.000', NULL, '2020-05-15 21:06:35.180', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('165e8d044309484cd8cc8dcd79c4e2f1', '配置项查看', '2', 'biz_config_view', NULL, '0c3be2aeb338898b2508e5f075cf5c38', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2020-09-04 20:46:32.469', '1', '2020-09-04 20:46:32.469', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('174d5b8fe7d45a1d12d3ff3aa54fb222', '配置项删除', '2', 'biz_config_del', NULL, '0c3be2aeb338898b2508e5f075cf5c38', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2020-09-04 20:46:32.476', '1', '2020-09-04 20:46:32.476', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('175bdf743c3c3deaa00227b7f7ca95e9', '套餐删除', '2', 'biz_tPlan_del', NULL, '258794048b5ed7337eb54d06ecc8d188', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2020-09-05 00:34:55.607', '1', '2020-09-05 00:36:43.055', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('17a713e918513ecd42d3e915d1fc79c1', '测试书籍删除', '2', 'test_testBook_del', NULL, '4f5c94e30f3a64e8e1f1bf10e7247e7e', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2020-05-25 10:15:07.791', '1', '2020-05-29 16:36:27.004', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('18d6b5e0f6b986cd074bf23de11ecd34', '任务调度删除', '2', 'quartz_job_del', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2019-08-14 10:36:47.091', '1', '2020-05-16 13:24:22.873', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('1901860c4e2bf0cee03af42bd7f9d846', 'testBook', '1', NULL, 'test-book', '1000', NULL, 'icon-right-square', 'biz/test-book/index', b'0', b'0', b'0', b'0', 30, '1', '2020-08-16 16:21:32.310', '1', '2020-09-02 13:52:25.042', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('1a900c3f10ef5b0987e0a8ee4445316d', '用户查看', '2', 'sys_user_view', NULL, '1100', '1000,1100,', NULL, NULL, b'0', b'0', b'0', b'1', 10, '1', '2019-08-07 17:27:34.000', '1', '2020-05-15 21:06:35.180', NULL, 4, '1');
INSERT INTO `sys_menu` VALUES ('1ae562534a64d4473899e52497c40b2e', '二级菜单1', '1', NULL, 'menu1', 'eb17cee437ea6b630dad59fff2a059ca', 'eb17cee437ea6b630dad59fff2a059ca,', 'dev', 'nested/menu1/index', b'0', b'0', b'0', b'0', 10, '1', '2020-05-18 11:10:06.354', '1', '2020-05-25 10:13:50.580', NULL, 9, '0');
INSERT INTO `sys_menu` VALUES ('1bbac8b179d963332b07d200672543ca', '抬头删除', '2', 'biz_invoice_del', NULL, '5e7e7140a49eb205075fb31205ddccbf', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2020-08-16 16:21:38.487', '1', '2020-08-16 16:21:38.487', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('2000', '系统监控', '0', NULL, '/sys', '-1', NULL, 'system', 'Layout', b'0', b'0', b'0', b'0', 20, '', '2017-11-07 20:56:00.000', '1', '2020-05-17 16:52:02.575', NULL, 39, '0');
INSERT INTO `sys_menu` VALUES ('2100', '操作日志', '1', NULL, 'log-operate', '2000', '2000,', 'log', 'monitor/log-operate/index', b'0', b'0', b'0', b'0', 40, '', '2017-11-20 14:06:22.000', '1', '2020-05-17 10:23:57.530', NULL, 12, '0');
INSERT INTO `sys_menu` VALUES ('2101', '操作日志删除', '2', 'sys_logOperate_del', NULL, '2100', '2000,2100,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '', '2017-11-20 20:37:37.000', '1', '2020-05-17 10:23:57.545', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('217a7eeb825e7ef901c960312d50bd64', 'testBook编辑', '2', 'biz_testBook_edit', NULL, '8a4be91b99e5798043eafac6a3ba102c', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2020-08-08 20:19:50.217', '1', '2020-08-08 20:22:50.150', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('2200', '字典管理', '1', 'sys_dict_view', 'dict', '1000', '1000,', 'dictionary', 'sys/dict/index', b'0', b'0', b'0', b'0', 50, '', '2017-11-29 11:30:52.000', '1', '2020-05-16 17:56:34.943', NULL, 11, '0');
INSERT INTO `sys_menu` VALUES ('2201', '字典删除', '2', 'sys_dict_del', NULL, '2200', '1000,2200,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '', '2017-11-29 11:30:11.000', '1', '2020-05-16 17:55:19.918', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('2202', '字典编辑', '2', 'sys_dict_edit', NULL, '2200', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 30, '', '2018-05-11 22:34:55.000', '1', '2020-05-16 13:24:22.800', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('2245134851ecd3537c454ba8a3ef915c', '测试书籍查看', '2', 'test_testBook_view', NULL, '8ce9f148e5720ace1b7cf24e0985c47e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1', '2020-05-25 10:12:05.954', '1', '2020-05-25 10:15:07.779', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('23430df88fb72179c2a85c39eaf4d50b', '任务调度日志清空', '2', 'quartz_jobLog_clean', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 80, '1', '2019-08-15 16:12:26.285', '1', '2020-05-16 15:40:21.370', NULL, 2, '1');
INSERT INTO `sys_menu` VALUES ('247071d42ff40267c8d8c44eac92da67', '生成方案', '1', NULL, 'scheme', '413892fe8d52c1163d6659f51299dc96', '413892fe8d52c1163d6659f51299dc96,', 'dev', 'gen/scheme/index', b'0', b'0', b'0', b'0', 30, '1', '2019-07-21 13:27:35.000', '1', '2020-05-18 11:39:42.026', NULL, 21, '0');
INSERT INTO `sys_menu` VALUES ('2500', '接口文档', '1', NULL, 'swagger2', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'swagger', 'tool/swagger/index', b'0', b'0', b'0', b'1', 20, '', '2018-06-26 10:50:32.000', '1', '2020-05-19 02:17:26.914', NULL, 8, '0');
INSERT INTO `sys_menu` VALUES ('258794048b5ed7337eb54d06ecc8d188', '套餐', '1', NULL, 't-plan', '1000', NULL, 'icon-right-square', 'biz/t-plan/index', b'0', b'0', b'0', b'0', 30, '1', '2020-09-05 00:34:55.595', '1', '2020-09-05 00:36:46.521', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('2600', '令牌管理', '1', NULL, 'persistent-token', '2000', '2000,', 'dev', 'monitor/persistent-token/index', b'0', b'0', b'0', b'0', 20, '', '2018-09-04 05:58:41.000', '1', '2020-05-16 17:57:31.286', NULL, 14, '0');
INSERT INTO `sys_menu` VALUES ('2601', '令牌删除', '2', 'sys_persistentToken_del', NULL, '2600', '2600,', NULL, NULL, b'0', b'0', b'0', b'1', 1, '', '2018-09-04 05:59:50.000', '1', '2020-05-16 17:57:31.293', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('27db071d74ab5e18988ab29990e94955', 'testBook', '1', NULL, 'test-book', '1000', NULL, 'icon-right-square', 'biz/test-book/index', b'0', b'0', b'0', b'0', 30, '1', '2020-08-08 21:20:47.654', '1', '2020-08-16 16:20:36.579', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('2836ced373377be75936827ecddf7fad', '测试树管理编辑', '2', 'test_testTreeBook_edit', NULL, '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2019-08-11 14:32:06.856', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('29de79df95e70d8e8fbdc7945acf214a', '任务调度查看', '2', 'quartz_job_view', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 10, '1', '2019-08-14 10:36:47.085', '1', '2020-05-16 12:10:40.648', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('29fa5859c9418ab919e172b7d21162de', '测试树查看', '2', 'test_testTreeBook_view', NULL, 'dab11e5104d690be6991002ae4da0cbd', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2020-05-25 10:15:02.872', '1', '2020-05-29 16:36:26.994', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('2af0268f695b79abdf6e8b10d559d081', '测试树管理删除', '2', 'test_testTreeBook_del', NULL, '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2019-08-11 14:32:06.859', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('2ba728e8a99e6d843bf904c52975035c', '表单编辑', '2', 'biz_orderForm_edit', NULL, 'bdd0f9b7a638527b6ecab7de453ddc00', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2020-08-18 10:25:50.880', '1', '2020-09-02 13:52:21.517', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('2c0688c2ad9259b9a7e7088a2f6ade4e', '测试书籍', '1', NULL, 'test-book', 'eb17cee437ea6b630dad59fff2a059ca', NULL, 'icon-right-square', 'views/test/test-book/index', b'0', NULL, b'0', b'0', 80, '1', '2020-05-25 09:36:39.119', '1', '2020-05-25 10:12:05.946', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('2c8fdecfee63a310266b2e4b94fd3f4c', '任务调度日志删除', '2', 'quartz_jobLog_del', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 70, '1', '2019-08-15 16:12:07.842', '1', '2020-05-16 15:40:08.708', NULL, 2, '1');
INSERT INTO `sys_menu` VALUES ('2c90f69bccf0845b1aca8b072b730c39', '任务调度方案删除', '2', 'quartz_job_del', NULL, '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2019-08-14 10:35:56.092', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('2d9efe7ea66351a96da68e6a7cca5e00', '任务调度方案删除', '2', 'quartz_job_del', NULL, 'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2019-08-14 10:36:03.606', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('310c04e534c9af92935c54b4e1357447', 'tes', '1', 'te', 'te', '54cd27f34ca7e9a8848b92377468965d', '54cd27f34ca7e9a8848b92377468965d,', 'app', 'te', b'0', b'0', b'0', b'1', 999, '1', '2020-05-14 18:17:11.736', '1', '2020-05-15 21:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('31265d5c7cf40ee21e3963476cabe26f', '配置项编辑', '2', 'biz_config_edit', NULL, '0c3be2aeb338898b2508e5f075cf5c38', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2020-09-04 20:46:32.473', '1', '2020-09-04 20:46:32.473', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('322efc9833f2562f8862f882dabdf3d6', '任务调度方案', '1', NULL, 'job', '2000', NULL, 'timing', 'quartz/job/index', b'0', b'0', b'0', b'0', 30, '1', '2019-08-14 10:35:56.081', '1', '2020-05-15 21:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('34acb71268387bb85c80849f7377c7fd', '任务日志导出', '2', 'quartz_jobLog_export', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0', b'1', 40, '1', '2019-08-14 10:36:42.000', '1', '2020-05-16 13:43:17.758', NULL, 4, '1');
INSERT INTO `sys_menu` VALUES ('34dae0db3f9c97482d598f964bd4c9c7', '配置管理', '1', NULL, 'configuration', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'dev', 'admin/configuration/index', b'0', b'0', b'0', b'1', 50, '1', '2019-08-05 17:46:50.000', '1', '2020-05-17 17:54:41.694', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('365a9f74f847322d2b8a0eff2b426ef4', '登录日志导出', '2', 'sys_logLogin_export', NULL, 'a41d4ac1a6cc179696e0dbf284e3efc4', 'a41d4ac1a6cc179696e0dbf284e3efc4,', NULL, NULL, b'0', b'0', b'0', b'1', 40, '1', '2019-08-15 09:26:02.000', '1', '2020-05-17 14:55:26.858', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('37953f386d9918cc59f94248456866d4', 'testBook删除', '2', 'biz_testBook_del', NULL, 'c03431f69cdbd3fcb3a018f98cd3403e', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2020-08-08 20:22:50.170', '1', '2020-08-08 21:04:31.473', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('37d3021781fcad4511196ec139fb2143', '表单删除', '2', 'biz_orderForm_del', NULL, 'bdd0f9b7a638527b6ecab7de453ddc00', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2020-08-18 10:25:50.884', '1', '2020-09-02 13:52:21.570', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('3956b4690e4f49cfb1e065384c1dc0b9', '测试树', '1', NULL, 'test-tree-book', 'eb17cee437ea6b630dad59fff2a059ca', NULL, 'icon-right-square', 'views/test/test-tree-book/index', b'0', NULL, b'0', b'0', 90, '1', '2020-05-25 09:35:47.300', '1', '2020-05-25 10:12:00.658', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('3c1c5a48888650b9a7ba5a1763f2e205', '任务日志查看', '2', 'quartz_jobLog_view', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0', b'1', 20, '1', '2019-08-14 10:36:42.000', '1', '2020-05-16 13:43:17.732', NULL, 4, '1');
INSERT INTO `sys_menu` VALUES ('40e872ab9b5511f81a7efc7a259d7f42', '联系单查看', '2', 'biz_contactInfo_view', NULL, 'aa1a0149d0a8b7ca223aafd06785192f', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2020-09-02 13:51:53.260', '1', '2020-09-04 20:44:42.025', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('413892fe8d52c1163d6659f51299dc96', '代码生成', '0', NULL, '/gen', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'codeConsole', 'gen/index', b'0', b'0', b'0', b'0', 10, '1', '2019-07-20 12:00:48.000', '1', '2020-05-18 11:39:41.987', NULL, 47, '0');
INSERT INTO `sys_menu` VALUES ('47b30f257d46475bfa7b595c2eb93602', 'testBook查看', '2', 'biz_testBook_view', NULL, 'c03431f69cdbd3fcb3a018f98cd3403e', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2020-08-08 20:22:50.162', '1', '2020-08-08 21:04:31.425', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('48ffd1c39241ab2b4c206155bb2ae8b4', '测试书籍查看', '2', 'test_testBook_view', NULL, '4f5c94e30f3a64e8e1f1bf10e7247e7e', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2020-05-25 10:15:07.785', '1', '2020-05-29 16:36:26.964', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('4be6c4bdd4e81a3e55bd3fbcdb44fb3a', 'testBook编辑', '2', 'biz_testBook_edit', NULL, '27db071d74ab5e18988ab29990e94955', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2020-08-08 21:20:47.667', '1', '2020-08-16 16:20:36.579', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('4f5c94e30f3a64e8e1f1bf10e7247e7e', '测试书籍', '1', NULL, 'test-book', 'eb17cee437ea6b630dad59fff2a059ca', NULL, 'icon-right-square', 'test/test-book/index', b'0', b'0', b'0', b'0', 30, '1', '2020-05-25 10:15:07.782', '1', '2020-05-29 16:36:34.943', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('511c942a5770b6bfa10fbdb3e2fa9d10', '测试树删除', '2', 'test_testTreeBook_del', NULL, 'c206444a1d18c7b505dea8ed5a617669', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1', '2020-05-25 10:12:00.674', '1', '2020-05-25 10:15:02.864', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('52715698214e88cb09fa4dd1ea5ad348', '生成方案菜单', '2', 'gen_scheme_menu', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-25 13:03:03.000', '1', '2020-05-18 11:39:42.037', NULL, 8, '0');
INSERT INTO `sys_menu` VALUES ('5404c3df9f771dbc0237578814bbe44b', 'Yaml编辑器', '1', NULL, 'yaml', 'd9d87cf8ed7c29ed2eda06d5dec4dcda', 'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'dev', 'components/YamlEdit', b'0', b'0', b'0', b'1', 50, '1', '2020-05-15 21:22:43.364', '1', '2020-05-15 21:22:43.364', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('5431004fa397e0280fd75c4a3b73c4aa', '登录日志查看', '2', 'sys_logLogin_view', NULL, 'a41d4ac1a6cc179696e0dbf284e3efc4', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2019-08-15 09:26:02.349', '1', '2020-05-17 14:55:26.848', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('54cd27f34ca7e9a8848b92377468965d', 'test', '1', 'test', 'tes', '-1', NULL, 'Steve-Jobs', 'tes', b'1', b'0', b'1', b'0', 999, '1', '2020-05-14 18:16:52.599', '1', '2020-05-15 21:07:50.836', NULL, 2, '1');
INSERT INTO `sys_menu` VALUES ('5b39ca5a25c772105c71f8c51d1f19d4', '三级菜单1', '1', NULL, 'menu1-1', '1ae562534a64d4473899e52497c40b2e', 'eb17cee437ea6b630dad59fff2a059ca,1ae562534a64d4473899e52497c40b2e,', 'dev', 'nested/menu1/menu1-1', b'0', b'0', b'0', b'1', 30, '1', '2020-05-18 11:11:16.436', '1', '2020-05-25 10:13:50.586', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('5c2c222381ebd63847639d528c04a01c', 'testBook删除', '2', 'biz_testBook_del', NULL, '8a4be91b99e5798043eafac6a3ba102c', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2020-08-08 20:19:50.221', '1', '2020-08-08 20:22:50.150', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('5d94bc2151ec9572966e5e768824752d', '测试树查看', '2', 'test_testTreeBook_view', NULL, '3956b4690e4f49cfb1e065384c1dc0b9', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1', '2020-05-25 09:35:47.304', '1', '2020-05-25 10:12:00.658', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('5da31e19f05edeea6a7041e3101deefe', '任务日志删除', '2', 'quartz_jobLog_del', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0', b'1', 80, '1', '2019-08-14 10:36:42.000', '1', '2020-05-16 13:43:17.702', NULL, 4, '1');
INSERT INTO `sys_menu` VALUES ('5e7e7140a49eb205075fb31205ddccbf', '抬头', '1', NULL, 'invoice', '1000', NULL, 'icon-right-square', 'biz/invoice/index', b'0', b'0', b'0', b'0', 30, '1', '2020-08-16 16:21:38.477', '1', '2020-08-16 16:21:38.477', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('618ee4b9660265a85a8b61277de2a579', '富文本', '1', NULL, 'editor', 'd9d87cf8ed7c29ed2eda06d5dec4dcda', 'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'fwb', 'components/Editor', b'0', b'0', b'0', b'1', 30, '1', '2020-05-15 21:16:40.552', '1', '2020-05-15 21:16:50.233', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('621e50e1c7d66a1febeb699bebb2fe35', '任务调度执行', '2', 'quartz_job_run', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 20, '1', '2019-08-15 16:10:59.000', '1', '2020-05-16 12:11:01.548', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('64b61b8966e1c74d9b309069b2f622d1', '图标库', '1', NULL, 'icons', 'd9d87cf8ed7c29ed2eda06d5dec4dcda', 'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'icon', 'components/icons/index', b'0', b'0', b'0', b'1', 10, '1', '2020-05-15 21:14:28.945', '1', '2020-05-15 21:15:00.712', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('667c1200525f846a97cfb535e7ae80b1', 'testBook编辑', '2', 'biz_testBook_edit', NULL, 'c03431f69cdbd3fcb3a018f98cd3403e', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2020-08-08 20:22:50.167', '1', '2020-08-08 21:04:31.449', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('6763703d160181a09cbe9a047146b2cf', 'testBook删除', '2', 'biz_testBook_del', NULL, 'ed690ac2933fc89fe7f4d01688e38ea4', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2020-08-16 16:20:36.599', '1', '2020-08-16 16:21:32.306', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('6d066d50173c42d31d5b46a9fea82fb7', '联系单', '1', NULL, 'contact-info', '1000', NULL, 'icon-right-square', 'biz/contact-info/index', b'0', b'0', b'0', b'0', 30, '1', '2020-09-04 20:44:42.032', '1', '2020-09-04 20:44:42.032', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('6d101761341b2ca58db9a953a1fde5e0', '套餐编辑', '2', 'biz_plan_edit', NULL, 'ad2ea4cf4a36770597f8e473bbf5b64b', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2020-09-05 00:36:55.093', '1', '2020-09-05 00:36:55.093', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('6d1104631464317431ab6fb827b1e599', '联系单编辑', '2', 'biz_contactInfo_edit', NULL, 'aa1a0149d0a8b7ca223aafd06785192f', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2020-09-02 13:51:53.263', '1', '2020-09-04 20:44:42.025', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('6e3f89cda84ac2c6e715e7812c102ae8', '在线用户', '1', '', 'user-online', '2000', '2000,', 'Steve-Jobs', 'monitor/user-online/index', b'0', b'0', b'0', b'0', 30, '1', '2019-08-07 09:03:52.000', '1', '2020-05-16 17:55:59.718', NULL, 10, '0');
INSERT INTO `sys_menu` VALUES ('74f2b2a8871a298e0acc4d7129d10e9c', '任务调度', '1', NULL, 'job', '1000', '1000,', 'timing', 'quartz/job/index', b'0', b'0', b'0', b'0', 60, '1', '2019-08-14 10:36:47.081', '1', '2020-05-16 17:56:34.966', NULL, 22, '0');
INSERT INTO `sys_menu` VALUES ('76d6087052dc26b32f3efa71b9cc119b', '任务调度日志', '2', 'quartz_jobLog_view', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 50, '1', '2019-08-15 16:11:30.986', '1', '2020-05-16 13:43:44.992', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('7754b1457826c48290bc189bb1289740', '支付宝工具', '1', NULL, 'alipay', 'ef2382c0cc2d99ee73444e684237a88a', 'ef2382c0cc2d99ee73444e684237a88a,', 'alipay', 'tool/alipay/index', b'0', b'0', b'0', b'1', 40, '1', '2020-05-17 17:58:06.876', '1', '2020-05-19 02:17:53.063', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('795b4d5cf0eb3ed80e24cbab39727b9d', 'Markdown', '1', NULL, 'markdown', 'd9d87cf8ed7c29ed2eda06d5dec4dcda', 'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'markdown', 'components/MarkDown', b'0', b'0', b'0', b'1', 40, '1', '2020-05-15 21:21:46.675', '1', '2020-05-15 21:22:53.122', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('7b14af9e9fbff286856338a194422b07', '令牌查看', '2', 'sys_persistentToken_view', NULL, '2600', '2600,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-08 09:44:25.617', '1', '2020-05-16 17:57:31.295', NULL, 4, '0');
INSERT INTO `sys_menu` VALUES ('7c7a876f4cceba2dd92aa539dea6b6e5', '任务日志清空', '2', 'quartz_jobLog_clean', NULL, 'c93f8fca7ca6f8631d383b08ab67009a', '2000,c93f8fca7ca6f8631d383b08ab67009a,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-15 13:55:37.892', '1', '2020-05-16 13:43:17.774', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('84f55c785ae71eb65e7325e148818041', '测试树查看', '2', 'test_testTreeBook_view', NULL, 'c206444a1d18c7b505dea8ed5a617669', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1', '2020-05-25 10:12:00.667', '1', '2020-05-25 10:15:02.864', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('862fa87cbc10766da4de286804e01d13', '测试树删除', '2', 'test_testTreeBook_del', NULL, 'dab11e5104d690be6991002ae4da0cbd', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2020-05-25 10:15:02.877', '1', '2020-05-29 16:36:26.973', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('8a4be91b99e5798043eafac6a3ba102c', 'testBook', '1', NULL, 'test-book', '1000', NULL, 'icon-right-square', 'biz/test-book/index', b'0', b'0', b'0', b'0', 30, '1', '2020-08-08 20:19:50.187', '1', '2020-08-08 20:22:50.150', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('8a8db0c2405754fd3ac1dd33f0d6fac5', 'testBook查看', '2', 'biz_testBook_view', NULL, '27db071d74ab5e18988ab29990e94955', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2020-08-08 21:20:47.662', '1', '2020-08-16 16:20:36.579', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('8ce9f148e5720ace1b7cf24e0985c47e', '测试书籍', '1', NULL, 'test-book', 'eb17cee437ea6b630dad59fff2a059ca', NULL, 'icon-right-square', 'test/test-book/index', b'0', NULL, b'0', b'0', 90, '1', '2020-05-25 10:12:05.950', '1', '2020-05-25 10:15:07.779', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('8d3517427e527df11d51da528261c915', '测试树管理', '1', NULL, 'test-tree-book', '413892fe8d52c1163d6659f51299dc96', NULL, 'dev', 'test/test-tree-book/index', b'0', b'0', b'0', b'0', 30, '1', '2019-08-11 14:32:06.849', '1', '2020-05-15 21:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('9203b35328f4c86e9ab552b1420ae8b3', '套餐查看', '2', 'biz_tPlan_view', NULL, '258794048b5ed7337eb54d06ecc8d188', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2020-09-05 00:34:55.599', '1', '2020-09-05 00:36:43.027', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('92f78825551a22fa130c03066f398448', '在线用户删除', '2', 'sys_userOnline_del', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', '2000,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 09:06:33.448', '1', '2020-05-16 17:55:59.728', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('9456f594320dac67c8ee407c8375a245', '表单查看', '2', 'biz_orderForm_view', NULL, 'bdd0f9b7a638527b6ecab7de453ddc00', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2020-08-18 10:25:50.877', '1', '2020-09-02 13:52:21.499', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('94b57a562063d103423e2c6125cb30ad', '菜单查看', '2', 'sys_menu_view', NULL, '1200', '1200,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 17:27:59.697', '1', '2020-05-15 21:06:35.180', NULL, 1, '1');
INSERT INTO `sys_menu` VALUES ('95781768e18770fc26c99c11c6528920', 'testBook查看', '2', 'biz_testBook_view', NULL, 'ed690ac2933fc89fe7f4d01688e38ea4', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2020-08-16 16:20:36.591', '1', '2020-08-16 16:21:32.306', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('9763343d9cce11ce9eb4f21c8e49122b', '任务调度编辑', '2', 'quartz_job_edit', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-14 10:36:47.088', '1', '2020-05-16 12:11:35.820', NULL, 1, '0');
INSERT INTO `sys_menu` VALUES ('97722c6d56c8b9990cc3c1a6eea3d6bb', '业务表编辑', '1', 'gen_table_edit', 'edit', '413892fe8d52c1163d6659f51299dc96', 'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,', NULL, 'gen/table/edit', b'1', b'0', b'0', b'1', 20, '1', '2019-07-21 13:24:02.000', '1', '2020-05-18 11:39:42.048', NULL, 10, '0');
INSERT INTO `sys_menu` VALUES ('9894fcdc0d77e5df85487b84abe62aee', 'testBook编辑', '2', 'biz_testBook_edit', NULL, 'd3d0dcfc154f40fc77e3711e5e964996', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2020-08-08 21:04:54.701', '1', '2020-08-08 21:20:47.646', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('9f02e346b5350366968f217daef3f1b7', '图表库', '1', NULL, 'Echarts', 'd9d87cf8ed7c29ed2eda06d5dec4dcda', 'd9d87cf8ed7c29ed2eda06d5dec4dcda,', 'chart', 'components/Echarts', b'0', b'0', b'0', b'1', 20, '1', '2020-05-15 21:12:39.827', '1', '2020-05-15 21:15:09.128', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('a18b33e15bde209a3c9115517c56d9ec', '业务表', '1', '', 'table', '413892fe8d52c1163d6659f51299dc96', 'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,', 'database', 'gen/table/index', b'0', b'0', b'0', b'0', 10, '1', '2019-07-20 12:02:02.000', '1', '2020-05-18 11:39:42.059', NULL, 23, '0');
INSERT INTO `sys_menu` VALUES ('a1dab416efe0a8e26d74018fb686bb35', 'testBook删除', '2', 'biz_testBook_del', NULL, '1901860c4e2bf0cee03af42bd7f9d846', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2020-08-16 16:21:32.339', '1', '2020-09-02 13:52:21.536', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('a24028c51b32b0e672c289b5deaed16b', 'testBook编辑', '2', 'biz_testBook_edit', NULL, 'ed690ac2933fc89fe7f4d01688e38ea4', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2020-08-16 16:20:36.595', '1', '2020-08-16 16:21:32.306', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('a402264b7868953cbcbedd6052d34eec', '套餐编辑', '2', 'biz_tPlan_edit', NULL, '258794048b5ed7337eb54d06ecc8d188', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2020-09-05 00:34:55.604', '1', '2020-09-05 00:36:42.999', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('a41d4ac1a6cc179696e0dbf284e3efc4', '登录日志', '1', NULL, 'log-login', '2000', '2000,', 'log', 'monitor//log-login/index', b'0', b'0', b'0', b'0', 50, '1', '2019-08-15 09:26:02.345', '1', '2020-05-17 14:55:36.150', NULL, 8, '1');
INSERT INTO `sys_menu` VALUES ('a59098c7feb21d9177773dc21c08c3c6', '联系单删除', '2', 'biz_contactInfo_del', NULL, 'aa1a0149d0a8b7ca223aafd06785192f', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2020-09-02 13:51:53.267', '1', '2020-09-04 20:44:42.025', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('aa1a0149d0a8b7ca223aafd06785192f', '联系单', '1', NULL, 'contact-info', '1000', NULL, 'icon-right-square', 'biz/contact-info/index', b'0', b'0', b'0', b'0', 30, '1', '2020-09-02 13:51:53.256', '1', '2020-09-04 20:44:42.025', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('ad2ea4cf4a36770597f8e473bbf5b64b', '套餐', '1', NULL, 'plan', '1000', NULL, 'icon-right-square', 'biz/plan/index', b'0', b'0', b'0', b'0', 30, '1', '2020-09-05 00:36:55.082', '1', '2020-09-05 00:36:55.082', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('b113dd83b57e3b53e5814de94374f843', 'testBook查看', '2', 'biz_testBook_view', NULL, '1901860c4e2bf0cee03af42bd7f9d846', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2020-08-16 16:21:32.330', '1', '2020-09-02 13:52:21.483', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('b1a7134f07a41e5f91df9f6c3b0238d4', '联系单查看', '2', 'biz_contactInfo_view', NULL, '6d066d50173c42d31d5b46a9fea82fb7', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2020-09-04 20:44:42.035', '1', '2020-09-04 20:44:42.035', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('b4f9ed81ae1390b4d1a2ae8373c4b2bc', 'testBook删除', '2', 'biz_testBook_del', NULL, 'd3d0dcfc154f40fc77e3711e5e964996', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2020-08-08 21:04:54.705', '1', '2020-08-08 21:20:47.646', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('b6bcb9fa8a3726bfbffb955dc9f56b91', '测试书籍编辑', '2', 'test_testBook_edit', NULL, '8ce9f148e5720ace1b7cf24e0985c47e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 40, '1', '2020-05-25 10:12:05.958', '1', '2020-05-25 10:15:07.779', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('b8eafb6c3a8bf0919230f0bfa59d86b6', '二级菜单2', '1', NULL, 'menu2', 'eb17cee437ea6b630dad59fff2a059ca', 'eb17cee437ea6b630dad59fff2a059ca,', 'dev', 'nested/menu2/index', b'0', b'0', b'0', b'1', 30, '1', '2020-05-18 11:14:32.907', '1', '2020-05-18 11:15:14.535', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('b961670cbf3454f5927c4bd2a327e915', '生成方案删除', '2', 'gen_scheme_del', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-21 13:30:18.000', '1', '2020-05-18 11:39:42.072', NULL, 8, '0');
INSERT INTO `sys_menu` VALUES ('b963a451117f430703817b3b6c87402a', '任务调度日志导出', '2', 'quartz_jobLog_export', NULL, '74f2b2a8871a298e0acc4d7129d10e9c', '74f2b2a8871a298e0acc4d7129d10e9c,', NULL, NULL, b'0', b'0', b'0', b'1', 60, '1', '2019-08-15 16:13:16.742', '1', '2020-05-16 13:43:54.409', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('ba860cfe687fd01fd492c683907936aa', '测试树编辑', '2', 'test_testTreeBook_edit', NULL, 'dab11e5104d690be6991002ae4da0cbd', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2020-05-25 10:15:02.874', '1', '2020-05-29 16:36:27.013', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('bb9dd4b7a2a462193d0f01517308f812', '业务表查看', '2', 'gen_table_view', NULL, 'a18b33e15bde209a3c9115517c56d9ec', 'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 08:47:39.828', '1', '2020-05-18 11:39:42.081', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('bceaa6c321109b9becd91e3eac3647c0', '测试书籍编辑', '2', 'test_testBook_edit', NULL, '4f5c94e30f3a64e8e1f1bf10e7247e7e', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2020-05-25 10:15:07.788', '1', '2020-05-29 16:36:26.983', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('bd62904371247f56594741ff8e9bded9', '用户导出', '2', 'sys_user_export', NULL, '1100', '1000,1100,', NULL, NULL, b'0', b'0', b'0', b'1', 80, '1', '2019-08-07 17:50:02.000', '1', '2020-05-15 21:06:35.180', NULL, 7, '0');
INSERT INTO `sys_menu` VALUES ('bdd0f9b7a638527b6ecab7de453ddc00', '表单', '1', NULL, 'order-form', '1000', NULL, 'icon-right-square', 'biz/order-form/index', b'0', b'0', b'0', b'0', 30, '1', '2020-08-18 10:25:50.873', '1', '2020-09-05 00:32:52.680', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('c03431f69cdbd3fcb3a018f98cd3403e', 'testBook', '1', NULL, 'test-book', '1000', NULL, 'icon-right-square', 'biz/test-book/index', b'0', b'0', b'0', b'0', 30, '1', '2020-08-08 20:22:50.157', '1', '2020-08-08 21:04:35.161', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('c0ba37c10abaecd89a738c5cf2a2fd24', '服务监控', '1', 'sys_monitor_view', 'server', '2000', '2000,', 'codeConsole', 'monitor/server/index', b'0', b'0', b'0', b'1', 40, '1', '2019-08-05 17:21:10.000', '1', '2020-05-17 16:52:02.586', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('c206444a1d18c7b505dea8ed5a617669', '测试树', '1', NULL, 'test-tree-book', 'eb17cee437ea6b630dad59fff2a059ca', 'eb17cee437ea6b630dad59fff2a059ca,', 'icon-right-square', 'test/test-tree-book/index', b'0', b'0', b'1', b'0', 80, '1', '2020-05-25 10:12:00.664', '1', '2020-05-25 10:15:02.864', NULL, 2, '1');
INSERT INTO `sys_menu` VALUES ('c77855e4171d00ae3f97563a8391f70a', '任务调度方案', '1', NULL, 'job', '2000', NULL, 'timing', 'quartz/job/index', b'0', b'0', b'0', b'0', 30, '1', '2019-08-14 10:36:03.593', '1', '2020-05-15 21:07:50.836', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('c7bc1d64972e77c15ed42d5cf21d9ec5', '测试树删除', '2', 'test_testTreeBook_del', NULL, '3956b4690e4f49cfb1e065384c1dc0b9', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1', '2020-05-25 09:35:47.314', '1', '2020-05-25 10:12:00.658', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('c8b84044eac87a2e2ed0e10da9e095d2', '测试书籍编辑', '2', 'test_testBook_edit', NULL, '2c0688c2ad9259b9a7e7088a2f6ade4e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 40, '1', '2020-05-25 09:36:39.128', '1', '2020-05-25 10:12:05.946', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('c93f8fca7ca6f8631d383b08ab67009a', '任务日志', '1', NULL, 'job-log', '2000', '2000,', 'log', 'quartz/job-log/index', b'0', b'0', b'0', b'0', 60, '1', '2019-08-14 10:36:42.000', '1', '2020-05-16 13:43:26.449', NULL, 14, '1');
INSERT INTO `sys_menu` VALUES ('caaec41413c5713c6f290efe08c11415', '生成方案查看', '2', 'gen_scheme_view', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 08:48:09.000', '1', '2020-05-18 11:39:42.095', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('cb13db6c1daea6afdba933ef6ad9d2a7', '套餐删除', '2', 'biz_plan_del', NULL, 'ad2ea4cf4a36770597f8e473bbf5b64b', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2020-09-05 00:36:55.097', '1', '2020-09-05 00:36:55.097', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('cb493ffb145ee7d7d5c31119180f0f96', '抬头编辑', '2', 'biz_invoice_edit', NULL, '5e7e7140a49eb205075fb31205ddccbf', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2020-08-16 16:21:38.483', '1', '2020-08-16 16:21:38.483', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('d3d0dcfc154f40fc77e3711e5e964996', 'testBook', '1', NULL, 'test-book', '1000', NULL, 'icon-right-square', 'biz/test-book/index', b'0', b'0', b'0', b'0', 30, '1', '2020-08-08 21:04:54.693', '1', '2020-08-08 21:20:47.646', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('d4c16faad8f883650a3a8eab829ebad9', '操作日志查看', '2', 'sys_logOperate_view', NULL, '2100', '2000,2100,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-07 17:51:38.454', '1', '2020-05-17 10:23:57.546', NULL, 2, '0');
INSERT INTO `sys_menu` VALUES ('d5159fe06c7ac2003426fa1b3c8d43b8', '套餐查看', '2', 'biz_plan_view', NULL, 'ad2ea4cf4a36770597f8e473bbf5b64b', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2020-09-05 00:36:55.089', '1', '2020-09-05 00:36:55.089', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('d5642a62bb1dc261baaf7dc883bba7e1', '测试书籍删除', '2', 'test_testBook_del', NULL, '8ce9f148e5720ace1b7cf24e0985c47e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1', '2020-05-25 10:12:05.961', '1', '2020-05-25 10:15:07.779', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('d5897b78312e09024546530fd8b2e8fc', '任务调度方案查看', '2', 'quartz_job_view', NULL, 'c77855e4171d00ae3f97563a8391f70a', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2019-08-14 10:36:03.598', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('d9d87cf8ed7c29ed2eda06d5dec4dcda', '组件管理', '0', NULL, '/components', '-1', NULL, 'zujian', 'Layout', b'0', b'0', b'0', b'0', 80, '1', '2020-05-15 20:57:28.521', '1', '2020-05-16 13:38:57.307', NULL, 26, '0');
INSERT INTO `sys_menu` VALUES ('da5709484a056154e0e89891eea6d6ac', '测试书籍查看', '2', 'test_testBook_view', NULL, '2c0688c2ad9259b9a7e7088a2f6ade4e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 20, '1', '2020-05-25 09:36:39.124', '1', '2020-05-25 10:12:05.946', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('dab11e5104d690be6991002ae4da0cbd', '测试树', '1', NULL, 'test-tree-book', 'eb17cee437ea6b630dad59fff2a059ca', NULL, 'icon-right-square', 'test/test-tree-book/index', b'0', b'0', b'0', b'0', 30, '1', '2020-05-25 10:15:02.868', '1', '2020-05-29 16:36:34.931', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('dea411c6512c54448e326e4b470b63e8', 'testBook编辑', '2', 'biz_testBook_edit', NULL, '1901860c4e2bf0cee03af42bd7f9d846', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2020-08-16 16:21:32.336', '1', '2020-09-02 13:52:21.554', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e086c4aa4943a883b29cf94680608b89', '生成方案代码', '2', 'gen_scheme_code', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 08:55:37.000', '1', '2020-05-18 11:39:42.099', NULL, 3, '0');
INSERT INTO `sys_menu` VALUES ('e1f4c8cc8f68a7e2dca4d6a4f1859f5a', 'testBook删除', '2', 'biz_testBook_del', NULL, '27db071d74ab5e18988ab29990e94955', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2020-08-08 21:20:47.671', '1', '2020-08-16 16:20:36.579', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e590df103d3382d3091eae818f68626b', '测试树管理查看', '2', 'test_testTreeBook_view', NULL, '8d3517427e527df11d51da528261c915', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2019-08-11 14:32:06.853', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e5ea38c1f97dee0043e78f3fb27b25d6', '生成方案编辑', '2', 'gen_scheme_edit', NULL, '247071d42ff40267c8d8c44eac92da67', '413892fe8d52c1163d6659f51299dc96,247071d42ff40267c8d8c44eac92da67,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-21 13:29:14.000', '1', '2020-05-18 11:39:42.102', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('e66c7efccb9e1a0519afc328339e9108', '登录日志删除', '2', 'sys_logLogin_del', NULL, 'a41d4ac1a6cc179696e0dbf284e3efc4', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2019-08-15 09:26:02.357', '1', '2020-05-17 14:55:26.867', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e6ea0a5dc986c69852010e4a24329cf1', '任务调度方案编辑', '2', 'quartz_job_edit', NULL, '322efc9833f2562f8862f882dabdf3d6', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 40, '1', '2019-08-14 10:35:56.089', '1', '2020-05-15 21:06:35.180', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('e710a66583fe0e324492462adb16014e', '业务表删除', '2', 'gen_table_del', NULL, 'a18b33e15bde209a3c9115517c56d9ec', 'ef2382c0cc2d99ee73444e684237a88a,413892fe8d52c1163d6659f51299dc96,a18b33e15bde209a3c9115517c56d9ec,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-07-21 13:24:45.000', '1', '2020-05-18 11:39:42.110', NULL, 6, '0');
INSERT INTO `sys_menu` VALUES ('eb17cee437ea6b630dad59fff2a059ca', '多级菜单', '0', NULL, '/nested', '-1', NULL, 'dev', 'Layout', b'0', b'0', b'0', b'0', 100, '1', '2020-05-18 11:09:23.393', '1', '2020-05-25 10:13:50.571', NULL, 13, '0');
INSERT INTO `sys_menu` VALUES ('ed690ac2933fc89fe7f4d01688e38ea4', 'testBook', '1', NULL, 'test-book', '1000', NULL, 'icon-right-square', 'biz/test-book/index', b'0', b'0', b'0', b'0', 30, '1', '2020-08-16 16:20:36.587', '1', '2020-08-16 16:21:32.306', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('ef2382c0cc2d99ee73444e684237a88a', '系统工具', '0', NULL, '/admin', '-1', NULL, 'sys-tools', 'Layout', b'0', b'0', b'0', b'0', 30, '1', '2019-08-05 15:58:12.000', '1', '2020-05-19 02:17:53.050', NULL, 46, '0');
INSERT INTO `sys_menu` VALUES ('f15e2186907d22765cd149a94905842a', '在线用户强退', '2', 'sys_userOnline_logout', NULL, '6e3f89cda84ac2c6e715e7812c102ae8', '2000,6e3f89cda84ac2c6e715e7812c102ae8,', NULL, NULL, b'0', b'0', b'0', b'1', 30, '1', '2019-08-11 10:57:51.502', '1', '2020-05-16 17:55:59.729', NULL, 5, '0');
INSERT INTO `sys_menu` VALUES ('f1e9e8bf1c2fe2302724c453490c91b6', '联系单删除', '2', 'biz_contactInfo_del', NULL, '6d066d50173c42d31d5b46a9fea82fb7', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 80, '1', '2020-09-04 20:44:42.042', '1', '2020-09-04 20:44:42.042', NULL, 0, '0');
INSERT INTO `sys_menu` VALUES ('f6d6b0be40b21899380fd7983d371c3a', '测试书籍删除', '2', 'test_testBook_del', NULL, '2c0688c2ad9259b9a7e7088a2f6ade4e', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 80, '1', '2020-05-25 09:36:39.132', '1', '2020-05-25 10:12:05.946', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('f9ad900ea905f0d388d9d2da66a42aef', '测试树编辑', '2', 'test_testTreeBook_edit', NULL, 'c206444a1d18c7b505dea8ed5a617669', NULL, NULL, NULL, b'0', NULL, b'0', b'0', 40, '1', '2020-05-25 10:12:00.671', '1', '2020-05-25 10:15:02.864', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('fb40ac1db035d60c99eb58283e334f74', 'testBook查看', '2', 'biz_testBook_view', NULL, 'd3d0dcfc154f40fc77e3711e5e964996', NULL, NULL, NULL, b'0', b'0', b'0', b'0', 20, '1', '2020-08-08 21:04:54.698', '1', '2020-08-08 21:20:47.646', NULL, 0, '1');
INSERT INTO `sys_menu` VALUES ('fe4c7938e146ec223e99d426aaa87109', '三级菜单2', '1', NULL, 'menu1-2', '1ae562534a64d4473899e52497c40b2e', 'eb17cee437ea6b630dad59fff2a059ca,1ae562534a64d4473899e52497c40b2e,', 'dev', 'nested/menu1/menu1-2', b'0', b'0', b'0', b'1', 30, '1', '2020-05-18 11:13:18.819', '1', '2020-05-25 10:13:50.588', NULL, 3, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_persistent_token
-- ----------------------------
DROP TABLE IF EXISTS `sys_persistent_token`;
CREATE TABLE `sys_persistent_token` (
  `series` varchar(76) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `token_value` varchar(76) NOT NULL,
  `token_date` timestamp(3) NULL DEFAULT NULL,
  `ip_address` varchar(39) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `login_location` varchar(255) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '操作系统',
  PRIMARY KEY (`series`) USING BTREE,
  KEY `fk_user_persistent_token` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_persistent_token
-- ----------------------------
BEGIN;
INSERT INTO `sys_persistent_token` VALUES ('jeg4tzpdr3bb1wghyq98', '1', 'admin', 'zy95xy6l8bxhuq8vkr4x', '2020-05-27 11:30:33.281', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016');
INSERT INTO `sys_persistent_token` VALUES ('snhdb8hbzvzfmb7fyl19', '1', 'admin', 'z69qbar0w0fltj4egbcs', '2020-05-29 22:29:15.595', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `level` int(11) DEFAULT NULL COMMENT '角色级别',
  `data_scope` char(1) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '数据权限 1全部 2所在机构及以下数据  3 所在机构数据  4仅本人数据 5 按明细设置',
  `available` char(1) COLLATE utf8mb4_bin DEFAULT '1' COMMENT '1-正常，0-锁定',
  `created_by` varchar(50) CHARACTER SET utf8 NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3),
  `description` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '描述',
  `version` int(11) NOT NULL,
  `del_flag` char(1) COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='系统角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES ('1', '超级管理员', 1, '1', '1', '', '2017-10-29 15:45:51.000', '1', '2020-05-14 11:00:00.741', NULL, 75, '0');
INSERT INTO `sys_role` VALUES ('2', '机构管理员', 2, '2', '1', '', '2018-11-11 19:42:26.000', '1', '2020-05-14 11:01:14.154', NULL, 18, '0');
INSERT INTO `sys_role` VALUES ('262da20a182dd09e70422cbca05503b7', 'tets', 3, '5', '1', '1', '2020-05-14 11:21:30.869', '1', '2020-05-14 11:28:55.628', NULL, 0, '1');
INSERT INTO `sys_role` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '后台管理员', 2, '1', '1', '1', '2020-05-14 11:02:13.389', '1', '2020-08-30 14:30:51.035', NULL, 4, '0');
INSERT INTO `sys_role` VALUES ('4647a907ad1dd30b28cbdaa229b67fc1', '普通管理员', 4, '4', '1', '1', '2020-05-14 11:00:50.813', '1', '2020-05-14 11:30:26.577', '普通管理', 6, '0');
INSERT INTO `sys_role` VALUES ('49dbe45a4e2a06a56730851e0c87f166', '企业普通用户', 3, '2', '1', '1', '2020-08-16 14:48:25.319', '1', '2020-08-29 01:19:53.793', NULL, 1, '0');
INSERT INTO `sys_role` VALUES ('904a870be22c6b84845dbd1699655b4a', '个人用户', 3, '4', '1', '1', '2020-08-16 14:47:33.168', '1', '2020-08-16 14:47:33.168', NULL, 0, '0');
INSERT INTO `sys_role` VALUES ('cdff3f167ae3dfc7984cd6e36976ddf8', '企业管理员', 3, '2', '1', '1', '2020-08-16 14:48:16.599', '1', '2020-08-16 14:48:16.599', NULL, 0, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `id` varchar(32) NOT NULL,
  `role_id` varchar(32) DEFAULT NULL COMMENT '角色ID',
  `dept_id` varchar(32) DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色与部门对应关系';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_dept` VALUES ('28e2bd6452d0aff99f014136336eab61', '1', '8');
INSERT INTO `sys_role_dept` VALUES ('34481e9777757dd6ffe1c799749b4db5', '2', '5');
INSERT INTO `sys_role_dept` VALUES ('5c5c58ad79db6edea88100e6491e5e30', '2', '4');
INSERT INTO `sys_role_dept` VALUES ('64af22db5dbe5cf69de8fa7f2d917922', '2', '3');
INSERT INTO `sys_role_dept` VALUES ('c3b5457350bb7a9be8201fa3f88d3c2c', '262da20a182dd09e70422cbca05503b7', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` varchar(32) NOT NULL COMMENT '角色ID',
  `menu_id` varchar(32) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色菜单表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` VALUES ('1', '04c21fed93d35764a3feebf9e30f50e5');
INSERT INTO `sys_role_menu` VALUES ('1', '096d58aaf7e893e7ee655bae823bd3fe');
INSERT INTO `sys_role_menu` VALUES ('1', '0c3be2aeb338898b2508e5f075cf5c38');
INSERT INTO `sys_role_menu` VALUES ('1', '0d0be247863fcbf08b3db943e5f45992');
INSERT INTO `sys_role_menu` VALUES ('1', '1000');
INSERT INTO `sys_role_menu` VALUES ('1', '10bd98f30a42427dd7ef75418ad3da6b');
INSERT INTO `sys_role_menu` VALUES ('1', '1100');
INSERT INTO `sys_role_menu` VALUES ('1', '1101');
INSERT INTO `sys_role_menu` VALUES ('1', '1102');
INSERT INTO `sys_role_menu` VALUES ('1', '1103');
INSERT INTO `sys_role_menu` VALUES ('1', '1200');
INSERT INTO `sys_role_menu` VALUES ('1', '1201');
INSERT INTO `sys_role_menu` VALUES ('1', '1202');
INSERT INTO `sys_role_menu` VALUES ('1', '1203');
INSERT INTO `sys_role_menu` VALUES ('1', '1300');
INSERT INTO `sys_role_menu` VALUES ('1', '1301');
INSERT INTO `sys_role_menu` VALUES ('1', '1302');
INSERT INTO `sys_role_menu` VALUES ('1', '1303');
INSERT INTO `sys_role_menu` VALUES ('1', '13093fb658c1806ad5bd0600316158f2');
INSERT INTO `sys_role_menu` VALUES ('1', '133f1408f5e3187d3e1a00b0260b7165');
INSERT INTO `sys_role_menu` VALUES ('1', '1400');
INSERT INTO `sys_role_menu` VALUES ('1', '1401');
INSERT INTO `sys_role_menu` VALUES ('1', '1402');
INSERT INTO `sys_role_menu` VALUES ('1', '1403');
INSERT INTO `sys_role_menu` VALUES ('1', '165e8d044309484cd8cc8dcd79c4e2f1');
INSERT INTO `sys_role_menu` VALUES ('1', '174d5b8fe7d45a1d12d3ff3aa54fb222');
INSERT INTO `sys_role_menu` VALUES ('1', '18d6b5e0f6b986cd074bf23de11ecd34');
INSERT INTO `sys_role_menu` VALUES ('1', '1ae562534a64d4473899e52497c40b2e');
INSERT INTO `sys_role_menu` VALUES ('1', '1bbac8b179d963332b07d200672543ca');
INSERT INTO `sys_role_menu` VALUES ('1', '2000');
INSERT INTO `sys_role_menu` VALUES ('1', '2100');
INSERT INTO `sys_role_menu` VALUES ('1', '2101');
INSERT INTO `sys_role_menu` VALUES ('1', '2200');
INSERT INTO `sys_role_menu` VALUES ('1', '2201');
INSERT INTO `sys_role_menu` VALUES ('1', '2202');
INSERT INTO `sys_role_menu` VALUES ('1', '247071d42ff40267c8d8c44eac92da67');
INSERT INTO `sys_role_menu` VALUES ('1', '2500');
INSERT INTO `sys_role_menu` VALUES ('1', '2600');
INSERT INTO `sys_role_menu` VALUES ('1', '2601');
INSERT INTO `sys_role_menu` VALUES ('1', '29de79df95e70d8e8fbdc7945acf214a');
INSERT INTO `sys_role_menu` VALUES ('1', '31265d5c7cf40ee21e3963476cabe26f');
INSERT INTO `sys_role_menu` VALUES ('1', '413892fe8d52c1163d6659f51299dc96');
INSERT INTO `sys_role_menu` VALUES ('1', '52715698214e88cb09fa4dd1ea5ad348');
INSERT INTO `sys_role_menu` VALUES ('1', '5404c3df9f771dbc0237578814bbe44b');
INSERT INTO `sys_role_menu` VALUES ('1', '5b39ca5a25c772105c71f8c51d1f19d4');
INSERT INTO `sys_role_menu` VALUES ('1', '5e7e7140a49eb205075fb31205ddccbf');
INSERT INTO `sys_role_menu` VALUES ('1', '618ee4b9660265a85a8b61277de2a579');
INSERT INTO `sys_role_menu` VALUES ('1', '621e50e1c7d66a1febeb699bebb2fe35');
INSERT INTO `sys_role_menu` VALUES ('1', '64b61b8966e1c74d9b309069b2f622d1');
INSERT INTO `sys_role_menu` VALUES ('1', '6d066d50173c42d31d5b46a9fea82fb7');
INSERT INTO `sys_role_menu` VALUES ('1', '6d101761341b2ca58db9a953a1fde5e0');
INSERT INTO `sys_role_menu` VALUES ('1', '6e3f89cda84ac2c6e715e7812c102ae8');
INSERT INTO `sys_role_menu` VALUES ('1', '74f2b2a8871a298e0acc4d7129d10e9c');
INSERT INTO `sys_role_menu` VALUES ('1', '76d6087052dc26b32f3efa71b9cc119b');
INSERT INTO `sys_role_menu` VALUES ('1', '7754b1457826c48290bc189bb1289740');
INSERT INTO `sys_role_menu` VALUES ('1', '795b4d5cf0eb3ed80e24cbab39727b9d');
INSERT INTO `sys_role_menu` VALUES ('1', '7b14af9e9fbff286856338a194422b07');
INSERT INTO `sys_role_menu` VALUES ('1', '92f78825551a22fa130c03066f398448');
INSERT INTO `sys_role_menu` VALUES ('1', '9763343d9cce11ce9eb4f21c8e49122b');
INSERT INTO `sys_role_menu` VALUES ('1', '97722c6d56c8b9990cc3c1a6eea3d6bb');
INSERT INTO `sys_role_menu` VALUES ('1', '9f02e346b5350366968f217daef3f1b7');
INSERT INTO `sys_role_menu` VALUES ('1', 'a18b33e15bde209a3c9115517c56d9ec');
INSERT INTO `sys_role_menu` VALUES ('1', 'ad2ea4cf4a36770597f8e473bbf5b64b');
INSERT INTO `sys_role_menu` VALUES ('1', 'b1a7134f07a41e5f91df9f6c3b0238d4');
INSERT INTO `sys_role_menu` VALUES ('1', 'b8eafb6c3a8bf0919230f0bfa59d86b6');
INSERT INTO `sys_role_menu` VALUES ('1', 'b961670cbf3454f5927c4bd2a327e915');
INSERT INTO `sys_role_menu` VALUES ('1', 'b963a451117f430703817b3b6c87402a');
INSERT INTO `sys_role_menu` VALUES ('1', 'bb9dd4b7a2a462193d0f01517308f812');
INSERT INTO `sys_role_menu` VALUES ('1', 'bd62904371247f56594741ff8e9bded9');
INSERT INTO `sys_role_menu` VALUES ('1', 'c0ba37c10abaecd89a738c5cf2a2fd24');
INSERT INTO `sys_role_menu` VALUES ('1', 'caaec41413c5713c6f290efe08c11415');
INSERT INTO `sys_role_menu` VALUES ('1', 'cb13db6c1daea6afdba933ef6ad9d2a7');
INSERT INTO `sys_role_menu` VALUES ('1', 'cb493ffb145ee7d7d5c31119180f0f96');
INSERT INTO `sys_role_menu` VALUES ('1', 'd4c16faad8f883650a3a8eab829ebad9');
INSERT INTO `sys_role_menu` VALUES ('1', 'd5159fe06c7ac2003426fa1b3c8d43b8');
INSERT INTO `sys_role_menu` VALUES ('1', 'd9d87cf8ed7c29ed2eda06d5dec4dcda');
INSERT INTO `sys_role_menu` VALUES ('1', 'e086c4aa4943a883b29cf94680608b89');
INSERT INTO `sys_role_menu` VALUES ('1', 'e5ea38c1f97dee0043e78f3fb27b25d6');
INSERT INTO `sys_role_menu` VALUES ('1', 'e710a66583fe0e324492462adb16014e');
INSERT INTO `sys_role_menu` VALUES ('1', 'eb17cee437ea6b630dad59fff2a059ca');
INSERT INTO `sys_role_menu` VALUES ('1', 'ef2382c0cc2d99ee73444e684237a88a');
INSERT INTO `sys_role_menu` VALUES ('1', 'f15e2186907d22765cd149a94905842a');
INSERT INTO `sys_role_menu` VALUES ('1', 'f1e9e8bf1c2fe2302724c453490c91b6');
INSERT INTO `sys_role_menu` VALUES ('1', 'fe4c7938e146ec223e99d426aaa87109');
INSERT INTO `sys_role_menu` VALUES ('2', '0d0be247863fcbf08b3db943e5f45992');
INSERT INTO `sys_role_menu` VALUES ('2', '1000');
INSERT INTO `sys_role_menu` VALUES ('2', '10bd98f30a42427dd7ef75418ad3da6b');
INSERT INTO `sys_role_menu` VALUES ('2', '1100');
INSERT INTO `sys_role_menu` VALUES ('2', '1101');
INSERT INTO `sys_role_menu` VALUES ('2', '1102');
INSERT INTO `sys_role_menu` VALUES ('2', '1103');
INSERT INTO `sys_role_menu` VALUES ('2', '1200');
INSERT INTO `sys_role_menu` VALUES ('2', '1201');
INSERT INTO `sys_role_menu` VALUES ('2', '1202');
INSERT INTO `sys_role_menu` VALUES ('2', '1203');
INSERT INTO `sys_role_menu` VALUES ('2', '1300');
INSERT INTO `sys_role_menu` VALUES ('2', '1301');
INSERT INTO `sys_role_menu` VALUES ('2', '1302');
INSERT INTO `sys_role_menu` VALUES ('2', '1303');
INSERT INTO `sys_role_menu` VALUES ('2', '13093fb658c1806ad5bd0600316158f2');
INSERT INTO `sys_role_menu` VALUES ('2', '133f1408f5e3187d3e1a00b0260b7165');
INSERT INTO `sys_role_menu` VALUES ('2', '1400');
INSERT INTO `sys_role_menu` VALUES ('2', '1401');
INSERT INTO `sys_role_menu` VALUES ('2', '1402');
INSERT INTO `sys_role_menu` VALUES ('2', '1403');
INSERT INTO `sys_role_menu` VALUES ('2', '18d6b5e0f6b986cd074bf23de11ecd34');
INSERT INTO `sys_role_menu` VALUES ('2', '2000');
INSERT INTO `sys_role_menu` VALUES ('2', '2100');
INSERT INTO `sys_role_menu` VALUES ('2', '2101');
INSERT INTO `sys_role_menu` VALUES ('2', '2200');
INSERT INTO `sys_role_menu` VALUES ('2', '2201');
INSERT INTO `sys_role_menu` VALUES ('2', '2202');
INSERT INTO `sys_role_menu` VALUES ('2', '247071d42ff40267c8d8c44eac92da67');
INSERT INTO `sys_role_menu` VALUES ('2', '2500');
INSERT INTO `sys_role_menu` VALUES ('2', '2600');
INSERT INTO `sys_role_menu` VALUES ('2', '2601');
INSERT INTO `sys_role_menu` VALUES ('2', '29de79df95e70d8e8fbdc7945acf214a');
INSERT INTO `sys_role_menu` VALUES ('2', '413892fe8d52c1163d6659f51299dc96');
INSERT INTO `sys_role_menu` VALUES ('2', '52715698214e88cb09fa4dd1ea5ad348');
INSERT INTO `sys_role_menu` VALUES ('2', '621e50e1c7d66a1febeb699bebb2fe35');
INSERT INTO `sys_role_menu` VALUES ('2', '6e3f89cda84ac2c6e715e7812c102ae8');
INSERT INTO `sys_role_menu` VALUES ('2', '74f2b2a8871a298e0acc4d7129d10e9c');
INSERT INTO `sys_role_menu` VALUES ('2', '76d6087052dc26b32f3efa71b9cc119b');
INSERT INTO `sys_role_menu` VALUES ('2', '7754b1457826c48290bc189bb1289740');
INSERT INTO `sys_role_menu` VALUES ('2', '7b14af9e9fbff286856338a194422b07');
INSERT INTO `sys_role_menu` VALUES ('2', '92f78825551a22fa130c03066f398448');
INSERT INTO `sys_role_menu` VALUES ('2', '9763343d9cce11ce9eb4f21c8e49122b');
INSERT INTO `sys_role_menu` VALUES ('2', '97722c6d56c8b9990cc3c1a6eea3d6bb');
INSERT INTO `sys_role_menu` VALUES ('2', 'a18b33e15bde209a3c9115517c56d9ec');
INSERT INTO `sys_role_menu` VALUES ('2', 'b961670cbf3454f5927c4bd2a327e915');
INSERT INTO `sys_role_menu` VALUES ('2', 'b963a451117f430703817b3b6c87402a');
INSERT INTO `sys_role_menu` VALUES ('2', 'bb9dd4b7a2a462193d0f01517308f812');
INSERT INTO `sys_role_menu` VALUES ('2', 'bd62904371247f56594741ff8e9bded9');
INSERT INTO `sys_role_menu` VALUES ('2', 'c0ba37c10abaecd89a738c5cf2a2fd24');
INSERT INTO `sys_role_menu` VALUES ('2', 'caaec41413c5713c6f290efe08c11415');
INSERT INTO `sys_role_menu` VALUES ('2', 'd4c16faad8f883650a3a8eab829ebad9');
INSERT INTO `sys_role_menu` VALUES ('2', 'e086c4aa4943a883b29cf94680608b89');
INSERT INTO `sys_role_menu` VALUES ('2', 'e5ea38c1f97dee0043e78f3fb27b25d6');
INSERT INTO `sys_role_menu` VALUES ('2', 'e710a66583fe0e324492462adb16014e');
INSERT INTO `sys_role_menu` VALUES ('2', 'ef2382c0cc2d99ee73444e684237a88a');
INSERT INTO `sys_role_menu` VALUES ('2', 'f15e2186907d22765cd149a94905842a');
INSERT INTO `sys_role_menu` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1100');
INSERT INTO `sys_role_menu` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1101');
INSERT INTO `sys_role_menu` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1102');
INSERT INTO `sys_role_menu` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1103');
INSERT INTO `sys_role_menu` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1300');
INSERT INTO `sys_role_menu` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1301');
INSERT INTO `sys_role_menu` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1302');
INSERT INTO `sys_role_menu` VALUES ('3570f348af7214a976e5d6bfbdd97df1', '1303');
INSERT INTO `sys_role_menu` VALUES ('4647a907ad1dd30b28cbdaa229b67fc1', '1000');
INSERT INTO `sys_role_menu` VALUES ('4647a907ad1dd30b28cbdaa229b67fc1', '1100');
INSERT INTO `sys_role_menu` VALUES ('49dbe45a4e2a06a56730851e0c87f166', '04c21fed93d35764a3feebf9e30f50e5');
INSERT INTO `sys_role_menu` VALUES ('49dbe45a4e2a06a56730851e0c87f166', '1bbac8b179d963332b07d200672543ca');
INSERT INTO `sys_role_menu` VALUES ('49dbe45a4e2a06a56730851e0c87f166', '5e7e7140a49eb205075fb31205ddccbf');
INSERT INTO `sys_role_menu` VALUES ('49dbe45a4e2a06a56730851e0c87f166', 'cb493ffb145ee7d7d5c31119180f0f96');
INSERT INTO `sys_role_menu` VALUES ('904a870be22c6b84845dbd1699655b4a', '04c21fed93d35764a3feebf9e30f50e5');
INSERT INTO `sys_role_menu` VALUES ('904a870be22c6b84845dbd1699655b4a', '1bbac8b179d963332b07d200672543ca');
INSERT INTO `sys_role_menu` VALUES ('904a870be22c6b84845dbd1699655b4a', '5e7e7140a49eb205075fb31205ddccbf');
INSERT INTO `sys_role_menu` VALUES ('904a870be22c6b84845dbd1699655b4a', 'cb493ffb145ee7d7d5c31119180f0f96');
INSERT INTO `sys_role_menu` VALUES ('cdff3f167ae3dfc7984cd6e36976ddf8', '04c21fed93d35764a3feebf9e30f50e5');
INSERT INTO `sys_role_menu` VALUES ('cdff3f167ae3dfc7984cd6e36976ddf8', '1bbac8b179d963332b07d200672543ca');
INSERT INTO `sys_role_menu` VALUES ('cdff3f167ae3dfc7984cd6e36976ddf8', '5e7e7140a49eb205075fb31205ddccbf');
INSERT INTO `sys_role_menu` VALUES ('cdff3f167ae3dfc7984cd6e36976ddf8', 'cb493ffb145ee7d7d5c31119180f0f96');
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` varchar(32) COLLATE utf8mb4_bin NOT NULL DEFAULT '1' COMMENT '主键ID',
  `username` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `password` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `nickname` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '昵称',
  `phone` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '简介',
  `email` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '头像',
  `dept_id` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '部门ID',
  `qq_open_id` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'QQ openid',
  `wx_open_id` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '微信openid',
  `available` char(1) COLLATE utf8mb4_bin DEFAULT '1' COMMENT '1-正常，0-锁定',
  `created_by` varchar(50) CHARACTER SET utf8 NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `description` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '描述',
  `version` int(11) NOT NULL,
  `del_flag` char(1) COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_wx_openid` (`wx_open_id`) USING BTREE,
  KEY `user_qq_openid` (`qq_open_id`) USING BTREE,
  KEY `user_idx1_username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES ('1', 'admin', '$2a$10$xPFxiboHiwEyURoblSWrv.i.7tGP6Vop.77IqIMLo6CzOw/ygvSw6', 'albedo', '17034642999', '22@ss.com', NULL, '1', NULL, 'o_0FT0uyg_H1vVy2H0JpSwlVGhWQ', '1', '', '2018-04-20 07:15:18.000', '1', '2020-09-02 12:35:58.255', '11', 47, '0');
INSERT INTO `sys_user` VALUES ('24b4bf2b0bcb7887f0e557d23d5c19a0', 'backend', '$2a$10$eltQ6ESPEevLUtbBmo0.Cug/LmovMbZR.d6oY3AsTownK0acxVYv6', NULL, '13346182371', '13346182371@163.com', NULL, 'c095173c3aebcd7ff9c6177fbf7a8b69', NULL, NULL, '1', '1', '2020-09-04 23:29:03.561', '1', '2020-09-04 23:29:03.561', NULL, 0, '0');
INSERT INTO `sys_user` VALUES ('5e82e2785a023c6e3c73b60371775efc', 'abcAccount', '$2a$10$DgdOVTVSn5WN9rarGz9vG.3p95rj/2cDY4dIJKUhIEl4eV5lBeZ8e', NULL, '', NULL, NULL, '4ec5d159e0c8196f2b4e0c8dc117639e', NULL, NULL, '1', 'system', '2020-09-05 00:01:47.161', 'system', '2020-09-05 00:01:47.161', NULL, 0, '0');
INSERT INTO `sys_user` VALUES ('9bc1afb81c83a33337a359ff41328cff', 'abcAccount2', '$2a$10$HG2qszymsPwm0ziYp8eSIOhE7twKvjeFNkYBiGbdu7uAsgOWcQ2yK', NULL, '', NULL, NULL, '5d675ff6a074c891fd1cd3e713198d34', NULL, NULL, '1', 'system', '2020-09-05 00:06:17.332', 'system', '2020-09-05 00:06:17.332', NULL, 0, '0');
INSERT INTO `sys_user` VALUES ('be1dc4776a045359d22312563697d569', 'bizAccount', '$2a$10$skbwDKv2.DC4vsCyKvVbeOBhJNwHu8G229mfTKwgS6TVrkBehApQK', NULL, '', NULL, NULL, '36af404b1b81da23c602bf048824b7a2', NULL, NULL, '1', 'system', '2020-09-04 23:31:10.998', 'system', '2020-09-04 23:31:10.998', NULL, 0, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_online
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_online`;
CREATE TABLE `sys_user_online` (
  `session_id` varchar(50) NOT NULL DEFAULT '' COMMENT '用户会话id',
  `user_id` varchar(32) DEFAULT NULL COMMENT '登录ID',
  `username` varchar(50) DEFAULT '' COMMENT '登录账号',
  `dept_id` varchar(32) DEFAULT NULL COMMENT '部门ID',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `ip_address` varchar(50) DEFAULT '' COMMENT 'IP',
  `ip_location` varchar(255) DEFAULT '' COMMENT 'IP地址',
  `user_agent` varchar(2000) DEFAULT NULL COMMENT '用户代理',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` varchar(10) DEFAULT '' COMMENT '在线状态on_line在线off_line离线',
  `start_timestamp` datetime DEFAULT NULL COMMENT 'session创建时间',
  `last_access_time` datetime DEFAULT NULL COMMENT 'session最后访问时间',
  `expire_time` int(11) DEFAULT '0' COMMENT '超时时间，单位为分钟',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`session_id`) USING BTREE,
  UNIQUE KEY `session_id` (`session_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='在线用户记录';

-- ----------------------------
-- Records of sys_user_online
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_online` VALUES ('-o8ZCk8YAneRqVF_4pEExR-WCSFS-12WyW8KIy6f', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-18 10:26:48', '2020-08-18 10:31:06', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('0mbzAvfIQQ3xnQGyOSMEDNgdNuKJ1S3SRj_PIlW0', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-11 20:38:48', '2020-08-11 20:38:48', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('2Vab9gSXXw295JaLtLFh_T0U_lLn9dKyth_THhtV', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-02 13:50:04', '2020-09-02 13:53:09', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('3HfD7cCT6qLhNtveoRlTVr-BqAK3BJu7XzpXcHeY', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-30 14:29:38', '2020-08-30 14:34:22', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('3izPP6MPep4-V9nz42bH4bPXCsC_lwk-xtTso4mg', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-16 16:45:21', '2020-08-16 16:45:21', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('3LjZYi8gtmUYalxlEQJquY76dsQuXgGwGTBWqNaF', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-08 21:20:29', '2020-08-08 21:20:29', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('4EG9hu0bnxv3uPgHzNKF22Bdhg6phhsh2pIkiiXV', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-29 17:14:28', '2020-08-29 17:17:47', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('4tWrQLXzBPfGizp-QTFdSfQoWzfLf44OS2YVaT8P', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-08 20:19:22', '2020-08-08 20:19:22', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('4W1gPMWE_hGFQuTLHKAEiGai49_x0tSjuXAYHf6Y', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-05 00:17:36', '2020-09-05 00:28:52', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('53YI9YvopLxtMr20onrQgefAmIDgTUOqm9WW8QQL', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-07 20:14:41', '2020-08-07 20:23:08', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('6SN2iHyIt5gcyDnQsjYbbTAij5IwWLpV9_7wlvgU', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-08 21:03:48', '2020-08-08 21:09:38', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('7DqkYf0Cd5-LjlVRPbClgBHJ20Pb9MIUZ5xihXx_', 'c1c21f56f6fdca9bde3a2e1da5886dc0', 'test3', '4d20ae207d9c836a732480429af58273', '公共部门', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-02 12:37:20', '2020-09-02 12:37:20', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('8iEdc7X4VNaPiLO-luL-sRC-xhTywsNHG541ngS4', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-29 21:37:49', '2020-08-29 21:37:49', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('9q9al6pkVg9foATJQmcY2hAzdrkVGSQ6ycaOVnou', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-04 19:23:04', '2020-09-04 19:23:04', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('AfaFQmX572T1oY_Mz4m4qKmmk0t2MtV_zI8eu4tc', '099ba5bc557a68c539e13f1df73586ac', 'personal2', '4d20ae207d9c836a732480429af58273', '公共部门', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-04 23:35:06', '2020-09-04 23:35:06', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('AHKsiwmpxJiloXCxOo82rLjdbJOMVTh5K1Sllc-E', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-08 20:30:54', '2020-08-08 20:36:08', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('aqa48ANkiS97O4ah34IpI2VuuV-ZXdZpcU5f-r6O', '9d1c246296a00c3e54783f2cf0303ddb', 'personal3', '4d20ae207d9c836a732480429af58273', '个人用户', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-16 16:03:43', '2020-08-16 16:03:43', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('Av2aWjYMNO4PjsiA_3dAOZJSKGxqRsso11NZE1yf', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-04 19:23:49', '2020-09-04 19:23:49', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('B9PfMnCggLM9ULLTgLakyvVxNVTb-Kc1rdCxc9bR', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-29 01:19:35', '2020-08-29 01:26:28', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('BALP5Jz3Kfs1AFW5oIT_VnSvpABqBxr5WkQrgdxL', '24b4bf2b0bcb7887f0e557d23d5c19a0', 'backend', 'c095173c3aebcd7ff9c6177fbf7a8b69', '平台', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-04 23:29:25', '2020-09-04 23:29:25', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('c0OvpJnwxJrSBQF_uBqhTlrrj31QUZBg1yYCB404', 'd20e7f392fd61954d432c6bc73cf043e', 'admin2', 'c095173c3aebcd7ff9c6177fbf7a8b69', '平台', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-30 14:42:48', '2020-08-30 14:42:48', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('dbgW_4FdzsolbPAeUlT_h1utzhseDWWIlOKOoX2t', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-08 20:40:10', '2020-08-08 20:42:18', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('dCnUhxEUEQZ5susuf5UvM65VkH56LGZN3gqMLmYl', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-29 01:30:49', '2020-08-29 01:35:19', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('EE03nWBJOO-GAlItFkO-8pgJS3nOOm5H6543N7N-', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-29 01:38:09', '2020-08-29 01:39:22', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('eg1paaOcIs-P1Wc3c9rU--Ejn2zOwPyi3nCjSA1b', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-02 12:16:42', '2020-09-02 12:16:42', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('FCdsNGqVHUBTuMBEXZ048CXSrhIDSA-jxpG3l4Sc', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-08 20:13:31', '2020-08-08 20:13:31', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('FQan129PP1hMWa0gZxqjbRPlkFZzfl5ujvOT6EwN', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-04 20:51:31', '2020-09-04 20:53:37', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('fYGl0-RhBOkGUxBDZVkwHXxC0r0RP6MnSlSproSW', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-03 15:20:04', '2020-09-03 15:20:04', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('GoRn67n2L0KImEBCWZLPwQt0N8xp5OZjg-TSqh0e', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-31 18:12:05', '2020-08-31 18:13:24', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('gyWU3xVwJgzzUTh1WtbIPSj0jUM4KkYi3-OxbrBm', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-29 17:14:28', '2020-08-29 17:16:05', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('H52SJ8aOnSCA79Y0ZAC_UawWClUm_o5UQ8xSOipP', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-08 20:24:28', '2020-08-08 20:28:16', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('H6SKDIsAg9F-1cA_JvXJd6dqS18y91r6dX7JzD48', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-18 10:25:17', '2020-08-18 10:25:17', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('h6zKmb8peKKt1yKBgzuKMAHUGn7gUwEMEWYrBL_g', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-29 01:10:43', '2020-08-29 01:11:53', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('Hfrq0oYZIrleRPbKNgxjmLQG7tzf0A57gm6HHf8z', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-29 21:55:16', '2020-08-29 21:55:16', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('hPtJAuQk60t4_ql-qbgY-UTBdw10dKUSyG_HVbUg', '18c4e11409918c5fe76ca18578807af2', 'personal', '4d20ae207d9c836a732480429af58273', '公共部门', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-04 23:30:33', '2020-09-04 23:30:33', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('Hy3GveZcp1h7srb8T82AZO7K16vvv6UQNB9IArkG', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-11 20:38:48', '2020-08-11 20:38:48', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('IG80kxodGa-et8Ej895iPjXLIqCv4tmyhLTInVEF', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-18 09:26:59', '2020-08-18 09:28:11', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('iPMgw0rS_XvtmP5wvYMtJLgeLK7zUVy9jTrc75Ia', '286cf7378ccb6d74f912f71387448199', 'account3', '4d20ae207d9c836a732480429af58273', '公共部门', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-02 17:41:55', '2020-09-02 17:41:55', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('jHwnLXWm98WMNs_gZBC8FlsqRLQlQv5D5EmG8Y6E', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-08 21:24:03', '2020-08-08 21:24:03', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('JRDwrO-tfPPnsJfMxmIoenbmst4X5UhhVZKfI7z_', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-08 21:12:50', '2020-08-08 21:12:50', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('JrEQ6LZlt-d8fcqaZ0ja4mIRxDzWFss9J2rAoc7P', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-16 16:03:55', '2020-08-16 16:21:55', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('JSi--tINeDFENgcLlmxpIAFRl_A74c114A6sousu', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-16 16:03:55', '2020-08-16 16:16:15', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('KKQcC928C7Zul61feRrK5Zb6OuopuqiEmqNnyz-b', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-16 16:26:42', '2020-08-16 16:33:20', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('l7eRiAdbIF-ZfX3FYmvI8h_KnW7BE4TqyyCRHQkX', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-29 17:43:11', '2020-08-29 20:58:23', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('LTU82B7Kyks2OPf25putr6NOak6qRJC1ca2_gXX3', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-01 04:13:01', '2020-09-01 04:13:01', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('mZZcU7en_oZuFjo1fO7cCVjbHO9Pp9NyEvpzLtfa', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-08 19:58:21', '2020-08-08 20:04:02', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('nI6aHOZeJj8UFRu1O_1mNdPQUbMQ_i_SLYf7B1JL', '127713cfa8706e73721ae07748637508', 'account', '4d20ae207d9c836a732480429af58273', '公共部门', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-02 17:29:25', '2020-09-02 17:29:25', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('nLkFARp-jLEU_4vqTEnp86g5VYtnEv8kenS4pb7t', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-02 12:36:06', '2020-09-02 12:36:06', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('nlXfXtoi1Mm9iB8OTQUGAc5sYdPGg-isH-blem7T', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-05 01:01:45', '2020-09-05 01:04:18', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('Oip3hVDwx38V9ob9Ntjl9wVcGjSEgw_e5dGt8Otd', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-03 13:55:25', '2020-09-03 13:55:25', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('omwcBE_RYztW9LnXwHYc3DIdXlgS5_SEwJmGNU-N', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-29 21:24:43', '2020-08-29 21:24:43', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('PEc6lodKVH7jJGbF-aZ0R2Pb0wlxP6MrqtMP5_im', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-29 21:45:22', '2020-08-29 21:48:43', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('pRyV15e3_jjTYgc7Yssmxd6DV2O9r01LMSVzToGT', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-16 16:22:03', '2020-08-16 16:22:03', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('QroR5gxHtEUwRwabvyRSi5DB3GD_2jJJgmvcQZOv', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-05 00:06:41', '2020-09-05 00:06:41', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('qxjBuJ3dzsmZyg8R61WGCGSICkDFjCDkrvcefQF-', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-04 23:28:12', '2020-09-04 23:28:12', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('Rvu5DAp9BUaCyokbwyQl60jNPZ2e1WO_WFQezH1V', '9bc1afb81c83a33337a359ff41328cff', 'abcAccount2', '5d675ff6a074c891fd1cd3e713198d34', 'ABC商城', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-05 00:10:43', '2020-09-05 00:10:43', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('ryxy1mCt0rDrsmd-06XoBR6FOL5VFJolsCdl0OXr', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-02 12:23:23', '2020-09-02 12:23:23', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('S5qm1EYxRWn6UAlcJFTz6yVuYPGbHKIky44FwzrH', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-02 12:25:54', '2020-09-02 12:32:35', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('sHWRPMRD5YSc5ssGPlVqW1zJSo_h9_fyKcUh3khc', '9bc1afb81c83a33337a359ff41328cff', 'abcAccount2', '5d675ff6a074c891fd1cd3e713198d34', 'ABC商城', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-05 00:06:25', '2020-09-05 00:06:25', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('sI7fUypDFScD0nshjOtPxyZfnVJjrh-dDF-65lTw', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-08 20:48:00', '2020-08-08 20:48:00', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('sIcccO4Q5k2OUatcC7Uzr76uAssLDzL0xFBuWe56', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-11 13:51:07', '2020-08-11 14:01:09', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('TKJXgxX4m8ktBFrPZdPJMSiBjJF6EA9dnwGjJjWB', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-11 13:51:07', '2020-08-11 13:51:07', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('TnNMoDba4aO8JVPy4TGGEXNH7tCYV6LFbnJanw5t', '18c4e11409918c5fe76ca18578807af2', 'personal', '4d20ae207d9c836a732480429af58273', '公共部门', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-04 23:29:48', '2020-09-04 23:29:48', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('udhUADZFGU5_CFkQq65SMtxkNx-NcBXICGkb366z', '9bc1afb81c83a33337a359ff41328cff', 'abcAccount2', '5d675ff6a074c891fd1cd3e713198d34', 'ABC商城', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-05 00:17:25', '2020-09-05 00:17:25', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('uNSDqdPfFOm-JVYa6xu7Sr8l9bALXoY_3W3EH4sW', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-16 19:16:21', '2020-08-16 19:16:21', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('vYOs-30cOrl1ggDHT0jPkSP4I_aVAXcLSjP6756B', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-08 21:17:40', '2020-08-08 21:17:40', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('w6D-dlTPUeiS_AP9gS9j2PKMSz0qq86nE-ZJ_G-s', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-05 00:00:30', '2020-09-05 00:00:30', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('w8pFVDkCd50MWos9rfYsicbFk5UG2jeJISOSo9Xb', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-08 20:22:31', '2020-08-08 20:24:18', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('wj3E6yVfDnNJ2m9SX4Jm68-OnWRt6FN5sS5vKDbv', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-30 14:23:35', '2020-08-30 14:25:19', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('WKgpoFwAWb70JAXloeXPwUuLS2AXjWaoUTbcKFGA', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-05 00:08:04', '2020-09-05 00:08:04', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('X829yJaaqtW4ElfsimtP10de5XNVeVxUj0hP0uzA', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-16 14:30:06', '2020-08-16 14:48:25', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('xRbMNOgAtFvFqUeQZYV2C2oQ6jdYeqsdGS3siutY', 'ed3c0d82f9c9f26c3212eb6093262ef1', 'abcAccount3', '4d20ae207d9c836a732480429af58273', '公共部门', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.83 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-09-05 00:00:15', '2020-09-05 00:00:15', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('Y4hbr_QtAHMLcKvt5XYSIhOZDg38K7CieFeis5Vo', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-13 17:19:18', '2020-08-13 17:19:18', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('y7I2__QDHAbrM1knMTIG1rr1lrJKwkc8b3CKg_gp', '1', 'admin', '1', '总部', '192.168.0.100', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-17 20:16:56', '2020-08-17 20:19:42', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('YgJFfw4v-sy8UFhsmQhyRnXe5SMEEtsZMJ6s7-T0', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-29 17:43:11', '2020-08-29 20:48:47', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('yoCP9PGTDc7DRuAteQJCYbHrbEHIwfgefrfQwnII', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-18 10:14:31', '2020-08-18 10:19:47', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('YOSJYjpD6tYyYlqcVdjy72DyqzJD_35j3MWhJu5N', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-29 23:56:22', '2020-08-30 00:13:56', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('ZHd4xIiUMI7HPNudMyKoEvkfDMQ7F_ueOLF0c8u1', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-19 02:05:52', '2020-08-19 02:05:52', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('ZPCO6nA2nniC02CofLVN6THD-EaaYXtsDWfW_F93', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-16 15:38:52', '2020-08-16 15:38:52', 1800, '1');
INSERT INTO `sys_user_online` VALUES ('_cMZ5K_TtajW-79DqwbkvybJa5ZfU4QyJxEHP0zF', '1', 'admin', '1', '总部', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36', 'Chrome', 'OSX', 'on_line', '2020-08-29 21:45:22', '2020-08-29 21:48:43', 1800, '1');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `role_id` varchar(32) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户角色表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` VALUES ('05342c371c18c7519dabeb38da454bf5', '');
INSERT INTO `sys_user_role` VALUES ('099ba5bc557a68c539e13f1df73586ac', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO `sys_user_role` VALUES ('1', '1');
INSERT INTO `sys_user_role` VALUES ('127713cfa8706e73721ae07748637508', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO `sys_user_role` VALUES ('18320c6ecc92e1509836778b6b6634b5', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO `sys_user_role` VALUES ('18c4e11409918c5fe76ca18578807af2', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO `sys_user_role` VALUES ('24b4bf2b0bcb7887f0e557d23d5c19a0', '3570f348af7214a976e5d6bfbdd97df1');
INSERT INTO `sys_user_role` VALUES ('2740f753a29cdddbe5fa6d66d8160414', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO `sys_user_role` VALUES ('286cf7378ccb6d74f912f71387448199', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO `sys_user_role` VALUES ('33f0f04578dff1e3909102a2d7b370f6', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO `sys_user_role` VALUES ('40f4a8ae93977f30dfcfe5c4ae33aaa7', 'cdff3f167ae3dfc7984cd6e36976ddf8');
INSERT INTO `sys_user_role` VALUES ('49f40b21c1dbdc83255d5c64119fcd4d', '2');
INSERT INTO `sys_user_role` VALUES ('4c2796f3667e3e5907a04623d7fd8de4', '2');
INSERT INTO `sys_user_role` VALUES ('5168fcfd16b8bad9fb38edfab4409023', '2');
INSERT INTO `sys_user_role` VALUES ('51e995c64ed5982b9ce8ad5d559f100c', '4647a907ad1dd30b28cbdaa229b67fc1');
INSERT INTO `sys_user_role` VALUES ('53fb3761bdd95ed3d03f4a07f78ea0eb', '1');
INSERT INTO `sys_user_role` VALUES ('5e82e2785a023c6e3c73b60371775efc', 'cdff3f167ae3dfc7984cd6e36976ddf8');
INSERT INTO `sys_user_role` VALUES ('7d01e21520d08265727b15513296c3c4', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO `sys_user_role` VALUES ('855c9e3bdaf333944f4a6669db433124', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO `sys_user_role` VALUES ('88e9ff3a35f0f0c0f2cd00bb2c7ba4cf', 'cdff3f167ae3dfc7984cd6e36976ddf8');
INSERT INTO `sys_user_role` VALUES ('90da0206c39867a1b36ac36ced80c1a9', '2');
INSERT INTO `sys_user_role` VALUES ('9bc1afb81c83a33337a359ff41328cff', 'cdff3f167ae3dfc7984cd6e36976ddf8');
INSERT INTO `sys_user_role` VALUES ('9d1c246296a00c3e54783f2cf0303ddb', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO `sys_user_role` VALUES ('ac94375948c95db618d088b2eaeb354f', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO `sys_user_role` VALUES ('be1dc4776a045359d22312563697d569', 'cdff3f167ae3dfc7984cd6e36976ddf8');
INSERT INTO `sys_user_role` VALUES ('c1c21f56f6fdca9bde3a2e1da5886dc0', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO `sys_user_role` VALUES ('d20e7f392fd61954d432c6bc73cf043e', '2');
INSERT INTO `sys_user_role` VALUES ('dcc5b57ad27014f1839a9f4bb2b568b1', '2');
INSERT INTO `sys_user_role` VALUES ('e520699f68eab0949352cf56f291107a', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO `sys_user_role` VALUES ('ed3c0d82f9c9f26c3212eb6093262ef1', '904a870be22c6b84845dbd1699655b4a');
COMMIT;

-- ----------------------------
-- Table structure for t_balance
-- ----------------------------
DROP TABLE IF EXISTS `t_balance`;
CREATE TABLE `t_balance` (
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `times` int(50) NOT NULL DEFAULT '0' COMMENT '剩余次数',
  `version` int(11) DEFAULT NULL,
  `account_available` int(11) DEFAULT NULL COMMENT '剩余可创建账号',
  `storage` decimal(5,2) DEFAULT NULL COMMENT '已使用存储空间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='次数表';

-- ----------------------------
-- Table structure for t_balance_record
-- ----------------------------
DROP TABLE IF EXISTS `t_balance_record`;
CREATE TABLE `t_balance_record` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL COMMENT '操作的用户ID',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT '变更次数',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT '1为+，0为-',
  `dimension` int(11) DEFAULT NULL COMMENT '0 下单次数 1 子账号数量 2 存储空间',
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='次数变更记录';

-- ----------------------------
-- Table structure for t_config
-- ----------------------------
DROP TABLE IF EXISTS `t_config`;
CREATE TABLE `t_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(20) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `url` varchar(20) DEFAULT NULL,
  `title` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `t_config_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COMMENT='配置项';

-- ----------------------------
-- Records of t_config
-- ----------------------------
BEGIN;
INSERT INTO `t_config` VALUES (4, '美妆护肤', 'label', 'label', NULL, 'label');
INSERT INTO `t_config` VALUES (5, '时尚配饰', 'label', 'label', NULL, 'label');
INSERT INTO `t_config` VALUES (6, '单人主播', 'anchorNum', 'anchorNum', NULL, 'anchorNum');
INSERT INTO `t_config` VALUES (7, '双人主播', 'anchorNum', 'anchorNum', NULL, 'anchorNum');
INSERT INTO `t_config` VALUES (8, '站姿', 'seat', 'seat', NULL, 'seat');
INSERT INTO `t_config` VALUES (9, '坐姿', 'seat', 'seat', NULL, 'seat');
INSERT INTO `t_config` VALUES (10, '活力青春型', 'anchorType', 'anchorType', NULL, 'anchorType');
INSERT INTO `t_config` VALUES (11, '成熟稳重型', 'anchorType', 'anchorType', NULL, 'anchorType');
INSERT INTO `t_config` VALUES (12, '浪漫古风型', 'anchorType', 'anchorType', NULL, 'anchorType');
INSERT INTO `t_config` VALUES (13, '度假', 'style', 'style', 'http://www.baidu.com', 'style');
INSERT INTO `t_config` VALUES (14, '海边', 'style', 'style', 'http://www.baidu.com', 'style');
INSERT INTO `t_config` VALUES (17, '气球', 'component', 'plusService', 'http://www.baidu.com', 'component');
INSERT INTO `t_config` VALUES (18, '狗', 'component', 'plusService', 'http://www.baidu.com', 'component');
INSERT INTO `t_config` VALUES (19, '发型1', 'hairstyle', 'plusService', 'http://www.baidu.com', 'hairstyle');
INSERT INTO `t_config` VALUES (20, '发型2', 'hairstyle', 'plusService', 'http://www.baidu.com', 'hairstyle');
INSERT INTO `t_config` VALUES (21, '衣服1', 'clothes', 'plusService', 'http://www.baidu.com', 'clothes');
INSERT INTO `t_config` VALUES (22, '衣服2', 'clothes', 'plusService', 'http://www.baidu.com', 'clothes');
INSERT INTO `t_config` VALUES (23, 'red', 'color', 'plusService', 'http://www.baidu.com', 'color');
INSERT INTO `t_config` VALUES (24, '#000', 'color', 'plusService', 'http://www.baidu.com', 'color');
COMMIT;

-- ----------------------------
-- Table structure for t_contact_info
-- ----------------------------
DROP TABLE IF EXISTS `t_contact_info`;
CREATE TABLE `t_contact_info` (
  `id` varchar(32) NOT NULL COMMENT '编号',
  `company_name` varchar(32) DEFAULT NULL COMMENT '企业名称',
  `name` varchar(32) DEFAULT NULL COMMENT '姓名',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `status` varchar(100) DEFAULT NULL COMMENT '处理状态 1已联系 0未联系',
  `version` int(11) DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='企业服务联系单';

-- ----------------------------
-- Records of t_contact_info
-- ----------------------------
BEGIN;
INSERT INTO `t_contact_info` VALUES ('ecaada548ebec7e959186c65fd84687b', 'ABC商城', '张三', '123', '0', 1, NULL, '1', '2020-09-05 00:17:56.115', '1', '2020-09-05 00:18:36.562', '0');
COMMIT;

-- ----------------------------
-- Table structure for t_invoice
-- ----------------------------
DROP TABLE IF EXISTS `t_invoice`;
CREATE TABLE `t_invoice` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户id',
  `type` int(11) NOT NULL COMMENT '0-个人，1-企业',
  `name` varchar(255) NOT NULL COMMENT '企业名称/个人名称',
  `tax_num` varchar(0) DEFAULT NULL COMMENT '公司税号',
  `company_location` varchar(255) DEFAULT NULL COMMENT '注册地址',
  `company_phone` varchar(255) DEFAULT NULL COMMENT '公司电话',
  `account_bank` varchar(255) DEFAULT NULL COMMENT '开户公司',
  `account_number` varchar(32) DEFAULT NULL COMMENT '开户账号',
  `created_by` varchar(50) CHARACTER SET utf8 NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `description` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '描述',
  `version` int(11) NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='抬头';

-- ----------------------------
-- Records of t_invoice
-- ----------------------------
BEGIN;
INSERT INTO `t_invoice` VALUES ('3687bb330c6980ed12bd2b870b376e14', NULL, 1, '个人', NULL, NULL, NULL, NULL, NULL, '9bc1afb81c83a33337a359ff41328cff', '2020-09-05 00:16:36.650', '9bc1afb81c83a33337a359ff41328cff', '2020-09-05 00:16:36.650', NULL, 0, '0');
COMMIT;

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) NOT NULL COMMENT '用户id',
  `state` int(11) DEFAULT NULL COMMENT '订单状态，见OrderStatus',
  `type` varchar(255) DEFAULT NULL COMMENT '订单类型（加速卡，单次，多次）',
  `staff_id` varchar(32) DEFAULT NULL,
  `video_id` varchar(32) DEFAULT NULL COMMENT '视频id，等视频上传后更新',
  `content` varchar(50) DEFAULT NULL COMMENT '表单json',
  `created_by` varchar(50) CHARACTER SET utf8 NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `description` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '描述',
  `version` int(11) NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  `accelerate` int(11) DEFAULT NULL COMMENT '是否加速 0不加速 1加速',
  `total_amount` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='订单状态';

-- ----------------------------
-- Records of t_order
-- ----------------------------
BEGIN;
INSERT INTO `t_order` VALUES ('123', '1', 1, '1', NULL, NULL, '{}', '1', '2020-09-05 01:26:32.755', '1', '2020-09-05 01:26:23.000', NULL, 0, '0', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for t_plan
-- ----------------------------
DROP TABLE IF EXISTS `t_plan`;
CREATE TABLE `t_plan` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `name` varchar(32) DEFAULT NULL COMMENT '套餐名',
  `price` decimal(18,2) DEFAULT '0.00' COMMENT '套餐价格',
  `goods_quantity` int(11) DEFAULT '0' COMMENT '可上传的商品数量',
  `video_time` int(11) DEFAULT '0' COMMENT '单条视频最大时长',
  `child_account` int(1) DEFAULT '0' COMMENT '子账户数量',
  `edit_time` int(1) DEFAULT '0' COMMENT '人物/场景可修改次数',
  `storage` int(1) DEFAULT '0' COMMENT '存储空间，单位GB',
  `history` int(1) DEFAULT '0' COMMENT '历史版本数',
  `anchor_amount` int(1) DEFAULT '0' COMMENT '虚拟人物',
  `env_amount` int(1) DEFAULT '0' COMMENT '虚拟场景个数',
  `anchor_amount_plus` int(1) DEFAULT '0' COMMENT '存储空间，单位GB',
  `env_amount_plus` int(1) DEFAULT '0' COMMENT '存储空间，单位GB',
  `times` int(1) DEFAULT '0' COMMENT '可下单次数',
  `version` int(11) DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='套餐表';

-- ----------------------------
-- Records of t_plan
-- ----------------------------
BEGIN;
INSERT INTO `t_plan` VALUES ('3c734f2104ab77ecdaba2bb96baa929c', '升级', 100.00, 200, 2, 3, -1, 3, 0, 6, 6, -1, -1, 3, 0, NULL, 'system', '2020-09-05 01:14:20.719', 'system', '2020-08-28 22:23:14.672', '0');
INSERT INTO `t_plan` VALUES ('44fb4bc69ff88e3e7113c597b0fa99cb', '定制', 100.00, 2147483647, 2147483647, 5, 3, 2147483647, 0, 3, 3, 1, 1, 3, 0, NULL, 'system', '2020-09-05 01:14:20.731', 'system', '2020-08-28 22:22:24.773', '0');
INSERT INTO `t_plan` VALUES ('6d89ea978f83243c3a137f3d25d9f10e', '标准', 100.00, 100, 2, 3, -1, 1, 0, 3, 3, -1, -1, 3, 0, NULL, 'system', '2020-09-05 01:14:20.743', 'system', '2020-08-28 22:23:14.656', '0');
INSERT INTO `t_plan` VALUES ('71af84e41a0e9783f4a21f4a5ea2bdd0', '旗舰', 100.00, 2147483647, 4, 5, 1, 6, 0, 12, 12, 1, 1, 3, 0, NULL, 'system', '2020-09-05 01:14:20.706', 'system', '2020-08-28 22:23:14.667', '0');
COMMIT;

-- ----------------------------
-- Table structure for t_purchase_record
-- ----------------------------
DROP TABLE IF EXISTS `t_purchase_record`;
CREATE TABLE `t_purchase_record` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `user_id` varchar(64) DEFAULT NULL COMMENT '购买的用户id',
  `out_trade_no` varchar(64) DEFAULT NULL COMMENT '对接支付宝id',
  `type` char(2) DEFAULT NULL COMMENT ' 0 套餐 1 订单',
  `outer_id` varchar(500) DEFAULT NULL COMMENT '套餐id 或 订单id 用于查询其他信息',
  `total_amount` varchar(30) DEFAULT NULL COMMENT '支付金额',
  `version` int(11) DEFAULT '0' COMMENT '默认0，必填，离线乐观锁',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='消费记录';

-- ----------------------------
-- Records of t_purchase_record
-- ----------------------------
BEGIN;
INSERT INTO `t_purchase_record` VALUES ('37a49b552896e70ff381092ead398432', '1', '202009050118521645', NULL, '3c734f2104ab77ecdaba2bb96baa929c', '100.00', 0, NULL, '1', '2020-09-05 01:18:52.013', '1', '2020-09-05 01:18:52.013', '0');
INSERT INTO `t_purchase_record` VALUES ('9b789ca9be5c55bac5a9648a71e36c21', '1', '202009050114387364', NULL, '3c734f2104ab77ecdaba2bb96baa929c', '100.00', 0, NULL, '1', '2020-09-05 01:14:38.052', '1', '2020-09-05 01:14:38.052', '0');
INSERT INTO `t_purchase_record` VALUES ('a0f58ac1032100a0e21eb3b1860713bf', '1', '202009050120115171', NULL, '3c734f2104ab77ecdaba2bb96baa929c', '100.00', 0, NULL, '1', '2020-09-05 01:20:11.434', '1', '2020-09-05 01:20:11.434', '0');
INSERT INTO `t_purchase_record` VALUES ('d28a74a12c9b2ca0547850aa13caa7ec', '1', '202009050112536959', NULL, '3c734f2104ab77ecdaba2bb96baa929c', '0.00', 0, NULL, '1', '2020-09-05 01:12:53.188', '1', '2020-09-05 01:12:53.188', '0');
COMMIT;

-- ----------------------------
-- Table structure for t_video
-- ----------------------------
DROP TABLE IF EXISTS `t_video`;
CREATE TABLE `t_video` (
  `id` varchar(32) NOT NULL,
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户id',
  `name` varchar(255) DEFAULT NULL COMMENT '视频名字',
  `origin_url` varchar(255) DEFAULT NULL,
  `logo_url` varchar(255) DEFAULT NULL COMMENT 'logo的地址',
  `output_url` varchar(255) DEFAULT NULL COMMENT '输出地址',
  `duration` int(11) DEFAULT NULL COMMENT '视频长度，单位是秒',
  `created_by` varchar(50) CHARACTER SET utf8 NOT NULL,
  `created_date` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '创建时间',
  `last_modified_by` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `last_modified_date` timestamp(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3) COMMENT '修改时间',
  `description` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '描述',
  `version` int(11) NOT NULL,
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='视频存储';

-- ----------------------------
-- Table structure for tool_alipay_config
-- ----------------------------
DROP TABLE IF EXISTS `tool_alipay_config`;
CREATE TABLE `tool_alipay_config` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `app_id` varchar(255) DEFAULT NULL COMMENT '应用ID',
  `charset` varchar(255) DEFAULT NULL COMMENT '编码',
  `format` varchar(255) DEFAULT NULL COMMENT '类型 固定格式json',
  `gateway_url` varchar(255) DEFAULT NULL COMMENT '网关地址',
  `notify_url` varchar(255) DEFAULT NULL COMMENT '异步回调',
  `private_key` text COMMENT '私钥',
  `public_key` text COMMENT '公钥',
  `return_url` varchar(255) DEFAULT NULL COMMENT '回调地址',
  `sign_type` varchar(255) DEFAULT NULL COMMENT '签名方式',
  `sys_service_provider_id` varchar(255) DEFAULT NULL COMMENT '商户号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='支付宝配置类';

-- ----------------------------
-- Records of tool_alipay_config
-- ----------------------------
BEGIN;
INSERT INTO `tool_alipay_config` VALUES (1, '2021000116688194', 'utf-8', 'JSON', 'https://openapi.alipaydev.com/gateway.do', 'http://api.auauz.net/api/aliPay/notify', 'MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCsrtjiZxqa6lnRRBmPqe6qiTtdcMei/kJqCfijFZIu2qsMBzPhn2BO+bZodaSj1k+ZLt3IxY0qiWky9Q9QwC6a0ma6YspgDrgRMINiSFgFAqYJyAYMKaUlrgE/ztZ1Dc8JBYJ5qUA7kVDgKLbXp0/A0OdOXy6gMwGHJ9iBpGl/H7XTxoGfZvmfNm8jBruYm1JtYaOrVarSVmQdwFsiN1c6qUr0oTC2WqF1GXneXfKpvi0LUi+dVNa6UyMi6H6gKEILxAowOUIoGhG4S3wXnQbHqjnY//yyNGTLjIDoWMWL98HWEotlqNIcV2YKfF3Qa+HazWjygKmdWpLcB+9lMMiHAgMBAAECggEBAJlrVsH/fIG6SEZGTLd48NSOzDF+a8ACShtP9JlgJtp96I3tMEj6gmRoM4mnS7lMRLgCDYW9DmiGYPKnCw5hUIa4/BAIiWjCawLKqU/+mkUJT19NWSIhNdq+N9nq+FpTBGgtfvh8SNcjikk9owUCXzcd4wOcSR6HcooT+qVj317S5cM4o59CT4W/QKfAEepAIwsGP6FJDja8aIy2WSSyYobAJ/RXAOIAppiWVmty31LXtnWqsVm7YdWFuL9Uc0dFnU4awolQ7R0DJ4+txEG/BCs3mRu05m0Fr0AXrXfuc5jfP7WM9loWxV2zxa+G4SfgV0p3hKWSMQ7osdAzGjcW7HECgYEA2H9pOy5bd26AEpQavdiNVFRSqt4oES63zGraQ6Xy+N41+9gxf/lVaHOKO6+UU+5WwcnNaFNP4FeZjth+6dg0tsiaAsvWZb7eGBuKwUT8wOP38KKZooI+aD6ssR2OaRwySogALWBKTe89yapFagZdqyPlTedMdJjF3D/dsGVz8TMCgYEAzDDa61Nb5wgndaHnR4rYlcTQEgOUU3Fl6fkXiYe8UlyvUgK87PEa9Qc8ZYZoSIqI8TLUKP1oovxdIkWWoq88+XhmDt26Q8SfQgfMAwthoTdCqYCfzGm3Bm9Z2ywkRl5LmMlTJeo6Yw7116DaFUDbA40nBFfpxxQ1LfL1uwTnM10CgYAlj2VIWTCRNeCOWJeTHEDYwpBdCJHW+U317wvS9LWEq7id6tIbq7w/lNwEot+O+CihEkvKr7mJ6GjBuZm7JEFw/LiLh6W4nTaW5CBci4V2SZa4bt1Mrl/5YfY//Cq63aNz/shZFv2NK9aCaEIGtPgHOwELVPeUuvSI06O4eMF2tQKBgQCe4gkGgaeKPtMNejyPc5+R8kIBMl3RC/TEOXmyHzdPUyVsiArfx8A1FztMuGgewgVKwUVK29v2rq39g+5xii/E4oVvXeKY5r8RTyXU3J9MJcauRBKTqVKsJCrkGxXi1261ZTpYz0g9Wh+7eEMZtIx21/ebLpkOuk+jAGFq86a/VQKBgQDXaKTrcihVawk6ha0bJfq6cIdfSrYe/AUmvv2pxFxcG1yvluJEo0hda1WVq+xaSYiTKWqMZKNxkODF2N4AsjzYC8akg+G2zlRPIzLvB+VxKW+ssc+rNZT89G9Z0DgagPQRKrgfxKO534L9i5AU06s4LOW0SdZq/sftZqPmsJaPsw==', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtXFqjUUgUKBQzzgDV09QLA4lwX/T4dz+0u7QodRraoKjrjZY2nvWLLwHqYuGWJTSz0TVKjEgIYF2MWxkJ6QvS9XuqvDyQPNmvRyo7vDEROmu2pnTMhUTkC6vjRafoCtxp+sIn6Xh4g9qPoUbQcSmLJESdo+BAzFxXA2e65D4g+LP7IPHOEn2KqGOsDtNlgNuVpcmpF/kZq65qme3qB6B3kdvuWH7DDveCpL4tkTpke0XgbQFsZlkuapSxNz6S8X8ODIrOCKJdINw/+NddW2T1EHyaLPHKkzbgZsEimlxVRWVvyJCSXOxTtYdWq8oG2i77D/kUZGV+eCR0dy2OrXi5QIDAQAB', 'http://api.auauz.net/api/aliPay/return', 'RSA2', '2088621955056287');
INSERT INTO `tool_alipay_config` VALUES (3, '2016091700532697', 'utf-8', 'JSON', 'https://openapi.alipaydev.com/gateway.do', 'http://api.auauz.net/api/aliPay/notify', 'MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC5js8sInU10AJ0cAQ8UMMyXrQ+oHZEkVt5lBwsStmTJ7YikVYgbskx1YYEXTojRsWCb+SH/kDmDU4pK/u91SJ4KFCRMF2411piYuXU/jF96zKrADznYh/zAraqT6hvAIVtQAlMHN53nx16rLzZ/8jDEkaSwT7+HvHiS+7sxSojnu/3oV7BtgISoUNstmSe8WpWHOaWv19xyS+Mce9MY4BfseFhzTICUymUQdd/8hXA28/H6osUfAgsnxAKv7Wil3aJSgaJczWuflYOve0dJ3InZkhw5Cvr0atwpk8YKBQjy5CdkoHqvkOcIB+cYHXJKzOE5tqU7inSwVbHzOLQ3XbnAgMBAAECggEAVJp5eT0Ixg1eYSqFs9568WdetUNCSUchNxDBu6wxAbhUgfRUGZuJnnAll63OCTGGck+EGkFh48JjRcBpGoeoHLL88QXlZZbC/iLrea6gcDIhuvfzzOffe1RcZtDFEj9hlotg8dQj1tS0gy9pN9g4+EBH7zeu+fyv+qb2e/v1l6FkISXUjpkD7RLQr3ykjiiEw9BpeKb7j5s7Kdx1NNIzhkcQKNqlk8JrTGDNInbDM6inZfwwIO2R1DHinwdfKWkvOTODTYa2MoAvVMFT9Bec9FbLpoWp7ogv1JMV9svgrcF9XLzANZ/OQvkbe9TV9GWYvIbxN6qwQioKCWO4GPnCAQKBgQDgW5MgfhX8yjXqoaUy/d1VjI8dHeIyw8d+OBAYwaxRSlCfyQ+tieWcR2HdTzPca0T0GkWcKZm0ei5xRURgxt4DUDLXNh26HG0qObbtLJdu/AuBUuCqgOiLqJ2f1uIbrz6OZUHns+bT/jGW2Ws8+C13zTCZkZt9CaQsrp3QOGDx5wKBgQDTul39hp3ZPwGNFeZdkGoUoViOSd5Lhowd5wYMGAEXWRLlU8z+smT5v0POz9JnIbCRchIY2FAPKRdVTICzmPk2EPJFxYTcwaNbVqL6lN7J2IlXXMiit5QbiLauo55w7plwV6LQmKm9KV7JsZs5XwqF7CEovI7GevFzyD3w+uizAQKBgC3LY1eRhOlpWOIAhpjG6qOoohmeXOphvdmMlfSHq6WYFqbWwmV4rS5d/6LNpNdL6fItXqIGd8I34jzql49taCmi+A2nlR/E559j0mvM20gjGDIYeZUz5MOE8k+K6/IcrhcgofgqZ2ZED1ksHdB/E8DNWCswZl16V1FrfvjeWSNnAoGAMrBplCrIW5xz+J0Hm9rZKrs+AkK5D4fUv8vxbK/KgxZ2KaUYbNm0xv39c+PZUYuFRCz1HDGdaSPDTE6WeWjkMQd5mS6ikl9hhpqFRkyh0d0fdGToO9yLftQKOGE/q3XUEktI1XvXF0xyPwNgUCnq0QkpHyGVZPtGFxwXiDvpvgECgYA5PoB+nY8iDiRaJNko9w0hL4AeKogwf+4TbCw+KWVEn6jhuJa4LFTdSqp89PktQaoVpwv92el/AhYjWOl/jVCm122f9b7GyoelbjMNolToDwe5pF5RnSpEuDdLy9MfE8LnE3PlbE7E5BipQ3UjSebkgNboLHH/lNZA5qvEtvbfvQ==', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAut9evKRuHJ/2QNfDlLwvN/S8l9hRAgPbb0u61bm4AtzaTGsLeMtScetxTWJnVvAVpMS9luhEJjt+Sbk5TNLArsgzzwARgaTKOLMT1TvWAK5EbHyI+eSrc3s7Awe1VYGwcubRFWDm16eQLv0k7iqiw+4mweHSz/wWyvBJVgwLoQ02btVtAQErCfSJCOmt0Q/oJQjj08YNRV4EKzB19+f5A+HQVAKy72dSybTzAK+3FPtTtNen/+b5wGeat7c32dhYHnGorPkPeXLtsqqUTp1su5fMfd4lElNdZaoCI7osZxWWUo17vBCZnyeXc9fk0qwD9mK6yRAxNbrY72Xx5VqIqwIDAQAB', 'http://api.auauz.net/api/aliPay/return', 'RSA2', '2088102176044281');
COMMIT;

-- ----------------------------
-- Table structure for tool_email_config
-- ----------------------------
DROP TABLE IF EXISTS `tool_email_config`;
CREATE TABLE `tool_email_config` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `from_user` varchar(255) DEFAULT NULL COMMENT '收件人',
  `host` varchar(255) DEFAULT NULL COMMENT '邮件服务器SMTP地址',
  `pass` varchar(255) DEFAULT NULL COMMENT '密码',
  `port` varchar(255) DEFAULT NULL COMMENT '端口',
  `user` varchar(255) DEFAULT NULL COMMENT '发件者用户名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='邮箱配置';

SET FOREIGN_KEY_CHECKS = 1;
