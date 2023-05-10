const router = require('koa-router')()
router.prefix('/api/monitor')
const resConfig = require('../config/app.res')
const { server, node } = require('../service/monitor')

// 进程监控
router.get('/process', async(ctx, next) => {
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await node()
    }
  } catch (error) {
    error.status = error.status ? error.status : 500
    ctx.throw(error.status, error)
  }
})

// 服务监控
router.get('/server', async(ctx, next) => {
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await server()
    }
  } catch (error) {
    error.status = error.status ? error.status : 500
    ctx.throw(error.status, error)
  }
})


module.exports = router