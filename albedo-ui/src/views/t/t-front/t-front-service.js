import request from '@/utils/request'
import qs from 'qs'


export function page(params) {
  return request({
    url: '/t/t-front/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

export function save(data) {
  return request({
    url: '/t/t-front',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/t/t-front',
    method: 'delete',
    data: ids
  })
}


export function get(id) {
  return request({
    url: '/t/t-front/' + id,
    method: 'get'
  })
}

export default { page, del, save, get }