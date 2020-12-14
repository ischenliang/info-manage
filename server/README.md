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
