const koa = require('koa')
const { loadMiddleware, loadRoutes } = require('./config/app.middleware')
const app = new koa()

const config = require('./config/app.config')
loadMiddleware(app)

// 全局拦截器
app.use(async (ctx, next) => {
  await next()
})

// 路由自动加载
loadRoutes(app)

// 监听端口
app.listen(config.port, () => {
  console.info('server is running at port 3000')
})
