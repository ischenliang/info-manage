const User = require('./User')
const Role = require('./Role')

// 用户角色表
User.belongsToMany(Role, { through: 'user_role', as:'ur' })
Role.belongsToMany(User, { through: 'user_role', as:'ur' })


// 向外抛出所有的model：后续使用就只需要引入这一个 model 即可
module.exports = {
  User,
  Role
}