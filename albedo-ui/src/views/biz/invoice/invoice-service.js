import request from '@/utils/request'
import qs from 'qs'


export function page(params) {
  return request({
    url: '/biz/invoice/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

export function save(data) {
  return request({
    url: '/biz/invoice',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/biz/invoice',
    method: 'delete',
    data: ids
  })
}


export function get(id) {
  return request({
    url: '/biz/invoice/' + id,
    method: 'get'
  })
}

export default { page, del, save, get }