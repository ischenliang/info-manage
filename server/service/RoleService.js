const { RoleModel } = require('../models/Role')
const { PermissionModel } = require('../models/Permission')
const { MenuModel } = require('../models/Menu')
const { Op } = require("sequelize")
const moment = require('moment')

// 新增
async function add (role) {
  try {
    return await RoleModel.create(role)
  } catch (error) {
    throw error
  }
}

// 删除
/**
 * 此时需要级联删除：删除所关联的数据
 * 关联的表：RolePermission、UserRole、RoleMenu
 * 此处：就不做删除，为了避免删除时将用户也该删除了
 */
async function deleteById (id) {
  try {
    return await RoleModel.destroy({
      where: {
        id
      }
    })
  } catch (error) {
    throw error
  }
}

// 更新
async function update (role) {
  try {
    return await RoleModel.update({
      name: role.name,
      description: role.description,
      updatetime: moment().format('YYYY-MM-DD HH:mm:ss'),
      status: role.status
    },{
      where: {
        id: role.id
      }
    })
  } catch (error) {
    throw error
  }
}

/**
 * 角色详情
 * @param {*} id 
 *  将角色、角色权限、角色菜单等都带出去
 */
async function detail (id) {
  try {
    return await RoleModel.findOne({
      where: {
        id
      },
      include: [
        {
          model: PermissionModel,
          as: 'rp',
          through: { attributes: [] }
        },
        {
          model: MenuModel,
          as: 'rm',
          through: { attributes: [] }
        }
      ],
    })
  } catch (error) {
    throw error
  }
}

/**
 * 角色列表
 * query参数：
 *  page: 页码
 *  size: 每页显示数量
 *  search: 搜索条件
*/
async function list (query) {
  try {
    const limit = query.size ? parseInt(query.size) : 10
    const { count, rows } = await RoleModel.findAndCountAll({
      where: {
        [Op.or]: [
          { name:  { [Op.like]: query.search ? `%${query.search}%` :　'%%' } },
          { description:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { updatetime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
        ]
      },
      order: [
        [query.sort ? query.sort : 'id', query.order ? query.order : 'desc']
      ],
      limit: limit,
      offset: query.page ? (parseInt(query.page) - 1) * limit : 0
    })
    return {
      total: count,
      data: rows
    }
  } catch (error) {
    throw error
  }
}

module.exports =  {
  add,
  deleteById,
  update,
  detail,
  list
}