import cPagination from './cPagination.vue'
import cDropdown from './cDropdown.vue'

// 使用开发插件的形式全局使用公用的components
export default {
  install (Vue) {
    Vue.mixin({
      components: {
        cPagination,
        cDropdown
      }
    })
  }
}
