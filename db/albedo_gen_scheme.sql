create table gen_scheme
(
    id                   varchar(64)                                           not null comment '编号'
        primary key,
    name                 varchar(200)                                          null comment '名称',
    category             varchar(2000)                                         null comment '分类',
    view_type            char(2)                                               null comment '视图类型 0  普通表格 1  表格采用ajax刷新',
    package_name         varchar(500)                                          null comment '生成包路径',
    module_name          varchar(30)                                           null comment '生成模块名',
    sub_module_name      varchar(30)                                           null comment '生成子模块名',
    function_name        varchar(500)                                          null comment '生成功能名',
    function_name_simple varchar(100)                                          null comment '生成功能名（简写）',
    function_author      varchar(100)                                          null comment '生成功能作者',
    gen_table_id         varchar(200)                                          null comment '生成表编号',
    version              int                      default 0                    null comment '默认0，必填，离线乐观锁',
    description          varchar(255)                                          null comment '描述',
    created_by           varchar(50)                                           not null,
    created_date         timestamp(3)             default CURRENT_TIMESTAMP(3) not null on update CURRENT_TIMESTAMP(3),
    last_modified_by     varchar(50)                                           null,
    last_modified_date   timestamp(3)                                          null,
    del_flag             char collate utf8mb4_bin default '0'                  null comment '0-正常，1-删除'
)
    comment '生成方案' charset = utf8;

INSERT INTO albedo.gen_scheme (id, name, category, view_type, package_name, module_name, sub_module_name, function_name, function_name_simple, function_author, gen_table_id, version, description, created_by, created_date, last_modified_by, last_modified_date, del_flag) VALUES ('145be4d808589aabed3d28fd6ce38f5c', '表单', 'curd', null, 'com.albedo.java.modules', 'biz', null, '表单', 'OrderForm', 'admin', 'ce24de2f484575934f17dc1efe204b15', 0, null, '1', '2020-08-18 10:19:40.036', '1', '2020-08-18 10:19:40.036', '0');
INSERT INTO albedo.gen_scheme (id, name, category, view_type, package_name, module_name, sub_module_name, function_name, function_name_simple, function_author, gen_table_id, version, description, created_by, created_date, last_modified_by, last_modified_date, del_flag) VALUES ('3a00af7846a8ab0ab657b8e244ef3bfb', '抬头', 'curd_front', null, 'com.albedo.java.modules', 'biz', null, '发票抬头管理', '发票抬头', 'arronshentu', '61253a55e25426b602fc9ad8ec1a0fe2', 1, null, '1', '2020-08-16 16:19:02.777', '1', '2020-08-16 16:33:12.437', '0');
INSERT INTO albedo.gen_scheme (id, name, category, view_type, package_name, module_name, sub_module_name, function_name, function_name_simple, function_author, gen_table_id, version, description, created_by, created_date, last_modified_by, last_modified_date, del_flag) VALUES ('4503bf9f5cdf64baaf74a6fc218f42ea', 'testBook', 'curd', null, 'com.albedo.java.modules', 'biz', null, 'test', 'test', 'admin', '3758a93f20975e49d4e7b70c94a3b48a', 2, null, '1', '2020-08-08 20:14:07.383', '1', '2020-08-08 21:20:40.484', '0');