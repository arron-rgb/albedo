import qs from 'qs'
import request from "@/utils/request";

export function uploadFile(file, config) {
  let formData = new FormData()
  formData.append('file', file.file)
  return request({
    url: '/file/upload',
    data: formData,
    method: 'post',
    // header: {
    //   "Content-Type": "application/x-www-form-urlencoded;charset=utf-8"
    // },
    config : config
  })
}

export function saveProduct(data) {
  return request({
    url: '/biz/commodity/batch',
    method: 'post',
    data : [data],
  })
}
export default { uploadFile, saveProduct }
