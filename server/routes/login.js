const router = require('koa-router')()
router.prefix('/api')
const jwt = require('jsonwebtoken')
const config = require('../config/app.config')

// 登录
router.post('/login', async(ctx, next) => {
  console.log(ctx.request.body)
  const token = jwt.sign({
    data: 'a1b2c3d4e5f6g7ih8i9'
  }, config.secret, { expiresIn: config.expiresIn })
  ctx.body = {
    status: 200,
    message: '哈哈哈哈哈',
    token: token
  }
})

module.exports = router