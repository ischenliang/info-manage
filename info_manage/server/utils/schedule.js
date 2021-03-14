const schedule = require("node-schedule")
const moment = require('moment')
const { sendMail } = require('./util')
const fse = require('fs-extra')
const path = require('path')


const logDir = '../log/schedule'

/**
 * 通知定时任务
 * 发送邮件通知
 * @param {*} task 
 */
function taskNotification (task) {
  const dir = path.join(__dirname, logDir, `${task.id}.log`)
  fse.appendFileSync(dir, `[${moment().format('YYYY-MM-DD HH:mm:ss')}] [TRACE] tasklog.notification - 启动任务\n`)
  schedule.scheduleJob(task.id, task.cron_expression, () => {
    try {
      sendMail(task.email, task.name, task.content)
      fse.appendFileSync(dir, `[${moment().format('YYYY-MM-DD HH:mm:ss')}] [INFO] tasklog.notification - 任务：${task.name}执行成功\n`)
    } catch (error) {
      fse.appendFileSync(dir, `[${moment().format('YYYY-MM-DD HH:mm:ss')}] [ERROR] tasklog.notification - 任务：${task.name}执行失败 ${error.message}\n`)
    }
  })
}

/**
 * 清理日志定时任务
 * 需要将当前用户的其他任务日志清理，不包括当前这个任务
 * @param {*} task 当前这个任务
 * @param {*} tasks 当前用户的其他任务 [{ id: '' }, { id: '' }]
 */
 function taskCleanupLog (task, tasks = []) {
  // 记录当前任务的启动日志
  const dir = path.join(__dirname, logDir, `${task.id}.log`)
  fse.appendFileSync(dir, `[${moment().format('YYYY-MM-DD HH:mm:ss')}] [TRACE] tasklog.cleanupLog - 启动任务\n`)
  schedule.scheduleJob(task.id, task.cron_expression, () => {
    try {
      // 清空其他任务日志
      tasks.forEach(item => {
        fse.writeFileSync(path.join(__dirname, `../log/schedule/${item.id}.log`), '')
      })
      // 记录当前任务的运行日志
      fse.appendFileSync(dir, `[${moment().format('YYYY-MM-DD HH:mm:ss')}] [INFO] tasklog.cleanupLog - 任务：${task.name}执行成功\n`)
    } catch (error) {
      // 记录当前任务的错误日志
      fse.appendFileSync(dir, `[${moment().format('YYYY-MM-DD HH:mm:ss')}] [ERROR] tasklog.cleanupLog  - 任务：${task.name}执行失败 ${error.message}\n`)
    }
  })
}

/**
 * 取消定时任务
 * @param {*} id 
 */
 function cancleSchedule (id) {
  const dir = path.join(__dirname, logDir, `${id}.log`)
  fse.appendFileSync(dir, `[${moment().format('YYYY-MM-DD HH:mm:ss')}] [TRACE] tasklog.cancel - 取消任务\n`)
  schedule.cancelJob(id)
}


module.exports = {
  taskNotification,
  taskCleanupLog,
  cancleSchedule
}