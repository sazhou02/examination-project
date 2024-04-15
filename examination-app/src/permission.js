import router from './router'
import {
    getToken,
    removeToken
} from './utils/auth'
import { Toast } from 'vant';
import store from './store'
import Vue from 'vue'

Vue.use(Toast)

const whiteList = ['/login', '/register'] // 不重定向白名单

router.beforeEach((to, from, next) => {
    if (getToken() && getToken() != 'undefined') {
        if (to.path === '/login') {
            next({
                path: '/main'
            })
        } else {
            store.commit('SET_TOKEN', getToken())
            next();
        }
    } else {
        if (whiteList.indexOf(to.path) !== -1) {
            next();
        } else {
            next({path: '/login'});
        }
    }
})