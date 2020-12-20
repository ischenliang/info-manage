const { RoleModel } = require('../models/Role')
const { MenuModel } = require('../models/Menu')
const { Op } = require("sequelize")
const moment = require('moment')
const sequelize = require('../utils/seq')
const { model } = require('../utils/seq')
const { IconModel } = require('../models/Icon')

// 菜单新增
async function add (menu) {
  try {
    return await MenuModel.create(menu)
  } catch (error) {
    throw error
  }
}

// 菜单删除：删除时需要将关联到的地方都删除
async function deleteById (id) {
  try {
    // 查看角色菜单表的数据
    const rm = await RoleModel.findAll({
      include: {
        model: MenuModel,
        as: 'rm',
        where: {
          id
        },
        through: { attributes: [] }
      }
    })
    // 遍历删除角色菜单表数据
    rm.forEach(async (item) => {
      item.rm.forEach(async sub => {
        await sequelize.query(`delete from role_menu where roleId='${item.id}' and menuId='${sub.id}'`)
      })
    })
    // 删除菜单以及菜单下的所有子菜单
    return await MenuModel.destroy({
      where: {
        [Op.or]: [
          { id: id },
          { pid: id }
        ]
      }
    })
  } catch (error) {
    throw error
  }
}

// 更新
async function update (menu) {
  try {
    return MenuModel.update({
      name: menu.name,
      url: menu.url,
      pid: menu.pid,
      component: menu.component,
      enable: menu.enable,
      visible: menu.visible,
      active: menu.active,
      order: menu.order,
      type: menu.type,
      redirect: menu.redirect,
      updatetime: moment().format('YYYY-MM-DD HH:mm:ss')
    },{
      where: {
        id: menu.id
      }
    })
  } catch (error) {
    throw error
  }
}

/**
 * 菜单详情
 * @param {*} id 
 */
async function detail (id) {
  try {
    return await MenuModel.findOne({
      where: {
        id
      },
      include: {
        model: IconModel,
        as: 'mi',
        through: { attributes: [] }
      }
    })
  } catch (error) {
    throw error
  }
}

/**
 * 菜单列表
 * query参数：
 *  page: 页码
 *  size: 每页显示数量
 *  search: 搜索条件
*/
async function list (query) {
  try {
    return {
      total: 10,
      data: []
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