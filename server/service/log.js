const { Log } = require('../models/Middle')
const moment = require('moment')
const { useBaiDuLocationByIp } = require('../utils/util')


// 新增
async function add (log) {
  try {
    const location = await useBaiDuLocationByIp(log.ip) // 根据ip获取城市定位
    log.client_info = {
      ip: log.ip,
      city: location.address_detail.city,
      adcode: location.address_detail.adcode,
      province: location.address_detail.province,
      rectangle: {
        x: location.point.x,
        y: location.point.y
      }
    }
  } catch (error) {
    log.client_info = {
      ip: log.ip,
      city: '',
      adcode: '',
      province: '',
      rectangle: {
        x: '',
        y: ''
      }
    }
  }
  log.ctime = moment().format('YYYY-MM-DD HH:mm:ss')
  try {
    return await Log.create(log)
  } catch (error) {
    throw error
  }
}
// 查询（分页、排序、模糊查询搜索、查询状态）
/**
 * limit 提取多少行，offset 跳过多少行
 * @param {*} page 当前页码
 * @param {*} size 每页条数
 */
async function findAll (query, uid, flag) {
  try {
    const size = query.size ? parseInt(query.size) : 10 // 如果没传参数设置一个默认值
    const page = query.page ? parseInt(query.page) : 1
    const params = {
      include: {
        all: true
      },
      where: {
      },
      offset: (page - 1) * size,
      limit: size,
      distinct: true, // 避免分页出的总数和实际数不匹配
      order: [
        [query.order ? query.order : 'ctime', query.sort ? query.sort : 'desc'] // 使用 Element 表格中的排序是互斥的，所以每次排序只能排一个元素的
      ]
    }
    if (!flag) {
      params.where.uid = uid
    }
    const { count, rows } = await Log.findAndCountAll(params)
    return {
      count,
      data: rows
    }
  } catch (error) {
    throw error
  }
}


// 删除
async function deleteById (id, uid) {
  try {
    return await Log.destroy({
      where: {
        id,
        uid
      }
    })
  } catch (error) {
    throw error
  }
}

module.exports = {
  add,
  findAll,
  deleteById
}