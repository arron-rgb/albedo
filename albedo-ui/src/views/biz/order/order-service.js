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

export function list() {
  return request({
    url: '/biz/order/list',
    method: 'get'
  })
}

export function consume(id){//员工接单
  return request({
    url: '/biz/order/consume',
    method: 'get',
    params : {
      orderId : id
    }
  })
}

export function uploadAudio(data){//保存上传的音频
  return request({
    url: '/biz/order/audio/upload',
    method: 'post',
    params : data,
  })
}

export function todo(){//保存上传的音频
  return request({
    url: '/biz/order/todo/list',
    method: 'get',
  })
}

export function belong(){//保存上传的音频
  return request({
    url: '/biz/order/list/belong',
    method: 'get',
  })
}
export default { page, del, save, get, current, list, consume, uploadAudio, todo, belong }
