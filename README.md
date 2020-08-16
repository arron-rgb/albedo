# 项目约定

## 团队git链接
1. [gitee组织邀请链接](https://gitee.com/organizations/arronrgb/invite?invite=495a8c47a8870e0673132730657f858eaea671b6a995e98b5cf8b3427290ca7c9fa7750066f001ff63ce7e16acfba504)
2. [后端仓库链接](https://gitee.com/arronrgb/virtual-live-web.git)
3. [前端仓库链接](https://gitee.com/arronrgb/virtual-live-front.git)
4. 建议gitee，但同步github（出于私心，记录一下自己的活跃度，特意新开了个号）

## git工作流程
1. [阮一峰git flow介绍](http://www.ruanyifeng.com/blog/2012/07/git.html)
2. feature命名样例: feature-08-account。feature-日期-相关实体类名

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

## 负责模块
1. 王岗（主前端）
2. 申屠康（主后端）：对后端代码有问题或者对脚手架有问题可以直接找我，其他问题先搜完还有问题再找我（我也不一定解决的了）
3. ？

# 项目介绍
详情见github-albedo，readme
## 需要运行的模块的作用
1. albedo-admin：后台应用主模块
2. albedo-api：生成后台应用暴露的接口文档的应用模块
3. 原有项目介绍见README.md
## 使用的框架
1. Spring Boot 后端
2. Mybatis Plus ORM
3. Element UI 前端（Vue的组件库）

# 开发介绍
## 工具
1. IDEA Java IDE （以下两个可选，IDEA够用）
2. DataGrip 数据库连接工具
3. WebStorm 前端IDE

## 需要了解的基本概念
1. Restful/ 前后端分离项目怎么启动[对接机制]
2. 关系对象映射(ORM)
3. 基础模块的代码的包结构
```
domain: 映射对象及业务对象
repository/ mapper: 数据库访问层
service: 提供内部业务逻辑
web(**Resource**): 对外暴露的接口
```
4. 知道Spring Boot怎么用
5. Mybatis Plus的查询
  1. 在admin的resource下有biz.mapper，用于写sql语句
  2. 可使用service.wrapper()进行包装，具体可查看Mybatis Plus官网
6. RBAC理论

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

### 部署上线 TODO
1. **看看jenkins能不能搭好**。能搭好就用。搭不好到时候我写个脚本运行即可

## 基本命令
``` shell sript
# 本地开发
# 1. 进入前端项目路径下 2. npm install/ yarn 3. 运行package.json中的dev命令
cd albedo-ui
npm install
npm ru dev

# 后台启动
# 1. 在idea中导入该项目，找到albedo-admin中的Application类，运行main方法等控制台打印出访问地址即可

# 项目部署（需要先打包前端）
# 1. 进入前端项目路径下 2. npm install 3. npm run build
cd albedo-ui
npm install
npm run uild
# 1. 进入顶层pom.xml文件所在路径下 2. mvn clean package 3. 将在albedo-admin的target路径下的jar包
mvn clean package
java -jar [jr包名]
# 等终端打印出URL即可通过 ip:port/ 访问主页

```

## 注意事项
1. 配置端口、配置文件等可直接加命令行参数
2. 前端工程打包好后再进行后端的打包
3. 前端工程路径在配置文件中强烈建议使用绝对路径
4. 如果是外网访问，请确保服务器端口已打开

## 运行环境
1. Java 1.8
2. Redis
3. MySQL 5.7
