# 数据表语义
``` sql
plan 套餐
balance 次数
balance_history 次数变更
invoice 发票抬头
order 订单
order_form 表单参数
video 渲染视频

todo 
- 消费记录表: 1. 套餐消费 2. 订单消费（包括是否加速）
id
user_id
out_trade_no 对接支付宝id
type 0 套餐 1 订单
total_amount 支付金额
===
- 开发票记录表
id
invoice_id 抬头id
total_amount
消费记录ids
===
- 直播间风格、主播风格静态图片表
id
name
url
plan_type 套餐权限
type 0直播间风格 1主播风格
```
# 项目约定

## 材料文档
1. 文档在processon，简单流程图。无具体规范，链接如下
2. 主辅出现出路以主为主
3. 需要修改或有自己的文档可以贴在下面
  1. [流程图及表设计（主）](https://www.processon.com/view/link/5f38bb461e085306e15da3c9)
  2. [草稿（辅）](https://www.processon.com/view/link/5f1d858d637689168e352728)
4. 业务表以t_开头，如t_oder
2. Java中枚举字段与MySQL中整型对应，图中用斜体表示，如Java: Enum，MySQL: int
5. 多值字段拼接统一使用英文逗号，字段名以字段名s表示，如ids:[id1, id2]
6. 三方服务字段用粗体表示，且尽可能与三方对齐字段名和语义，如trade_no

## 三方服务文档
1. [SMS](https://help.aliyun.com/document_detail/102715.html?spm=5176.8195934.1283918.7.39e06a7d3w17Ug#concept-t4w-pcs-ggb)
2. [OSS](https://help.aliyun.com/product/31815.html?spm=5176.10695662.5694434980.7.2f2d36b92lYrEe)
3. [语音合成](https://help.aliyun.com/document_detail/84437.html?spm=5176.12061040.1228750.3.4e724779xH8QRr)
4. [支付宝支付文档](https://opendocs.alipay.com/apis/api_1/alipay.trade.wap.pay#%E5%93%8D%E5%BA%94%E5%8F%82%E6%95%B0)

# 项目介绍
详情见github-albedo，readme

## 使用的框架
1. Spring Boot 后端
2. Mybatis Plus ORM
3. Element UI 前端（Vue的组件库）

## 开发环境（以下均需安装）
1. JDK 1.8
2. MySQL 5.7
3. [Maven] IDEA内部有提供，可选
4. node.js(npm)
5. Redis

### 本地运行
1. 安装好开发环境后，将db目录下的albedo.sql导入数据库
2. 修改配置文件，在application-prod.yml中将datasource中的url和账号密码修改为自己本地的数据库/账号密码
3. 启动Redis，需根据情况调整配置文件下的redis端口
4. 在IDEA中按maven project导入该项目，左侧目录会出现部分加粗黑体字，等安装好依赖后进入albedo-modules下的albedo-admin中的AlbedoAdminApplication运行main方法即可
5. 在终端/命令行中进入albedo-ui目录下，输入npm install安装前端依赖，等安装完毕后执行npm run dev即可运行去前端项目
6. 在浏览器中输入第五步输出的链接即可访问，使用账号可查看数据库中sys_user表。顶级管理员账号密码为admin/amin
