const { RoleModel } = require('../models/Role')
const { MenuModel } = require('../models/Menu')
const { Op } = require("sequelize")
const moment = require('moment')
const sequelize = require('../utils/seq')
const { model, Sequelize } = require('../utils/seq')
const { IconModel } = require('../models/Icon')

// 菜单新增
async function add (menu) {
  try {
    // 先新增菜单
    const res = await MenuModel.create({
      name: menu.name,
      url: menu.url,
      pid: menu.pid,
      component: menu.component,
      enable: menu.enable === undefined ? false : menu.enable,
      visible: menu.visible === undefined ? true : menu.visible,
      active: menu.active === undefined ? '' : menu.active,
      order: menu.order === undefined ? 1 : menu.order,
      type: menu.type === undefined ? 2 : menu.type,
      redirect: menu.redirect === undefined ? '' : menu.redirect
    })
    // 再新增图标
    if (menu.icon !== null && menu.icon !== '') {
      await sequelize.query(`insert into menu_icon (menuId, iconId) values('${res.id}', '${menu.icon.id}')`)
    }
    return res
  } catch (error) {
    throw error
  }
}

// 菜单删除：删除时需要将关联到的地方都删除
async function deleteById (id) {
  try {
    // 删除role_menu下 menuId = id 的数据
    await sequelize.query(`delete from role_menu where menuId='${id}'`)
    // 删除 menu_icon下 menuId = id 的数据
    await sequelize.query(`delete from menu_icon where menuId='${id}'`)
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
    // 先更新菜单
    const res = MenuModel.update({
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
    // 然后更新menu_icon
    if (menu.icon !== null && menu.icon !== '') {
      await sequelize.query(`update menu_icon set iconId='${menu.icon.id}' where menuId='${menu.id}'`)
    }
    return res
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
 * 菜单列表:需要将嵌套层次算出来
 *  做自身关联查询
 * query参数：
 *  page: 页码
 *  size: 每页显示数量
 *  search: 搜索条件
*/
async function list (query) {
  try {
    // 获取第一层
    return {
      total: (await MenuModel.findAll({
        where: {
          pid: {
            [Op.eq]: ''
          }
        },
        include: {
          model: MenuModel,
          as: 'children',
          required: false,
          include: {
            model: IconModel,
            as: 'mi',
            nested : true,
            through: { attributes: [] }
          }
        }
      })).length,
      data: await MenuModel.findAll({
        where: {
          pid: {
            [Op.eq]: ''
          }
        },
        include: {
          model: MenuModel,
          as: 'children',
          required: false,
          include: {
            model: IconModel,
            as: 'mi',
            nested : true,
            through: { attributes: [] }
          }
        }
      })
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