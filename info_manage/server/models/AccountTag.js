const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * 账目分类表
 * id: 主键 UUID
 * name：名称 String
 * icon：图标 String
 * order：顺序 Integer 后端直接定义
 * type：类别 TinyInteger 1收入/0支出
 * uid：用户 UUID
 * ctime：创建时间 String
 * mtime：更新时间 String
 */
const AccountTag = seq.define('account_tag', {
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
  icon: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '图标'
  },
  order: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 1,
    comment: '顺序'
  },
  type: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 1,
    comment: '类型：1收入/0支出'
  },
  uid: {
    type: DataTypes.UUID,
    allowNull: false,
    comment: '用户'
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
    comment: '更新时间'
  }
}, {
  freezeTableName: true,
  indexes: [
    {
      unique: true,
      fields: ['name']
    }
  ]
})

module.exports = AccountTag
