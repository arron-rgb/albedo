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

export function update(orderId, videoIds) {//用户更新视频
  return request({
    url: '/biz/order/update',
    method: 'post',
    data :{
      // body :{
        orderId : orderId,
        videoIds : videoIds
      // }
    }
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
    url: '/biz/balance',
    method: 'get',
  })
}

export function isAccept(data){
  return request({
    url: '/biz/order/accept',
    method: 'get',
    params : {
      editDescription : data.editDescription,
      orderId : data.orderId,
      state : data.state,//用户意见  1满意   0 不满意
    }
  })
}
export default { save, purchase, placeSecond, balance, edit, isAccept, update }
