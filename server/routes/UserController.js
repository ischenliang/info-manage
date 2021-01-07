const router = require('koa-router')()
router.prefix('/api/sys')
const { add } = require('../service/UserService')

// 获取角色详情
router.get('/detail', async(ctx, next) => {
  try {
    ctx.body = {
      code: 200,
      msg: '查询成功',
      data: await add()
    }
  } catch (error) {
    throw error
  }
})

module.exports = router