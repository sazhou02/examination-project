import { relativeTimeRounding } from "moment";

const TOKEN_KEY  = 'App-Token'

// 获取Token
export function getToken() {
  return localStorage.getItem(TOKEN_KEY);
}

// 设置Token
export function setToken(token) {
  localStorage.setItem(TOKEN_KEY, token);
}

// 删除Token
export function removeToken() {
  localStorage.removeItem(TOKEN_KEY);
}


const USER_KEY = "userInfo";
export function getUserInfo() {
  return JSON.parse(localStorage.getItem(USER_KEY));
}

export function setUserInfo(userInfo) {
  return localStorage.setItem(USER_KEY, JSON.stringify(userInfo));
}

export function removeUserInfo() {
  return localStorage.removeItem(USER_KEY);
}