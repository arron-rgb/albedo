import commonUtil from '@/utils/common'
import loginService from '@/api/login'
import storeApi from '@/utils/store'
import {MSG_TYPE_SUCCESS} from '@/const/common'
import payOrder from "@/views/VirtualWeb/order/payOrder-server";

const user = {
  state: {
    user: {},
    roles: [],
    permissions: [],
    loginSuccess: storeApi.get({
      name: 'loginSuccess'
    }) || false,
    // 第一次加载菜单时用到
    loadMenus: false,
    token : '',
    userType : '',//用户类型
    balance : {},
  },

  mutations: {
    SET_USER: (state, user) => {
      state.user = user
    },
    SET_USERTYPE: (state, userType) => {
      state.userType = userType
    },
    SET_TOKEN: (state, data) => {
      state.token = data
    },
    SET_BALANCE: (state, data) => {
      state.balance = data
    },
    SET_ROLES: (state, roles) => {
      state.roles = roles
    },
    SET_PERMISSIONS: (state, permissions) => {
      state.permissions = permissions
    },
    SET_LOAD_MENUS: (state, loadMenus) => {
      state.loadMenus = loadMenus
    },
    SET_LOGIN_SUCCESS: (state, loginSuccess) => {
      state.loginSuccess = loginSuccess
      storeApi.set({
        name: 'loginSuccess',
        content: state.loginSuccess,
        type: 'session'
      })
    }
  },

  actions: {
    // 登录
    Login({commit}, user) {
      const params = commonUtil.encryption({
        data: user,
        key: 'somewhere-albedo',
        param: ['password']
      })
      return new Promise((resolve, reject) => {
        loginService.login(params).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            commit('SET_LOGIN_SUCCESS', true)
            commit('SET_LOAD_MENUS', true)
            resolve()
          }
        }).catch(error => {
          reject(error)
        })
      })
    },
    Register({commit}, user) {
      const params = commonUtil.encryption({
        data: user,
        key: 'somewhere-albedo',
        param: []
      });
      return new Promise((resolve, reject) => {
        loginService.register(params).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            commit('SET_LOGIN_SUCCESS', true)
            commit('SET_LOAD_MENUS', true)
            resolve()
          }
        }).catch(error => {
          reject(error)
        })
      })
    },

    // 获取用户信息
    GetUser({commit}) {
      return new Promise((resolve, reject) => {
        loginService.getUser().then((res) => {
          const data = res.data || {}
          setUserInfo(data, commit);
          payOrder.balance().then(res => {//获取用户套餐信息
            if(res.code === MSG_TYPE_SUCCESS){
              commit('SET_BALANCE', res.data)
            }
          }).catch(res =>{
              reject();
            }
          )
          resolve(data)
        }).catch((err) => {
          reject(err)
        })
      })
    },
        // 登出
    LogOut({commit}) {
      return new Promise((resolve, reject) => {
        loginService.logout().then(res => {
          logOut(commit)
          resolve()
        }).catch(error => {
          logOut(commit)
          reject(error)
        })
      })
    },

    updateLoadMenus({commit}) {
      return new Promise((resolve, reject) => {
        commit('SET_LOAD_MENUS', false)
      })
    }
  }
}

export const logOut = (commit) => {
  commit('SET_LOGIN_SUCCESS', false)
  commit('SET_USER', {})
  commit('SET_ROLES', [])
  commit('SET_PERMISSIONS', [])
  commit('SET_BALANCE', {})
}

export const setUserInfo = (res, commit) => {
  commit('SET_USERTYPE', res.userType)
  commit('SET_USER', res.user)
  commit('SET_ROLES', res.roles || [])
  commit('SET_PERMISSIONS', res.permissions || [])
}

export default user
