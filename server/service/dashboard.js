const { Dashboard } = require('../models/Middle')
const { Op } = require("sequelize")
const sequelize = require('../utils/seq')
const moment = require('moment')
const util = require('../utils/util')
const path = require('path')
const fse = require('fs-extra')

// 新增
async function add (obj) {
  obj.ctime = moment().format('YYYY-MM-DD HH:mm:ss')
  obj.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
  try {
    return await Dashboard.create(obj)
  } catch (error) {
    throw error
  }
}

// 删除
/**
 * @param {*} id
 * 首先项目文件
 * 然后删除数据以及关联数据
 */
async function deleteById (id) {
  try {
    return await Dashboard.destroy({
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
    return await Dashboard.update(obj, {
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
    return await Dashboard.findOne({
      where: {
        id
      }
    })
  } catch (error) {
    throw error
  }
}

// 查询
async function getByIdentify (identify) {
  try {
    return await Dashboard.findOne({
      attributes: ['id', 'layout'],
      where: {
        identify
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
 *  type: 类型
 *  tid: 所属模块
 */
async function list (query, uid) {
  try {
    const limit = query.size ? parseInt(query.size) : 10
    const { count, rows } = await Dashboard.findAndCountAll({
      attributes: ['id', 'name', 'description', 'identify', 'mtime', 'ctime'],
      where: {
        [Op.or]: [
          { name:  { [Op.like]: query.search ? `%${query.search}%` :　'%%' } },
          { description:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { identify:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { layout:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { ctime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { mtime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
        ]
      },
      order: [
        [query.sort ? query.sort : 'mtime', query.order ? query.order : 'desc']
      ],
      uid,
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
  list,
  getByIdentify
}