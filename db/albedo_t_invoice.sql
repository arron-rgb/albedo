create table t_invoice
(
    id                 varchar(32)                                           not null
        primary key,
    user_id            varchar(32)                                           null comment '用户id',
    type               int                                                   not null comment '0-个人，1-企业',
    name               varchar(255)                                          not null comment '企业名称/个人名称',
    tax_num            varchar(0)                                            null comment '公司税号',
    company_location   varchar(255)                                          null comment '注册地址',
    company_phone      varchar(255)                                          null comment '公司电话',
    account_bank       varchar(255)                                          null comment '开户公司',
    account_number     varchar(32)                                           null comment '开户账号',
    created_by         varchar(50) charset utf8                              not null,
    created_date       timestamp(3)             default CURRENT_TIMESTAMP(3) null comment '创建时间',
    last_modified_by   varchar(50) charset utf8                              null,
    last_modified_date timestamp(3)                                          null on update CURRENT_TIMESTAMP(3) comment '修改时间',
    description        varchar(255) charset utf8                             null comment '描述',
    version            int                                                   not null,
    del_flag           char collate utf8mb4_bin default '0'                  null comment '0-正常，1-删除'
);

