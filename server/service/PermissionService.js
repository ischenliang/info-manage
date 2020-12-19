const { PermissionModel } = require('../models/Permission')
const { Op } = require("sequelize")
const moment = require('moment')

// 新增
async function add (permission) {
  try {
    return await PermissionModel.create(permission)
  } catch (error) {
    throw error
  }
}

// 删除
/**
 * @param {*} id 
 * 此时需要级联删除：删除所关联的数据
 * 关联的表：RolePermission
 */
async function deleteById (id) {
  try {
    // 删除所有关联的RolePermission
    await RolePermissionModel.destroy({
      where: { pid: id }
    })
    return await PermissionModel.destroy({
      where: {
        id
      }
    })
  } catch (error) {
    throw error
  }
}

// 更新
async function update (permission) {
  try {
    return await PermissionModel.update({
      name: permission.name,
      path: permission.path,
      type: permission.type,
      basename: permission.basename,
      updatetime: moment().format('YYYY-MM-DD HH:mm:ss')
    },{
      where: {
        id: permission.id
      }
    })
  } catch (error) {
    throw error
  }
}

// 详情
async function detail (id) {
  try {
    return await PermissionModel.findOne({
      where: {
        id: id
      }
    })
  } catch (error) {
    throw error
  }
}

// 详情
async function findAll (query) {
  const where = {}
  const order = []
  let limit = 10
  let offset = 0
  // where处理
  if (query.type) {
    where['type'] = query.type
  }
  if (query.basename) {
    where['basename'] = query.basename
  }
  if (query.search) {
    where['name'] = {
      [Op.like]: '%' + query.search
    }
  }
  if (query.start) {
    if (query.end) {
      where['updatetime'] = {
        [Op.gte]: query.start,
        [Op.lte]: query.end
      }
    } else {
      where['updatetime'] = {
        [Op.gte]: query.start
      }
    }
  }
  // 排序处理
  if (query.sort) {
    if (query.order) {
      order.push([query.sort, query.order])
    } else {
      order.push([query.sort, 'desc'])
    }
  }
  // 分页处理
  if (query.size) {
    limit = parseInt(query.size)
  }
  if (query.page) {
    offset = (parseInt(query.page) - 1) * limit
  }
  // 返回数据
  try {
    return {
      total: (await PermissionModel.findAll({
        where,
        order: order
      })).length,
      data: await PermissionModel.findAll({
        where,
        order: order,
        limit,
        offset
      })
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
  findAll
}