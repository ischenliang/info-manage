const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * 密码管理表
 * id: 主键 UUID
 * name：名称 String
 * url：网址 String
 * type：类别 Integer 1网站/0软件
 * account：账号 String
 * password：登录密码 String(密码不能暴露出来：应该在查看的时候校验当前用户的登录密码(类似于gitee))
 * remark：备注 String
 * uid：用户 UUID
 * ctime：api创建时间 String
 * mtime：api更新时间 String
 */
const Password = seq.define('password', {
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
    comment: '名称'
  },
  url: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '网址'
  },
  type: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 1,
    comment: '类型：1网站/0软件'
  },
  account: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '账号'
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '密码'
  },
  remark: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '备注'
  },
  uid: {
    type: DataTypes.UUID,
    allowNull: false,
    comment: '用户'
  },
  ctime: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: moment().format('YYYY-MM-DD HH:mm:ss'),
    comment: '创建时间'
  },
  mtime: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: moment().format('YYYY-MM-DD HH:mm:ss'),
    comment: '更新时间'
  }
}, {
  freezeTableName: true
})

module.exports = Password
