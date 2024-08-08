const moment = require('moment')

function showLog (ctx) {
  const datetime = moment().format('YYYY/MM/DD HH:mm:ss')
  console.log(`[INFO] - ${datetime} INFO ----- [${ctx.request.method}]---${ctx.request.url}`)
}

module.exports = {
  showLog
}