const koa = require('koa')
const { loadMiddleware, loadRoutes } = require('./config/app.middleware')
const app = new koa()

const appConfig = require('./config/app.config')
const errorConfig = require('./config/app.error')
loadMiddleware(app)

// 全局拦截器
app.use(async (ctx, next) => {
  try {
    await next()
  } catch (error) {
    // 提交错误....
    ctx.app.emit('error', error, ctx)
  }
})

// 全局错误处理
app.on('error', async(error, ctx) => {
  ctx.status = 200
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
  console.info('server is running at port 3000')
})
