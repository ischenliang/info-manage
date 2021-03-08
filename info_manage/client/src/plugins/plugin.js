import Vue from 'vue'
import JsonExcel from 'vue-json-excel'
import CUI from '@/components/index'
import VueQuillEditor from 'vue-quill-editor'

import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'

Vue.use(CUI)
Vue.component('jsonExcel', JsonExcel)
Vue.use(VueQuillEditor)
