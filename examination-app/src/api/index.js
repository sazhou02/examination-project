import axios from 'axios';
import { getToken, removeToken } from '@/utils/auth';

import { Toast } from 'vant';
import router from '../router';

const http = axios.create({
  baseURL: `http://${location.hostname}:3000`,
  timeout: 15000,
  headers: {
    'Content-Type': 'application/json'
  },
});

// request拦截器
http.interceptors.request.use(
  config => {
    const token = getToken();
    if (token) {
      config.headers.token = token;
    }
    return config;
  },
  error => error,
);

// response拦截器
http.interceptors.response.use(
  response => {
    return response;
  },
  error => {
    if (error.response && error.response.status === 401) {
      Toast.fail('身份验证失败，请重新登录');
      removeToken();
      // 设置一个延迟来等待Toast信息显示完成后再跳转
      setTimeout(() => {
        router.push('/login');
      }, 1000);
    }
    return Promise.reject(error);
  }
);


export default http;