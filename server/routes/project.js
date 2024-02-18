const router = require('koa-router')()
router.prefix('/api/project')
const resConfig = require('../config/app.res')
const appConfig = require('../config/app.config')
const send = require('koa-send')
const token = require('jsonwebtoken')
const path = require('path')
const { add, deleteById, detail, list, update } = require('../service/project')
const Project = require('../models/Project')

// 新增
router.post('/add', async(ctx, next) => {
  try {
    const obj = ctx.request.body
    obj.uid = ctx.uid
    ctx.status = 200
    ctx.body = {
      code: 200,
      msg: resConfig[ctx.request.method],
      data: await add(ctx.request.files.file, obj)
    }
  } catch (error) {
    error.status = error.status ? error.status : 500
    ctx.throw(error.status, error)
  }
})

// 删除: 海英删除对应的数据，如项目文档、项目图集、项目任务、项目代码
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
      data: await update(ctx.request.files.file, ctx.request.body, ctx.uid)
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

// 下载
router.get('/download', async(ctx, next) => {
  try {
    ctx.verifyParams({
      id: { type: 'string', required: true },
      token: { type: 'string', required: true }
    })
    const uid = token.verify(ctx.query.token, appConfig.secret).data
    const project = await detail(ctx.query.id, uid)
    if (project) {
      ctx.attachment(`${project.name}.zip`)
      await send(ctx, `/project/code/${project.id}.zip`, { root: path.join(__dirname, '..') })
    } else {
      ctx.throw(404, '文件不存在')
    }
  } catch (error) {
    ctx.throw(error.status, error)
  }
})


module.exports = router