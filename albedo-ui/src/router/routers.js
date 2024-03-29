import Vue from 'vue'
import Router from 'vue-router'
import Layout from '../layout/index'

Vue.use(Router)

export const constantRouterMap = [
  {
    path: '/login',
    meta: { title: '登录', noCache: true},
    component: (resolve) => require(['@/views/login'], resolve),
    hidden: true
  },
  {
    path: '/findPassword',
    meta: { title: '找回密码', noCache: true, showHeader: true },
    component: (resolve) => require(['@/views/VirtualWeb/account/findPassword'], resolve),
    hidden: true
  },
  {
    path: '/404',
    component: (resolve) => require(['@/views/features/404'], resolve),
    hidden: true
  },
  {
    path: '/401',
    component: (resolve) => require(['@/views/features/401'], resolve),
    hidden: true
  },
  {
    path: '/redirect',
    component: Layout,
    hidden: true,
    children: [
      {
        path: '/redirect/:path*',
        component: (resolve) => require(['@/views/features/redirect'], resolve)
      }
    ]
  },
  {
    // path: '/',
    component: Layout,
    path: '/dashboard',
    children: [
      {
        path: 'dashboard',
        component: (resolve) => require(['@/views/home'], resolve),
        name: 'Dashboard',
        meta: { title: '首页', icon: 'index', affix: true, noCache: true }
      }
    ]
  },
  {
    path: '/user',
    component: Layout,
    hidden: true,
    redirect: 'noredirect',
    children: [
      {
        path: 'center',
        component: (resolve) => require(['@/views/sys/user/center'], resolve),
        name: '个人中心',
        meta: { title: '个人中心' }
      }
    ]
  },

  //虚拟工坊
  {
    path: '/',
    meta: { title: '主页', noCache: true, showHeader: true },
    component: (resolve) => require(['@/views/VirtualWeb/exhibition/home'], resolve),
    hidden: true
  },
  {
    path: '/proService',
    meta: { title: '企业服务', noCache: true, showHeader: true },
    component: (resolve) => require(['@/views/VirtualWeb/exhibition/enterprise'], resolve),
    hidden: true
  },
  {
    path: '/train',
    meta: { title: '真人代播', noCache: true, showHeader: true },
    component: (resolve) => require(['@/views/VirtualWeb/exhibition/train'], resolve),
    hidden: true
  },
  {
    path: '/contact',
    meta: { title: '帮助中心', noCache: true, showHeader: true },
    component: (resolve) => require(['@/views/VirtualWeb/helpCenter/helpContact'], resolve),
    hidden: true,
    children: [
      {
        path: '/siteGuide',
        meta: { showHeader: true },
        component: (resolve) => require(['@/views/VirtualWeb/helpCenter/siteGuide'], resolve),
        hidden: true
      },
      {
        path: '/agreement',
        meta: { showHeader: true },
        component: (resolve) => require(['@/views/VirtualWeb/helpCenter/agreement'], resolve),
        hidden: true
      },
      {
        path: '/privacy',
        meta: { showHeader: true },
        component: (resolve) => require(['@/views/VirtualWeb/helpCenter/privacy'], resolve),
        hidden: true
      },
      {
        path: '/problems',
        meta: { showHeader: true },
        component: (resolve) => require(['@/views/VirtualWeb/helpCenter/problems'], resolve),
        hidden: true
      },
      {
        path: '/contactUs',
        meta: { showHeader: true },
        component: (resolve) => require(['@/views/VirtualWeb/helpCenter/contactUs'], resolve),
        hidden: true
      },
    ]
  },
  {
    path: '/personal',
    meta: { title: '个人中心', showHeader: true },
    component: (resolve) => require(['@/views/VirtualWeb/personal/personal'], resolve),
    hidden: true,
    children: [
      {
        path: '/myData',
        meta: { showHeader: true},
        component: (resolve) => require(['@/views/sys/user/center'], resolve),
      },
      {
        path: '/memberCenter',
        meta: { showHeader: true },
        component: (resolve) => require(['@/views/VirtualWeb/personal/memberCenter'], resolve),
        hidden: true
      },
      {
        path: '/myOrder',
        meta: { showHeader: true },
        component: (resolve) => require(['@/views/VirtualWeb/personal/myOrder'], resolve),
        hidden: true
      },
      {
        path: '/myReceipt',
        meta: { showHeader: true },
        component: (resolve) => require(['@/views/VirtualWeb/personal/myReceipt'], resolve),
        hidden: true
      },
      {
        path: '/historyReceipt',
        meta: { showHeader: true },
        component: (resolve) => require(['@/views/VirtualWeb/personal/historyReceipt'], resolve),
        hidden: true
      },
    ]
  },

  {
    path: '/Order',
    meta: { title: "订单页面",showHeader: true },
    component: (resolve) => require(['@/views/VirtualWeb/order/order'], resolve),
    hidden: true,
    children: [
      {
        path: '/addOrder',
        meta: { showHeader: true, stepLine: 0 },
        component: (resolve) => require(['@/views/VirtualWeb/order/addOrder'], resolve),
        hidden: true,
      },
      {
        path: '/payOrder',
        meta: { showHeader: true, stepLine: 1 },
        component: (resolve) => require(['@/views/VirtualWeb/order/payOrder'], resolve),
        hidden: true,
      },
      {
        path: '/waiting',
        meta: { showHeader: true, stepLine: 2 },
        component: (resolve) => require(['@/components/VirtualWeb/waiting'], resolve),
        hidden: true
      },
      {
        path: '/endOrder',
        meta: { showHeader: true, stepLine: 5 },
        component: (resolve) => require(['@/views/VirtualWeb/order/endOrder'], resolve),
        hidden: true
      },
    ]
  },
  {
    path: '/addDetail',
    meta: { showHeader: true, stepLine: 3 },
    component: (resolve) => require(['@/views/VirtualWeb/order/addDetail'], resolve),
    hidden: true
  },
  //配音选项
  {
    path: '/mechineDub',
    meta: { title: '配音台词', noCache: true, showHeader: true, stepLine: 3 },
    component: (resolve) => require(['@/components/VirtualWeb/addDetail/machineDub/machineDub'], resolve),
    hidden: true,
    // children: [
    //   {
    //     path: '/proDetail',
    //     meta: { showHeader: true },
    //     component: (resolve) => require(['@/components/VirtualWeb/addDetail/machineDub/dubDetail'], resolve),
    //     hidden: true,
        children:[
          {
            path:'/newProduct',
            meta: { showHeader: true, stepLine: 3 },
            component: (resolve) => require(['@/components/VirtualWeb/addDetail/machineDub/newProduct'], resolve),
            hidden: true,
          },
          {
            path:'/selectAttri',
            meta: { showHeader: true, stepLine: 3 },
            component: (resolve) => require(['@/components/VirtualWeb/addDetail/machineDub/selectAttri'], resolve),
            hidden: true,
          },
          {
            path:'/uploadDub',
            meta: { showHeader: true, stepLine: 3 },
            component: (resolve) => require(['@/components/VirtualWeb/addDetail/machineDub/uploadDub'], resolve),
            hidden: true,
          },
        ]
  },
]

export default new Router({
  // mode: 'history',
  scrollBehavior: () => ({ y: 0 }),
  routes: constantRouterMap
})
