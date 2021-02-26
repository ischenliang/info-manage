const router = require('koa-router')()
router.prefix('/api/resource')
const resConfig = require('../config/app.res')
const { add, deleteById, update, detail, list, move, copy, upload } = require('../service/resource')

// 新增
router.post('/add', async(ctx, next) => {
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await add(ctx.query.path, ctx.request.body, ctx.uid)
    }
  } catch (error) {
    error.status = error.status ? error.status : 500
    ctx.throw(error.status, error)
  }
})

// 删除
router.delete('/delete', async(ctx, next) => {
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await deleteById(ctx.query.path, ctx.uid)
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
      data: await update(ctx.query.path, ctx.request.body, ctx.uid)
    }
  } catch (error) {
    error.status = error.status ? error.status : 500
    ctx.throw(error.status, error)
  }
})

// 查询
router.get('/info', async(ctx, next) => {
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data:  await detail(ctx.query.path, ctx.uid)
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
      data: await list(ctx.query.path, ctx.uid)
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
      data: await move(ctx.query.path, ctx.request.body, ctx.uid)
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
      data: await copy(ctx.query.path, ctx.request.body, ctx.uid)
    }
  } catch (error) {
    ctx.throw(error.status, error)
  }
})

// 上传
router.post('/upload', async(ctx, next) => {
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig['UPLOAD_SUCCESS'],
      data: await upload(ctx.request.files.files, ctx.query.path, ctx.uid)
    }
  } catch (error) {
    ctx.throw(error.status, error)
  }
})

module.exports = router