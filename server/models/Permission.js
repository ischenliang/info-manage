const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

// Permission 模型
const PermissionModel = seq.define('permission', {
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
    comment: '权限名称'
  },
  path: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '权限地址'
  },
  type: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'get',
    comment: '权限类型'
  },
  basename: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '所属类别：用户管理/角色管理等等'
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
  PermissionModel
}
