const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

// Menu 模型
const MenuModel = seq.define('menu', {
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
    comment: '菜单名称'
  },
  url: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '菜单路径'
  },
  pid: {
    type: DataTypes.UUID,
    allowNull: true,
    comment: '上级菜单'
  },
  icon: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '图标icon'
  },
  component: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'Layout',
    comment: '组件名称'
  },
  enable: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    comment: '菜单是否启用'
  },
  visible: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true,
    comment: '是否显示在菜单栏上'
  },
  active: {
    type: DataTypes.UUID,
    allowNull: true,
    comment: '激活菜单项'
  },
  order: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 1,
    comment: '排序：值越大就越靠前'
  },
  type: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 2,
    comment: '菜单类别：目录1，菜单2'
  },
  redirect: {
    type: DataTypes.UUID,
    allowNull: true,
    comment: '重定向：为了解决目录菜单时应该默认前往哪个子菜单'
  },
  updatetime: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: moment().format('YYYY-MM-DD HH:mm:ss'),
    comment: '重定向：为了解决目录菜单时应该默认前往哪个子菜单'
  }
}, {
  freezeTableName: true
})

module.exports = {
  MenuModel
}
