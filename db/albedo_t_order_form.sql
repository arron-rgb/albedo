create table t_order_form
(
    id                 varchar(64)                                           not null comment '编号',
    labels             text                                                  not null comment '标签文本',
    user_id            varchar(200)                                          null,
    anchor_num         varchar(500)                                          null comment '是否站立，0站1坐',
    seat               varchar(20)                                           null comment '活力青春',
    anchor_type        varchar(50)                                           null comment '直播间风格',
    plus_service       varchar(100)                                          null comment '实体类名称',
    description        varchar(255)                                          null comment '描述',
    created_by         varchar(50)                                           not null,
    created_date       timestamp(3)             default CURRENT_TIMESTAMP(3) not null on update CURRENT_TIMESTAMP(3),
    last_modified_by   varchar(50)                                           null,
    last_modified_date timestamp(3)                                          null,
    del_flag           char collate utf8mb4_bin default '0'                  null comment '0-正常，1-删除'
)
    comment '表单temp' charset = utf8;

