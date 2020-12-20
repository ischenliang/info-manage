const { IconModel } = require('../models/Icon')
const { MenuModel } = require('../models/Menu')
const { Op } = require("sequelize")
const moment = require('moment')

// 图标新增
async function add (icon) {
  try {
    return await IconModel.create(icon)
  } catch (error) {
    throw error
  }
}

// 图标删除：删除时需要将关联到的地方都删除/清空
async function deleteById (id) {
  try {
    // 清空菜单标的icon
    const menus = await MenuModel.findAll({
      where: {
        icon: id
      }
    })
    menus.forEach(item => {
      MenuModel.update({
        icon: null // 此处必须设为null，否则会报错
      },{
        where: {
          id: item.id
        }
      })
    })
    // 删除icon
    return await IconModel.destroy({
      where: {
        id
      }
    })
  } catch (error) {
    throw error
  }
}

// 更新图标
async function update (icon) {
  try {
    return await IconModel.update({
      name: icon.name,
      code: icon.code,
      updatetime: moment().format('YYYY-MM-DD HH:mm:ss')
    },{
      where: {
        id: icon.id
      }
    })
  } catch (error) {
    throw error
  }
}

/**
 * 图标详情
 * @param {*} id 
 */
async function detail (id) {
  try {
    return await IconModel.findOne({
      where: {
        id
      }
    })
  } catch (error) {
    throw error
  }
}

/**
 * 图标列表
 * query参数：
 *  page: 页码
 *  size: 每页显示数量
 *  search: 搜索条件
*/
async function list (query) {
  try {
    return {
      total: (await IconModel.findAll({
        where: {
          [Op.or]: [
            { name:  { [Op.like]: query.search ? `%${query.search}%` :　'%%' } },
            { code:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
            { updatetime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
          ]
        }
      })).length,
      data: await IconModel.findAll({
        where: {
          [Op.or]: [
            { name:  { [Op.like]: query.search ? `%${query.search}%` :　'%%' } },
            { code:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
            { updatetime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
          ]
        },
        order: [
          [query.sort ? query.sort : 'id', query.order ? query.order : 'desc']
        ],
        limit: query.size ? parseInt(query.size) : 10,
        offset: query.page ? (parseInt(query.page) - 1) * limit : 0
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