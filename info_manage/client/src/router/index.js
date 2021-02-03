import Vue from 'vue'
import VueRouter from 'vue-router'

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
  }
]

const router = new VueRouter({
  routes
})

export default router
