const { User } = require('../models/Middle')
const { Op } = require("sequelize")
const sequelize = require('../utils/seq')
const { MD5 } = require('../utils/util')
const moment = require('moment')
const token = require('jsonwebtoken')
const appConfig = require('../config/app.config')

// 登录
async function login (user) {
  try {
    const res = await User.findOne({
      where: {
        username: user.username,
        password: MD5(user.password)
      }
    })
    return {
      user: res,
      token: token.sign({
        data: res.id,
      }, appConfig.secret, { expiresIn: appConfig.expiresIn })
    }
  } catch (error) {
    throw error
  }
}


module.exports =  {
  login
}