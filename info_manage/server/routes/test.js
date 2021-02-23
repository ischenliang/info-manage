const router = require('koa-router')()
const path = require('path')
const fs = require('fs')
router.prefix('/api/test')

router.get('/download', async(ctx, next) => {
  const url = path.join(__dirname, '../public/style.css')
  const size = fs.statSync(url).size
  ctx.set('Content-Type', 'application/force-download')
  ctx.set('Content-Disposition', 'attachment; filename=test.js')
  ctx.set('Content-Length', size)
  ctx.set('filename', 'test.js')
  fs.createReadStream(url).pipe(ctx)
})

module.exports = router