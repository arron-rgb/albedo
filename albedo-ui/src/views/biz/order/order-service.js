import request from '@/utils/request'
import qs from 'qs'


export function page(params) {
  return request({
    url: '/biz/order/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

export function save(data) {
  return request({
    url: '/biz/order',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/biz/order',
    method: 'delete',
    data: ids
  })
}


export function get(id) {
  return request({
    url: '/biz/order/' + id,
    method: 'get'
  })
}

export function current() {
  return request({
    url: '/biz/order/current',
    method: 'get'
  })
}
export default { page, del, save, get, current }
