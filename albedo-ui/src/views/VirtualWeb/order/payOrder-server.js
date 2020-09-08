import request from '@/utils/request'
import axios from 'axios'
import Config from '@/settings'
import qs from 'qs'

export function save(data) {
  return request({
    url: '/biz/order/place',
    method: 'post',
    data : data
  })
}

export function purchase(data) {
  axios.post(
    Config.api + '/biz/order/purchase',
    {},
    {
      headers: {
        'Content-type':'application/json;charset=utf-8'
      },
      params :data
    }
  ).then(res => {
    return res
  })
}


export default { save, purchase }
