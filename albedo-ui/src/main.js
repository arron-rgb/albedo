import Vue from 'vue'

import Element from 'element-ui'

import Cookies from 'js-cookie'

import 'normalize.css/normalize.css'

import VideoPlayer from 'vue-video-player'
//
import mavonEditor from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'
// 权限指令
import permission from './components/Permission'
import './assets/styles/element-variables.scss'
// global css
import './assets/styles/index.scss'
import '@/common/reset.css'
// 代码高亮
import VueHighlightJS from 'vue-highlightjs'
import 'highlight.js/styles/atom-one-dark.css'

import App from './App'
import store from './store'
import router from './router/routers'

import './assets/icons' // icon
import './router/index' // permission control
// import 'echarts-gl'
//音频控件
import Aplayer from 'vue-aplayer'
Vue.use(VueHighlightJS)
Vue.use(mavonEditor)
Vue.use(permission)
Vue.use(Element, {
  // size: Cookies.get('size') || 'small' // set element-ui default size
  size: 'small'
})
require('video.js/dist/video-js.css')
require('vue-video-player/src/custom-theme.css')
Vue.use(VideoPlayer)
Vue.config.productionTip = false

new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App)
})
