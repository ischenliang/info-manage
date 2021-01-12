// 静态文件处理
const static = require('koa-static')
// 跨域处理
const cors = require('koa2-cors')
 // 路由
const router = require('koa-router')
// 路由自动加载
const requireDirectory = require('require-directory')
// 解析请求体
const koaBody = require('koa-body')
// 权限控制
const jwt = require('koa-jwt')
// 参数验证
const parameter = require('koa-parameter')
const path = require('path')


// 加载中间件
function loadMiddleware (app) {
  app.use(static(path.join(__dirname, 'public')))
  app.use(cors({
    credentials: true,
    allowMethods: ['GET', 'POST', 'DELETE', 'PUT'],
    allowHeaders: ['Content-Type', 'Authorization', 'Accept']
  }))
  // 解析request body
  app.use(koaBody({
    enableTypes: ['json', 'form', 'text'],
    multipart: true // 是否支持 multipart-formdate 的表单
  }))
  // 路由权限控制中间件
  const notauth = ['/api/login']
  app.use(jwt({ secret: 'jwt_secret', passthrough: true }).unless({ path: notauth }))
  // 参数验证
  app.use(parameter(app))
}

// 自定加载路由：避免了多很多路由文件，而需要一个个去加载
function loadRoutes (app) {
  requireDirectory(module, '../routes', {
    visit: obj => {
      if (obj instanceof router) {
        app.use(obj.routes(), obj.allowedMethods())
      }
    }
  })
}

module.exports = {
  loadMiddleware,
  loadRoutes
}