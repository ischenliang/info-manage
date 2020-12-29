const { SystemModel } = require('../models/System')
const { Op } = require("sequelize")
const moment = require('moment')


// 系统详情
async function detail () {
  try {
    return await SystemModel.findOne()
  } catch (error) {
    throw error
  }
}

module.exports =  {
  detail
}