const koa = require('koa')
const router = require('koa-router') // 路由
const requireDirectory = require('require-directory') // 路由自动加载
const path = require('path')
const static = require('koa-static') // 静态资源中间件
const jwt = require('koa-jwt') // 权限控制
const JWT = require('jsonwebtoken') // token生成器

// 导入自定义文件
const config = require('./config/app.config')

const app = new koa()
/**
 * 中间件使用
*/
// 静态资源中间件
app.use(static(path.join(__dirname, 'public')))
// 路由权限控制中间件
const notauth = ['/api/login']
app.use(jwt({ secret: 'jwt_secret', passthrough: true }).unless({ path: notauth }))

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
      console.log(id)
      // 验证token
      await next()
    } catch (error) {
      console.log(error)
      // 验证失败
      ctx.status = 401
      ctx.body = {
        status:401,
        msg:'登录过期，请重新登录'
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
