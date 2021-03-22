/* eslint-disable no-unused-vars */
import axios from 'axios'
import Cookies from 'js-cookie'
const baseURL = 'http://localhost:3000/api/'
const http = axios.create({
  baseURL
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
  // 移动资源 请求类型：post 请求地址：/resource/move
  MoveResource: { method: 'post', url: '/resource/move' },
  // 复制资源 请求类型：post 请求地址：/resource/copy
  CopyResource: { method: 'post', url: '/resource/copy' },
  // 下载资源 请求类型：get 请求地址：/resource/download
  DownloadResource: { method: 'get', url: '/resource/download' },

  /**
   * 账目类别管理
  */
  // 账目类别列表 请求类型：get 请求地址：/accountTag/list
  GetAccountTags: { method: 'get', url: '/accountTag/list' },
  // 新增账目类别 请求类型：post 请求地址：/accountTag/add
  AddAccountTag: { method: 'post', url: '/accountTag/add' },
  // 账目类别详情 请求类型：get 请求地址：/accountTag/detail
  GetAccountTag: { method: 'get', url: '/accountTag/detail' },
  // 更新账目类别 请求类型：put 请求地址：/accountTag/update
  UpdateccountTag: { method: 'put', url: '/accountTag/update' },
  // 删除账目类别 请求类型：delete 请求地址：/accountTag/deleteById
  DeleteAccountTag: { method: 'delete', url: '/accountTag/deleteById' },
  // 移动账目类别顺序 请求类型：get 请求地址：/accountTag/moveOrder
  MoveAccountTag: { method: 'get', url: '/accountTag/moveOrder' },
  // 重置账目类别顺序 请求类型：put 请求地址：/accountTag/resetOrder
  ResetAccountTag: { method: 'put', url: '/accountTag/resetOrder' },

  /**
   * 账目管理
  */
  // 账目列表 请求类型：get 请求地址：/account/list
  GetAccounts: { method: 'get', url: '/account/list' },
  // 新增账目 请求类型：post 请求地址：/account/add
  AddAccount: { method: 'post', url: '/account/add' },
  // 账目详情 请求类型：get 请求地址：/account/detail
  GetAccount: { method: 'get', url: '/account/detail' },
  // 更新账目 请求类型：put 请求地址：/account/update
  UpdateAccount: { method: 'put', url: '/account/update' },
  // 删除账目 请求类型：delete 请求地址：/account/deleteById
  DeleteAccount: { method: 'delete', url: '/account/deleteById' },

  /**
   * 密码管理
  */
  // 密码列表 请求类型：get 请求地址：/password/list
  GetPasswords: { method: 'get', url: '/password/list' },
  // 新增密码 请求类型：post 请求地址：/password/add
  AddPassword: { method: 'post', url: '/password/add' },
  // 更新密码 请求类型：put 请求地址：/password/update
  UpdatePassword: { method: 'put', url: '/password/update' },
  // 密码详情 请求类型：get 请求地址：/password/detail
  GetPassword: { method: 'get', url: '/password/detail' },
  // 删除密码 请求类型：delete 请求地址：/password/deleteById
  DeletePassword: { method: 'delete', url: '/password/deleteById' },

  /**
   * 备忘录管理
  */
  // 备忘录列表 请求类型：get 请求地址：/memory/list
  GetMemories: { method: 'get', url: '/memory/list' },
  // 新增备忘录 请求类型：post 请求地址：/memory/add
  AddMemory: { method: 'post', url: '/memory/add' },
  // 删除备忘录 请求类型：delete 请求地址：/memory/deleteById
  DeleteMemory: { method: 'delete', url: '/memory/deleteById' },
  // 备忘录详情 请求类型：get 请求地址：/memory/detail
  GetMemory: { method: 'get', url: '/memory/detail' },
  // 更新备忘录 请求类型：put 请求地址：/memory/update
  UpdateMemory: { method: 'put', url: '/memory/update' },

  /**
   * 定时任务管理
  */
  // 任务列表 请求类型：get 请求地址：/task/list
  GetTasks: { method: 'get', url: '/task/list' },
  // 更新任务 请求类型：put 请求地址：/task/update
  UpdateTask: { method: 'put', url: '/task/update' },
  // 删除任务 请求类型：delete 请求地址：/task/deleteById
  DeleteTask: { method: 'delete', url: '/task/deleteById' },
  // 新增任务 请求类型：post 请求地址：/task/add
  AddTask: { method: 'post', url: '/task/add' },
  // 任务详情 请求类型：get 请求地址：/task/detail
  GetTask: { method: 'get', url: '/task/detail' },
  // 任务执行日志 请求类型：get 请求地址：/task/log
  GetTaskLog: { method: 'get', url: '/task/log' },

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

    if (requestConfig.headers && requestConfig.headers['Content-Type'] === 'application/octet-stream') {
      requestConfig.baseURL = baseURL
      resolve(requestConfig)
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
