import http from '@/api'

export default {
  namespaced: true,
  state: {
    uid: '', // 用户id
    token: '', // 用户token
    menus: [], // 用户能够访问的菜单
    perms: [] // 用户能够访问的接口
  },
  mutations: {
    // 设置用户id
    SET_UID (state, arg) {
      state.uid = arg
    },
    // 设置token
    SET_TOKEN (state, arg) {
      state.token = arg
    },
    // 设置menu
    SET_MENUS (state, arg) {
      state.menus = arg
    },
    // 设置perms
    SET_PERMS (state, arg) {
      state.perms = arg
    }
  },
  actions: {
    SET_UID ({ commit }, arg) {
      commit('SET_UID', arg)
    },
    SET_TOKEN ({ commit }, arg) {
      commit('SET_TOKEN', arg)
    },
    async SET_USER ({ state, commit }, arg) {
      // eslint-disable-next-line no-unused-vars
      const [menus, apis] = await Promise.all([
        http({
          name: 'GetUserMenu',
          requireAuth: true,
          paths: [state.uid],
          params: {
            status: true
          }
        }),
        http({
          name: 'GetUserApi',
          requireAuth: true,
          paths: [state.uid]
        })
      ])
      const routes = []
      menus.data.sort((a, b) => a.order - b.order).forEach(item1 => {
        // 第一层
        const tmp1 = {
          path: item1.path,
          component: item1.component,
          children: [],
          meta: {
            title: item1.name,
            icon: item1.icon,
            hidden: item1.visible,
            is_frame: item1.is_frame
          }
        }
        if (item1.children) {
          item1.children.forEach(item2 => {
            // 第二层
            const tmp2 = {
              path: item2.path,
              component: item2.component,
              children: [],
              meta: {
                title: item2.name,
                icon: item2.icon,
                hidden: item2.visible,
                is_frame: item2.is_frame
              }
            }
            if (item2.children) {
              item2.children.forEach(item3 => {
                // 第三层
                const tmp3 = {
                  path: item3.path,
                  component: item3.component,
                  children: [],
                  meta: {
                    title: item3.name,
                    icon: item3.icon,
                    hidden: item3.visible,
                    is_frame: item3.is_frame
                  }
                }
                if (item3.children) {
                  item3.children.forEach(item4 => {
                    const tmp4 = {
                      path: item4.path,
                      component: item4.component,
                      children: [],
                      meta: {
                        title: item4.name,
                        icon: item4.icon,
                        hidden: item4.visible,
                        is_frame: item4.is_frame
                      }
                    }
                    item3.children.push(tmp4)
                  })
                }
                tmp2.children.push(tmp3)
              })
            }
            tmp1.children.push(tmp2)
          })
        }
        routes.push(tmp1)
      })
      // console.log(routes)
      // console.log(apis)
    },
    CLEAR_INFO ({ commit }) {
      commit('SET_UID', '')
      commit('SET_TOKEN', '')
      commit('SET_MENUS', [])
      commit('SET_PERMS', [])
    }
  }
}
