const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')
/**
 * 公钥私钥对
 */
const Crypto = seq.define('crypto', {
  id: {
    type: DataTypes.UUID,
    allowNull: false,
    primaryKey: true,
    defaultValue: Sequelize.UUIDV4,
    comment: 'uuid'
  },
  public_key: {
    type: DataTypes.TEXT,
    allowNull: false,
    comment: '公钥'
  },
  private_key: {
    type: DataTypes.TEXT,
    allowNull: false,
    comment: '秘钥'
  },
  label: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '传输的label'
  },
  type: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '加密类型'
  },
  bits: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '加密长度，通常为1024、2048...'
  },
  generate_ip: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '客户端ip，为指定客户端ip生成的密钥对'
  },
  is_valid: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    comment: '验证状态'
  },
  ctime: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: moment().format('YYYY-MM-DD HH:mm:ss'),
    comment: '创建时间'
  }
}, {
  freezeTableName: true
})

module.exports = Crypto
