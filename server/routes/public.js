const router = require('koa-router')()
router.prefix('/api')
const resConfig = require('../config/app.res')
const { login, register, generateCryptoKey } = require('../service/public')
const { add: addLog } = require('../service/log')
const { CRYPTO_PADDING: { token: token_prefix } } = require('../global.config')

async function createLog (username, type, content, uid, ip) {
  return await addLog({
    name: username,
    type: type,
    content,
    uid: uid,
    ip: ip
  })
}

/**
 * 登录：Post
*/
router.post('/login', async(ctx, next) => {
  try {
    ctx.status = 200
    const ip = ctx.req_ip
    const res = await login(ctx.request.body, ip)
    const { user, token, error } = res
    if (error) {
      ctx.body = {
        code: 500,
        msg: resConfig['LOGIN_FAILURE'],
        data: error
      }
    } else {
      createLog(user.username, '登录系统', '登录成功', user.id, ip)
      ctx.set(token_prefix, token)
      ctx.body = {
        code: 200,
        msg: resConfig['LOGIN_SUCCESS'],
        data: user
      }
    }
  } catch (error) {
    ctx.throw(error.status, error)
  }
})


/**
 * 注册: Post
 */
router.post('/register', async (ctx, next) => {
  try {
    ctx.status = 200
    const ip = ctx.req_ip
    const { error, data, user } = await register(ctx.request.body, ip)
    if (error) {
      ctx.body = error
    } else {
      if (user) {
        await addLog({
          name: user.username,
          type: '账号注册',
          content: "注册成功",
          uid: user.id,
          ip: ip
        })
      }
      ctx.body = data
    }
  } catch (error) {
    ctx.throw(error.status, error)
  }
})


/**
 * 密钥对：公钥
 */
router.post('/pke', async (ctx, next) => {
  try {
    ctx.status = 200
    ctx.set('X-Custom-Header', 'CustomValue')
    const res = await generateCryptoKey(ctx.req_ip)
    ctx.body = {
      code: 200,
      msg: '成功',
      data: res
    }
  } catch (error) {
    
  }
})

module.exports = router