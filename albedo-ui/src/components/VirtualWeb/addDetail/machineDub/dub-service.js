import qs from 'qs'
import request from "@/utils/request";

export function uploadFile(file) {
  let formData = new FormData()
  formData.append('file', file.file)
  return request({
    url: '/file/upload',
    data: formData,
    method: 'post',
    header: {
      "Content-Type": "application/x-www-form-urlencoded;charset=utf-8"
    },
  })
}

export default { uploadFile }
