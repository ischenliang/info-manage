const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * 文件资源表
 * id: 主键 UUID
 * name：文件名称 String
 * is_dir：是否目录 Boolean true文件夹/false文件
 * size：文件大小 Integer
 * path：文件位置 String
 * extension：文件扩展名 String
 * share：是否共享 JSON { is_share: false, }
 * pid：上级目录id
 * uid：用户 UUID
 * ctime：api创建时间 String
 * mtime：api更新时间 String
 */
const File = seq.define('resource', {
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
    comment: '文件名称'
  },
  is_dir: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    comment: '是否目录'
  },
  size: {
    type: DataTypes.BIGINT,
    allowNull: true,
    defaultValue: 0,
    comment: '文件大小'
  },
  path: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: '',
    comment: '文件位置'
  },
  extension: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '文件扩展名'
  },
  share: {
    type: DataTypes.JSON,
    allowNull: false,
    defaultValue: { 'is_share': false, path: '' },
    comment: '文件共享'
  },
  uid: {
    type: DataTypes.UUID,
    allowNull: false,
    comment: '用户'
  },
  pid: {
    type: DataTypes.UUID,
    allowNull: true,
    comment: '上级菜单id'
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

module.exports = File
