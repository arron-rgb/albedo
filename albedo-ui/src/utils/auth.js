import Cookies from 'js-cookie'
import Config from '@/settings'

const TokenKey = Config.TokenKey

export function getToken() {
  return Cookies.get(TokenKey)
}

export function getXsrfToken() {
  console.log('getgetget')
  return Cookies.get('XSRF-TOKEN')
}

export function setToken(token, rememberMe) {
  console.log('fucku')
  if (rememberMe) {
    return Cookies.set(TokenKey, token, {expires: Config.tokenCookieExpires})
  } else return Cookies.set(TokenKey, token)
}

export function removeToken() {
  return Cookies.remove(TokenKey)
}
