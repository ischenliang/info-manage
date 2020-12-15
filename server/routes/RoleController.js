const router = require('koa-router')()
router.prefix('/api/role')
const { add } = require('../service/RoleService')


// 新增角色
router.post('/add', async(ctx, next) => {
  await add(ctx.request.body)
  ctx.body = '新增角色'
})


// 角色列表
router.get('/list', async(ctx, next) => {
  ctx.body = '角色列表'
})

module.exports = router