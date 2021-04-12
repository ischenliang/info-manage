import Vue from 'vue'
import VueRouter from 'vue-router'
import Cookies from 'js-cookie'
import store from '@/store'
import { Message } from 'element-ui'
import routeComponentMap from '@/utils/routeComponentMap'

Vue.use(VueRouter)

// 重写replace方法
// const originalReplace = VueRouter.prototype.replace
// VueRouter.prototype.replace = function replace (location, onResolve, onReject) {
//   if (onResolve || onReject) return originalReplace.call(this, location, onResolve, onReject)
//   return originalReplace.call(this, location).catch(err => err)
// }
// // 重写push方法
// const routerPush = VueRouter.prototype.push
// VueRouter.prototype.push = function push (location) {
//   return routerPush.call(this, location).catch(error => error)
// }

export const routes = [
  {
    path: '/login',
    component: () => import('@/views/Login'),
    meta: {
      title: 'login',
      hidden: 0,
      is_frame: 0,
      icon: ''
    }
  },
  {
    path: '/401',
    component: () => import('@/views/error-page/401'),
    meta: {
      title: '401',
      hidden: 0
    }
  },
  {
    path: '/404',
    component: () => import('@/views/error-page/404'),
    meta: {
      title: '404',
      hidden: 0,
      is_frame: 0,
      icon: ''
    }
  },
  {
    path: '/test',
    component: () => import('@/views/test/Test'),
    meta: {
      title: 'Test',
      hidden: 0,
      is_frame: 0,
      icon: ''
    }
  },
  {
    path: '/redirect',
    component: () => import('@/views/Layout'),
    meta: {
      title: '重定向',
      hidden: 0,
      is_frame: 0,
      icon: ''
    },
    children: [
      {
        path: '/redirect/:path(.*)',
        name: 'Redirect',
        component: () => import('@/views/redirect/Index'),
        meta: {
          title: '重定向',
          hidden: 0,
          is_frame: 0,
          icon: ''
        }
      }
    ]
  }
]

const createRouter = () => new VueRouter({
  routes
})
const router = createRouter()

// 根据权限获取有效路由列表
export function parseRoutes (routes) {
  const res = routes.map(element => {
    if (element.children && element.children.length > 0) {
      element.children = parseRoutes(element.children)
    }
    element.component = routeComponentMap[element.component]
    return element
  })
  return res
}

/**
 * 路由前置守卫
 * 1. 从cookie中获取token和uid
 * 2.判断cookie和uid是否存在：判断登录状态
 *    存在：执行第三步
 *    不存在：执行第四步
 * 3.cookie和uid存在
 * 4.cookie和uid都不存在
 *  判断当前路由去往哪里：
 *    登录页/login：**to.path === '/login'** 直接放行
 *    其他页：**to.path !== '/login'** 拦截，让其跳转到登录界面，并且将to.path保存到redirect中
*/
router.beforeEach(async (to, from, next) => {
  // 使用localStorage 还是使用 Cookies
  const token = Cookies.get('token')
  const uid = Cookies.get('uid')
  const perms = store.getters.perms
  // 判断登录状态
  if (token && uid) {
    // 解决三级菜单不能缓存的问题
    if (to.matched && to.matched.length > 2) {
      for (let i = 0; i < to.matched.length; i++) {
        const element = to.matched[i]
        if (element.components.default.name === 'Index') {
          to.matched.splice(i, 1)
        }
      }
    }
    try {
      // 判断当前数据是否已有，有就不必再获取，避免每次都需要去请求获取
      if (perms && perms.length > 0) {
        next()
      } else {
        // 获取用户菜单信息以及用户接口信息
        store.dispatch('user/SET_UID', uid)
        store.dispatch('user/SET_TOKEN', token)
        // 一定要加await，否则后续再使用指令过程中拿不到数据
        await store.dispatch('user/SET_PERMS')
        const dynamicRoutes = await store.dispatch('user/SET_MENUS', routes) // 注意：要将静态路由拼接到menus中
        const routelist = parseRoutes(dynamicRoutes)
        routelist.push({ path: '*', redirect: '/404' })
        router.addRoutes([...routelist])
        next({ ...to, replace: true })
      }
    } catch (error) {
      Message({
        title: '错误',
        message: error,
        type: 'error',
        duration: 1000
      })
    }
  } else {
    const notauth = ['/login', '/404', '/401']
    if (notauth.includes(to.path)) {
      next()
    } else {
      to.path === '/login' ? next({ path: '/login' }) : next({
        path: '/login',
        query: {
          redirect: to.fullPath
        }
      })
    }
  }
})

export default router

export function resetRouter () {
  const newRouter = createRouter()
  router.matcher = newRouter.matcher // 替换旧的router 的watcher
}
