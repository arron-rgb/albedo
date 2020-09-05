# todo
1. record延迟到回调或异步通知接口
2. 二次表单生成的过程
3. ffmpeg调用gpu渲染

# 数据表语义
``` sql
balance 次数
balance_record 次数变更记录
invoice 发票抬头
order 订单
order_form 表单参数
video 渲染视频
plan 套餐
purchase_record 消费记录表

套餐限制：1. 子账号数量 2. 下单次数 3. 存储空间 4(todo).可选项
套餐使用量：1. 子账号数量 2. 下单次数 3. 存储空间
套餐变更记录：1. 变更维度 2. 新增or删减 3. 变更数量

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
5. [沙箱切换至正式环境](https://opensupport.alipay.com/support/helpcenter/190/201602483976?ant_source=antsupport)
6. [交易状态查询](https://opensupport.alipay.com/support/helpcenter/194/201602516393?ant_source=antsupport)
