const router = require('koa-router')()
router.prefix('/api')
const jwt = require('jsonwebtoken')
const config = require('../config/app.config')

// 登录
router.post('/login', async(ctx, next) => {
  console.log(ctx.request.body)
  const token = jwt.sign({
    data: 'af4477a8-1359-4484-a72e-f0b77ca25162'
  }, config.secret, { expiresIn: config.expiresIn })
  ctx.body = {
    status: 200,
    msg: '哈哈哈哈哈',
    token: token
  }
})

module.exports = router