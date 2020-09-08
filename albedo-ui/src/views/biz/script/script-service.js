import request from '@/utils/request'
import qs from 'qs'


export function page(params) {
  return request({
    url: '/biz/script/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

export function save(data) {
  return request({
    url: '/biz/script',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/biz/script',
    method: 'delete',
    data: ids
  })
}


export function get(id) {
  return request({
    url: '/biz/script/' + id,
    method: 'get'
  })
}

export function list() {
  return request({
    url: '/biz/script/list',
    method: 'get'
  })
}

export default { page, del, save, get, list }
