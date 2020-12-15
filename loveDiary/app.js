const nodemailer = require('nodemailer')
const axios = require('axios')
const schedule = require("node-schedule")
const fs = require('fs')
const moment = require('moment')

// 发送邮件封装
async function sendMail (text) {
  var user = '1825956830@qq.com' // 自己的邮箱
  var pass = 'pmjcgrpplkwociaf' // 邮箱授权码
  var to = '1737770335@qq.com' // 对方邮箱
  let transporter = nodemailer.createTransport({
    host: "smtp.qq.com",
    port: 587,
    secure: false,
    auth: {
      user: user, // 用户账号
      pass: pass, //授权码,通过QQ获取
    },
  })
  let info = await transporter.sendMail({
    from: `爱你的乖乖<${user}>`, // sender address
    to: `我爱的宝宝<${to}>`, // list of receivers
    subject: "我的小笨猪", // Subject line
    text: text, // plain text body
  })
  console.log("发送成功")
}

// 获取情话
function getText () {
  return axios({
    url: 'https://chp.shadiao.app/api.php',
    method: 'GET'
  })
}

// 每天定时发送：11:14:00
schedule.scheduleJob({ hour: 11, minute: 14 }, function () {
  fs.appendFileSync('success.log', `[${moment().format('YYYY-MM-DD HH:mm:ss')}] [DEBUG] start ---- 200 "启动任务"\n`)
  getText().then(res => {
    sendMail('情话内容：' + res.data)
    const text = `[${moment().format('YYYY-MM-DD HH:mm:ss')}] [INFO] access ---- 200 "${res.data}"\n`
    fs.appendFileSync('success.log', text)
  }).catch(error => {
    const text = `[${moment().format('YYYY-MM-DD HH:mm:ss')}] [ERROR] access ---- 500 "${error.message}"\n`
    fs.appendFileSync('failure.log', text)
  })
})