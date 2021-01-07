// 静态文件处理
const static = require('koa-static')
// 跨域处理
const cors = require('koa2-cors')
 // 路由
const router = require('koa-router')
// 路由自动加载
const requireDirectory = require('require-directory')
const path = require('path')

// 加载中间件
function loadMiddleware (app) {
  app.use(static(path.join(__dirname, 'public')))
  app.use(cors({
    credentials: true,
    allowMethods: ['GET', 'POST', 'DELETE', 'PUT'],
    allowHeaders: ['Content-Type', 'Authorization', 'Accept']
  }))
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