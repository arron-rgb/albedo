create table t_video
(
    id                 varchar(32)                                           not null
        primary key,
    user_id            varchar(32)                                           null comment '用户id',
    name               varchar(255)                                          null comment '视频名字',
    origin_url         varchar(255)                                          null,
    logo_url           varchar(255)                                          null comment 'logo的地址',
    output_url         varchar(255)                                          null comment '输出地址',
    duration           int                                                   null comment '视频长度，单位是秒',
    created_by         varchar(50) charset utf8                              not null,
    created_date       timestamp(3)             default CURRENT_TIMESTAMP(3) null comment '创建时间',
    last_modified_by   varchar(50) charset utf8                              null,
    last_modified_date timestamp(3)                                          null on update CURRENT_TIMESTAMP(3) comment '修改时间',
    description        varchar(255) charset utf8                             null comment '描述',
    version            int                                                   not null,
    del_flag           char collate utf8mb4_bin default '0'                  null comment '0-正常，1-删除'
);

