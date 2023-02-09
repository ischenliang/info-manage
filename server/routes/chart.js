const router = require('koa-router')()
router.prefix('/api/chart')
const resConfig = require('../config/app.res')
const appConfig = require('../config/app.config')
const send = require('koa-send')
const token = require('jsonwebtoken')
const path = require('path')
const { add, deleteById, detail, list, update } = require('../service/chart')

// 新增
router.post('/add', async(ctx, next) => {
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await add(ctx.request.body)
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
      data: await deleteById(ctx.params.id)
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
      data: await update(ctx.request.body)
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
      data:  await detail(ctx.params.id)
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
      data: await list(ctx.query)
    }
  } catch (error) {
    ctx.throw(error.status, error)
  }
})

module.exports = router