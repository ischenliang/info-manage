const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * 账目表
 * id: 主键 UUID
 * type：类型 Integer 1收入/0支出
 * tag：分类 JSON：{ name: '餐饮', icon: 'iconfont-canyin' }
 * pay：支付方式 String
 * money：付款金额
 * ptime：支付时间 String
 * location：定位 JSON { code: [1001, 1002, 1003], city: ['四川省', '成都市', '青羊区'] }
 * remark：备注 TEXT
 * uid：用户 UUID
 * template：模板 Boolean false
 * ctime：创建时间 String
 * mtime：更新时间 String
 */
const Account = seq.define('account', {
  id: {
    type: DataTypes.UUID,
    allowNull: false,
    primaryKey: true,
    defaultValue: Sequelize.UUIDV4,
    comment: 'uuid'
  },
  type: {
    type: DataTypes.TINYINT,
    allowNull: false,
    defaultValue: 1,
    comment: '账目类型: 1收入 0支出'
  },
  tag: {
    type: DataTypes.JSON,
    allowNull: false,
    comment: '账目分类'
  },
  pay: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: '支付宝',
    comment: '支付方式'
  },
  money: {
    type: DataTypes.FLOAT,
    allowNull: false,
    defaultValue: 0.00,
    comment: '付款金额'
  },
  ptime: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: moment().format('YYYY-MM-DD HH:mm:ss'),
    comment: '支付时间'
  },
  location: {
    type: DataTypes.JSON,
    allowNull: false,
    comment: '定位'
  },
  remark: {
    type: DataTypes.TEXT,
    allowNull: true,
    comment: '账目备注'
  },
  uid: {
    type: DataTypes.UUID,
    allowNull: false,
    comment: '用户'
  },
  template: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    comment: '是否为模板'
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

module.exports = Account
