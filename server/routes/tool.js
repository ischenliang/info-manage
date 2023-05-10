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
router.post('/baidu', async (ctx, next) => {
  try {
    ctx.body = await new Promise((resolve, reject) => {
      request.post({
        url: `http://data.zz.baidu.com/urls?site=${ctx.query.site}&token=${ctx.query.token}`,
        body: ctx.request.body.join('\n'),
        headers: {
          'Content-Type': 'text/plain'
        }
      }, function (error, response, body) {
        if (error) reject(error)
        resolve({ code: response.statusCode, data: JSON.parse(body) })
      })
    })
  } catch (error) {
    ctx.throw(500, error)
  }
})

module.exports = router