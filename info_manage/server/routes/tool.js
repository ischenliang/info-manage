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