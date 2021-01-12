const router = require('koa-router')()
const moment = require('moment')
router.prefix('/api/role')
const resConfig = require('../config/app.res')
const { add, deleteById } = require('../service/role')

router.get('/list', async(ctx, next) => {
  try {
    console.log(ctx.query)
    // 验证参数
    ctx.verifyParams({
      name: { type: 'string' },
      age:{ type: 'string' },
    })
    ctx.body = {
      data: '哇哈哈哈'
    }
  } catch (error) {
    ctx.throw(error.status, error)
  }
})

// 新增角色
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
      data: '哈哈' // await deleteById(ctx.params.id)
    }
  } catch (error) {
    error.status = error.status ? error.status : 500
    ctx.throw(error.status, error)
  }
})

module.exports = router