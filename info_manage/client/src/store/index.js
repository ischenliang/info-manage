import Vue from 'vue'
import Vuex from 'vuex'
import user from '@/store/module/user'
import role from '@/store/module/role'
import tagsview from '@/store/module/tagsview'
import { Message } from 'element-ui'

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    websocket: null
  },
  mutations: {
    WEBSOCKE_INIT (state, url) {
      if (typeof WebSocket === 'undefined') {
        Message({
          title: '错误',
          message: '您的浏览器不支持socket',
          type: 'error',
          duration: 1000
        })
      } else {
        // 初始化WebSocket
        state.websock = new WebSocket(url)
        // 监听socket连接
        state.websock.onopen = function () {
          console.log('【websocket】连接成功')
        }
        // 监听socket错误信息
        state.websock.onerror = function (error) {
          console.log(`【websocket】发生错误：${error}`)
        }
        // 监听socket消息
        state.websock.onmessage = function (msg) {
          console.log(`【websocket】发生错误：${msg}`)
        }
        // 监听socket消息
        state.websock.onclose = function () {
          console.log('【websocket】连接关闭')
        }
      }
    }
  },
  actions: {
    WEBSOCKE_INIT ({ commit }, url) {
      commit('WEBSOCKE_INIT', url)
    }
  },
  modules: {
    user,
    role,
    tagsview
  },
  getters: {
    perms: state => state.user.perms,
    menus: state => state.user.menus,
    tags: state => state.tagsview.tags
  }
})
export default store
