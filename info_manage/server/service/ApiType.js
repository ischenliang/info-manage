const { ApiType, Api } = require('../models/Middle')
const { Op } = require("sequelize")
const sequelize = require('../utils/seq')
const moment = require('moment')

// 新增
async function add (api_type) {
  api_type.ctime = moment().format('YYYY-MM-DD HH:mm:ss')
  api_type.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
  try {
    return await ApiType.create(api_type)
  } catch (error) {
    throw error
  }
}

// 删除
/**
 * @param {*} id
 * 删除Api_type
 *  1.首先重置api中关联到的数据:
 *    api
 *  2.删除api_type
 *    api_type
 */
async function deleteById (id) {
  try {
    // 更新api
    await Api.update({
      tid: ''
    },{
      where: {
        tid: id
      }
    })
    return await ApiType.destroy({
      where: {
        id
      }
    })
  } catch (error) {
    throw error
  }
}

// 修改
async function update (api_type) {
  try {
    api_type.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
    return await ApiType.update(api_type,{
      where: {
        id: api_type.id
      }
    })
  } catch (error) {
    throw error
  }
}

// 查询
async function detail (id) {
  try {
    return await ApiType.findOne({
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
 *  status: 角色状态
 */
async function list (query) {
  try {
    const limit = query.size ? parseInt(query.size) : 10
    const { count, rows } = await ApiType.findAndCountAll({
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


module.exports =  {
  add,
  deleteById,
  update,
  detail,
  list
}