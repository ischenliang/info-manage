const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * 
 * 项目图集管理表
 * id: 主键 UUID
 * pid：项目id UUID
 * name：名称 String
 * path：图片存放位置 String /project/image/projectid/imageid.png
 * ctime：创建时间 String
 * mtime：更新时间 String
 */
const ProjectImage = seq.define('project_image', {
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
  path: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '图片存放位置'
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

module.exports = ProjectImage
