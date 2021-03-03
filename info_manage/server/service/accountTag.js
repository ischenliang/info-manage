const { AccountTag } = require('../models/Middle')
const { Op, Sequelize } = require("sequelize")
const sequelize = require('../utils/seq')
const moment = require('moment')
const seq = require('../utils/seq')

/**
 * 新增
 * 1. 获取数据库中已经存在的数据
 * 2. 判断已经存在的数据是否为null
 * 3. 不为null，设置当前这项的order为已存在order + 1
 * 4. 为null，设置order为1
*/
async function add (account_tag) {
  // 获取当前用户已创建的accountTag中的order最大值
  const res = await AccountTag.max('order', { where: { uid: account_tag.uid } })
  if (res !== NaN) {
    account_tag.order = res + 1
  }
  account_tag.ctime = moment().format('YYYY-MM-DD HH:mm:ss')
  account_tag.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
  try {
    return await AccountTag.create(account_tag)
  } catch (error) {
    throw error
  }
}

/**
 * 删除
 * @param {*} id
 *  1.删除account_tag
 *    account_tag：需要注意的是需要将uid带上，否则有可能其他人删除了别人的数据
 */
async function deleteById (id, uid) {
  try {
    // 删除时需要将在他后面的顺序都更改了
    const tmp = await AccountTag.findOne({
      where: {
        id,
        uid
      },
      raw: true
    })
    // 更新，条件当前用户的数据，并且order大于当前这一项的order
    await seq.query(`
      update account_tag as a
      set a.order = a.order - 1
      where a.uid='${uid}'
      and a.order > ${tmp.order}`)
    return await AccountTag.destroy({
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
async function update (account_tag, uid) {
  try {
    account_tag.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
    return await AccountTag.update(account_tag, {
      where: {
        id: account_tag.id,
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
    return await AccountTag.findOne({
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
 *  type: 类别
 */
async function list (query, uid) {
  try {
    const limit = query.size ? parseInt(query.size) : 10
    const { count, rows } = await AccountTag.findAndCountAll({
      where: {
        [Op.or]: [
          { name:  { [Op.like]: query.search ? `%${query.search}%` :　'%%' } },
          { icon:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { ctime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { mtime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
        ],
        uid,
        type: {
          [Op.like]: query.type ? `%${JSON.parse(query.type) ? 1 : 0}%` : '%%'
        }
      },
      order: [
        [query.sort ? query.sort : 'order', query.order ? query.order : 'asc']
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

/**
 * 上下移动
 * @param {*} id 
 * @param {*} uid 
 * @param {*} option
 * option:
 *  up：上移，需要将当前项和当前项的前一项的order互换，需要判断当前项是否是第一项
 *    current.order === 1 ? 第一项 : 其他项
 *  down：下移，需要将当前项和当前项的后一项的order互换，需要判断当前项是否是最后一项
 *    current.order === max ? 最后一项 : 其他项
 */
async function move (id, uid, option) {
  try {
    const current = await AccountTag.findOne({ where: {id, uid}, raw: true })
    const max = await AccountTag.max('order', { where: { uid } })
    switch(option) {
      case 'up':
        if (current.order > 1) {
          const prev = await AccountTag.findOne({ where: {order: current.order - 1, uid}, raw: true })
          // 更新当前项
          await AccountTag.update({
            order: prev.order
          }, {
            where: {
              id,
              uid
            }
          })
          // 更新前一项
          await AccountTag.update({
            order: current.order
          }, {
            where: {
              id: prev.id,
              uid
            }
          })
        }
        break
      case 'down':
        if (current.order < max) {
          const next = await AccountTag.findOne({ where: {order: current.order + 1, uid}, raw: true })
          // 更新当前项
          await AccountTag.update({
            order: next.order
          }, {
            where: {
              id,
              uid
            }
          })
          // 更新后一项
          await AccountTag.update({
            order: current.order
          }, {
            where: {
              id: next.id,
              uid
            }
          })
        }
        break
    }
    return await AccountTag.findOne({ where: {id, uid} })
  } catch (error) {
    throw error
  }
}

/**
 * 重排
 * @param {*} id 
 * @param {*} uid 
 * 1. 删除数据库中已有的的数据
 *    where uid=uid
 * 2. 根据传过来的数据组织好order熟悉批量添加数据
 */
async function reset (data, uid) {
  try {
    data.forEach((item, index) => {
      item.order = index + 1
      item.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
    })
    // 批量删除
    await AccountTag.destroy({
      truncate: true,
      where: { uid }
    })
    // 批量添加
    await AccountTag.bulkCreate(data)
    // 返回数据
    return await AccountTag.findAll({
      where: { uid },
      order: [['order', 'asc']]
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
  move,
  reset
}