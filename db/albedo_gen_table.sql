create table gen_table
(
    id                 varchar(64)                                           not null comment '编号',
    name               varchar(200)                                          null comment '名称',
    comments           varchar(500)                                          null comment '描述',
    coding             varchar(20)                                           null comment '字符编码',
    engine             varchar(50)                                           null comment '数据库引擎',
    class_name         varchar(100)                                          null comment '实体类名称',
    parent_table       varchar(200)                                          null comment '关联父表',
    parent_table_fk    varchar(100)                                          null comment '关联父表外键',
    version            int                      default 0                    null comment '默认0，必填，离线乐观锁',
    description        varchar(255)                                          null comment '描述',
    created_by         varchar(50)                                           not null,
    created_date       timestamp(3)             default CURRENT_TIMESTAMP(3) not null on update CURRENT_TIMESTAMP(3),
    last_modified_by   varchar(50)                                           null,
    last_modified_date timestamp(3)                                          null,
    del_flag           char collate utf8mb4_bin default '0'                  null comment '0-正常，1-删除',
    constraint id
        unique (id)
)
    comment '业务表' charset = utf8;

create index gen_table_name
    on gen_table (name);

alter table gen_table
    add primary key (id);

INSERT INTO albedo.gen_table (id, name, comments, coding, engine, class_name, parent_table, parent_table_fk, version, description, created_by, created_date, last_modified_by, last_modified_date, del_flag) VALUES ('3758a93f20975e49d4e7b70c94a3b48a', 'test_book', '测试书籍', null, null, 'TestBook', null, null, 0, null, '1', '2020-08-08 20:13:49.014', '1', '2020-08-08 20:13:49.014', '0');
INSERT INTO albedo.gen_table (id, name, comments, coding, engine, class_name, parent_table, parent_table_fk, version, description, created_by, created_date, last_modified_by, last_modified_date, del_flag) VALUES ('61253a55e25426b602fc9ad8ec1a0fe2', 't_invoice', 't_invoice', null, null, 'Invoice', null, null, 1, null, '1', '2020-08-16 16:33:00.329', '1', '2020-08-16 16:33:00.327', '0');
INSERT INTO albedo.gen_table (id, name, comments, coding, engine, class_name, parent_table, parent_table_fk, version, description, created_by, created_date, last_modified_by, last_modified_date, del_flag) VALUES ('ce24de2f484575934f17dc1efe204b15', 't_order_form', '表单temp', null, null, 'OrderForm', null, null, 0, null, '1', '2020-08-18 10:19:05.066', '1', '2020-08-18 10:19:05.066', '0');