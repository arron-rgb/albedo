import request from '@/utils/request'
import qs from 'qs'


export function generate() {
  return request({
    url: '/sys/user/generate',
    method: 'get'
  })
}

export function list() {
  return request({
    url: '/sys/user/list',
    method: 'get',
  })
}
export default { generate, list }
