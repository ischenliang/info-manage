import cPagination from './cPagination.vue'
import cDropdown from './cDropdown.vue'
import cPopicon from './cPopicon.vue'
import cPopmenu from './cPopmenu.vue'
import cJsonExcel from './cJsonExcel.vue'
import cParticles from './cParticles.vue'
import cDragVerify from './cDragVerify.vue'
import cFlexAuto from './cFlexAuto.vue'
import cTagsInput from './cTagsInput.vue'
import cForkMe from './cForkMe.vue'
import cResources from './cResources.vue'
import cToggleLook from './cToggleLook.vue'
import cToggleCopy from './cToggleCopy.vue'
import cQuillEditor from './cQuillEditor.vue'
import cMavonEditor from './cMavonEditor.vue'
import cMavonPreview from './cMavonPreview.vue'
import cBackUp from './cBackUp.vue'
import cMenuItem from './cMenuItem.vue'
import cTagsView from './cTagsView.vue'
import cBreadCrumb from './cBreadCrumb.vue'
import cChart1 from './chart/cChart1.vue'
import cChart2 from './chart/cChart2.vue'
import cChart3 from './chart/cChart3.vue'
import cChart4 from './chart/cChart4.vue'
import cChart5 from './chart/cChart5.vue'
import cChart6 from './chart/cChart6.vue'
import cChart7 from './chart/cChart7.vue'
import cChart8 from './chart/cChart8.vue'
import cChart9 from './chart/cChart9.vue'
import cChart10 from './chart/cChart10.vue'
import cChart11 from './chart/cChart11.vue'
import cChart12 from './chart/cChart12.vue'
import cChart13 from './chart/cChart13.vue'
import cChart14 from './chart/cChart14.vue'

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
        cFlexAuto,
        cTagsInput,
        cForkMe,
        cResources,
        cToggleLook,
        cToggleCopy,
        cQuillEditor,
        cMavonEditor,
        cMavonPreview,
        cBackUp,
        cMenuItem,
        cTagsView,
        cBreadCrumb,
        cChart1,
        cChart2,
        cChart3,
        cChart4,
        cChart5,
        cChart6,
        cChart7,
        cChart8,
        cChart9,
        cChart10,
        cChart11,
        cChart12,
        cChart13,
        cChart14
      }
    })
  }
}
