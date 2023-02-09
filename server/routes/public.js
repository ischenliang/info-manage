const router = require('koa-router')()
const moment = require('moment')
router.prefix('/api')
const resConfig = require('../config/app.res')
const { login } = require('../service/public')

/**
 * 登录：Get
*/
router.get('/login', async(ctx, next) => {
  try {
    ctx.status = 200
    const user = await login(ctx.query)
    if (user) {
      ctx.body = {
        code: 200,
        msg: resConfig['LOGIN_SUCCESS'],
        data: user
      }
    } else {
      ctx.body = {
        code: 500,
        msg: resConfig['LOGIN_FAILURE'],
        data: resConfig['LOGIN_FAILURE_RES']
      }
    }
  } catch (error) {
    ctx.throw(error.status, error)
  }
})

/**
 * 登录：Post
*/
router.post('/login', async(ctx, next) => {
  try {
    ctx.status = 200
    const user = await login(ctx.request.body)
    if (user) {
      ctx.body = {
        code: 200,
        msg: resConfig['LOGIN_SUCCESS'],
        data: user
      }
    } else {
      ctx.body = {
        code: 500,
        msg: resConfig['LOGIN_FAILURE'],
        data: resConfig['LOGIN_FAILURE_RES']
      }
    }
  } catch (error) {
    ctx.throw(error.status, error)
  }
})

module.exports = router