const koa = require('koa')
const app = new koa()
const moment = require('moment')
app.use(async (ctx, next) => {
  console.log(moment().format('YYYY-MM-DD HH:mm:ss'), 1)
  await next()
  console.log(ctx.body)
  ctx.body = '22'
  console.log(moment().format('YYYY-MM-DD HH:mm:ss'), 2)
})
app.use(async (ctx, next) => {
  console.log(moment().format('YYYY-MM-DD HH:mm:ss'), 3)
  await next()
  ctx.body = '21'
  console.log(moment().format('YYYY-MM-DD HH:mm:ss'), 4)
})
app.use(async (ctx, next) => {
  console.log(moment().format('YYYY-MM-DD HH:mm:ss'), 5)
  await next()
  console.log(moment().format('YYYY-MM-DD HH:mm:ss'), 6)
})
app.listen(4000)