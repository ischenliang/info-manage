const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

const ZhihuAccount = seq.define('zhihu_account', {
  id: {
    type: DataTypes.UUID,
    allowNull: false,
    primaryKey: true,
    defaultValue: Sequelize.UUIDV4,
    comment: 'uuid'
  },
  account: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '账号'
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '账号密码'
  },
  phone: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '关联手机号'
  },
  nickname: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '账号昵称'
  },
  uid: {
    type: DataTypes.UUID,
    allowNull: false,
    comment: '用户'
  },
}, {
  freezeTableName: true
})
const ZhihuQuestion = seq.define('zhihu_question', {
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

module.exports = {
  ZhihuAccount,
  ZhihuQuestion
}
