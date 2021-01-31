const { User, Role, Menu, Api, ApiType } = require('../models/Middle')
const { Op } = require("sequelize")
const sequelize = require('../utils/seq')
const { MD5, uploadAvatar } = require('../utils/util')
const { getMenuTree } = require('./menu')
const { getApiTree } = require('./api')
const moment = require('moment')

/**
 * 新增
 * @param {*} user 
 *  username：用户名
 *  password：登录密码
 *  remark：用户备注
 *  role: ["rid", "rid"] 用户所属角色
 *    1.登录密码加密
 *    2.新增用户
 *    3.新增用户角色
 */
async function add (user) {
  try {
    user.ctime = moment().format('YYYY-MM-DD HH:mm:ss')
    user.password = MD5(user.password)
    const res = await User.create(user)
    let values = []
    user.role.forEach(item => {
      values.push(`('${res.id}', '${item}')`)
    })
    // 批量插入user_role
    await sequelize.query(`insert into user_role (userId, roleId) values${values.join(',')}`)
    return res
  } catch (error) {
    throw error
  }
}

/**
 * 删除
 * @param {*} id
 * 删除用户：
 *  1.删除用户关联的所有表
 *    user_role、
 *  2.然后删除用户记录
 *    user
 */
async function deleteById (id) {
  try {
    // 删除用户关联的表
    await sequelize.query(`delete from user_role where userId='${id}'`)
    return await User.destroy({
      where: {
        id
      }
    })
  } catch (error) {
    throw error
  }
}

/**
 * 修改
 * @param {*} user
 * 更新用户
 *  1.更新用户角色：先删除该用户的角色，然后再重新新增
 *  2.更新用户
 */
async function update (user) {
  try {
    // 删除用户角色
    await sequelize.query(`delete from user_role where userId='${user.id}'`)
    // 再重新新增用户角色
    let values = []
    user.role.forEach(item => {
      values.push(`('${user.id}', '${item}')`)
    })
    await sequelize.query(`insert into user_role (userId, roleId) values${values.join(',')}`)
    // 更新用户
    if (user.password !== '' && user.password !== undefined && user.password !== null) {
      user.password = MD5(user.password)
    } else {
      // 删除password属性
      delete user.password
    }
    return await User.update(user,{
      where: {
        id: user.id
      }
    })
  } catch (error) {
    throw error
  }
}

/**
 * 查询详情
 * @param {*} id 
 *  id：用户id
 *  将用户信息以及用户关联角色都查询出来
 */
async function detail (id) {
  try {
    return await User.findOne({
      where: {
        id
      },
      include: [
        // 查询关联表数据
        {
          model: Role,
          as: 'ur',
          through: { attributes: [] } // 不显示中间表字段信息
        }
      ]
    })
  } catch (error) {
    throw error
  }
}

/**
 * 用户菜单
 * @param {*} id 
 */
async function userMenu (id) {
  try {
    const user = (await User.findOne({
      where: {
        id
      },
      include: [
        { // 用户角色
          model: Role,
          as: 'ur',
          through: { attributes: [] },
          include: [ // 角色菜单
            {
              model: Menu,
              as: 'rm',
              through: { attributes: [] },
              include: [
                {
                  model: Menu,
                  as: 'children',
                  include: [
                    {
                      model: Menu,
                      as: 'children'
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    })).toJSON()
    // 用户角色
    let menuIds = []
    user.ur.forEach(item => {
      item.rm.forEach(subItem => {
        menuIds.push(subItem.id)
      })
    })
    return getMenuTree(menuIds)
  } catch (error) {
    throw error
  }
}

/**
 * 用户接口
 * @param {*} id 
 */
async function userApi (id) {
  try {
    const user = (await User.findOne({
      where: {
        id
      },
      include: [
        { // 用户角色
          model: Role,
          as: 'ur',
          through: { attributes: [] },
          include: [ // 角色菜单
            {
              model: Api,
              as: 'ra',
              through: { attributes: [] },
              include: [
                {
                  model: ApiType
                }
              ]
            }
          ]
        }
      ]
    })).toJSON()
    // 用户角色
    let apiIds = []
    user.ur.forEach(item => {
      item.ra.forEach(subItem => {
        apiIds.push(subItem.id)
      })
    })
    return getApiTree(apiIds)
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
 *  status: 用户状态
 */
async function list (query) {
  try {
    const limit = query.size ? parseInt(query.size) : 10
    const { count, rows } = await User.findAndCountAll({
      where: {
        [Op.or]: [
          { username:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { nickname:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { remark:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { ctime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
        ],
        status: {
          [Op.like]: query.status ? `%${JSON.parse(query.status) ? 1 : 0}%` : '%%'
        }
      },
      order: [
        [query.sort ? query.sort : 'ctime', query.order ? query.order : 'desc']
      ],
      limit: limit,
      offset: query.page ? (parseInt(query.page) - 1) * limit : 0,
      include: [
        {
          model: Role,
          as: 'ur',
          through: { attributes: [] }
        }
      ]
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
 * 重置用户密码
 * @param {*} id 
 */
async function resetPwd (id) {
  try {
    return await User.update({
      password: MD5('111111')
    },{
      where: {
        id
      }
    })
  } catch (error) {
    throw error
  }
}

/**
 * 更新用户头像
 * @param {*} id 
 */
async function updateAvatar (origin, file, id) {
  try {
    const avatar = uploadAvatar(origin, file, id)
    return await User.update({
      avatar
    },{
      where: {
        id
      }
    })
  } catch (error) {
    throw error
  }
}

module.exports =  {
  add,
  deleteById,
  update,
  detail,
  userMenu,
  userApi,
  list,
  resetPwd,
  updateAvatar
}