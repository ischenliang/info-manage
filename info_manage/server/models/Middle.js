const User = require('./User')
const Role = require('./Role')
const Menu = require('./Menu')
const Icon = require('./Icon')
const IconProject = require('./IconProject')
const Api = require('./Api')
const ApiType = require('./ApiType')
const Collect = require('./Collect')
const CollectType = require('./CollectType')
const Account = require('./Account')
const AccountTag = require('./AccountTag')
const Password = require('./Password')

// 用户角色表
User.belongsToMany(Role, { through: 'user_role', as:'ur' })
Role.belongsToMany(User, { through: 'user_role', as:'ur' })

// 角色菜单表
Role.belongsToMany(Menu, { through: 'role_menu', as: 'rm' })
Menu.belongsToMany(Role, { through: 'role_menu', as: 'rm' })

// 菜单与菜单自关联
Menu.hasMany(Menu, { as: 'children', foreignKey: 'pid', through: null })

// 图标项目与图标关联
IconProject.hasMany(Icon, { foreignKey: 'pid', sourceKey: 'id' })
Icon.belongsTo(IconProject, { foreignKey: 'pid', targetKey: 'id', })

// api与api_type关联
ApiType.hasMany(Api, { foreignKey: 'tid', sourceKey: 'id' })
Api.belongsTo(ApiType, { foreignKey: 'tid', sourceKey: 'id' })

// role与api表关联
Role.belongsToMany(Api, { through: 'role_api', as: 'ra' })
Api.belongsToMany(Role, { through: 'role_api', as: 'ra' })

// Collect 与 Collect_type 以及 User关联
CollectType.hasMany(Collect, { foreignKey: 'tid', sourceKey: 'id' })
Collect.belongsTo(CollectType, { foreignKey: 'tid', sourceKey: 'id' })
Collect.belongsTo(User, { foreignKey: 'uid', sourceKey: 'id' })

// Account、AccountTag 与 User关联
// 一个用户用于：多个Account和AccountTag
User.hasMany(AccountTag, { foreignKey: 'uid', sourceKey: 'id' })
User.hasMany(Account, { foreignKey: 'uid', sourceKey: 'id' })

// Password 与 User 关联
User.hasMany(Password, { foreignKey: 'uid', sourceKey: 'id' })




// 向外抛出所有的model：后续使用就只需要引入这一个 model 即可
module.exports = {
  User,
  Role,
  Menu,
  Icon,
  IconProject,
  Api,
  ApiType,
  Collect,
  CollectType,
  Account,
  AccountTag,
  Password
}