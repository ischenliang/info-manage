const koa = require('koa')
const router = require('koa-router') // 路由
const requireDirectory = require('require-directory') // 路由自动加载
const path = require('path')
const static = require('koa-static') // 静态资源中间件
const jwt = require('koa-jwt') // 权限控制
const JWT = require('jsonwebtoken') // token生成器
const cors = require('koa2-cors')
const bodyparser = require('koa-body')
const app = new koa()

// 导入自定义文件
const config = require('./config/app.config')
const seq = require('./utils/seq')
require('./models/Middles')
require('./models/Resource')


/**
 * 中间件使用
*/
// 静态资源中间件
app.use(static(path.join(__dirname, 'public')))
// 路由权限控制中间件
const notauth = ['/api/login']
app.use(jwt({ secret: 'jwt_secret', passthrough: true }).unless({ path: notauth }))
// 配置跨域
app.use(cors({
  credentials: true,
  allowMethods: ['GET', 'POST', 'DELETE', 'PUT'],
  allowHeaders: ['Content-Type', 'Authorization', 'Accept']
}))
// 解析request body
app.use(bodyparser({
  enableTypes: ['json', 'form', 'text'],
  multipart: true // 是否支持 multipart-formdate 的表单
}))
// 日志的使用
const { logger, accessLogger } = require('./utils/log')
app.use(accessLogger())


// 全局配置
app.use(async (ctx,next) => {
  await next()
})

// 全局拦截器
app.use(async (ctx, next) => {
  // 排除不拦截的接口
  if (notauth.includes(ctx.url)) {
    await next()
  } else if (ctx.headers.authorization === undefined) {
    ctx.status = 401
    ctx.body = {
      status:401,
      msg:'登录过期，请重新登录'
    }
  } else {
    try {
      const id = JWT.verify(ctx.headers.authorization, config.secret)
      // 验证token
      await next()
    } catch (error) {
      // 全局错误处理
      ctx.body = {
        code: 500,
        msg: error.message,
        data: null
      }
    }
  }
})

// 路由自动加载
requireDirectory(module, './routes', { visit: whenLoadModule })
function whenLoadModule(obj) {
  if (obj instanceof router) {
    app.use(obj.routes(), obj.allowedMethods())
  }
}

// 监听端口
app.listen(config.port, () => {
  console.info('server is running at port 3000')
})
