import Vue from 'vue';
import Router from 'vue-router';
import Login from './views/Login.vue';

Vue.use(Router);

export default new Router({
  routes: [
    { path: '/', redirect: '/main' },
    {
      path: '/login',
      name: 'login',
      component: Login,
    },
    {
      path: '/register',
      name: 'register',
      component: () => import('./views/Register'),
    },
    {
      path: '/main',
      component: () => import('./views/Main'),
      children: [{
        path: '/',
        redirect: '/main/home'
      },
      {
        path: 'home',
        name: 'home',
        component: () => import('./views/tab/Home')
      },
      {
        path: '/institution',
        component: () => import('./views/tab/Institution/Institution.vue'),
        children: [
          {
            path: "/",
            name: "institution",
            component: () => import('./views/tab/Institution/Institution.vue')
          }
        ]
      }, 
      {
        path: "/institutionDetail",
        name: "institutionDetail",
        component: () => import('./views/tab/Institution/Detail.vue')
      },
      {
        path: '/package',
        name: 'package',
        component: () => import('./views/tab/Package.vue')
      },
      {
        path: '/packageDetail',
        name: 'packageDetail',
        component: () => import('./views/tab/PackageDetail.vue')
      },
      {
        path: '/homeUser',
        name: 'homeUser',
        component: () => import('./views/tab/HomeUser')
      }, {
        path: '/user',
        name: 'user',
        component: () => import('./views/user/index.vue')
      },
      {
        path: "/userInfo",
        name: "userInfo",
        component: () => import('./views/user/UserInfo.vue')
      },
      {
        path: '/pay',
        name: 'pay',
        component: () => import('./views/tab/pay')
      }]
    },
    {
      path: '/userDetail',
      name: 'userDetail',
      component: () => import('./views/userDetail'),
    },
    {
      path: '/order',
      name: 'order',
      component: () => import('./views/Order.vue')
    },
    {
      path: '/reportDetail',
      name: 'reportDetail',
      component: () => import('./views/reportDetail.vue'),
    },
    {
      path: '/feedback',
      name: 'feedback',
      component: () => import('./views/Feedback')
    }
  ],
});
