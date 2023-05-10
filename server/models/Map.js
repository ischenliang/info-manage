const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * 地图管理表
 * id: 主键 UUID
 * name：名称 String
 * description：描述 String
 * url：上传地址 String 相对地址
 * ctime：创建时间 String
 * mtime：更新时间 String
 */
const Chart = seq.define('chart', {
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
  url: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '部署地址'
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

module.exports = Chart
