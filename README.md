
#接口文档
##/a/biz/order/place
#####功能：下单
#####方法：POST
#####测试数据：
```json
content: 订单json
  必须要传入title为anchorNum的字段，用于计算订单金额
  其余格式同获取Config中data字段，不做限制
method: 支付方式，暂时没用
totalAmount: 订单金额 保留2位小数，金额=主播数量的价格+加速的价格
type: 1加速 0普通
```
#####返回数据
```json
                                    {
                                      "code": 1,
                                      "data": [
                                        {
                                          "createdBy": "system",
                                          "createdDate": "2020-09-05 01:14:20",
                                          "lastModifiedBy": "system",
                                          "lastModifiedDate": "2020-08-28 22:23:14",
                                          "version": 0,
                                          "description": null,
                                          "id": "3c734f2104ab77ecdaba2bb96baa929c",
                                          "price": 100,
                                          "goodsQuantity": 200,
                                          "videoTime": 2,
                                          "childAccount": 3,
                                          "editTime": -1,
                                          "storage": 3,
                                          "history": 0,
                                          "anchorAmount": 6,
                                          "envAmount": 6,
                                          "anchorAmountPlus": -1,
                                          "envAmountPlus": -1,
                                          "times": 3,
                                          "name": "升级"
                                        },
                                        {
                                          "createdBy": "system",
                                          "createdDate": "2020-09-05 01:14:20",
                                          "lastModifiedBy": "system",
                                          "lastModifiedDate": "2020-08-28 22:22:24",
                                          "version": 0,
                                          "description": null,
                                          "id": "44fb4bc69ff88e3e7113c597b0fa99cb",
                                          "price": 100,
                                          "goodsQuantity": 2147483647,
                                          "videoTime": 2147483647,
                                          "childAccount": 5,
                                          "editTime": 3,
                                          "storage": 2147483647,
                                          "history": 0,
                                          "anchorAmount": 3,
                                          "envAmount": 3,
                                          "anchorAmountPlus": 1,
                                          "envAmountPlus": 1,
                                          "times": 3,
                                          "name": "定制"
                                        },
                                        {
                                          "createdBy": "system",
                                          "createdDate": "2020-09-05 01:14:20",
                                          "lastModifiedBy": "system",
                                          "lastModifiedDate": "2020-08-28 22:23:14",
                                          "version": 0,
                                          "description": null,
                                          "id": "6d89ea978f83243c3a137f3d25d9f10e",
                                          "price": 100,
                                          "goodsQuantity": 100,
                                          "videoTime": 2,
                                          "childAccount": 3,
                                          "editTime": -1,
                                          "storage": 1,
                                          "history": 0,
                                          "anchorAmount": 3,
                                          "envAmount": 3,
                                          "anchorAmountPlus": -1,
                                          "envAmountPlus": -1,
                                          "times": 3,
                                          "name": "标准"
                                        },
                                        {
                                          "createdBy": "system",
                                          "createdDate": "2020-09-05 01:14:20",
                                          "lastModifiedBy": "system",
                                          "lastModifiedDate": "2020-08-28 22:23:14",
                                          "version": 0,
                                          "description": null,
                                          "id": "71af84e41a0e9783f4a21f4a5ea2bdd0",
                                          "price": 100,
                                          "goodsQuantity": 2147483647,
                                          "videoTime": 4,
                                          "childAccount": 5,
                                          "editTime": 1,
                                          "storage": 6,
                                          "history": 0,
                                          "anchorAmount": 12,
                                          "envAmount": 12,
                                          "anchorAmountPlus": 1,
                                          "envAmountPlus": 1,
                                          "times": 3,
                                          "name": "旗舰"
                                        }
                                      ],
                                      "message": ""
                                    }
```
#####返回关键字含义


