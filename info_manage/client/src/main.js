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

Vue.config.productionTip = false
Vue.prototype.$http = http
Vue.prototype.$fields = config
Vue.prototype.$Cookies = Cookies
Vue.use(VueParticles)

// 全局指令：按钮级权限指令控制
Vue.directive('perms', {
  inserted: (el, binding, vnode) => {
    console.log(el)
    // const perm = binding.value
    // // 判断是否拥有该类别的大权限
    // if (store.getters.permission[perm.category] === undefined) {
    //   el.parentNode.removeChild(el)
    // } else {
    //   // 判断是否拥有大权限下的某一个小权限
    //   if (!store.getters.permission[perm.category].includes(perm.id)) {
    //     el.parentNode.removeChild(el)
    //   }
    // }
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
