import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from '@/store/index'
import './permission'
import Vant from 'vant';
import 'vant/lib/index.css';
import VantGreen from 'vant-green';
import 'vant-green/lib/index.css';

Vue.use(Vant);
Vue.use(VantGreen);

Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
