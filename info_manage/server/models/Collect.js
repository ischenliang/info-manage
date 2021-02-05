const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')
/**
 * id: 唯一主键 UUID
 * name：名称 String
 * url：地址 String
 * logo：logo String
 * repository：仓库地址 String
 * tag：标签 String
 * status：状态 Boolean
 * remark：备注 String
 * uid：用户id UUID 关联 User
 * tid：类型id UUID 关联 CollectType
 * ctime：角色创建时间 String
 * mtime：角色更新时间 String
 */
const Collect = seq.define('collect', {
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
    comment: '收藏名称'
  },
  url: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '收藏地址'
  },
  logo: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '收藏logo'
  },
  repository: {
    type: DataTypes.STRING,
    allowNull: true,
    defaultValue: '',
    comment: '收藏仓库/首页'
  },
  tag: {
    type: DataTypes.STRING,
    allowNull: true,
    defaultValue: '',
    comment: '收藏标签:使用,分隔'
  },
  remark: {
    type: DataTypes.TEXT,
    allowNull: true,
    defaultValue: '',
    comment: '收藏备注'
  },
  uid: {
    type: DataTypes.UUID,
    allowNull: false,
    comment: '用户id(关联User表)'
  },
  tid: {
    type: DataTypes.UUID,
    allowNull: false,
    comment: '收藏类型id(关联collect_type表)'
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
    comment: '修改时间'
  }
}, {
  freezeTableName: true
})

module.exports = Collect
