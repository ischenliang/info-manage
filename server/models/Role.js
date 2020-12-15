const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

// Role 模型
const RoleModel = seq.define('role', {
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
    comment: '角色名称'
  },
  description: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '角色描述'
  },
  updatetime: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: moment().format('YYYY-MM-DD HH:mm:ss'),
    comment: '更新时间'
  } 
}, {
  freezeTableName: true
})

module.exports = {
  RoleModel
}
