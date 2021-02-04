const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * id: api主键 UUID
 * name：api名称 String
 * path：api路径 String
 * perms：权限标识 String
 * type：api类型 String
 *    GET POST PUT DELETE
 * tid：api类别/api所属类别 UUID
 *    关联api_type表，删除时将其清空即可
 * ctime：api创建时间 String
 * mtime：api更新时间 String
 */
const Api = seq.define('api', {
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
  perms: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '权限标识'
  },
  type: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'GET',
    comment: '权限类型'
  },
  tid: {
    type: DataTypes.UUID,
    allowNull: true,
    comment: 'api_type表关联'
  },
  remark: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '接口备注'
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

module.exports = Api
