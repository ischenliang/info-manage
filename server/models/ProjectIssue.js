const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * 项目任务管理表
 * id: 主键 UUID
 * pid：项目id UUID
 * name：任务名称 String
 * description：任务描述 Text
 * text：任务描述 Text
 * tag：任务标签 String bug,feature
 * priority：优先级 Integer 1无优先级/2不重要/3次要/4主要/5重要
 * status：状态 Integer 1代办/2进行中/3已完成/0已拒绝
 * ctime：创建时间 String
 * mtime：更新时间 String
 */
const ProjectIssue = seq.define('project_issue', {
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
    type: DataTypes.TEXT,
    allowNull: true,
    comment: '描述'
  },
  text: {
    type: DataTypes.TEXT,
    allowNull: true,
    comment: '描述'
  },
  tag: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '标签'
  },
  priority: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 1,
    comment: '优先级'
  },
  status: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 1,
    comment: '状态：1'
  },
  pid: {
    type: DataTypes.UUID,
    allowNull: false,
    comment: '所对应项目'
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

module.exports = ProjectIssue
