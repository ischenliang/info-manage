const router = require('koa-router')()
router.prefix('/api/accountTag')
const resConfig = require('../config/app.res')
const { add, deleteById, update, detail, list, move, reset } = require('../service/accountTag')

// 新增
router.post('/add', async(ctx, next) => {
  const ctype = ctx.request.body
  ctype.uid = ctx.uid
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await add(ctype)
    }
  } catch (error) {
    error.status = error.status ? error.status : 500
    ctx.throw(error.status, error)
  }
})

// 删除
router.delete('/deleteById/:id', async(ctx, next) => {
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

// 修改
router.put('/update', async(ctx, next) => {
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await update(ctx.request.body, ctx.uid)
    }
  } catch (error) {
    error.status = error.status ? error.status : 500
    ctx.throw(error.status, error)
  }
})

// 查询
router.get('/detail/:id', async(ctx, next) => {
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data:  await detail(ctx.params.id, ctx.uid)
    }
  } catch (error) {
    error.status = error.status ? error.status : 500
    ctx.throw(error.status, error)
  }
})

// 列表
router.get('/list', async(ctx, next) => {
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await list(ctx.query, ctx.uid)
    }
  } catch (error) {
    ctx.throw(error.status, error)
  }
})

// 上下移动
router.get('/moveOrder/:id', async(ctx, next) => {
  try {
    ctx.verifyParams({
      option: { type: 'string', required: true }
    })
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await move(ctx.params.id, ctx.uid, ctx.query.option)
    }
  } catch (error) {
    ctx.throw(error.status, error)
  }
})

// 重排
router.put('/resetOrder', async(ctx, next) => {
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await reset(ctx.request.body, ctx.uid)
    }
  } catch (error) {
    ctx.throw(error.status, error)
  }
})

module.exports = router