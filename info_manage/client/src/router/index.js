import Vue from 'vue'
import VueRouter from 'vue-router'
import Cookies from 'js-cookie'
import store from '@/store'
import { Message } from 'element-ui'
import routeComponentMap from '@/utils/routeComponentMap'

Vue.use(VueRouter)

export const routes = [
  {
    path: '/',
    redirect: '/home',
    component: () => import('@/views/Layout'),
    children: [
      {
        path: 'home',
        name: 'Home',
        component: () => import('@/views/home/Home')
      }
    ]
  },
  {
    path: '/login',
    component: () => import('@/views/Login'),
    meta: {
      title: 'login',
      hidden: true
    }
  },
  {
    path: '/401',
    component: () => import('@/views/error-page/401'),
    meta: {
      title: '401',
      hidden: true
    }
  },
  {
    path: '/404',
    component: () => import('@/views/error-page/404'),
    meta: {
      title: '404',
      hidden: true
    }
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
    try {
      // 获取用户菜单信息以及用户接口信息
      store.dispatch('user/SET_UID', uid)
      store.dispatch('user/SET_TOKEN', token)
      // 判断当前数据是否已有，有就不必再获取，避免每次都需要去请求获取
      if (perms && perms.length > 0) {
        next()
      } else {
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
