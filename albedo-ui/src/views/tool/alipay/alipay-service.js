import request from '@/utils/request'

export function update(data) {
  return request({
    url: '/tool/aliPay',
    data,
    method: 'put'
  })
}

// 支付
export function toAliPay(url, data) {
  return request({
    url: '/tool/' + url,
    data,
    method: 'post'
  })
}
