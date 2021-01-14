const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * 图标：管理员维护
 * id：图标主键 UUID
 * pid：图标项目id UUID
 *    外键：IconProject 的id
 * name：图标名称 String
 * code：图标code即font_class String
 * status：图标状态 Boolean 默认true
 *    true：启用  false：禁用
 * ctime：图标创建时间 String
 * mtime：图标修改时间 String
 */
const Icon = seq.define('icon', {
  id: {
    type: DataTypes.UUID,
    allowNull: false,
    primaryKey: true,
    defaultValue: Sequelize.UUIDV4,
    comment: 'uuid'
  },
  pid: {
    type: DataTypes.UUID,
    allowNull: false,
    defaultValue: Sequelize.UUIDV4,
    comment: '图标项目id'
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '图标名称'
  },
  code: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '图标的code'
  },
  status:{
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true,
    comment: '图标状态'
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

module.exports = Icon
