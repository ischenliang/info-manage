const { RoleModel } = require('../models/Role')
const { Test1Model, Test2Model } = require('../models/Test1')
const { Op } = require("sequelize")
const moment = require('moment')

// 新增
async function add (role) {
  try {
    return await RoleModel.create(role)
  } catch (error) {
    throw error
  }
}

// 删除
/**
 * @param {*} id 
 * 此时需要级联删除：删除所关联的数据
 * 关联的表：RolePermission、UserRole、RoleMenu
 * 此处：就不做删除，为了避免删除时将用户也该删除了
 */
async function deleteById (id) {
  try {
    return await RoleModel.destroy({
      where: {
        id
      }
    })
  } catch (error) {
    throw error
  }
}

// 更新
async function update (role) {
  try {
    return await RoleModel.update({
      name: role.name,
      description: role.description,
      updatetime: moment().format('YYYY-MM-DD HH:mm:ss'),
      status: role.status
    },{
      where: {
        id: role.id
      }
    })
  } catch (error) {
    throw error
  }
}

// 详情
async function detail (id) {
  try {
    const role = await RoleModel.findOne({
      where: {
        id
      }
    })
    return Object.assign(role, { menu: [] }, { permission: [] })
  } catch (error) {
    throw error
  }
}

// 列表
async function list () {
  try {
    return await Test1Model.findAll({
      include: {
        model: Test2Model,
        as: 'Test1Test2',
        attributes: ["id", "name"],
        through: { attributes: [] } // 隐藏中间表字段
      }
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
  list
}