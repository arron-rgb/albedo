create table sys_role_dept
(
    id      varchar(32) not null
        primary key,
    role_id varchar(32) null comment '角色ID',
    dept_id varchar(32) null comment '部门ID'
)
    comment '角色与部门对应关系' charset = utf8;

INSERT INTO albedo.sys_role_dept (id, role_id, dept_id) VALUES ('28e2bd6452d0aff99f014136336eab61', '1', '8');
INSERT INTO albedo.sys_role_dept (id, role_id, dept_id) VALUES ('34481e9777757dd6ffe1c799749b4db5', '2', '5');
INSERT INTO albedo.sys_role_dept (id, role_id, dept_id) VALUES ('5c5c58ad79db6edea88100e6491e5e30', '2', '4');
INSERT INTO albedo.sys_role_dept (id, role_id, dept_id) VALUES ('64af22db5dbe5cf69de8fa7f2d917922', '2', '3');
INSERT INTO albedo.sys_role_dept (id, role_id, dept_id) VALUES ('c3b5457350bb7a9be8201fa3f88d3c2c', '262da20a182dd09e70422cbca05503b7', null);