const { ApiType, Api } = require('../models/Middle')
const { Op } = require("sequelize")
const sequelize = require('../utils/seq')
const moment = require('moment')

// 新增
async function add (obj) {
  obj.ctime = moment().format('YYYY-MM-DD HH:mm:ss')
  obj.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
  try {
    return await Api.create(obj)
  } catch (error) {
    throw error
  }
}

// 删除
/**
 * @param {*} id
 * 删除Api
 *  1.首先需要删除role_api表中的数据:
 *    role_api
 *  2.删除api
 *    api
 */
async function deleteById (id) {
  try {
    // 删除role_api
    await sequelize.query(`delete from role_api where apiId='${id}'`)
    return await Api.destroy({
      where: {
        id
      }
    })
  } catch (error) {
    throw error
  }
}

// 修改
async function update (obj) {
  try {
    obj.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
    return await Api.update(obj, {
      where: {
        id: obj.id
      }
    })
  } catch (error) {
    throw error
  }
}

// 查询
async function detail (id) {
  try {
    return await Api.findOne({
      where: {
        id
      },
      include: [
        {
          model: ApiType
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
 *  type: 类型
 *  tid: 所属模块
 */
async function list (query) {
  try {
    const limit = query.size ? parseInt(query.size) : 10
    const { count, rows } = await Api.findAndCountAll({
      where: {
        [Op.or]: [
          { name:  { [Op.like]: query.search ? `%${query.search}%` :　'%%' } },
          { remark:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { path:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { ctime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { mtime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
        ],
        type: {
          [Op.like]: query.type ? `%${query.type}%` : '%%'
        },
        tid: {
          [Op.like]: query.tid ? `%${query.tid}%` : '%%'
        }
      },
      order: [
        [query.sort ? query.sort : 'ctime', query.order ? query.order : 'desc']
      ],
      limit: limit,
      offset: query.page ? (parseInt(query.page) - 1) * limit : 0,
      include: [
        {
          model: ApiType,
          required: false,
          attributes: ['name']
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
async function getApiTree (ids) {
  try {
    // 获取所有数据
    return await Api.findAll({
      where: {
        id: {
          [Op.in]: ids
        },
      },
      raw: true,
      attributes: ['perms', 'path', 'type', 'id']
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
  list,
  getApiTree
}