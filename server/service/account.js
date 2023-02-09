const { Account } = require('../models/Middle')
const { Op } = require("sequelize")
const sequelize = require('../utils/seq')
const moment = require('moment')

// 新增
async function add (account) {
  account.ctime = moment().format('YYYY-MM-DD HH:mm:ss')
  account.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
  try {
    return await Account.create(account)
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
    return await Account.destroy({
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
async function update (account, uid) {
  try {
    account.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
    return await Account.update(account, {
      where: {
        id: account.id,
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
    return await Account.findOne({
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
 *  type: 支付/收入
 *  pay：支付方式
 *  template：是否模板
 *  start：开始时间
 *  end：结束时间
 */
async function list (query, uid) {
  try {
    const limit = query.size ? parseInt(query.size) : 10
    const { count, rows } = await Account.findAndCountAll({
      where: {
        [Op.or]: [
          { remark:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { ctime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { mtime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { 'tag.name':  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
        ],
        ptime: {
          [Op.between]: [
            query.start ? query.start : await Account.min('ptime', { where: { uid } }),
            query.end ? query.end : await Account.max('ptime', { where: { uid } })
          ]
        },
        pay: {
          [Op.like]: query.pay ? `%${query.pay}%` : '%%'
        },
        template: {
          [Op.like]: query.template ? `%${JSON.parse(query.template) ? 1 : 0}%` : '%%'
        },
        type: {
          [Op.like]: query.type ? `%${JSON.parse(query.type) ? 1 : 0}%` : '%%'
        },
        uid
      },
      order: [
        [query.sort ? query.sort : 'ptime', query.order ? query.order : 'desc']
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