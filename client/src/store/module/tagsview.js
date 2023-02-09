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
    }],
    cachedTags: ['Home']
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
      const index = state.tags.findIndex(item => item.fullPath === tag.fullPath)
      if (index !== 0) {
        state.tags.splice(index, 1)
      }
    },
    // 删除其他标签
    DEL_OTHER_TAG (state, tags) {
      state.tags = tags
    },
    // 删除其他标签
    DEL_ALL_TAG (state, tags) {
      state.tags = tags
    },
    // 新增缓存标签
    ADD_CACHED_TAG (state, tag) {
      if (!state.cachedTags.includes(tag)) {
        state.cachedTags.push(tag)
      }
    },
    // 删除缓存标签
    DEL_CACHED_TAG (state, tag) {
      const index = state.cachedTags.findIndex(item => item === tag)
      state.cachedTags.splice(index, 1)
    },
    // 删除其他缓存标签
    DEL_OTHER_CACHED_TAG (state, tags) {
      state.cachedTags = tags
    },
    // 删除所有缓存标签
    DEL_ALL_CACHED_TAG (state, tags) {
      state.cachedTags = tags
    }
  },
  actions: {
    // 新增标签：于此同时需要新增缓存标签
    add_tag ({ commit }, tag) {
      commit('ADD_TAG', tag)
      commit('ADD_CACHED_TAG', tag.name)
    },
    // 删除标签：于此同时需要删除缓存标签
    del_tag ({ commit }, tag) {
      commit('DEL_TAG', tag)
      commit('DEL_CACHED_TAG', tag.name)
    },
    // 删除其他标签
    del_other_tag ({ commit }, tag) {
      if (tag.name === 'Home') {
        commit('DEL_OTHER_TAG', [{
          name: 'Home',
          params: {},
          query: {},
          title: '首页',
          path: '/home',
          fullPath: '/home'
        }])
      } else {
        commit('DEL_OTHER_TAG', [{
          name: 'Home',
          params: {},
          query: {},
          title: '首页',
          path: '/home',
          fullPath: '/home'
        }, tag])
      }
      commit('DEL_OTHER_CACHED_TAG', ['Home', tag.name])
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
      commit('DEL_ALL_CACHED_TAG', ['Home'])
    },
    // 分发删除缓存标签: 主要是在刷新标签的时候使用
    del_cached_tag ({ commit }, tag) {
      commit('DEL_CACHED_TAG', tag)
    }
  }
}
