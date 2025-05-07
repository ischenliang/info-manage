const { DataTypes } = require('sequelize')
const seq = require('../utils/seq')
const moment = require('moment')
// log 模型

/**
 *id：id uuid 必填
  操作用户：name string
  操作信息：content string
  客户端信息：client_info string
  操作类型：type string
  操作日期：ctime string  默认moment当前时间
 */
module.exports = seq.define('log', {
  // 在这里定义模型属性
  id: {
    type: DataTypes.UUID,
    primaryKey: true,
    allowNull: false,
    defaultValue: DataTypes.UUIDV4,
    comment: '日志id'
  },
  uid: {
    type: DataTypes.UUID,
    allowNull: false,
    comment: '用户'
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '操作用户'
  },
  content: {
    type: DataTypes.STRING,
    comment: '操作信息'
  },
  client_info: {
    type: DataTypes.JSON,
    comment: '客户端信息'
  },
  type: {
    type: DataTypes.STRING,
    comment: '操作类型'
  },
  ctime: {
    type: DataTypes.STRING,
    defaultValue: moment().format('YYYY-MM-DD HH:mm:ss'),
    comment: '创建时间'
  }
})
