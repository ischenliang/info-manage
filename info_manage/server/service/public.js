const { User } = require('../models/Middle')
const { Op } = require("sequelize")
const sequelize = require('../utils/seq')
const { MD5 } = require('../utils/util')
const moment = require('moment')

// 登录
async function login (user) {
  try {
    return await User.findOne({
      where: {
        username: user.username,
        password: MD5(user.password)
      }
    })
  } catch (error) {
    throw error
  }
}


module.exports =  {
  login
}