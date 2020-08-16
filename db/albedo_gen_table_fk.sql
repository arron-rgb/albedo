create table gen_table_fk
(
    id                 varchar(64)                                           not null comment '编号'
        primary key,
    gen_table_id       varchar(64)                                           null comment '归属表编号',
    name               varchar(200)                                          null comment '名称',
    comments           varchar(500)                                          null comment '描述',
    jdbc_type          varchar(100)                                          null comment '列的数据类型的字节长度',
    java_type          varchar(500)                                          null comment 'JAVA类型',
    java_field         varchar(200)                                          null comment 'JAVA字段名',
    is_pk              char                                                  null comment '是否主键',
    is_unique          char                     default '0'                  null comment '是否唯一（1：是；0：否）',
    is_null            char                                                  null comment '是否可为空',
    is_insert          char                                                  null comment '是否为插入字段',
    is_edit            char                                                  null comment '是否编辑字段',
    is_list            char                                                  null comment '是否列表字段',
    is_query           char                                                  null comment '是否查询字段',
    query_type         varchar(200)                                          null comment '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）',
    show_type          varchar(200)                                          null comment '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）',
    dict_type          varchar(200)                                          null comment '字典类型',
    settings           varchar(2000)                                         null comment '其它设置（扩展字段JSON）',
    sort               decimal                                               null comment '排序（升序）',
    version            int                      default 0                    null comment '默认0，必填，离线乐观锁',
    description        varchar(255)                                          null comment '描述',
    created_by         varchar(50)                                           not null,
    created_date       timestamp(3)             default CURRENT_TIMESTAMP(3) not null on update CURRENT_TIMESTAMP(3),
    last_modified_by   varchar(50)                                           null,
    last_modified_date timestamp(3)                                          null,
    del_flag           char collate utf8mb4_bin default '0'                  null comment '0-正常，1-删除'
)
    comment '业务表字段' charset = utf8;

create index gen_table_column_name
    on gen_table_fk (name);

create index gen_table_column_sort
    on gen_table_fk (sort);

create index gen_table_column_table_id
    on gen_table_fk (gen_table_id);

