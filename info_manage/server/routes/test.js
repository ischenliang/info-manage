const router = require('koa-router')()
const path = require('path')
const { taskNotification, taskCleanupLog, cancleSchedule } = require('../utils/schedule')
const fs = require('fs')
const fse = require('fs-extra')
const moment = require('moment')
router.prefix('/api/test')

// router.get('/download', async(ctx, next) => {
//   const url = path.join(__dirname, '../public/style.css')
//   const size = fs.statSync(url).size
//   ctx.set('Content-Type', 'application/force-download')
//   ctx.set('Content-Disposition', 'attachment; filename=test.js')
//   ctx.set('Content-Length', size)
//   ctx.set('filename', 'test.js')
//   fs.createReadStream(url).pipe(ctx)
// })


router.get('/download', async(ctx, next) => {
  // taskNotification({
  //   id: '1111',
  //   cron: '13 * * * * *',
  //   email: 'itchenliang@163.com',
  //   name: '打卡通知',
  //   content: '<h1>哈哈哈哈</h1>'
  // })

  // 清空文件的两种方式：删除文件/将文件内容设置为空
  // fse.removeSync(path.join(__dirname, '../log/schedule/1111.log'))
  // fs.writeFileSync(path.join(__dirname, '../log/schedule/aaa.log'), '')

  const tasks = [
    { id: '222' }, { id: '333' }
  ]
  const task = {
    id: '111',
    cron: '* * * * * *',
    name: '日志清理'
  }
  if (ctx.query.option) {
    switch (ctx.query.option) {
      case 'start':
        taskCleanupLog(task, tasks)
        break
      case 'stop':
        cancleSchedule(task.id)
        break
    }
  }
  ctx.body = "哈哈哈哈"
})

module.exports = router