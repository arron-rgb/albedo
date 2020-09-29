import request from '@/utils/request'
import qs from 'qs'


export function getVerify(phone) {
  return request({
    url: '/password/reset',
    method: 'get',
    params : {
      phone : phone
    }
  })
}

export function reset(data) {
  return request({
    url: '/sys/password/reset',
    method: 'post',
    data : data,
  })
}

export default { getVerify, reset }
