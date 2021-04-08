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
import VueParticles from 'vue-particles'
import Cookies from 'js-cookie'
import moment from 'moment'
moment.locale('zh-cn')

Vue.config.productionTip = false
Vue.prototype.$http = http
Vue.prototype.$fields = config
Vue.prototype.$Cookies = Cookies
Vue.prototype.$moment = moment
Vue.use(VueParticles)

// 全局指令：按钮级权限指令控制

// 自定义指令实现按钮级的权限控制
Vue.directive('perms', {
  inserted: (el, binding, vnode) => {
    const perms = vnode.context.$store.state.user.perms
    if (!perms.includes(binding.value)) {
      el.parentNode.removeChild(el)
    }
  }
})

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
