import axios from 'axios'
import Cookies from 'js-cookie'
localStorage.setItem('baidu-token', 'WdhbCVRbA3h4Rumg')
// 用于后续图表预览时使用
localStorage.setItem('baseUrl', 'http://localhost:3000/')
// 这样做的方法是为了如果有多个后台
const baseURL = ['http://localhost:3000/api', 'http://data.zz.baidu.com']
const http = axios.create()

// 定义所有的请求
const list = {
  /**
   * 角色管理
  */
  // 角色列表 请求类型：get 请求地址：/role/list
  GetRoles: { method: 'get', url: baseURL[0] + '/role/list' },
  // 更新角色 请求类型：put 请求地址：/role/update
  UpdateRole: { method: 'put', url: baseURL[0] + '/role/update' },
  // 删除角色 请求类型：delete 请求地址：/role/deleteById/:id
  DeleteRole: { method: 'delete', url: baseURL[0] + '/role/deleteById' },
  // 新增角色 请求类型：post 请求地址：/role/add
  AddRole: { method: 'post', url: baseURL[0] + '/role/add' },
  // 角色详情 请求类型：get 请求地址：/role/detail/:id
  GetRole: { method: 'get', url: baseURL[0] + '/role/detail' },
  // 角色菜单 请求类型：post 请求地址：/role/roleMenu/:id
  UpdateRoleMenu: { method: 'post', url: baseURL[0] + '/role/roleMenu' },
  // 角色接口 请求类型：post 请求地址：/role/roleApi/:id
  UpdateRoleApi: { method: 'post', url: baseURL[0] + '/role/roleApi' },

  /**
   * 菜单管理
  */
  // 菜单列表 请求类型：get 请求地址：/menu/list
  GetMenus: { method: 'get', url: baseURL[0] + '/menu/list' },
  // 更新菜单 请求类型：put 请求地址：/menu/update
  UpdateMenu: { method: 'put', url: baseURL[0] + '/menu/update' },
  // 更新菜单 请求类型：delete 请求地址：/menu/deleteById/:id
  DeleteMenu: { method: 'delete', url: baseURL[0] + '/menu/deleteById' },
  // 获取菜单 请求类型：get 请求地址：/menu/detail/:id
  GetMenu: { method: 'get', url: baseURL[0] + '/menu/detail' },
  // 新增菜单 请求类型：post 请求地址：/menu/add
  AddMenu: { method: 'post', url: baseURL[0] + '/menu/add' },

  /**
   * 用户管理
  */
  // 用户列表 请求类型：get 请求地址：/user/list
  GetUsers: { method: 'get', url: baseURL[0] + '/user/list' },
  // 用户详情 请求类型：get 请求地址：/user/detail
  GetUser: { method: 'get', url: baseURL[0] + '/user/detail' },
  // 新增用户 请求类型：post 请求地址：/user/add
  AddUser: { method: 'post', url: baseURL[0] + '/user/add' },
  // 更新用户 请求类型：put 请求地址：/user/update
  UpdateUser: { method: 'put', url: baseURL[0] + '/user/update' },
  // 删除用户 请求类型：delete 请求地址：/user/deleteById/:id
  DeleteUser: { method: 'delete', url: baseURL[0] + '/user/deleteById' },
  // 用户菜单 请求类型：get 请求地址：/user/userMenu/:id
  GetUserMenu: { method: 'get', url: baseURL[0] + '/user/userMenu' },
  // 用户权限 请求类型：get 请求地址：/user/userApi/:id
  GetUserApi: { method: 'get', url: baseURL[0] + '/user/userApi' },

  /**
   * 接口类别管理
  */
  // 接口类别列表 请求类型：get 请求地址：/apitype/list
  GetApiTypes: { method: 'get', url: baseURL[0] + '/apitype/list' },
  // 更新接口类别 请求类型：put 请求地址：/apitype/update
  UpdateApiType: { method: 'put', url: baseURL[0] + '/apitype/update' },
  // 新增接口类别 请求类型：post 请求地址：/apitype/add
  AddApiType: { method: 'post', url: baseURL[0] + '/apitype/add' },
  // 接口类别详情 请求类型：get 请求地址：/apitype/detail
  GetApiType: { method: 'get', url: baseURL[0] + '/apitype/detail' },
  // 删除接口类别 请求类型：delete 请求地址：/apitype/deleteById/:id
  DeleteApiType: { method: 'delete', url: baseURL[0] + '/apitype/deleteById' },

  /**
   * 接口管理
  */
  // 接口列表 请求类型：get 请求地址：/api/list
  GetApis: { method: 'get', url: baseURL[0] + '/api/list' },
  // 更新接口 请求类型：put 请求地址：/api/update
  UpdateApi: { method: 'put', url: baseURL[0] + '/api/update' },
  // 新增接口 请求类型：post 请求地址：/api/add
  AddApi: { method: 'post', url: baseURL[0] + '/api/add' },
  // 接口详情 请求类型：get 请求地址：/api/detail
  GetApi: { method: 'get', url: baseURL[0] + '/api/detail' },
  // 删除接口 请求类型：delete 请求地址：/api/deleteById/:id
  DeleteApi: { method: 'delete', url: baseURL[0] + '/api/deleteById' },

  /**
   * 收藏类别管理
  */
  // 收藏类别列表 请求类型：get 请求地址：/ctype/list
  GetCollectTypes: { method: 'get', url: baseURL[0] + '/ctype/list' },
  // 更新收藏类别 请求类型：put 请求地址：/ctype/update
  UpdateCollectType: { method: 'put', url: baseURL[0] + '/ctype/update' },
  // 删除收藏类别 请求类型：delete 请求地址：/ctype/deleteById/:id
  DeleteCollectType: { method: 'delete', url: baseURL[0] + '/ctype/deleteById' },
  // 收藏类别详情 请求类型：get 请求地址：/ctype/detail/:id
  GetCollectType: { method: 'get', url: baseURL[0] + '/ctype/detail' },
  // 新增收藏类别 请求类型：post 请求地址：/ctype/add
  AddCollectType: { method: 'post', url: baseURL[0] + '/ctype/add' },

  /**
   * 收藏管理
  */
  // 收藏列表 请求类型：get 请求地址：/collect/list
  GetCollects: { method: 'get', url: baseURL[0] + '/collect/list' },
  // 更新收藏 请求类型：put 请求地址：/collect/update
  UpdateCollect: { method: 'put', url: baseURL[0] + '/collect/update' },
  // 删除收藏 请求类型：delete 请求地址：/collect/deleteById/:id
  DeleteCollect: { method: 'delete', url: baseURL[0] + '/collect/deleteById' },
  // 收藏详情 请求类型：get 请求地址：/collect/detail/:id
  GetCollect: { method: 'get', url: baseURL[0] + '/collect/detail' },
  // 新增收藏 请求类型：post 请求地址：/collect/add
  AddCollect: { method: 'post', url: baseURL[0] + '/collect/add' },

  /**
   * 资源管理
  */
  // 资源列表 请求类型：get 请求地址：/resource/list
  GetResources: { method: 'get', url: baseURL[0] + '/resource/list' },
  // 新增资源 请求类型：post 请求地址：/resource/add
  AddResource: { method: 'post', url: baseURL[0] + '/resource/add' },
  // 更新资源 请求类型：put 请求地址：/resource/update
  UpdateResource: { method: 'put', url: baseURL[0] + '/resource/update' },
  // 更新资源 请求类型：get 请求地址：/resource/info
  GetResource: { method: 'get', url: baseURL[0] + '/resource/info' },
  // 删除资源 请求类型：delete 请求地址：/resource/delete
  DeleteResource: { method: 'delete', url: baseURL[0] + '/resource/delete' },
  // 上传资源 请求类型：post 请求地址：/resource/upload
  UploadResource: { method: 'post', url: baseURL[0] + '/resource/upload' },
  // 移动资源 请求类型：post 请求地址：/resource/move
  MoveResource: { method: 'post', url: baseURL[0] + '/resource/move' },
  // 复制资源 请求类型：post 请求地址：/resource/copy
  CopyResource: { method: 'post', url: baseURL[0] + '/resource/copy' },
  // 下载资源 请求类型：get 请求地址：/resource/download
  DownloadResource: { method: 'get', url: baseURL[0] + '/resource/download' },
  // 保存网络图片资源 请求类型：post 请求地址：/resource/saveImg
  SaveResource: { method: 'post', url: baseURL[0] + '/resource/saveImg' },

  /**
   * 账目类别管理
  */
  // 账目类别列表 请求类型：get 请求地址：/accountTag/list
  GetAccountTags: { method: 'get', url: baseURL[0] + '/accountTag/list' },
  // 新增账目类别 请求类型：post 请求地址：/accountTag/add
  AddAccountTag: { method: 'post', url: baseURL[0] + '/accountTag/add' },
  // 账目类别详情 请求类型：get 请求地址：/accountTag/detail
  GetAccountTag: { method: 'get', url: baseURL[0] + '/accountTag/detail' },
  // 更新账目类别 请求类型：put 请求地址：/accountTag/update
  UpdateccountTag: { method: 'put', url: baseURL[0] + '/accountTag/update' },
  // 删除账目类别 请求类型：delete 请求地址：/accountTag/deleteById
  DeleteAccountTag: { method: 'delete', url: baseURL[0] + '/accountTag/deleteById' },
  // 移动账目类别顺序 请求类型：get 请求地址：/accountTag/moveOrder
  MoveAccountTag: { method: 'get', url: baseURL[0] + '/accountTag/moveOrder' },
  // 重置账目类别顺序 请求类型：put 请求地址：/accountTag/resetOrder
  ResetAccountTag: { method: 'put', url: baseURL[0] + '/accountTag/resetOrder' },

  /**
   * 账目管理
  */
  // 账目列表 请求类型：get 请求地址：/account/list
  GetAccounts: { method: 'get', url: baseURL[0] + '/account/list' },
  // 新增账目 请求类型：post 请求地址：/account/add
  AddAccount: { method: 'post', url: baseURL[0] + '/account/add' },
  // 账目详情 请求类型：get 请求地址：/account/detail
  GetAccount: { method: 'get', url: baseURL[0] + '/account/detail' },
  // 更新账目 请求类型：put 请求地址：/account/update
  UpdateAccount: { method: 'put', url: baseURL[0] + '/account/update' },
  // 删除账目 请求类型：delete 请求地址：/account/deleteById
  DeleteAccount: { method: 'delete', url: baseURL[0] + '/account/deleteById' },

  /**
   * 密码管理
  */
  // 密码列表 请求类型：get 请求地址：/password/list
  GetPasswords: { method: 'get', url: baseURL[0] + '/password/list' },
  // 新增密码 请求类型：post 请求地址：/password/add
  AddPassword: { method: 'post', url: baseURL[0] + '/password/add' },
  // 更新密码 请求类型：put 请求地址：/password/update
  UpdatePassword: { method: 'put', url: baseURL[0] + '/password/update' },
  // 密码详情 请求类型：get 请求地址：/password/detail
  GetPassword: { method: 'get', url: baseURL[0] + '/password/detail' },
  // 删除密码 请求类型：delete 请求地址：/password/deleteById
  DeletePassword: { method: 'delete', url: baseURL[0] + '/password/deleteById' },

  /**
   * 备忘录管理
  */
  // 备忘录列表 请求类型：get 请求地址：/memory/list
  GetMemories: { method: 'get', url: baseURL[0] + '/memory/list' },
  // 新增备忘录 请求类型：post 请求地址：/memory/add
  AddMemory: { method: 'post', url: baseURL[0] + '/memory/add' },
  // 删除备忘录 请求类型：delete 请求地址：/memory/deleteById
  DeleteMemory: { method: 'delete', url: baseURL[0] + '/memory/deleteById' },
  // 备忘录详情 请求类型：get 请求地址：/memory/detail
  GetMemory: { method: 'get', url: baseURL[0] + '/memory/detail' },
  // 更新备忘录 请求类型：put 请求地址：/memory/update
  UpdateMemory: { method: 'put', url: baseURL[0] + '/memory/update' },

  /**
   * 定时任务管理
  */
  // 任务列表 请求类型：get 请求地址：/task/list
  GetTasks: { method: 'get', url: baseURL[0] + '/task/list' },
  // 更新任务 请求类型：put 请求地址：/task/update
  UpdateTask: { method: 'put', url: baseURL[0] + '/task/update' },
  // 删除任务 请求类型：delete 请求地址：/task/deleteById
  DeleteTask: { method: 'delete', url: baseURL[0] + '/task/deleteById' },
  // 新增任务 请求类型：post 请求地址：/task/add
  AddTask: { method: 'post', url: baseURL[0] + '/task/add' },
  // 任务详情 请求类型：get 请求地址：/task/detail
  GetTask: { method: 'get', url: baseURL[0] + '/task/detail' },
  // 任务执行日志 请求类型：get 请求地址：/task/log
  GetTaskLog: { method: 'get', url: baseURL[0] + '/task/log' },

  /**
   * 仪表盘管理
  */
  // 新增仪表盘 请求类型：post 请求地址：/dash/add
  AddDash: { method: 'post', url: baseURL[0] + '/dash/add' },
  // 更新仪表盘 请求类型：put 请求地址：/dash/update
  UpdateDash: { method: 'put', url: baseURL[0] + '/dash/update' },
  // 仪表盘详情 请求类型：get 请求地址：/dash/detail
  GetDash: { method: 'get', url: baseURL[0] + '/dash/detail' },
  // 仪表盘列表 请求类型：get 请求地址：/dash/list
  GetDashs: { method: 'get', url: baseURL[0] + '/dash/list' },
  // 删除仪表盘 请求类型：delete 请求地址：/dash/deleteById
  DeleteDash: { method: 'delete', url: baseURL[0] + '/dash/deleteById' },

  /**
   * 图表管理
  */
  // 图表列表 请求类型：get 请求地址：/chart/list
  GetCharts: { method: 'get', url: baseURL[0] + '/chart/list' },
  // 新增图表 请求类型：post 请求地址：/chart/add
  AddChart: { method: 'post', url: baseURL[0] + '/chart/add' },
  // 删除图表 请求类型：delete 请求地址：/chart/deleteById
  DeleteChart: { method: 'delete', url: baseURL[0] + '/chart/deleteById' },
  // 图表详情 请求类型：get 请求地址：/chart/detail
  GetChart: { method: 'get', url: baseURL[0] + '/chart/detail' },
  // 更新图表 请求类型：put 请求地址：/chart/update
  UpdateChart: { method: 'put', url: baseURL[0] + '/chart/update' },

  /**
   * 项目管理
  */
  // 项目列表 请求类型：get 请求地址：/project/list
  GetProjects: { method: 'get', url: baseURL[0] + '/project/list' },
  // 新增项目 请求类型：post 请求地址：/project/add
  AddProject: { method: 'post', url: baseURL[0] + '/project/add' },
  // 项目详情 请求类型：get 请求地址：/project/detail
  GetProject: { method: 'get', url: baseURL[0] + '/project/detail' },
  // 更新项目 请求类型：put 请求地址：/project/update
  UpdateProject: { method: 'put', url: baseURL[0] + '/project/update' },
  // 删除项目 请求类型：delete 请求地址：/project/deleteById
  DeleteProject: { method: 'delete', url: baseURL[0] + '/project/deleteById' },
  /**
   * 项目图集
  */
  // 项目图集列表 请求类型：get 请求地址：/pimage/list
  GetProjectImages: { method: 'get', url: baseURL[0] + '/pimage/list' },
  // 新增项目图集 请求类型：post 请求地址：/pimage/upload
  AddProjectImage: { method: 'post', url: baseURL[0] + '/pimage/upload' },
  // 更新项目图集 请求类型：put 请求地址：/pimage/update
  UpdateProjectImage: { method: 'put', url: baseURL[0] + '/pimage/update' },
  // 删除项目图集 请求类型：delete 请求地址：/pimage/deleteById
  DeleteProjectImage: { method: 'delete', url: baseURL[0] + '/pimage/deleteById' },
  // 项目图集详情 请求类型：get 请求地址：/pimage/detail
  GetProjectImage: { method: 'get', url: baseURL[0] + '/pimage/detail' },
  /**
   * 项目文档
  */
  // 项目文档列表 请求类型：get 请求地址：/pdocument/list
  GetProjectDocuments: { method: 'get', url: baseURL[0] + '/pdocument/list' },
  // 新增项目文档 请求类型：post 请求地址：/pdocument/upload
  AddProjectDocument: { method: 'post', url: baseURL[0] + '/pdocument/add' },
  // 更新项目文档 请求类型：put 请求地址：/pdocument/update
  UpdateProjectDocument: { method: 'put', url: baseURL[0] + '/pdocument/update' },
  // 删除项目文档 请求类型：delete 请求地址：/pdocument/deleteById
  DeleteProjectDocument: { method: 'delete', url: baseURL[0] + '/pdocument/deleteById' },
  // 项目文档详情 请求类型：get 请求地址：/pdocument/detail
  GetProjectDocument: { method: 'get', url: baseURL[0] + '/pdocument/detail' },
  /**
   * 项目任务
  */
  // 项目任务列表 请求类型：get 请求地址：/pissue/list
  GetProjectIssues: { method: 'get', url: baseURL[0] + '/pissue/list' },
  // 更新项目任务 请求类型：put 请求地址：/pissue/update
  UpdateProjectIssue: { method: 'put', url: baseURL[0] + '/pissue/update' },
  // 项目任务详情 请求类型：get 请求地址：/pissue/detail
  GetProjectIssue: { method: 'get', url: baseURL[0] + '/pissue/detail' },
  // 新增项目任务 请求类型：post 请求地址：/pissue/add
  AddProjectIssue: { method: 'post', url: baseURL[0] + '/pissue/add' },
  // 删除项目任务 请求类型：delete 请求地址：/pissue/deleteById
  DeleteProjectIssue: { method: 'delete', url: baseURL[0] + '/pissue/deleteById' },

  /**
   * 公共接口
  */
  // 登录 请求类型：post 请求地址：/login
  Login: { method: 'post', url: baseURL[0] + '/login' },
  // 系统监控 请求类型：get 请求地址：/monitor/server
  MonitorSystem: { method: 'get', url: baseURL[0] + '/monitor/server' },
  // 服务监控 请求类型：get 请求地址：/monitor/process
  MonitorServer: { method: 'get', url: baseURL[0] + '/monitor/process' },
  // 服务下载 请求类型：get 请求地址：/test/download
  Download: { method: 'get', url: baseURL[0] + '/test/download' },
  // 获取ip和前缀 请求类型：get 请求地址：/
  GetIP: { method: 'get', url: baseURL[0] + '/' },

  /**
   * 百度收录接口
  */
  // 百度收录 请求类型：get 请求地址：/urls
  BaiduIncluded: { method: 'get', url: baseURL[1] + '/urls' }
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
        // if (res.data.code === 200) {
        //   resolve(res.dat)
        // } else {
        //   reject(res.data)
        // }
        resolve(res)
      }
    }).catch(error => {
      reject(error)
    })
  })
}
