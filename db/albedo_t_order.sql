create table t_order
(
    id                 varchar(32)                                           not null
        primary key,
    user_id            varchar(32)                                           not null comment '用户id',
    status             int                                                   null comment '订单状态（具体细节后面再说）',
    type               varchar(255)                                          null comment '订单类型（加速卡，单次，多次）',
    video_id           varchar(32)                                           null comment '视频id，等视频上传后更新',
    user_name          varchar(255)                                          null comment '用户名字',
    user_phone         varchar(255)                                          null comment '用户电话',
    created_by         varchar(50) charset utf8                              not null,
    created_date       timestamp(3)             default CURRENT_TIMESTAMP(3) null comment '创建时间',
    last_modified_by   varchar(50) charset utf8                              null,
    last_modified_date timestamp(3)                                          null on update CURRENT_TIMESTAMP(3) comment '修改时间',
    description        varchar(255) charset utf8                             null comment '描述',
    version            int                                                   not null,
    del_flag           char collate utf8mb4_bin default '0'                  null comment '0-正常，1-删除'
);

