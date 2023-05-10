// 静态文件处理
const static = require('koa-static')
// 跨域处理
const cors = require('koa2-cors')
 // 路由
const router = require('koa-router')
// 路由自动加载
const requireDirectory = require('require-directory')
// 解析请求体
const koaBody = require('koa-body')
// 权限控制
const jwt = require('koa-jwt')
// 参数验证
const parameter = require('koa-parameter')
// 数据压缩
const compress = require('koa-compress')
const path = require('path')


// 加载中间件
function loadMiddleware (app) {
  app.use(static(path.join(__dirname, '../public')))
  app.use(cors({
    credentials: true,
    allowMethods: ['GET', 'POST', 'DELETE', 'PUT'],
    allowHeaders: ['Content-Type', 'Authorization', 'Accept']
  }))
  // 解析request body
  app.use(koaBody({
    enableTypes: ['json', 'form', 'text'],
    multipart: true, // 是否支持 multipart-formdate 的表单
    formidable: {
      // 配置了这两项之后：文件在上传后会自动上传到指定目录下，且文件名会被加密处理，但是不便于我们后续使用，不建议.....
      // 建议方式：通过拿到文件，将文件使用读入流和写入流写入到指定的目录，还可以进行自定义名称
      // // 上传目录
      // uploadDir: path.join(__dirname, '../public/avatar'),
      // // 保留文件扩展名
      // keepExtensions: true,
      maxFileSize: 200 * 1024 * 1024 // 文件最大支持的大小
    }
  }))
  // 路由权限控制中间件
  const notauth = ['/api/login']
  app.use(jwt({ secret: 'jwt_secret', passthrough: true }).unless({ path: notauth }))
  // 参数验证
  app.use(parameter(app))
  // 数据压缩
  // 参考: https://blog.csdn.net/weixin_43352901/article/details/109137516
  app.use(compress({
    filter: function(content_type) {
      // 只有在请求的content-type中有gzip类型，我们才会考虑压缩，因为zlib是压缩成gzip类型的
      return /text/i.test(content_type)
    },
    threshold: 1024, // 阀值，当数据超过1kb的时候，可以压缩
    flush: require('zlib').Z_SYNC_FLUSH // zlib是node的压缩模块
  }))
}

// 自定加载路由：避免了多很多路由文件，而需要一个个去加载
function loadRoutes (app) {
  requireDirectory(module, '../routes', {
    visit: obj => {
      if (obj instanceof router) {
        app.use(obj.routes(), obj.allowedMethods())
      }
    }
  })
}

module.exports = {
  loadMiddleware,
  loadRoutes
}