const { Project, ProjectImage, ProjectIssue } = require('../models/Middle')
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
    return await ProjectIssue.create(obj)
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
    return await ProjectIssue.destroy({
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
    return await ProjectIssue.update(obj, {
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
    return await ProjectIssue.findOne({
      attributes: ['id', 'name', 'status', 'tag', 'priority', 'ctime', 'mtime', 'description'],
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
 *  sort：排序字段 默认ctime
 *  order：排序方式 默认desc
 *  search: 搜索 默认%%
 *  type: 类型
 *  tid: 所属模块
 */
async function list (query) {
  try {
    const { count, rows } = await ProjectIssue.findAndCountAll({
      attributes: ['id', 'name', 'status', 'tag', 'priority', 'ctime', 'mtime'],
      where: {
        [Op.or]: [
          { name:  { [Op.like]: query.search ? `%${query.search}%` :　'%%' } },
          { description:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { tag:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { ctime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { mtime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
        ],
        priority: {
          [Op.like]: query.priority ? `%${query.priority}%` : '%%'
        },
        status: {
          [Op.like]: query.status ? `%${query.status}%` : '%%'
        },
        pid: query.pid
      },
      order: [
        ['priority', 'desc'],
        [query.sort ? query.sort : 'ctime', query.order ? query.order : 'desc']
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


module.exports =  {
  add,
  deleteById,
  update,
  detail,
  list
}