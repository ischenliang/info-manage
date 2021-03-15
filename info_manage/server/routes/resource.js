const router = require('koa-router')()
const path = require('path')
const fs = require('fs')
const token = require('jsonwebtoken')
const appConfig = require('../config/app.config')
const archiver = require('archiver')
const send = require('koa-send')
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

// 下载
router.get('/download', async(ctx, next) => {
  try {
    ctx.verifyParams({
      path: { type: 'string', required: true },
      token: { type: 'string', required: true }
    })
    const uid = token.verify(ctx.query.token, appConfig.secret).data
    const info = fs.statSync(path.join(__dirname, '../resource', uid, ctx.query.path))
    if (info.isDirectory()) {
      // 是文件夹：则打压缩包
      const name = ctx.query.path.split('/').pop()
      // 将压缩包先放进临时目录
      const dir = path.join(__dirname, `../tmp/${name}.zip`)
      const stream = fs.createWriteStream(dir)
      const zip = archiver('zip', {
        zlib: { level: 9 }
      })
      zip.pipe(stream)
      zip.directory(`resource/${uid}/${name}/`, `${name}`)
      await zip.finalize()
      ctx.attachment(`${name}.zip`)
      await send(ctx, `/tmp/${name}.zip`, { root: path.join(__dirname, '..') })
    } else {
      // 是文件则直接下载
      const name = ctx.query.path.split('/').pop()
      ctx.attachment(name)
      await send(ctx, `/resource/${uid}/${ctx.query.path}`, { root: path.join(__dirname, '..') })
    }
  } catch (error) {
    ctx.throw(error.status, error)
  }
})
module.exports = router