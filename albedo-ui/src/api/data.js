import request from '@/utils/request'
import qs from 'qs'

export function initData(url, params) {
  return request({
    url: url + '?' + qs.stringify(params, {indices: false}),
    method: 'get'
  })
}

export function download(url, params) {
  return request({
    url: url + '?' + qs.stringify(params, {indices: false}),
    method: 'get',
    responseType: 'blob'
  })
}

export function staticsData(codes) {
  return request({
    url: '/dict/codes',
    method: 'get',
    params: {
      codes: codes
    }
  })
}

export default {initData, download, staticsData}
