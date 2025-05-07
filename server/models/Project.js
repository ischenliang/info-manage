const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * 项目管理表
 * id: 主键 UUID
 * name：名称 String
 * description：描述 String
 * type：类别 Integer 内部项目/外包项目/个人项目
 * status：状态 Integer 开始/暂停/关闭
 * tag：技术 String vue,vuex等
 * path：源代码存放位置 String /project/code/projectid
 * url：部署地址 String
 * uid：用户 UUID
 * ctime：api创建时间 String
 * mtime：api更新时间 String
 */
const Project = seq.define('project', {
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
  description: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '描述'
  },
  type: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 1,
    comment: '类型：2内部项目/3外包项目/1个人项目'
  },
  status: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 1,
    comment: '1开始/2暂停/3关闭'
  },
  tag: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '技术标签'
  },
  path: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '源代码存放位置'
  },
  url: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '部署地址'
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

module.exports = Project
