import request from '@/utils/request'
import qs from 'qs'


export function page(params) {
  return request({
    url: '/biz/commodity/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

export function save(data) {
  return request({
    url: '/biz/commodity',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/biz/commodity',
    method: 'delete',
    data: ids
  })
}


export function get(id) {
  return request({
    url: '/biz/commodity/' + id,
    method: 'get'
  })
}

export default { page, del, save, get }