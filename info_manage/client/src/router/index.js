import Vue from 'vue'
import VueRouter from 'vue-router'
import Cookies from 'js-cookie'
import store from '@/store'

Vue.use(VueRouter)

const routes = [
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
  },
  {
    path: '/test',
    component: () => import('@/views/test/Test'),
    meta: {
      title: 'Test',
      hidden: true
    }
  },
  {
    path: '/system',
    component: () => import('@/views/Layout'),
    redirect: '/system/role',
    children: [
      {
        path: 'role',
        name: 'SystemRole',
        component: () => import('@/views/system/role/List')
      },
      {
        path: 'user',
        name: 'SystemUser',
        component: () => import('@/views/system/user/List')
      },
      {
        path: 'menu',
        name: 'SystemMenu',
        component: () => import('@/views/system/menu/List')
      },
      {
        path: 'api',
        name: 'SystemApi',
        component: () => import('@/views/system/api/List')
      },
      {
        path: 'permission/:id',
        name: 'SystemPermission',
        component: () => import('@/views/system/permission/List')
      },
      {
        path: 'edit/:id',
        name: 'SystemEdit',
        component: () => import('@/views/system/permission/Edit')
      }
    ]
  },
  {
    path: '/collect',
    component: () => import('@/views/Layout'),
    redirect: '/collect/list',
    children: [
      {
        path: 'list',
        name: 'CollectList',
        component: () => import('@/views/collect/List')
      }
    ]
  },
  {
    path: '/info',
    component: () => import('@/views/Layout'),
    redirect: '/info/resource',
    children: [
      {
        path: 'resource',
        name: 'Resource',
        redirect: 'resource/list',
        component: () => import('@/views/Index'),
        children: [
          {
            path: 'list',
            name: 'ResourceList',
            component: () => import('@/views/info/resource/List')
          },
          {
            path: 'upload',
            name: 'ResourceUpload',
            component: () => import('@/views/info/resource/Upload')
          }
        ]
      },
      {
        path: 'password',
        name: 'PasswordList',
        component: () => import('@/views/info/password/List')
      },
      {
        path: 'account',
        name: 'AccountList',
        component: () => import('@/views/info/account/List')
      },
      {
        path: 'memory',
        name: 'MemoryList',
        component: () => import('@/views/info/memory/List')
      }
    ]
  }
]

const router = new VueRouter({
  routes
})

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
  // 判断登录状态
  if (token && uid) {
    // 获取用户菜单信息以及用户接口信息
    store.dispatch('user/SET_UID', uid)
    store.dispatch('user/SET_TOKEN', token)
    store.dispatch('user/SET_USER')
    next()
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
