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

export function add(data) {
  return request({
    url: '/sys/user/change',
    method: 'post',
    data : {
      companyName : data
    },
  })
}

export default { getVerify, reset, add}
