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


// router.get('/download', async(ctx, next) => {
//   // taskNotification({
//   //   id: '1111',
//   //   cron: '13 * * * * *',
//   //   email: 'itchenliang@163.com',
//   //   name: '打卡通知',
//   //   content: '<h1>哈哈哈哈</h1>'
//   // })

//   // 清空文件的两种方式：删除文件/将文件内容设置为空
//   // fse.removeSync(path.join(__dirname, '../log/schedule/1111.log'))
//   // fs.writeFileSync(path.join(__dirname, '../log/schedule/aaa.log'), '')

//   const tasks = [
//     { id: '222' }, { id: '333' }
//   ]
//   const task = {
//     id: '111',
//     cron: '* * * * * *',
//     name: '日志清理'
//   }
//   if (ctx.query.option) {
//     switch (ctx.query.option) {
//       case 'start':
//         taskCleanupLog(task, tasks)
//         break
//       case 'stop':
//         cancleSchedule(task.id)
//         break
//     }
//   }
//   ctx.body = "哈哈哈哈"
// })

// const send = require('koa-send')
// router.get('/download', async(ctx, next) => {
//   // ctx.attachment('tmp/test.html')
//   // await send(ctx, 'tmp/chart/echarts.js')
//   // fs.createReadStream(path.join(__dirname, '../tmp/chart/echarts.js')).pipe(ctx)
//   const dir = path.join(__dirname, '../tmp/chart/echarts.js')
//   ctx.set('Content-Type', 'application/force-download')
//   ctx.set('Content-Disposition', 'attachment; filename=echarts.js')
//   ctx.set('Content-Length', 1068)
//   fs.createReadStream(dir).pipe(ctx)
// })

// router.get('/download', async (ctx, next) => {
//   ctx.body = {
//     code: 200,
//     msg: '获取成功',
//     data: 'data:image/png;base64,' + fs.readFileSync(path.join(__dirname, '../project/01.jpg'), 'base64')
//   }
// })

async function test () {
  // return new Promise((resolve, reject) => {
  //   request({
  //     method: 'POST',
  //     uri: 'http://data.zz.baidu.com/urls?site=https://itchenliang.gitee.io&token=WdhbCVRbA3h4Rumg',
  //     headers: {
  //       'Content-Type': 'text/plain'
  //     },
  //     function (error, response, body) {
  //       console.log(error)
  //       console.log(response)
  //     }
  //   })
  // })
}

const request = require('request')
router.get('/download', async (ctx, next) => {
  request.post({
    url: 'http://data.zz.baidu.com/urls?site=https://itchenliang.gitee.io&token=WdhbCVRbA3h4Rumg',
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
    data: 'asdasd'
  }
})

module.exports = router