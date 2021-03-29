export default {
  namespaced: true,
  state: {
    tags: [{
      name: 'Home',
      params: {},
      query: {},
      title: '首页',
      path: '/home',
      fullPath: '/home'
    }]
  },
  mutations: {
    // 添加标签
    ADD_TAG (state, tag) {
      const index = state.tags.findIndex(item => item.path === tag.path)
      if (index === -1) {
        state.tags.push(tag)
      } else {
        // 缓存路由未变但是参数发生改变的情况，如 /resource/list?path=1 /resource/list?path=3
        state.tags[index].params = tag.params
        state.tags[index].query = tag.query
        state.tags[index].fullPath = tag.fullPath
        state.tags[index].title = tag.title
        state.tags[index].name = tag.name
      }
    },
    // 删除标签
    DEL_TAG (state, tag) {
      const index = state.tags.findIndex(item => item.name === tag.name)
      state.tags.splice(index, 1)
    },
    // 删除其他标签
    DEL_OTHER_TAG (state, tags) {
      state.tags = tags
    },
    // 删除其他标签
    DEL_ALL_TAG (state, tags) {
      state.tags = tags
    }
  },
  actions: {
    add_tag ({ commit }, tag) {
      commit('ADD_TAG', tag)
    },
    // 删除标签
    del_tag ({ commit }, tag) {
      commit('DEL_TAG', tag)
    },
    // 删除其他标签
    del_other_tag ({ commit }, tag) {
      commit('DEL_OTHER_TAG', [{
        name: 'Home',
        params: {},
        query: {},
        title: '首页',
        path: '/home',
        fullPath: '/home'
      }, tag])
    },
    // 删除
    del_all_tag ({ commit }) {
      commit('DEL_ALL_TAG', [{
        name: 'Home',
        query: {},
        params: {},
        title: '首页',
        path: '/home',
        fullPath: '/home'
      }])
    }
  }
}
