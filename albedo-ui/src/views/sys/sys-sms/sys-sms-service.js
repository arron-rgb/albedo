import request from '@/utils/request'
import qs from 'qs'


export function page(params) {
  return request({
    url: '/sys/sys-sms/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

export function save(data) {
  return request({
    url: '/sys/sys-sms',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/sys/sys-sms',
    method: 'delete',
    data: ids
  })
}


export function get(id) {
  return request({
    url: '/sys/sys-sms/' + id,
    method: 'get'
  })
}

export default { page, del, save, get }