const router = require('koa-router')()
router.prefix('/api/role')

// 角色列表
router.get('/list', async(ctx, next) => {
  ctx.body = '角色列表'
})

module.exports = router