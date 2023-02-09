const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')
/**
 * id: 用户主键 UUID
 * username：用户账号 String 唯一
 * password：用户密码 String(需要md5加密)
 * nickname：用户昵称 String
 * avatar: 用户头像 String 默认http://vue.ruoyi.vip/static/img/profile.473f5971.jpg
 * remark：用户备注 String
 * status: 用户状态 Boolean 默认false
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
    comment: '用户名',
    unique: 'username'
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '密码'
  },
  nickname: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: '用户007',
    comment: '用户昵称'
  },
  avatar: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'http://vue.ruoyi.vip/static/img/profile.473f5971.jpg',
    comment: '用户头像'
  },
  remark: {
    type: DataTypes.STRING,
    allowNull: true,
    defaultValue: '',
    comment: '用户备注'
  },
  status: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true,
    comment: '用户状态'
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
