const { Task } = require('../models/Middle')
const { Op } = require("sequelize")
const sequelize = require('../utils/seq')
const fse = require('fs-extra')
const path = require('path')
const readline = require('readline')
const { taskNotification, taskCleanupLog, cancleSchedule } = require('../utils/schedule')
const moment = require('moment')

function read_line (dir) {
  return new Promise((resolve, reject) => {
    try {
      // 文件若不存在：则创建文件
      if (!fse.existsSync(dir)) {
        fse.createFileSync(dir)
      }
      const fread = fse.createReadStream(dir)
      const lines = readline.createInterface({
        input: fread
      })
      var logs = new Array()
      lines.on('line', function (line) {
        logs.push(line)
      })
      lines.on('close', function () {
        resolve(logs)
      })
    } catch (error) {
      reject(error)
    }
  })
}

// 新增
async function add (task) {
  task.ctime = moment().format('YYYY-MM-DD HH:mm:ss')
  task.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
  try {
    const res = await Task.create(task)
    await startTask(res)
    return res
  } catch (error) {
    throw error
  }
}

// 启动任务
async function startTask (task) {
  if (task.status) {
    switch (task.invoke_target) {
      case 'task.notification':
        taskNotification(task)
        break
      case 'task.cleanupLog':
        const tasks = await Task.findAll({
          where: {
            uid: task.uid,
            id: {
              [Op.ne]: task.id
            }
          },
          raw: true
        })
        taskCleanupLog(task, tasks)
        break
    }
  }
}

/**
 * 删除任务
 * 1. 删除数据库数据
 * 2. 取消当前定时任务
 * 3. 删除日志文件
 * @param {*} id
 */
async function deleteById (id, uid) {
  try {
    cancleSchedule(id)
    fse.removeSync(path.join(__dirname, `../log/schedule/${id}.log`))
    return await Task.destroy({
      where: {
        id,
        uid
      }
    })
  } catch (error) {
    throw error
  }
}

// 修改
async function update (task, uid) {
  try {
    task.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
    const res = await Task.update(task, {
      where: {
        id: task.id,
        uid
      }
    })
    const tmp = await Task.findOne({
      where: {
        id: task.id,
        uid
      },
      raw: true
    })
    if (tmp.status) {
      startTask(tmp)
    } else {
      cancleSchedule(tmp.id)
    }
    return res
  } catch (error) {
    throw error
  }
}

// 查询
async function detail (id, uid) {
  try {
    return await Task.findOne({
      where: {
        id,
        uid
      }
    })
  } catch (error) {
    throw error
  }
}

/**
 * 查询列表
 * @param {*} query
 *  size: 每页显示数量 默认10
 *  page：当前所在页码 默认0
 *  sort：排序字段 默认ctime
 *  order：排序方式 默认desc
 *  search: 搜索 默认%%
 *  start：开始时间
 *  end：结束时间
 */
async function list (query, uid) {
  try {
    const limit = query.size ? parseInt(query.size) : 10
    const { count, rows } = await Task.findAndCountAll({
      where: {
        [Op.or]: [
          { name:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { content:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { invoke_target:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { cron_expression:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { ctime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { mtime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
        ],
        mtime: {
          [Op.between]: [
            query.start ? query.start : await Task.min('mtime', { where: { uid } }),
            query.end ? query.end : await Task.max('mtime', { where: { uid } })
          ]
        },
        uid
      },
      order: [
        [query.sort ? query.sort : 'mtime', query.order ? query.order : 'desc']
      ],
      limit: limit,
      offset: query.page ? (parseInt(query.page) - 1) * limit : 0
    })
    return {
      total: count,
      data: rows
    }
  } catch (error) {
    throw error
  }
}

// 查询日志
async function log (id, uid) {
  try {
    const task = await Task.findOne({
      where: {
        id,
        uid
      }
    })
    if (task) {
      const dir = path.join(__dirname, `../log/schedule/${id}.log`)
      return {
        name: task.name,
        logs: await read_line(dir)
      }
    }
  } catch (error) {
    throw error
  }
}


module.exports =  {
  add,
  deleteById,
  update,
  detail,
  list,
  log
}