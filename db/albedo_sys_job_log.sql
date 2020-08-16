create table sys_job_log
(
    id              bigint auto_increment comment '任务日志ID'
        primary key,
    job_name        varchar(64)               not null comment '任务名称',
    job_group       varchar(64)               not null comment '任务组名',
    cron_expression varchar(255)  default ''  null comment 'cron执行表达式',
    invoke_target   varchar(500)              not null comment '调用目标字符串',
    job_message     varchar(500)              null comment '日志信息',
    status          char          default '0' null comment '执行状态（0正常 1失败）',
    start_time      datetime(3)               null comment '开始时间',
    end_time        datetime(3)               null comment '结束时间',
    create_time     datetime(3)               null comment '创建时间',
    exception_info  varchar(3000) default ''  null comment '异常信息',
    description     varchar(255) charset utf8 null comment '描述'
)
    comment '定时任务调度日志表';

