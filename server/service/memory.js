const { Memory } = require('../models/Middle')
const { Op } = require("sequelize")
const sequelize = require('../utils/seq')
const moment = require('moment')

// 新增
async function add (memory) {
  memory.ctime = moment().format('YYYY-MM-DD HH:mm:ss')
  memory.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
  try {
    return await Memory.create(memory)
  } catch (error) {
    throw error
  }
}

/**
 * 删除
 * @param {*} id
 */
async function deleteById (id, uid) {
  try {
    return await Memory.destroy({
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
async function update (memory, uid) {
  try {
    memory.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
    return await Memory.update(memory, {
      where: {
        id: memory.id,
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
    return await Memory.findOne({
      attributes: ['id', 'name', 'content', 'priority', 'tag', 'type', 'text'],
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
 *  start：开始时间
 *  end：结束时间
 */
async function list (query, uid) {
  try {
    const limit = query.size ? parseInt(query.size) : 10
    const { count, rows } = await Memory.findAndCountAll({
      where: {
        [Op.or]: [
          { name:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { content:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { text:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { tag:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { ctime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { mtime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
        ],
        mtime: {
          [Op.between]: [
            query.start ? query.start : await Memory.min('mtime', { where: { uid } }),
            query.end ? query.end : await Memory.max('mtime', { where: { uid } })
          ]
        },
        uid
      },
      order: [
        ['priority', 'asc'],
        [query.sort ? query.sort : 'mtime', query.order ? query.order : 'desc']
      ],
      limit: limit,
      offset: query.page ? (parseInt(query.page) - 1) * limit : 0,
      attributes: ['id', 'name', 'tag', 'type', 'priority', 'tag', 'ctime', 'mtime']
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