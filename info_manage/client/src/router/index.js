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
    path: '/project',
    component: () => import('@/views/Layout'),
    children: [
      {
        path: '',
        name: 'project',
        component: () => import('@/views/project/List')
      }
    ]
  }
]

const router = new VueRouter({
  routes
})

export default router
