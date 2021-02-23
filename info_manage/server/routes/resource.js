const router = require('koa-router')()
router.prefix('/api/resource')
const resConfig = require('../config/app.res')
const { add, deleteById, update, detail, list, move } = require('../service/resource')

// 新增
router.post('/add', async(ctx, next) => {
  const resource = ctx.request.body
  resource.uid = ctx.uid
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await add(resource)
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

// 移动
router.post('/move', async(ctx, next) => {
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig['MOVE_SUCCESS'],
      data: await move(ctx.query.id, ctx.request.body, ctx.uid)
    }
  } catch (error) {
    ctx.throw(error.status, error)
  }
})


// 复制
router.post('/copy', async(ctx, next) => {
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig['COPY_SUCCESS'],
      data: await move(ctx.query, ctx.uid)
    }
  } catch (error) {
    ctx.throw(error.status, error)
  }
})

module.exports = router