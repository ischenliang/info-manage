const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * 定时任务管理
 * id：主键 UUID
 * name：名称 String
 * content：内容 Text
 * invoke_target：调用目标方法 String (task.notification/task.cleanupLog)
 * cron_expression：cron表达式 String (task.notification/task.cleanupLog)
 * status：状态 Boolean 默认true: 启用
 * uid：用户id UUID
 * email：接收人邮箱 String(只有是通知的时候)
 * ctime：创建时间 String
 * mtime：修改时间 String
 */
const Task = seq.define('task', {
  id: {
    type: DataTypes.UUID,
    allowNull: false,
    primaryKey: true,
    defaultValue: Sequelize.UUIDV4,
    comment: 'uuid'
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '名称'
  },
  content: {
    type: DataTypes.TEXT,
    allowNull: true,
    comment: '内容'
  },
  invoke_target: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '调用方法'
  },
  cron_expression:{
    type: DataTypes.STRING,
    allowNull: false,
    comment: 'cron表达式'
  },
  status:{
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    comment: 'cron表达式'
  },
  email: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '收件邮箱'
  },
  ctime: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: moment().format('YYYY-MM-DD HH:mm:ss'),
    comment: '创建时间'
  },
  mtime: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: moment().format('YYYY-MM-DD HH:mm:ss'),
    comment: '图标更新时间'
  }
}, {
  freezeTableName: true
})

module.exports = Task
