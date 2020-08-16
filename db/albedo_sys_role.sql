create table sys_role
(
    id                 varchar(32)                               not null
        primary key,
    name               varchar(64)                               not null comment '名称',
    level              int                                       null comment '角色级别',
    data_scope         char                                      null comment '数据权限 1全部 2所在机构及以下数据  3 所在机构数据  4仅本人数据 5 按明细设置',
    available          char         default '1'                  null comment '1-正常，0-锁定',
    created_by         varchar(50) charset utf8                  not null,
    created_date       timestamp(3) default CURRENT_TIMESTAMP(3) not null,
    last_modified_by   varchar(50) charset utf8                  null,
    last_modified_date timestamp(3)                              null on update CURRENT_TIMESTAMP(3),
    description        varchar(255) charset utf8                 null comment '描述',
    version            int                                       not null,
    del_flag           char         default '0'                  null comment '0-正常，1-删除'
)
    comment '系统角色表' collate = utf8mb4_bin;

INSERT INTO albedo.sys_role (id, name, level, data_scope, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('1', '超级管理员', 1, '1', '1', '', '2017-10-29 15:45:51', '1', '2020-05-14 11:00:00.741', null, 75, '0');
INSERT INTO albedo.sys_role (id, name, level, data_scope, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('2', '机构管理员', 2, '2', '1', '', '2018-11-11 19:42:26', '1', '2020-05-14 11:01:14.154', null, 18, '0');
INSERT INTO albedo.sys_role (id, name, level, data_scope, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('262da20a182dd09e70422cbca05503b7', 'tets', 3, '5', '1', '1', '2020-05-14 11:21:30.869', '1', '2020-05-14 11:28:55.628', null, 0, '1');
INSERT INTO albedo.sys_role (id, name, level, data_scope, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('3570f348af7214a976e5d6bfbdd97df1', '部门管理员', 3, '3', '1', '1', '2020-05-14 11:02:13.389', '1', '2020-05-25 11:13:04.474', null, 3, '0');
INSERT INTO albedo.sys_role (id, name, level, data_scope, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('4647a907ad1dd30b28cbdaa229b67fc1', '普通管理员', 4, '4', '1', '1', '2020-05-14 11:00:50.813', '1', '2020-05-14 11:30:26.577', '普通管理', 6, '0');
INSERT INTO albedo.sys_role (id, name, level, data_scope, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('49dbe45a4e2a06a56730851e0c87f166', '企业用户', 3, '2', '1', '1', '2020-08-16 14:48:25.319', '1', '2020-08-16 14:48:25.319', null, 0, '0');
INSERT INTO albedo.sys_role (id, name, level, data_scope, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('904a870be22c6b84845dbd1699655b4a', '个人用户', 3, '4', '1', '1', '2020-08-16 14:47:33.168', '1', '2020-08-16 14:47:33.168', null, 0, '0');
INSERT INTO albedo.sys_role (id, name, level, data_scope, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('cdff3f167ae3dfc7984cd6e36976ddf8', '企业管理员', 3, '2', '1', '1', '2020-08-16 14:48:16.599', '1', '2020-08-16 14:48:16.599', null, 0, '0');