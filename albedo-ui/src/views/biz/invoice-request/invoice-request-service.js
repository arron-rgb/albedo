import request from '@/utils/request'
import qs from 'qs'


export function page(params) {
  return request({
    url: '/biz/invoice-request/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

export function save(data) {
  return request({
    url: '/biz/invoice-request',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/biz/invoice-request',
    method: 'delete',
    data: ids
  })
}


export function get(id) {
  return request({
    url: '/biz/invoice-request/' + id,
    method: 'get'
  })
}

export function list() {
  return request({
    url: '/biz/purchase-record/',
    method: 'get'
  })
}

export function requestInvoice(data) {
  return request({
    url: '/biz/purchase-record/generate',
    method: 'post',
    data: data
  })
}

export function history() {
  return request({
    url: '/biz/purchase-record/list',
    method: 'get'
  })
}
export default { page, del, save, get, list, requestInvoice, history }
