import request from '@/utils/request'
import qs from 'qs'


export function page(params) {
  return request({
    url: '/biz/coupon/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

export function save(data) {
  return request({
    url: '/biz/coupon',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/biz/coupon',
    method: 'delete',
    data: ids
  })
}
export function verify(code) {
  return request({
    url: '/biz/coupon/query',
    method: 'get',
    params :{
      code : code
    }
  })
}

export function get(id) {
  return request({
    url: '/biz/coupon/' + id,
    method: 'get'
  })
}

export default { page, del, save, get, verify }
