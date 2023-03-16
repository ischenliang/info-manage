const router = require('koa-router')()
const moment = require('moment')
router.prefix('/api')
const resConfig = require('../config/app.res')
const { login } = require('../service/public')
const { add: addLog } = require('../service/log')

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
    let content = user === null ? '登录失败' : '登录成功'
    await addLog({
      name: user.user.username,
      type: '登录系统',
      content,
      uid: user.user.id,
      ip: ctx.req_ip
    })
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