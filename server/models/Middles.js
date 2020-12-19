/**
 * 用于定义关联关系的
 *  查看：https://www.sequelize.com.cn/core-concepts/assocs
*/
const { RoleModel } = require('./Role')
const { PermissionModel } = require('./Permission')
RoleModel.belongsToMany(PermissionModel, { through: 'role_permission', as:'rp' })
PermissionModel.belongsToMany(RoleModel, { through: 'role_permission', as:'rp' })