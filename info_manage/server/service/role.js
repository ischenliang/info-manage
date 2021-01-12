const { Role } = require('../models/Middle')
const { Op } = require("sequelize")
const moment = require('moment')

// 新增
async function add (role) {
  try {
    return await Role.create(role)
  } catch (error) {
    throw error
  }
}

// 删除
async function deleteById (id) {
  try {
    return await Role.destroy({
      where: {
        id
      }
    })
  } catch (error) {
    throw error
  }
}

module.exports =  {
  add,
  deleteById
}