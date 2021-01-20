/* eslint-disable no-unused-vars */
import axios from 'axios'
const http = axios.create({
  baseURL: 'http://127.0.0.1:3000/api/'
})

// 定义所有的请求
const list = {
  /**
   * 角色管理
  */
  // 角色列表 请求类型：get 请求地址：/role/list
  GetRoles: { method: 'get', url: '/role/list' },
  // 更新角色 请求类型：put 请求地址：/role/update
  UpdateRole: { method: 'put', url: '/role/update' },
  // 删除角色 请求类型：put 请求地址：/role/update
  DeleteRole: { method: 'delete', url: '/role/deleteById' },
  // 新增角色 请求类型：post 请求地址：/role/add
  AddRole: { method: 'post', url: '/role/add' },
  // 角色详情 请求类型：get 请求地址：/role/detail
  GetRole: { method: 'get', url: '/role/detail' },

  /**
   * 菜单管理
  */
  // 菜单列表 请求类型：get 请求地址：/menu/list
  GetMenus: { method: 'get', url: '/menu/list' },
  // 更新菜单 请求类型：put 请求地址：/menu/update
  UpdateMenu: { method: 'put', url: '/menu/update' },
  // 更新菜单 请求类型：put 请求地址：/menu/update
  DeleteMenu: { method: 'delete', url: '/menu/deleteById' },
  // 获取菜单 请求类型：get 请求地址：/menu/update
  GetMenu: { method: 'get', url: '/menu/detail' },
  // 新增菜单 请求类型：post 请求地址：/menu/add
  AddMenu: { method: 'post', url: '/menu/add' },

  /**
   * 用户管理
  */
  GetUsers: { method: 'get', url: '/user/list' }
}

export default (config) => {
  return new Promise((resolve, reject) => {
    if (!list[config.name]) {
      // eslint-disable-next-line prefer-promise-reject-errors
      reject('未定义接口：' + config.name)
    }

    const { method, url } = list[config.name]
    const requestConfig = {
      method,
      url,
      headers: config.headers ? config.headers : {}
    }

    if (method === 'get' || method === 'delete') {
      requestConfig.params = config.params
    }
    if (method === 'post' || method === 'put') {
      requestConfig.data = config.data
    }

    // 处理paths参数
    if (config.paths) {
      config.paths.map(item => {
        if (item) {
          requestConfig.url += '/' + item
        } else {
          // eslint-disable-next-line prefer-promise-reject-errors
          reject('paths：参数有误')
        }
      })
    }

    // 发送请求
    http(requestConfig).then(res => {
      if (res.data) {
        if (res.data.code === 200) {
          resolve(res.data)
        } else {
          reject(res.data)
        }
      }
    }).catch(error => {
      reject(error)
    })
  })
}
