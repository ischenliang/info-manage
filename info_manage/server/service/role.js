const { Role, Menu } = require('../models/Middle')
const { Op, QueryTypes } = require("sequelize")
const sequelize = require('../utils/seq')
const moment = require('moment')

// 新增
async function add (role) {
  try {
    return await Role.create(role)
  } catch (error) {
    throw error
  }
}

// 删除
/**
 * @param {*} id
 * 删除角色
 *  1.删除角色关联的表记录:
 *    user_role、
 *    只需要删除关联表即可，不用将使用到该角色的用户都给删了
 *  2.删除角色
 *    role
 */
async function deleteById (id) {
  try {
    // 删除角色关联的表
    await sequelize.query(`delete from user_role where roleId='${id}'`)
    return await Role.destroy({
      where: {
        id
      }
    })
  } catch (error) {
    throw error
  }
}

// 修改
async function update (role) {
  try {
    role.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
    return await Role.update(role,{
      where: {
        id: role.id
      }
    })
  } catch (error) {
    throw error
  }
}

/**
 * 查询
 * @param {*} id 
 * 
 */
async function detail (id) {
  try {
    // 查询role_menu所有数据
    // const results = await sequelize.query(`select * from role_menu where roleId='${id}'`, { type: QueryTypes.SELECT })
    // const role = (await Role.findOne({ where: { id } })).toJSON()
    return await Role.findOne({
      where: {
        id
      },
      include: [
        {
          model: Menu,
          as: 'rm',
          required: false,
          through: { attributes: [] }
        }
      ]
    })
  } catch (error) {
    throw error
  }
}

/**
 * 查询列表
 * @param {*} query
 *  size: 每页显示数量 默认10
 *  page：当前所在页码 默认0
 *  sort：排序字段 默认ctime
 *  order：排序方式 默认desc
 *  search: 搜索 默认%%
 *  status: 角色状态
 */
async function list (query) {
  try {
    const limit = query.size ? parseInt(query.size) : 10
    const { count, rows } = await Role.findAndCountAll({
      where: {
        [Op.or]: [
          { name:  { [Op.like]: query.search ? `%${query.search}%` :　'%%' } },
          { remark:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { ctime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { mtime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
        ],
        status: {
          [Op.like]: query.status ? `%${JSON.parse(query.status) ? 1 : 0}%` : '%%'
        }
      },
      order: [
        [query.sort ? query.sort : 'ctime', query.order ? query.order : 'desc']
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

/**
 * 角色菜单授权
 * @param {*} id 角色id
 * @param {*} menuIds 菜单ids
 * 1.先清空role_menu里面roleId的数据
 * 2.重新添加role_menu
 */
async function roleMenu (id, menuIds) {
  try {
    await sequelize.query(`delete from role_menu where roleId='${id}'`)
    let values = []
    menuIds.forEach(item => {
      values.push(`('${id}', '${item}')`)
    })
    // 批量添加role_menu
    return await sequelize.query(`insert into role_menu (roleId, menuId) values${values.join(',')}`)
  } catch(error) {
    throw error
  }
}


module.exports =  {
  add,
  deleteById,
  update,
  detail,
  list,
  roleMenu
}