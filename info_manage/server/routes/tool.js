const router = require('koa-router')()
const dns = require('dns')
const { Resolver } = require('dns')
const resolver = new Resolver()
router.prefix('/api/tool')


router.get('/dns', async (ctx, next) => {
  try {
    ctx.body = await new Promise((resolve, reject) => {
      try {
        dns.lookupService('127.0.0.1', 22, (err, hostname, service) => {
          resolve({
            hostname, // 主机名称
            service // 服务名称
          })
        })
      } catch (error) {
        reject(error)
      }
    })
  } catch (error) {
    ctx.throw(500, error)
  }
})

// 解析url成ip
router.get('/dnsip', async (ctx, next) => {
  try {
    ctx.body = await new Promise((resolve, reject) => {
      try {
        dns.lookup(ctx.query.url, (err, address, family) => {
          resolve({
            address, // ip地址
            family: 'Ipv' + family // ip版本
          })
        })
      } catch (error) {
        reject(error)
      }
    })
  } catch (error) {
    ctx.throw(500, error)
  }
})

// dns工具
router.get('/dnsip', async (ctx, next) => {
  dns.lookupService('127.0.0.1', 22, (err, hostname, service) => {
    console.log('lookupService', hostname, service) // hostname：主机名称 service：服务名称
  })
  dns.resolve('121.199.50.62', 'CNAME', (err, records) => {
    console.log('记录：', records)
  })
  resolver.resolve4(ctx.query.url, (err, addresses) => {
    console.log('addresses:', addresses) // 解析绑定到该url上的ip
  })
  dns.resolveCname(ctx.query.url, (err, addresses) => {
    console.log('Cname:', addresses)
  })
  ctx.body = '哈哈哈哈哈哈'
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