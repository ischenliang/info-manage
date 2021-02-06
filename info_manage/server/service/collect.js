const { CollectType, Collect } = require('../models/Middle')
const { Op } = require("sequelize")
const sequelize = require('../utils/seq')
const moment = require('moment')
const { model } = require('../utils/seq')

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
async function update (collect, uid) {
  try {
    collect.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
    return await Collect.update(collect, {
      where: {
        id: collect.id,
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
    return await Collect.findOne({
      where: {
        id,
        uid
      },
      include: [
        {
          model: CollectType
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
 */
async function list (query, uid) {
  try {
    const limit = query.size ? parseInt(query.size) : 10
    const { count, rows } = await Collect.findAndCountAll({
      where: {
        [Op.or]: [
          { name:  { [Op.like]: query.search ? `%${query.search}%` :　'%%' } },
          { remark:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { ctime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { mtime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
        ],
        uid
      },
      order: [
        [query.sort ? query.sort : 'ctime', query.order ? query.order : 'desc']
      ],
      limit: limit,
      offset: query.page ? (parseInt(query.page) - 1) * limit : 0,
      include: {
        model: CollectType,
        where: {
          name: {
            [Op.like]: query.type ? `%${query.type}%` : '%%'
          }
        }
      }
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