import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

import './plugins/elementui'
import '@/assets/css/style.scss'
import '@/assets/css/global.scss'
import CUI from '@/components/index'
import http from './api'

Vue.config.productionTip = false
Vue.prototype.$http = http

Vue.use(CUI)

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
