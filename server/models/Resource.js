const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

// Resource 模型
const ResourceModel = seq.define('resource', {
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
    comment: '资源名称'
  },
  information: {
    type: DataTypes.JSON,
    allowNull: false,
    comment: '资源的路径，项目下的那个路径'
  },
  description: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '资源的描述'
  },
  type: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 1,
    comment: '资源类型：1-资源 2-地图服务 3-JSONSchema'
  },
  updatetime: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: moment().format('YYYY-MM-DD HH:mm:ss'),
    comment: '资源更新时间'
  }
}, {
  freezeTableName: true
})

module.exports = {
  ResourceModel
}
