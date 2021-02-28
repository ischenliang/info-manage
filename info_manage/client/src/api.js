/* eslint-disable no-unused-vars */
import axios from 'axios'
import Cookies from 'js-cookie'
const http = axios.create({
  baseURL: 'http://localhost:3000/api/'
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
  // 删除角色 请求类型：delete 请求地址：/role/deleteById/:id
  DeleteRole: { method: 'delete', url: '/role/deleteById' },
  // 新增角色 请求类型：post 请求地址：/role/add
  AddRole: { method: 'post', url: '/role/add' },
  // 角色详情 请求类型：get 请求地址：/role/detail/:id
  GetRole: { method: 'get', url: '/role/detail' },
  // 角色菜单 请求类型：post 请求地址：/role/roleMenu/:id
  UpdateRoleMenu: { method: 'post', url: '/role/roleMenu' },
  // 角色接口 请求类型：post 请求地址：/role/roleApi/:id
  UpdateRoleApi: { method: 'post', url: '/role/roleApi' },

  /**
   * 菜单管理
  */
  // 菜单列表 请求类型：get 请求地址：/menu/list
  GetMenus: { method: 'get', url: '/menu/list' },
  // 更新菜单 请求类型：put 请求地址：/menu/update
  UpdateMenu: { method: 'put', url: '/menu/update' },
  // 更新菜单 请求类型：delete 请求地址：/menu/deleteById/:id
  DeleteMenu: { method: 'delete', url: '/menu/deleteById' },
  // 获取菜单 请求类型：get 请求地址：/menu/detail/:id
  GetMenu: { method: 'get', url: '/menu/detail' },
  // 新增菜单 请求类型：post 请求地址：/menu/add
  AddMenu: { method: 'post', url: '/menu/add' },

  /**
   * 用户管理
  */
  // 用户列表 请求类型：get 请求地址：/user/list
  GetUsers: { method: 'get', url: '/user/list' },
  // 用户详情 请求类型：get 请求地址：/user/detail
  GetUser: { method: 'get', url: '/user/detail' },
  // 新增用户 请求类型：post 请求地址：/user/add
  AddUser: { method: 'post', url: '/user/add' },
  // 更新用户 请求类型：put 请求地址：/user/update
  UpdateUser: { method: 'put', url: '/user/update' },
  // 删除用户 请求类型：delete 请求地址：/user/deleteById/:id
  DeleteUser: { method: 'delete', url: '/user/deleteById' },
  // 用户菜单 请求类型：get 请求地址：/user/userMenu/:id
  GetUserMenu: { method: 'get', url: '/user/userMenu' },
  // 用户权限 请求类型：get 请求地址：/user/userApi/:id
  GetUserApi: { method: 'get', url: '/user/userApi' },

  /**
   * 接口类别管理
  */
  // 接口类别列表 请求类型：get 请求地址：/apitype/list
  GetApiTypes: { method: 'get', url: '/apitype/list' },
  // 更新接口类别 请求类型：put 请求地址：/apitype/update
  UpdateApiType: { method: 'put', url: '/apitype/update' },
  // 新增接口类别 请求类型：post 请求地址：/apitype/add
  AddApiType: { method: 'post', url: '/apitype/add' },
  // 接口类别详情 请求类型：get 请求地址：/apitype/detail
  GetApiType: { method: 'get', url: '/apitype/detail' },
  // 删除接口类别 请求类型：delete 请求地址：/apitype/deleteById/:id
  DeleteApiType: { method: 'delete', url: '/apitype/deleteById' },

  /**
   * 接口管理
  */
  // 接口列表 请求类型：get 请求地址：/api/list
  GetApis: { method: 'get', url: '/api/list' },
  // 更新接口 请求类型：put 请求地址：/api/update
  UpdateApi: { method: 'put', url: '/api/update' },
  // 新增接口 请求类型：post 请求地址：/api/add
  AddApi: { method: 'post', url: '/api/add' },
  // 接口详情 请求类型：get 请求地址：/api/detail
  GetApi: { method: 'get', url: '/api/detail' },
  // 删除接口 请求类型：delete 请求地址：/api/deleteById/:id
  DeleteApi: { method: 'delete', url: '/api/deleteById' },

  /**
   * 收藏类别管理
  */
  // 收藏类别列表 请求类型：get 请求地址：/ctype/list
  GetCollectTypes: { method: 'get', url: '/ctype/list' },
  // 更新收藏类别 请求类型：put 请求地址：/ctype/update
  UpdateCollectType: { method: 'put', url: '/ctype/update' },
  // 删除收藏类别 请求类型：delete 请求地址：/ctype/deleteById/:id
  DeleteCollectType: { method: 'delete', url: '/ctype/deleteById' },
  // 收藏类别详情 请求类型：get 请求地址：/ctype/detail/:id
  GetCollectType: { method: 'get', url: '/ctype/detail' },
  // 新增收藏类别 请求类型：post 请求地址：/ctype/add
  AddCollectType: { method: 'post', url: '/ctype/add' },

  /**
   * 收藏管理
  */
  // 收藏列表 请求类型：get 请求地址：/collect/list
  GetCollects: { method: 'get', url: '/collect/list' },
  // 更新收藏 请求类型：put 请求地址：/collect/update
  UpdateCollect: { method: 'put', url: '/collect/update' },
  // 删除收藏 请求类型：delete 请求地址：/collect/deleteById/:id
  DeleteCollect: { method: 'delete', url: '/collect/deleteById' },
  // 收藏详情 请求类型：get 请求地址：/collect/detail/:id
  GetCollect: { method: 'get', url: '/collect/detail' },
  // 新增收藏 请求类型：post 请求地址：/collect/add
  AddCollect: { method: 'post', url: '/collect/add' },

  /**
   * 资源管理
  */
  // 资源列表 请求类型：get 请求地址：/resource/list
  GetResources: { method: 'get', url: '/resource/list' },
  // 新增资源 请求类型：post 请求地址：/resource/add
  AddResource: { method: 'post', url: '/resource/add' },
  // 更新资源 请求类型：put 请求地址：/resource/update
  UpdateResource: { method: 'put', url: '/resource/update' },
  // 更新资源 请求类型：get 请求地址：/resource/info
  GetResource: { method: 'get', url: '/resource/info' },
  // 删除资源 请求类型：delete 请求地址：/resource/delete
  DeleteResource: { method: 'delete', url: '/resource/delete' },
  // 上传资源 请求类型：post 请求地址：/resource/upload
  UploadResource: { method: 'post', url: '/resource/upload' },

  /**
   * 公共接口
  */
  // 登录 请求类型：post 请求地址：/api/login
  Login: { method: 'post', url: '/login' }
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

    // if (method === 'get' || method === 'delete') {
    //   requestConfig.params = config.params
    // }
    // if (method === 'post' || method === 'put') {
    //   requestConfig.data = config.data
    // }
    requestConfig.params = config.params
    requestConfig.data = config.data

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

    if (config.requireAuth) {
      requestConfig.headers.Authorization = Cookies.get('token')
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
