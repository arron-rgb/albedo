create table t_balance
(
    user_id varchar(32)       null comment '用户ID',
    times   int(50) default 0 not null comment '次数',
    version int               null
)
    comment '次数表' charset = utf8;

