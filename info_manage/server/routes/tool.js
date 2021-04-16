const router = require('koa-router')()
const dns = require('dns')
const { Resolver } = require('dns')
const resolver = new Resolver()
router.prefix('/api/tool')

// 
router.get('/dnsips', async (ctx, next) => {
  try {
    ctx.body = await new Promise((resolve, reject) => {
      resolver.resolve4(ctx.query.url, (error, addresses) => {
        if (error) {
          reject(error)
        }
        resolve({
          addresses
        })
      })
    })
  } catch (error) {
    ctx.throw(error)
  }
})

// 根据ip和端口解析主机名
router.get('/dnsservice', async (ctx, next) => {
  try {
    ctx.body = await new Promise((resolve, reject) => {
      dns.lookupService(ctx.query.ip, ctx.query.port, (error, hostname, service) => {
        if (error) {
          reject(error)
        }
        resolve({
          hostname, // 主机名称
          service // 服务名称
        })
      })
    })
  } catch (error) {
    ctx.throw(500, error)
  }
})

// 解析url成ip
router.get('/dnsip', async (ctx, next) => {
  try {
    ctx.body = await new Promise((resolve, reject) => {
      dns.lookup(ctx.query.url, (error, address, family) => {
        if (error) {
          reject(error)
        }
        resolve({
          address, // ip地址
          family: 'Ipv' + family // ip版本
        })
      })
    })
  } catch (error) {
    ctx.throw(500, error)
  }
})

// 百度收录
const request = require('request')
router.get('/baidu', async (ctx, next) => {
  request.post({
    // url: 'http://data.zz.baidu.com/urls?site=https://itchenliang.gitee.io&token=WdhbCVRbA3h4Rumg',
    url: '',
    body: [
      'https://itchenliang.gitee.io/posts/30efc280-f984-11ea-90b0-c5a83a2f2ef9a0b/',
      'https://itchenliang.gitee.io/posts/70ba8db0-f72b-11ea-938b-b99af4f0d6b5/',
      'https://itchenliang.gitee.io/posts/60272b20-49b5-11eb-b4bb-b1a7a3af1020/'
    ].join('\n'),
    headers: {
      'Content-Type': 'text/plain'
    }
  }, function (error, response, body) {
    // console.log(error)
    // console.log(response)
    console.log(response.statusCode)
    console.log(body)
  })
  ctx.body = {
    data: '哈哈哈哈哈'
  }
})

module.exports = router