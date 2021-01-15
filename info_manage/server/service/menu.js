const { Menu } = require('../models/Middle')
const { Op } = require("sequelize")
const sequelize = require('../utils/seq')
const moment = require('moment')

// 新增
async function add (menu) {
  try {
    return await Menu.create(menu)
  } catch (error) {
    throw error
  }
}

/**
 * 删除
 * @param {*} id
 * 删除菜单
 *  1.删除菜单关联的表记录:
 *    role_menu、
 *  2.判断菜单类型是否为目录
 *    是：删除下面的所有子菜单
 */
async function deleteById (id) {
  try {
    const menu = await Menu.findOne({ where: { id } })
    if (menu.type === 1) {
      // 删除所有的子菜单同时还需要删除role_menu表里面引用到的子菜单数据
      const children = await Menu.findAll({ where: { pid: id } })
      children.forEach(async item => {
        await sequelize.query(`delete from role_menu where menuId='${item.id}'`)
        await Menu.destroy({
          where: {
            id: item.id
          }
        })
      })
    }
    // 删除本菜单
    await sequelize.query(`delete from role_menu where menuId='${id}'`)
    return await Menu.destroy({
      where: {
        id
      }
    })
  } catch (error) {
    throw error
  }
}

// 修改
async function update (menu) {
  try {
    menu.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
    return await Menu.update(menu,{
      where: {
        id: menu.id
      }
    })
  } catch (error) {
    throw error
  }
}

// 查询
async function detail (id) {
  try {
    return await Menu.findOne({
      where: {
        id
      }
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
 *  status: 状态
 *  is_frame: 是否外链 默认 %%
 *  visible：是否可见 默认%%
 */
async function list (query) {
  try {
    const limit = query.size ? parseInt(query.size) : 10
    const { count, rows } = await Menu.findAndCountAll({
      where: {
        [Op.or]: [
          { name:  { [Op.like]: query.search ? `%${query.search}%` :　'%%' } },
          { component:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { path:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { icon:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { remark:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { ctime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { mtime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
        ],
        status: {
          [Op.like]: query.status ? `%${JSON.parse(query.status) ? 1 : 0}%` : '%%'
        },
        is_frame: {
          [Op.like]: query.is_frame ? `%${JSON.parse(query.is_frame) ? 1 : 0}%` : '%%'
        },
        visible: {
          [Op.like]: query.visible ? `%${JSON.parse(query.visible) ? 1 : 0}%` : '%%'
        },
        pid: {
          [Op.eq]: null
        }
      },
      order: [
        [query.sort ? query.sort : 'ctime', query.order ? query.order : 'desc']
      ],
      limit: limit,
      offset: query.page ? (parseInt(query.page) - 1) * limit : 0,
      // 自关联查询
      include: [
        {
          required: false,
          all: true,
          nested : true
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
 * 根据ids递归出嵌套菜单
 * @param {*} ids 
 */
async function getMenuTree (ids) {
  try {
    // 获取所有数据
    const data = await Menu.findAll({
      where: {
        id: {
          [Op.in]: ids
        }
      },
      raw: true
    })
    // 存储父节点
    let parent = []
    data.forEach(item => {
      if (item.pid === '' || item.pid === null) {
        item.children = getChildTree(item.id, data)
        parent.push(item)
      }
    })
    return parent
  } catch (error) {
    throw error
  }
}

// 获取子节点下的数据
function getChildTree (pid, data) {
  let children = []
  // 判断item.pid 是否等于 pid
  data.forEach(item => {
    if (item.pid === pid) {
      children.push(item)
    }
  })
  children.forEach(item => {
    const list = getChildTree(item.id, data)
    if (list.length !== 0) {
      item.children = list
    } else {
      item.children = []
    }
  })
  return children
}


module.exports =  {
  add,
  deleteById,
  update,
  detail,
  list,
  getMenuTree
}