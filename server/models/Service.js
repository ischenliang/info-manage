const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * 服务注册管理表
 * id: 主键 UUID
 * name：名称 String
 * description：描述 String
 * type：服务类型 String 地图服务/运动服务
 * information：服务详情 json
 * ctime：创建时间 String
 * mtime：更新时间 String
 */
const Service = seq.define('service', {
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
  type: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 1,
    comment: '服务类型'
  },
  information: {
    type: DataTypes.JSON,
    allowNull: false,
    comment: '服务详情'
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

module.exports = Service
