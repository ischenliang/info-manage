const router = require('koa-router')()
router.prefix('/api/user')

router.get('/list', async(ctx, next) => {
  try {
    ctx.body = {
      code: 200,
      msg: '新增成功',
      data: '哈哈哈哈'
    }
  } catch (error) {
    throw error
  }
})

module.exports = router