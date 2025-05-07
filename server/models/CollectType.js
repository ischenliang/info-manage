const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * id: 唯一id UUID
 * name：名称 String
 * status：状态 Boolean
 * remark：备注 String
 * uid：用户id String
 * ctime：创建时间 String
 * mtime：更新时间 String
 */
const CollectType = seq.define('collect_type', {
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
    comment: '分类名称'
  },
  status: {
    type: DataTypes.BOOLEAN,
    allowNull: true,
    defaultValue: true,
    comment: '分类状态'
  },
  remark: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '分类备注'
  },
  uid: {
    type: DataTypes.UUID,
    allowNull: false,
    comment: '用户id'
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
  freezeTableName: true
})

module.exports = CollectType
