create table sys_job
(
    id                 int auto_increment comment '任务ID'
        primary key,
    name               varchar(64)              default ''                   not null comment '任务名称',
    `group`            varchar(64)              default 'DEFAULT'            not null comment '任务组名',
    invoke_target      varchar(500)                                          not null comment '调用目标字符串',
    cron_expression    varchar(255)             default ''                   null comment 'cron执行表达式',
    misfire_policy     varchar(20)              default '3'                  null comment '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
    concurrent         char                     default '1'                  null comment '是否并发执行（1允许 0禁止）',
    sub_task           varchar(100)                                          null comment '子任务id 多个用逗号隔开',
    email              varchar(100) charset utf8                             null comment '报警邮箱',
    status             char                     default '0'                  null comment '状态(1-运行中，0-暂停)',
    created_by         varchar(50) charset utf8                              not null,
    created_date       datetime(3)              default CURRENT_TIMESTAMP(3) not null,
    last_modified_by   varchar(50) charset utf8                              null,
    last_modified_date datetime(3)                                           null on update CURRENT_TIMESTAMP(3),
    description        varchar(255) charset utf8                             null comment '描述',
    version            int                                                   not null,
    del_flag           char collate utf8mb4_bin default '0'                  null comment '0-正常，1-删除'
)
    comment '定时任务调度表';

INSERT INTO albedo.sys_job (id, name, `group`, invoke_target, cron_expression, misfire_policy, concurrent, sub_task, email, status, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES (1, '系统默认（无参）', 'DEFAULT', 'simpleTask.doNoParams', '0/10 * * * * ?', '3', '1', '2', null, '0', '', '2019-08-14 10:21:36', '1', '2020-05-16 15:38:24.728', null, 9, '0');
INSERT INTO albedo.sys_job (id, name, `group`, invoke_target, cron_expression, misfire_policy, concurrent, sub_task, email, status, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES (2, '系统默认（有参）', 'DEFAULT', 'simpleTask.doParams(''albedo'')', '0/15 * * * * ?', '3', '1', null, null, '0', '', '2019-08-14 10:21:36.950', '1', '2020-05-16 15:28:24.387', null, 18, '0');
INSERT INTO albedo.sys_job (id, name, `group`, invoke_target, cron_expression, misfire_policy, concurrent, sub_task, email, status, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES (3, '系统默认（多参）', 'DEFAULT', 'simpleTask.doMultipleParams(''albedo'', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', null, null, '0', '', '2019-08-14 10:21:36', '1', '2020-05-16 15:12:50.258', null, 4, '0');
INSERT INTO albedo.sys_job (id, name, `group`, invoke_target, cron_expression, misfire_policy, concurrent, sub_task, email, status, created_by, created_date, last_modified_by, last_modified_date, description, version, del_flag) VALUES (4, 'test', 'DEFAULT', 'test', '0/20 * * * * ?', '2', '1', '1', null, '0', '1', '2020-05-16 15:06:05.098', '1', '2020-05-16 15:21:10.516', null, 1, '1');