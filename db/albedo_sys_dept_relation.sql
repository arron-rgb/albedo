create table sys_dept_relation
(
    ancestor   varchar(32)                          not null comment '祖先节点',
    descendant varchar(32)                          not null comment '后代节点',
    del_flag   char collate utf8mb4_bin default '0' null comment '0-正常，1-删除',
    primary key (ancestor, descendant)
)
    comment '部门关系表' charset = latin1;

create index idx1
    on sys_dept_relation (ancestor);

create index idx2
    on sys_dept_relation (descendant);

INSERT INTO albedo.sys_dept_relation (ancestor, descendant, del_flag) VALUES ('1', '1', '0');
INSERT INTO albedo.sys_dept_relation (ancestor, descendant, del_flag) VALUES ('1', '6304292a4ecb1448c33447adc0c35f08', '0');
INSERT INTO albedo.sys_dept_relation (ancestor, descendant, del_flag) VALUES ('1', '701903b72179df2c79d383f621eab9c8', '0');
INSERT INTO albedo.sys_dept_relation (ancestor, descendant, del_flag) VALUES ('1', 'db32c981785f619401518127c48b6247', '0');
INSERT INTO albedo.sys_dept_relation (ancestor, descendant, del_flag) VALUES ('1', 'f52e1e844bf0fbadf5213214fb621e27', '0');
INSERT INTO albedo.sys_dept_relation (ancestor, descendant, del_flag) VALUES ('4981e65fbb6059f3a5ceddd6b3426e6d', '4981e65fbb6059f3a5ceddd6b3426e6d', '1');
INSERT INTO albedo.sys_dept_relation (ancestor, descendant, del_flag) VALUES ('4d20ae207d9c836a732480429af58273', '4d20ae207d9c836a732480429af58273', '0');
INSERT INTO albedo.sys_dept_relation (ancestor, descendant, del_flag) VALUES ('6304292a4ecb1448c33447adc0c35f08', '6304292a4ecb1448c33447adc0c35f08', '0');
INSERT INTO albedo.sys_dept_relation (ancestor, descendant, del_flag) VALUES ('701903b72179df2c79d383f621eab9c8', '701903b72179df2c79d383f621eab9c8', '0');
INSERT INTO albedo.sys_dept_relation (ancestor, descendant, del_flag) VALUES ('9e4dcac1683359bfeac1871ccdc29e9f', '4981e65fbb6059f3a5ceddd6b3426e6d', '1');
INSERT INTO albedo.sys_dept_relation (ancestor, descendant, del_flag) VALUES ('9e4dcac1683359bfeac1871ccdc29e9f', '9e4dcac1683359bfeac1871ccdc29e9f', '1');
INSERT INTO albedo.sys_dept_relation (ancestor, descendant, del_flag) VALUES ('c095173c3aebcd7ff9c6177fbf7a8b69', 'c095173c3aebcd7ff9c6177fbf7a8b69', '0');
INSERT INTO albedo.sys_dept_relation (ancestor, descendant, del_flag) VALUES ('db32c981785f619401518127c48b6247', 'db32c981785f619401518127c48b6247', '0');
INSERT INTO albedo.sys_dept_relation (ancestor, descendant, del_flag) VALUES ('f52e1e844bf0fbadf5213214fb621e27', 'f52e1e844bf0fbadf5213214fb621e27', '0');