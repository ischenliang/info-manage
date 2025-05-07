const koa = require('koa')
const { loadMiddleware, loadRoutes } = require('./config/app.middleware')
const app = new koa()

const appConfig = require('./config/app.config')
const errorConfig = require('./config/app.error')
const resConfig = require('./config/app.res')
const token = require('jsonwebtoken')
loadMiddleware(app)
require('./models/Middle')
const { userApi } = require('./service/user')
const { NOT_AUTH, REG_PREFIX, CRYPTO_PADDING: { token: token_prefix } } = require('./global.config')
const { showLog } = require('./utils/log')


// 获取客户端IP地址
function getClientIP(req) {
  let ip = req.headers['x-forwarded-for'] || // 判断是否有反向代理 IP
    req.ip  ||
    req.connection.remoteAddress || // 判断 connection 的远程 IP
    req.socket.remoteAddress || // 判断后端的 socket 的 IP
    req.connection.socket.remoteAddress || ''
  if(ip) {
    ip = ip.replace('::ffff:', '')
  }
  return ip
}

/**
 * 全局拦截器
 * 1. 判断当前请求url是否在 notauth 中 indexOf
 *    在：直接放行 -> 意味着该接口是开放的
 *    不在：执行第二步
 * 2.验证 ctx.request.headers.authorization 是否存在
 *    存在：执行第三步
 *    不存在：直接抛出权限不足的异常
 * 3.根据authorization是否过期
 *    过期：抛出token过期异常
 *    没有过期：执行第四步
 * 4.根据authorization获取里面的用户信息
 *    将用户信息存储到ctx中
*/
app.use(async (ctx, next) => {
  showLog(ctx)
  try {
    ctx.req_ip = getClientIP(ctx.req)
    if (NOT_AUTH.includes(ctx.request.url.split('?')[0])) {
      await next()
    } else {
      const url = ctx.req.url
      // 处理静态资源的
      if (url.indexOf('/api') === -1) {
        ctx.status = 200
        ctx.type = 'image/png'
      } else {
        // 处理token
        const authorization = ctx.request.headers[token_prefix]
        if (authorization === undefined) {
          ctx.throw(401, resConfig['401'])
        } else {
          const payload = token.verify(authorization, appConfig.secret)
          if (payload.req_ip === getClientIP(ctx.req)) {
            ctx.uid = payload.data
            await next()
          } else {
            ctx.throw(401, resConfig['401'])
          }
        }
      }
    }
  } catch (error) {
    // 提交错误....
    ctx.app.emit('error', error, ctx)
  }
})

/**
 * 权限处理中间件
 * 1. 从ctx中获取当前登录用户的id
 *    ctx.uid
 * 2. 根据uid获取用户所属的角色
 * 3. 根据角色获取对应的Api
*/
app.use(async (ctx, next) => {
  try {
    ctx.compress = true
    const { url: request_url, method } = ctx.request
    let url = request_url.split('?')[0]
    if (!NOT_AUTH.includes(url)) {
      REG_PREFIX.forEach(item => {
        if (url.indexOf(item) !== -1) {
          url = url.replace(new RegExp(`${item}\/.*`), `${item}/:id`)
        }
      })
      // 判断是否拥有权限
      const apis = await userApi(ctx.uid)
      const index = apis.findIndex(item => item.path === url && item.type.toUpperCase() === method.toUpperCase())
      // 是否拥有删除日志权限，拥有即代表可以查看所有日志
      const lookAllLogs = apis.some(item => item.path === '/api/log/deleteById/:id')
      ctx.state.lookAllLogs = lookAllLogs
      if (index !== -1) {
        await next()
      } else {
        ctx.body = {
          code: 401,
          data: resConfig['401'],
          msg: resConfig['401']
        }
      }
    } else {
      await next()
    }
  } catch (error) {
    console.log(error)
    ctx.throw(401, '报错啦')
  }
})

// 全局错误处理
app.on('error', async(error, ctx) => {
  const code = error.status ? error.status : 500
  ctx.body = {
    code: code,
    msg: errorConfig[code], // 这个msg应该从数据库/配置文件中获取
    data: error.original ? error.original.sqlMessage : error.message // 判断是否是数据库发生的错误....
  }
})

// 路由自动加载
loadRoutes(app)

// 监听端口
app.listen(appConfig.port, () => {
  console.info(`server is running at port ${appConfig.port}`)
})
