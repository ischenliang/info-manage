const { UserModel } = require('../models/User')
const { Op } = require("sequelize")
const moment = require('moment')

// 新增用户/注册
async function add (user) {
  try {
    return await UserModel.create(user)
  } catch (error) {
    throw error
  }
}


module.exports =  {
  add
}