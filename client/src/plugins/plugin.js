import Vue from 'vue'
import JsonExcel from 'vue-json-excel'
import CUI from '@/components/index'
import VueQuillEditor from 'vue-quill-editor'
import mavonEditor from 'mavon-editor'

// import 'vue-quill-editor/dist'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'
import 'mavon-editor/dist/css/index.css'

Vue.use(CUI)
Vue.component('jsonExcel', JsonExcel)
Vue.use(VueQuillEditor)
Vue.use(mavonEditor)
