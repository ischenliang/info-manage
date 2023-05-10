const router = require('koa-router')()
router.prefix('/api/log')
const resConfig = require('../config/app.res')
const { add, findAll, deleteById } = require('../service/log')

// 新增
router.post('/add', async (ctx, next) => {
  const log = ctx.request.body
  log.uid = ctx.uid
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await add(log)
    }
  } catch (error) {
    error.status = error.status ? error.status : 500
    ctx.throw(error.status, error)
  }
})

// 查询
router.get('/list', async (ctx, next) => {
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await findAll(ctx.query, ctx.uid, ctx.state.lookAllLogs)
    }
  } catch (error) {
    error.status = error.status ? error.status : 500
    ctx.throw(error.status, error)
  }
})


// 删除
router.delete('/deleteById/:id', async (ctx, next) => {
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await deleteById(ctx.params.id, ctx.uid)
    }
  } catch (error) {
    error.status = error.status ? error.status : 500
    ctx.throw(error.status, error)
  }
})


module.exports = router