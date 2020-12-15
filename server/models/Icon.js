const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

// Icon 模型
const IconModel = seq.define('icon', {
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
    comment: '图标名称'
  },
  prefix: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'xapi',
    comment: '图标的前缀'
  },
  code: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '图标的code'
  },
  updatetime: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: moment().format('YYYY-MM-DD HH:mm:ss'),
    comment: '图标更新时间'
  }
}, {
  freezeTableName: true
})

module.exports = {
  IconModel
}
