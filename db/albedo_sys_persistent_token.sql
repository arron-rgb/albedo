create table sys_persistent_token
(
    series         varchar(76)                             not null
        primary key,
    user_id        varchar(32)                             null,
    username       varchar(255)                            null comment '用户名',
    token_value    varchar(76)                             not null,
    token_date     timestamp(3)                            null,
    ip_address     varchar(39)                             null,
    user_agent     varchar(255)                            null,
    login_location varchar(255) charset utf8mb4 default '' null comment '登录地点',
    browser        varchar(50) charset utf8mb4  default '' null comment '浏览器类型',
    os             varchar(50) charset utf8mb4  default '' null comment '操作系统'
)
    charset = utf8;

create index fk_user_persistent_token
    on sys_persistent_token (user_id);

INSERT INTO albedo.sys_persistent_token (series, user_id, username, token_value, token_date, ip_address, user_agent, login_location, browser, os) VALUES ('jeg4tzpdr3bb1wghyq98', '1', 'admin', 'zy95xy6l8bxhuq8vkr4x', '2020-05-27 11:30:33.281', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016');
INSERT INTO albedo.sys_persistent_token (series, user_id, username, token_value, token_date, ip_address, user_agent, login_location, browser, os) VALUES ('snhdb8hbzvzfmb7fyl19', '1', 'admin', 'z69qbar0w0fltj4egbcs', '2020-05-29 22:29:15.595', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016');