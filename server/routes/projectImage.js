const router = require('koa-router')()
router.prefix('/api/pimage')
const resConfig = require('../config/app.res')
const appConfig = require('../config/app.config')
const send = require('koa-send')
const token = require('jsonwebtoken')
const path = require('path')
const { add, deleteById, detail, list, update } = require('../service/projectImage')
const { Project } = require('../models/Middle')

// 新增
router.post('/upload', async(ctx, next) => {
  try {
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await add(ctx.request.files.file, ctx.request.body)
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
      data: await update(ctx.request.files.file, ctx.request.body)
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
    ctx.verifyParams({
      pid: { type: 'string', required: true }
    })
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await list(ctx.query, ctx.uid)
    }
  } catch (error) {
    console.log(error)
  }
})

// 下载
router.get('/download', async(ctx, next) => {
  try {
    ctx.verifyParams({
      id: { type: 'string', required: true },
      token: { type: 'string', required: true }
    })
    token.verify(ctx.query.token, appConfig.secret).data
    const image = await detail(ctx.query.id)
    if (image) {
      ctx.attachment(image.name)
      await send(ctx, `/project/image/${image.name}`, { root: path.join(__dirname, '..') })
    } else {
      ctx.throw(404, '文件不存在')
    }
  } catch (error) {
    ctx.throw(error.status, error)
  }
})


module.exports = router