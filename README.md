# biz/order/placeSecond
## post
### post body
1. required
  - content 配音文本（type非1时）
  - type 配音方式 0下单 1上传 2合成
  - orderId 订单id
2. 可选
以下三个均需通过通用上传接口获得链接
  - logoUrl
  - adUrl
  - audioUrl
  
## 前端流程
1. 自行上传配音
  1. 先用通用上传接口上传录音
  2. 获得路径后作为audioUrl传入
2. 人工配音
  1. 传入配音内容 content 订单描述 description
  2. 得到支付链接 重定向即可
3. 机器配音
  1. 传入 content
  
### 非自行上传通用流程
1. 上传商品
2. 上传套词
