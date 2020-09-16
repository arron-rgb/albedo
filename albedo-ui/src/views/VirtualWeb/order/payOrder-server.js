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
    console.log(res.data);
    if (res.data.code === MSG_TYPE_SUCCESS) {
      window.open(res.data.message);

      // this.$message({
      //   message: '支付成功！',
      //   type: 'success'
      // });
    }
  }).catch(error => {
    reject(error)
  })
}


export default { save, purchase }
