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
        path: '/taobaoGuide',
        meta: { showHeader: true },
        component: (resolve) => require(['@/views/VirtualWeb/helpCenter/taobaoGuide'], resolve),
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
        path: '/security',
        meta: { showHeader: true },
        component: (resolve) => require(['@/views/VirtualWeb/personal/security'], resolve),
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
        meta: { showHeader: true },
        component: (resolve) => require(['@/views/VirtualWeb/order/addOrder'], resolve),
        hidden: true,
      },
      {
        path: '/payOrder',
        meta: { showHeader: true },
        component: (resolve) => require(['@/views/VirtualWeb/order/payOrder'], resolve),
        hidden: true,
      },
    ]
  },
  {
    path: '/addDetail',
    meta: { showHeader: true },
    component: (resolve) => require(['@/views/VirtualWeb/order/addDetail'], resolve),
    hidden: true
  },
  //配音选项
  {
    path: '/mechineDub',
    meta: { title: '配音台词', noCache: true, showHeader: true },
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
            meta: { showHeader: true },
            component: (resolve) => require(['@/components/VirtualWeb/addDetail/machineDub/newProduct'], resolve),
            hidden: true,
          },
          {
            path:'/selectAttri',
            meta: { showHeader: true },
            component: (resolve) => require(['@/components/VirtualWeb/addDetail/machineDub/selectAttri'], resolve),
            hidden: true,
          },
          {
            path:'/addMark',
            meta: { showHeader: true },
            component: (resolve) => require(['@/components/VirtualWeb/addDetail/machineDub/addMark'], resolve),
            hidden: true,
          }
        ]
      // },
    // ]
  },
  {
    path:'/selfDub',
    meta: { showHeader: true },
    component: (resolve) => require(['@/components/VirtualWeb/addDetail/selfDub/selfDub'], resolve),
    hidden: true,
    children:[
      {
        path:'/dubDetail',
        meta: { showHeader: true },
        component: (resolve) => require(['@/components/VirtualWeb/addDetail/selfDub/DubDetail'], resolve),
        hidden: true,
        children:[
          {
            path:'/uploadDub',
            meta: { showHeader: true },
            component: (resolve) => require(['@/components/VirtualWeb/addDetail/selfDub/uploadDub'], resolve),
            hidden: true,
          },
          {
            path:'/selfMark',
            meta: { showHeader: true },
            component: (resolve) => require(['@/components/VirtualWeb/addDetail/selfDub/addMark'], resolve),
            hidden: true,
          }
        ]
      }

    ]
  },
  {
    path:'/manualDub',
    meta: { showHeader: true },
    component: (resolve) => require(['@/components/VirtualWeb/addDetail/manualDub/manualDub'], resolve),
    hidden: true,
    children:[
      {
        path:'/dubDetail',
        meta: { showHeader: true },
        component: (resolve) => require(['@/components/VirtualWeb/addDetail/manualDub/dubDetail'], resolve),
        hidden: true,
        children:[
          {
            path:'/paymentPage',
            meta: { showHeader: true },
            component: (resolve) => require(['@/components/VirtualWeb/addDetail/manualDub/paymentPage'], resolve),
            hidden: true,
          },
          {
            path:'/addMark',
            meta: { showHeader: true },
            component: (resolve) => require(['@/components/VirtualWeb/addDetail/manualDub/addMark'], resolve),
            hidden: true,
          }
        ]
      }

    ]
  }
]

export default new Router({
  // mode: 'history',
  scrollBehavior: () => ({ y: 0 }),
  routes: constantRouterMap
})
