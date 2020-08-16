create table sys_user
(
    id                 varchar(32)  default '1'                  not null comment '主键ID'
        primary key,
    username           varchar(64)                               not null comment '用户名',
    password           varchar(255)                              not null,
    nickname           varchar(64)                               null comment '昵称',
    phone              varchar(20)                               null comment '简介',
    email              varchar(64)                               null comment '邮箱',
    avatar             varchar(255)                              null comment '头像',
    dept_id            varchar(32)                               null comment '部门ID',
    qq_open_id         varchar(32)                               null comment 'QQ openid',
    wx_open_id         varchar(32)                               null comment '微信openid',
    available          char         default '1'                  null comment '1-正常，0-锁定',
    created_by         varchar(50) charset utf8                  not null,
    created_date       timestamp(3) default CURRENT_TIMESTAMP(3) null comment '创建时间',
    last_modified_by   varchar(50) charset utf8                  null,
    last_modified_date timestamp(3)                              null on update CURRENT_TIMESTAMP(3) comment '修改时间',
    description        varchar(255) charset utf8                 null comment '描述',
    version            int                                       not null,
    del_flag           char         default '0'                  null comment '0-正常，1-删除'
)
    comment '用户表' collate = utf8mb4_bin;

create index user_idx1_username
    on sys_user (username);

create index user_qq_openid
    on sys_user (qq_open_id);

create index user_wx_openid
    on sys_user (wx_open_id);

