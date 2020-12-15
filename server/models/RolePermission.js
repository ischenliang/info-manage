const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')
const { RoleModel } = require('./Role')
const { PermissionModel } = require('./Permission')

// RolePermission 模型
const RolePermissionModel = seq.define('role_permission', {
  id: {
    type: DataTypes.UUID,
    allowNull: false,
    primaryKey: true,
    defaultValue: Sequelize.UUIDV4,
    comment: 'uuid'
  },
  rid: {
    type: DataTypes.UUID,
    allowNull: false,
    comment: '角色id',
    references: { // 关联其他model
      model: RoleModel,
      key: 'id'
    }
  },
  pid: {
    type: DataTypes.UUID,
    allowNull: false,
    comment: '权限id',
    references: {
      model: PermissionModel,
      key: 'id'
    }
  }
}, {
  freezeTableName: true
})

module.exports = {
  RolePermissionModel
}
