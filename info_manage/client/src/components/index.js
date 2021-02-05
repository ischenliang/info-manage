import cPagination from './cPagination.vue'
import cDropdown from './cDropdown.vue'
import cPopicon from './cPopicon.vue'
import cPopmenu from './cPopmenu.vue'
import cJsonExcel from './cJsonExcel.vue'
import cParticles from './cParticles.vue'
import cDragVerify from './cDragVerify.vue'
import cFlexAuto from './cFlexAuto.vue'

// 使用开发插件的形式全局使用公用的components
export default {
  install (Vue) {
    Vue.mixin({
      components: {
        cPagination,
        cDropdown,
        cPopicon,
        cPopmenu,
        cJsonExcel,
        cParticles,
        cDragVerify,
        cFlexAuto
      }
    })
  }
}
