const { CollectType, Collect } = require('../models/Middle')
const { Op } = require("sequelize")
const sequelize = require('../utils/seq')
const moment = require('moment')

// 新增
async function add (collect) {
  collect.ctime = moment().format('YYYY-MM-DD HH:mm:ss')
  collect.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
  try {
    return await Collect.create(collect)
  } catch (error) {
    throw error
  }
}

/**
 * 删除
 * @param {*} id
 *  1.删除collect
 *    collect：需要注意的是需要将uid带上，否则有可能其他人删除了别人的数据
 */
async function deleteById (id, uid) {
  try {
    return await Collect.destroy({
      where: {
        id,
        uid
      }
    })
  } catch (error) {
    throw error
  }
}

// 修改
async function update (collect_type, uid) {
  try {
    collect_type.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
    return await CollectType.update(collect_type, {
      where: {
        id: collect_type.id,
        uid
      }
    })
  } catch (error) {
    throw error
  }
}

// 查询
async function detail (id, uid) {
  try {
    return await CollectType.findOne({
      where: {
        id,
        uid
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
async function list (query, uid) {
  try {
    const limit = query.size ? parseInt(query.size) : 10
    const { count, rows } = await CollectType.findAndCountAll({
      where: {
        [Op.or]: [
          { name:  { [Op.like]: query.search ? `%${query.search}%` :　'%%' } },
          { remark:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { ctime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { mtime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
        ],
        status: {
          [Op.like]: query.status ? `%${JSON.parse(query.status) ? 1 : 0}%` : '%%'
        },
        uid
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