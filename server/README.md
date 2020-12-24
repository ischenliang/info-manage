# 后台
使用技术 node + koa + mysql搭建
+ koa
  Koa是基于 Node.js 平台的下一代 web 开发框架。
+ koa-router
  Koa-router 是 koa 的一个路由中间件，它可以将请求的URL和方法（如：GET 、 POST 、 PUT 、 DELETE 等） 匹配到对应的响应程序或页面。
+ require-directory
  koa中使用require-directory实现路由自动注册，方便对多路由的自动注册。
+ koa-static
  静态资源中间件。
+ koa-jwt
  提供路由权限控制的功能。
+ koa2-cors
  koa配置跨域处理
+ koa-body
  能够接收formData数据
  + koa-bodyparser
    解析body的中间件，比方说你通过post来传递表单，json数据，或者上传文件，在koa中是不容易获取的，通过koa-bodyparser解析之后，在koa中this.body就能直接获取到数据。配置后就可以直接使用`ctx.request.body获取请求体`
  + koa-better-body
+ nodemon
  Nodemon 是一款非常实用的工具，用来监控你 node.js 源代码的任何变化和自动重启你的服务器。 Nodemon 是一款完美的开发工具，可以使用 npm 安装。
## 数据库设计


## 接口设计
### 菜单管理
1. 新增菜单
地址：/api/menu/add
类型：POST
请求头：`Authorization: token`
请求体数据：
```json
{
  "name": "系统管理", // 菜单名称
  "url": "/system", // 菜单地址
  "pid": "", // 上级菜单id
  "component": "Layout", // 菜单对应组件名称
  "enable": 0, // 是否启用菜单
  "visible": 1, // 菜单是否显示在菜单栏
  "active": "", // 菜单激活项：主要是为了解决 /edit/:id 这种菜单激活显示 /list
  "order": 1, // 菜单排序：值越大就越靠前
  "type": 1, // 菜单类别：1-目录 2-菜单
  "redirect": "", // 菜单重定向：为了解决 /menu -> /menu/list
  "updatetime": "", // 菜单更新时间
  "icon": { // 菜单图标
    "id": "3f5e982b-caaf-47d3-9797-856ca40f6408" // icon表的id
  }
}
```
返回结果：
```json
{
  "code": 200,
  "msg": "新增成功",
  "data": {
    "id": "210f8e41-529c-4b6b-8139-ab3f433d4753",
    "enable": false,
    "visible": true,
    "order": 1,
    "updatetime": "2020-12-24 13:57:42",
    "name": "系统管理",
    "url": "/system",
    "pid": "",
    "component": "Layout",
    "type": 1
  }
}
```
2. 修改菜单
地址：/api/menu/update
类型：PUT
请求头：`Authorization: token`
请求体数据：
```json
{
  "id": "210f8e41-529c-4b6b-8139-ab3f433d4753",
  "enable": false,
  "visible": true,
  "order": 1,
  "updatetime": "2020-12-24 13:57:42",
  "name": "系统管理",
  "url": "/system",
  "pid": "",
  "component": "Layout",
  "type": 2,
  "icon": {
    "id": "3f5e982b-caaf-47d3-9797-856ca40f6402"
  }
}
```
返回结果：
```json
{
  "code": 200,
  "msg": "更新成功",
  "data": [1]
}
```
3. 删除菜单
地址：/api/menu/delete/{id}
类型：DELETE
请求头：`Authorization: token`
返回结果：
```json
{
  "code": 200,
  "msg": "删除成功",
  "data": 1
}
```
4. 查询菜单详情
地址：/api/menu/detail/{id}
类型：GET
请求头：`Authorization: token`
返回结果：
```json
{
  "code": 200,
  "msg": "查询成功",
  "data": {
    "id": "3a61d37c-67c5-412b-868f-5f2240566cdc",
    "name": "系统管理",
    "url": "/system",
    "pid": "",
    "component": "Layout",
    "enable": false,
    "visible": true,
    "active": "",
    "order": 1,
    "type": 1,
    "redirect": "",
    "updatetime": "",
    "mi": [
      {
        "id": "3f5e982b-caaf-47d3-9797-856ca40f6408",
        "name": "system",
        "prefix": "xapi",
        "code": "xapi-sys",
        "updatetime": "2020-12-20 15:43:45"
      }
    ]
  }
}
```

