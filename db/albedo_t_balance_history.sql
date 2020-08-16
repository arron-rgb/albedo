create table t_balance_history
(
    id                 varchar(32)                                           not null
        primary key,
    user_id            varchar(32)                                           null comment '操作的用户ID',
    amount             int                      default 0                    not null comment '变更次数',
    type               int                      default 0                    not null comment '1为+，0为-',
    created_by         varchar(50)                                           not null,
    created_date       timestamp(3)             default CURRENT_TIMESTAMP(3) not null on update CURRENT_TIMESTAMP(3),
    last_modified_by   varchar(50)                                           null,
    last_modified_date timestamp(3)                                          null,
    description        varchar(255)                                          null,
    version            int                                                   null,
    del_flag           char collate utf8mb4_bin default '0'                  null comment '0-正常，1-删除'
)
    comment '次数变更表' charset = utf8;