INSERT INTO albedo.sys_user (id, username, password, nickname, phone, email, avatar, dept_id, qq_open_id, wx_open_id, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('1', 'admin', '$2a$10$6z14VGdfVnlWY2K1pvdzJOHkvjLmOuBrJXXeZ0mGIqB60Qd6WYDoC', 'albedo', '17034642999', '22@ss.com', null, '1', null, 'o_0FT0uyg_H1vVy2H0JpSwlVGhWQ', '1', '', '2018-04-20 07:15:18', '1', '2020-08-08 20:36:03.780', '11', 46, '0');
INSERT INTO albedo.sys_user (id, username, password, nickname, phone, email, avatar, dept_id, qq_open_id, wx_open_id, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('18320c6ecc92e1509836778b6b6634b5', 'personal2', 'Wl6DHE6IPIomJOnY7LkALg==', null, '', null, null, '4d20ae207d9c836a732480429af58273', null, null, '1', 'system', '2020-08-16 15:59:17.038', 'system', '2020-08-16 15:59:17.038', null, 0, '0');
INSERT INTO albedo.sys_user (id, username, password, nickname, phone, email, avatar, dept_id, qq_open_id, wx_open_id, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('33f0f04578dff1e3909102a2d7b370f6', 'personal', 'oAEsh9M748NkIqbTgHipkQ==', null, '', null, null, '4d20ae207d9c836a732480429af58273', null, null, '1', 'system', '2020-08-16 15:39:39.960', 'system', '2020-08-16 15:39:39.960', null, 0, '0');
INSERT INTO albedo.sys_user (id, username, password, nickname, phone, email, avatar, dept_id, qq_open_id, wx_open_id, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('49f40b21c1dbdc83255d5c64119fcd4d', 'test1', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe', null, '13254642311', '13@qqx.om', null, '6304292a4ecb1448c33447adc0c35f08', null, null, '1', '1', '2020-05-12 09:51:46.703', '1', '2020-08-16 14:31:06.550', null, 7, '0');
INSERT INTO albedo.sys_user (id, username, password, nickname, phone, email, avatar, dept_id, qq_open_id, wx_open_id, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('4c2796f3667e3e5907a04623d7fd8de4', 'ttttt', '$2a$10$KYuAjYBhucUG4GbYQTuRO.YOl6JJlGdEdD5zGLkfrSumnjEF59S7G', '1', '13245678975', '1@e.com', null, 'c095173c3aebcd7ff9c6177fbf7a8b69', null, null, '1', '1', '2020-05-29 16:41:21.126', '4c2796f3667e3e5907a04623d7fd8de4', '2020-05-29 16:48:48.526', null, 7, '0');
INSERT INTO albedo.sys_user (id, username, password, nickname, phone, email, avatar, dept_id, qq_open_id, wx_open_id, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('5168fcfd16b8bad9fb38edfab4409023', 'www', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe', null, '13258465211', 'qq@ee.com', null, '1', null, null, '1', '1', '2020-05-12 10:22:11.393', '1', '2020-05-29 16:42:57.181', null, 18, '0');
INSERT INTO albedo.sys_user (id, username, password, nickname, phone, email, avatar, dept_id, qq_open_id, wx_open_id, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('51e995c64ed5982b9ce8ad5d559f100c', 'dddd', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe', 'dd', '13258465214', '1@1.com', null, '1', null, null, '1', '1', '2020-05-28 03:08:17.639', '1', '2020-05-29 16:42:57.184', null, 0, '0');
INSERT INTO albedo.sys_user (id, username, password, nickname, phone, email, avatar, dept_id, qq_open_id, wx_open_id, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('53fb3761bdd95ed3d03f4a07f78ea0eb', 'dsafdf', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe', null, '13258462101', '837158@qq.com', null, '1', null, null, '1', '1', '2019-07-07 14:32:17', '1', '2020-05-29 16:42:57.186', '11', 26, '0');
INSERT INTO albedo.sys_user (id, username, password, nickname, phone, email, avatar, dept_id, qq_open_id, wx_open_id, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('90da0206c39867a1b36ac36ced80c1a9', 'test', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe', null, '13258462222', 'ww@qq.com', null, '1', null, null, '1', '1', '2019-07-07 14:35:13', '1', '2020-05-29 16:42:57.187', null, 50, '0');
INSERT INTO albedo.sys_user (id, username, password, nickname, phone, email, avatar, dept_id, qq_open_id, wx_open_id, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('9d1c246296a00c3e54783f2cf0303ddb', 'personal3', '$2a$10$d4St7jm.7kDhweGT5pqn0uqJd/fie9z31IE5wPIAHjd/ztrPfHvca', null, '', null, null, '4d20ae207d9c836a732480429af58273', null, null, '1', 'system', '2020-08-16 16:03:39.751', 'system', '2020-08-16 16:03:39.751', null, 0, '0');
INSERT INTO albedo.sys_user (id, username, password, nickname, phone, email, avatar, dept_id, qq_open_id, wx_open_id, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('ac94375948c95db618d088b2eaeb354f', '', '', null, '', null, null, '4d20ae207d9c836a732480429af58273', null, null, '1', 'system', '2020-08-16 15:18:45.919', 'system', '2020-08-16 15:39:03.085', null, 0, '1');
INSERT INTO albedo.sys_user (id, username, password, nickname, phone, email, avatar, dept_id, qq_open_id, wx_open_id, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('dcc5b57ad27014f1839a9f4bb2b568b1', 'ttt', '$2a$10$hZ5daUd8k4LSOgmFuRlSZuEnYRndkGjMJ/wsl6UQ5.rlWFqNcmPSe', null, '13254732131', '2113@ed.bom', null, '1', null, null, '1', '1', '2020-05-12 10:06:21.381', '1', '2020-05-29 16:42:57.190', null, 1, '1');
INSERT INTO albedo.sys_user (id, username, password, nickname, phone, email, avatar, dept_id, qq_open_id, wx_open_id, available, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES ('e520699f68eab0949352cf56f291107a', 'personal', 'sIQDVq+F5DYItuIQw9UN7Q==', null, '', null, null, '4d20ae207d9c836a732480429af58273', null, null, '1', 'system', '2020-08-16 15:37:11.631', 'system', '2020-08-16 15:39:26.942', null, 0, '1');