const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * 图标项目
 * id：项目主键 UUID
 * name：项目名称 String
 * remark：项目备注 String
 * family：FontFamily String
 * prefix：项目图标前缀
 * url：图标css样式文件存放位置
 *    默认：http://at.alicdn.com/t/font_2246210_dg83mt99oye.css
 * uid：创建者 UUID
 * ctime：项目创建时间 String
 * mtime：项目修改时间 String
 */
const IconProject = seq.define('icon_project', {
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
    comment: '项目名称'
  },
  remark: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '项目备注'
  },
  family: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'iconfont',
    comment: 'FontFamily'
  },
  prefix: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'icon',
    comment: '图标前缀'
  },
  url: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'http://at.alicdn.com/t/font_2246210_dg83mt99oye.css',
    comment: '样式文件存放位置'
  },
  uid: {
    type: DataTypes.UUID,
    allowNull: true,
    comment: '项目所有者'
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

module.exports = IconProject
