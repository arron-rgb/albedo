import request from '@/utils/request'
import qs from 'qs'


export function page(params) {
  return request({
    url: '/biz/contact-info/?' + qs.stringify(params, {indices: false}),
    method: 'get'
  })
}

export function save(data) {
  return request({
    url: '/biz/contact-info',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/biz/contact-info',
    method: 'delete',
    data: ids
  })
}


export function get(id) {
  return request({
    url: '/biz/contact-info/' + id,
    method: 'get'
  })
}

export function update(id) {
  return request({
    url: '/biz/contact-info/update/?' + id,
    method: 'get'
  })
}


export default {page, del, save, get, update}
