import request from '@/utils/request'
import axios from 'axios'
import Config from '@/settings'
import qs from 'qs'
import {MSG_TYPE_SUCCESS} from "@/const/common";

export function save(data) {
  return request({
    url: '/biz/order/place',
    method: 'post',
    data : data
  })
}

export function edit(data) {
  return request({
    url: '/biz/order/edit',
    method: 'get',
    params :data
  })
}

export function purchase(data) {
  return new Promise((resolve, reject) => {
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
      // console.log(res);
      if (res.data.code === MSG_TYPE_SUCCESS) {

        window.open(res.data.data);

      }else{
        alert('支付失败，请重试！')
      }
    }).catch(error => {
      reject(error)
    })
  })

}

export function placeSecond(data){
  return request({
    url: '/biz/order/placeSecond',
    method: 'post',
    data : data
  })
}

export function balance() {
  return request({
    url: '/biz/balance/undefined',
    method: 'get',
  })
}

export default { save, purchase, placeSecond, balance, edit }
