const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

// User 模型
const UserModel = seq.define('user', {
  id: {
    type: DataTypes.UUID,
    allowNull: false,
    primaryKey: true, // 主键
    defaultValue: Sequelize.UUIDV4
    // autoIncrement: true, // 自动递增
  },
  username: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '登录账号'
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '登录密码'
  },
  nickname: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: '网友007',
    comment: '昵称'
  },
  avatar: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2712859483,1666841396&fm=26&gp=0.jpg',
    comment: '用户头像'
  },
  email: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '用户邮箱'
  },
  gender: {
    type: DataTypes.STRING,
    allowNull: true,
    defaultValue: '未知',
    comment: '用户性别'
  },
  remark: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '用户备注'
  },
  updatetime: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '更新时间',
    defaultValue: moment().format('YYYY-MM-DD HH:mm:ss')
  },
  status: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    comment: '用户状态', // 可用/不可用
    defaultValue: true
  }
}, {
  freezeTableName: true // 设置 freezeTableName 后，表格名称就不用再加s，否则：user => users
  // 不设置 timestamps，Sequlize 会自动为我们添加创建时间和更新时间
})

module.exports = {
  UserModel
}
