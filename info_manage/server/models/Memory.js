const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * 账目表
 * id: 主键 UUID
 * name：名称 String
 * text：内容 TEXT
 * content：内容 Text(html)
 * tag：标签 String，使用`,`分隔
 * priority：重要性 float
 * uid：用户 UUID
 * ctime：api创建时间 String
 * mtime：api更新时间 String
 */
const Memory = seq.define('memory', {
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
    comment: '备忘录名称'
  },
  text: {
    type: DataTypes.TEXT,
    allowNull: false,
    comment: '备忘录内容'
  },
  content: {
    type: DataTypes.TEXT,
    allowNull: false,
    comment: '备忘录内容(html)'
  },
  priority: {
    type: DataTypes.FLOAT,
    allowNull: false,
    defaultValue: 0,
    comment: '重要性'
  },
  tag: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '备忘录标签'
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
  freezeTableName: true
})

module.exports = Memory
