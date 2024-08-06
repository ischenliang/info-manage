const { User, Role } = require('../models/Middle')
const { MD5 } = require('../utils/util')
const token = require('jsonwebtoken')
const appConfig = require('../config/app.config')
const sequelize = require('../utils/seq')
const fse = require('fs-extra')
const path = require('path')

// 登录
async function login (user) {
  try {
    const res = await User.findOne({
      where: {
        username: user.username,
        password: MD5(user.password)
      }
    })
    if (res) {
      return {
        user: res,
        token: token.sign({
          data: res.id,
        }, appConfig.secret, { expiresIn: appConfig.expiresIn })
      }
    } else {
      return null
    }
  } catch (error) {
    throw error
  }
}

// 注册
async function register (params) {
  try {
    const res = await User.findOne({
      where: {
        username: params.username
      }
    })
    if (res) {
      return {
        code: 500,
        msg: '该用户名已被占用！',
        data: '该用户名已被占用！'
      }
    }
    // 查询guest角色
    const role = await Role.findOne({ where: { name: 'guest' } })
    if (!role) {
      return {
        code: 500,
        msg: 'guest角色不存在，请联系管理员创建guest角色！',
        data: 'guest角色不存在，请联系管理员创建guest角色！'
      }
    }
    const user = await User.create({
      username: params.username,
      password: MD5(params.password),
      nickname: params.nickname,
      avatar: 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif?imageView2/1/w/80/h/80'
    })
    // 批量插入user_role
    await sequelize.query(`insert into user_role (userId, roleId) values('${user.id}', '${role.id}')`)
    // 然后创建用户独立空间: 即文件目录
    const dir = path.join(__dirname, '../resource', user.id)
    fse.mkdirpSync(dir)
    return {
      code: 200,
      msg: '账号注册成功！',
      data: '账号注册成功！'
    }
  } catch (error) {
    throw error
  }
}


module.exports =  {
  login,
  register
}