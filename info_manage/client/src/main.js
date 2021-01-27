import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

import './plugins/elementui'
import './plugins/plugin'
import config from './config/export_fields'
import '@/assets/css/style.scss'
import '@/assets/css/global.scss'
import http from './api'

Vue.config.productionTip = false
Vue.prototype.$http = http
Vue.prototype.$fields = config

// 全局值空过滤器
Vue.filter('valueEmpty', (value) => {
  if (value === '' || value === null || value === undefined) {
    return '-'
  } else {
    return value
  }
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
