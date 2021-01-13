const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * id: 菜单主键 UUID
 * name：菜单名称 String
 * pid：父级菜单id UUID
 * order：显示顺序 Integer
 * path：路由地址 String
 * redirect：重定向地址 String：最终决定不用
 *    考虑是否需要使用：
 *      否：默认目录的重定向到子菜单第一项，问题：当嵌套多层时会出现问题
 *      是：考虑实现方式....
 * component：组件路径 String
 * type：菜单类型 Integer
 *    1：目录 2：菜单
 * is_frame：是否外链 Boolean
 * visible：菜单显示 Boolean 默认1
 *    1：显示 0：隐藏
 *    使用了该字段后就可以不用激活项字段
 * status：菜单状态 Boolean 默认0
 *    1：正常 0：停用
 * icon：菜单图标 String
 * uid：创建者 UUID
 * remark：菜单备注 String
 * ctime：菜单创建时间
 * mtime：菜单更新时间
 */
const Menu = seq.define('menu', {
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
  pid: {
    type: DataTypes.UUID,
    allowNull: true,
    comment: '上级菜单id'
  },
  order: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 1,
    comment: '菜单排序'
  },
  path: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '菜单路由'
  },
  component: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: '/Layout',
    comment: '组件路径'
  },
  type: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 1,
    comment: '菜单类型：目录1，菜单2'
  },
  is_frame: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    comment: '是否外链'
  },
  visible: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true,
    comment: '菜单显示'
  },
  status: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: false,
    comment: '菜单状态'
  },
  icon: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'aaa',
    comment: '菜单图标'
  },
  uid: {
    type: DataTypes.UUID,
    allowNull: false,
    comment: '菜单创建者'
  },
  remark: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '菜单备注'
  },
  ctime: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '菜单创建时间',
    defaultValue: moment().format('YYYY-MM-DD HH:mm:ss')
  },
  mtime: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '菜单更新时间',
    defaultValue: moment().format('YYYY-MM-DD HH:mm:ss')
  }
}, {
  freezeTableName: true
})

module.exports = {
  Menu
}
