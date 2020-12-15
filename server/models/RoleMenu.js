const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')
const { MenuModel } = require('./Menu')
const { RoleModel } = require('./Role')

// RoleMenu 模型
const RoleMenuModel = seq.define('role_menu', {
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
  mid: {
    type: DataTypes.UUID,
    allowNull: false,
    comment: '菜单id',
    references: {
      model: MenuModel,
      key: 'id'
    }
  }
}, {
  freezeTableName: true
})

module.exports = {
  RoleMenuModel
}
