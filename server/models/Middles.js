/**
 * 用于定义关联关系的
 *  查看：https://www.sequelize.com.cn/core-concepts/assocs
*/
const { RoleModel } = require('./Role')
const { PermissionModel } = require('./Permission')
const { MenuModel } = require('./Menu')
const { IconModel } = require('./Icon')
RoleModel.belongsToMany(PermissionModel, { through: 'role_permission', as:'rp' })
PermissionModel.belongsToMany(RoleModel, { through: 'role_permission', as:'rp' })

RoleModel.belongsToMany(MenuModel, { through: 'role_menu', as: 'rm' })
MenuModel.belongsToMany(RoleModel, { through: 'role_menu', as:'rm' })

// icon表和menu进行关联
MenuModel.belongsToMany(IconModel, { through: 'menu_icon', as:'mi' })
IconModel.belongsToMany(MenuModel, { through: 'menu_icon', as:'mi' })

// 自连接查询
MenuModel.hasMany(MenuModel, { as: 'children', foreignKey: 'pid', through: null })