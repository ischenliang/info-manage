const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')
const { UserModel } = require('./User')
const { RoleModel } = require('./Role')

// UserRole 模型
const UserRoleModel = seq.define('user_role', {
  id: {
    type: DataTypes.UUID,
    allowNull: false,
    primaryKey: true,
    defaultValue: Sequelize.UUIDV4,
    comment: 'uuid'
  },
  uid: {
    type: DataTypes.UUID,
    allowNull: false,
    comment: '用户id',
    references: { // 关联其他model
      model: UserModel,
      key: 'id'
    }
  },
  rid: {
    type: DataTypes.UUID,
    allowNull: false,
    comment: '角色id',
    references: {
      model: RoleModel,
      key: 'id'
    }
  }
}, {
  freezeTableName: true
})

module.exports = {
  UserRoleModel
}
