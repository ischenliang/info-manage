const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * 仪表盘管理表
 * id: 主键 UUID
 * name：名称 String
 * description：描述 String
 * identify：唯一标识 String 如：home/account，不可重复
 * layout：布局配置 JSON
 * ctime：创建时间 String
 * mtime：更新时间 String
 */
const Dashboard = seq.define('dashboard', {
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
  description: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '描述'
  },
  identify: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '唯一标识'
  },
  layout: {
    type: DataTypes.JSON,
    allowNull: false,
    comment: '布局配置'
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
      fields: ['identify']
    }
  ]
})

module.exports = Dashboard
