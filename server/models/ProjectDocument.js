const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * 项目文档管理表
 * id: 主键 UUID
 * pid：项目id UUID
 * name：文档名称 String
 * content：文档内容 Text
 * text：文档文本
 * ctime：创建时间 String
 * mtime：更新时间 String
 */
const ProjectDocument = seq.define('project_document', {
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
  content: {
    type: DataTypes.TEXT,
    allowNull: true,
    comment: '文档内容'
  },
  text: {
    type: DataTypes.TEXT,
    allowNull: true,
    comment: '文档文本'
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

module.exports = ProjectDocument
