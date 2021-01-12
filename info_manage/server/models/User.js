const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')
/**
 * id: 用户主键 UUID
 * username：用户账号 String
 * password：用户密码 String(需要md5加密)
 * nickname：用户昵称 String
 * remark：用户备注 String
 * ctime：用户创建时间 String(moment().format('YYYY-MM-DD HH:mm:ss'))
 */
const User = seq.define('user', {
  id: {
    type: DataTypes.UUID,
    allowNull: false,
    primaryKey: true,
    defaultValue: Sequelize.UUIDV4,
    comment: 'uuid'
  },
  username: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '用户名'
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '密码'
  },
  nickname: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: '网友007',
    comment: '用户名'
  },
  remark: {
    type: DataTypes.STRING,
    allowNull: true,
    defaultValue: '',
    comment: '用户备注'
  },
  ctime: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: moment().format('YYYY-MM-DD HH:mm:ss'),
    comment: '用户创建时间'
  }
}, {
  freezeTableName: true
})

module.exports = User
