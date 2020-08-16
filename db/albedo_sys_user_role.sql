create table sys_user_role
(
    user_id varchar(32) not null comment '用户ID',
    role_id varchar(32) not null comment '角色ID',
    primary key (user_id, role_id)
)
    comment '用户角色表' charset = utf8;

INSERT INTO albedo.sys_user_role (user_id, role_id) VALUES ('1', '1');
INSERT INTO albedo.sys_user_role (user_id, role_id) VALUES ('18320c6ecc92e1509836778b6b6634b5', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO albedo.sys_user_role (user_id, role_id) VALUES ('33f0f04578dff1e3909102a2d7b370f6', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO albedo.sys_user_role (user_id, role_id) VALUES ('49f40b21c1dbdc83255d5c64119fcd4d', '2');
INSERT INTO albedo.sys_user_role (user_id, role_id) VALUES ('4c2796f3667e3e5907a04623d7fd8de4', '2');
INSERT INTO albedo.sys_user_role (user_id, role_id) VALUES ('5168fcfd16b8bad9fb38edfab4409023', '2');
INSERT INTO albedo.sys_user_role (user_id, role_id) VALUES ('51e995c64ed5982b9ce8ad5d559f100c', '4647a907ad1dd30b28cbdaa229b67fc1');
INSERT INTO albedo.sys_user_role (user_id, role_id) VALUES ('53fb3761bdd95ed3d03f4a07f78ea0eb', '1');
INSERT INTO albedo.sys_user_role (user_id, role_id) VALUES ('90da0206c39867a1b36ac36ced80c1a9', '2');
INSERT INTO albedo.sys_user_role (user_id, role_id) VALUES ('9d1c246296a00c3e54783f2cf0303ddb', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO albedo.sys_user_role (user_id, role_id) VALUES ('ac94375948c95db618d088b2eaeb354f', '904a870be22c6b84845dbd1699655b4a');
INSERT INTO albedo.sys_user_role (user_id, role_id) VALUES ('dcc5b57ad27014f1839a9f4bb2b568b1', '2');
INSERT INTO albedo.sys_user_role (user_id, role_id) VALUES ('e520699f68eab0949352cf56f291107a', '904a870be22c6b84845dbd1699655b4a');