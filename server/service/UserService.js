const { UserModel } = require('../models/User')
const { Op } = require("sequelize")
const moment = require('moment')
/**
 * 用户管理涉及到的功能：
 *  新增用户：包括新增用户所属角色
 *  更新用户信息：包括更新用户所属角色
 *  删除用户
 *  更新密码
 *  重置密码
 *  用户列表
 *  导入用户
 *  导出用户
 *  用户详情
 */

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