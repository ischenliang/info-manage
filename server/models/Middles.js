/**
 * 用于定义关联关系的
 *  查看：https://www.sequelize.com.cn/core-concepts/assocs
*/
const { RoleModel } = require('./Role')
const { PermissionModel } = require('./Permission')
const { MenuModel } = require('./Menu')
const { IconModel } = require('./Icon')
const { UserModel } =  require('./User')
// 角色权限表
RoleModel.belongsToMany(PermissionModel, { through: 'role_permission', as:'rp' })
PermissionModel.belongsToMany(RoleModel, { through: 'role_permission', as:'rp' })

// 角色菜单表
RoleModel.belongsToMany(MenuModel, { through: 'role_menu', as: 'rm' })
MenuModel.belongsToMany(RoleModel, { through: 'role_menu', as:'rm' })

// icon表和menu进行关联
MenuModel.belongsToMany(IconModel, { through: 'menu_icon', as:'mi' })
IconModel.belongsToMany(MenuModel, { through: 'menu_icon', as:'mi' })

// 用户角色表
UserModel.belongsToMany(RoleModel, { through: 'user_role', as:'ur' })
RoleModel.belongsToMany(UserModel, { through: 'user_role', as:'ur' })

// 菜单菜单表：自连接查询
MenuModel.hasMany(MenuModel, { as: 'children', foreignKey: 'pid', through: null })