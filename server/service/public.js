const { User, Role, Crypto } = require('../models/Middle')
const { MD5 } = require('../utils/util')
const token = require('jsonwebtoken')
const appConfig = require('../config/app.config')
const sequelize = require('../utils/seq')
const fse = require('fs-extra')
const path = require('path')
const { pki } = require('node-forge')
const { decodeData, decodeBase64 } = require('../utils/crypto')

/**
 * 登录: 需要传输过程采用加密手段
 *  同时生成的token和用户ip进行绑定
 * @param {*} user 
 * @returns 
 */
async function login (user, req_ip) {
  try {
    const { username: username_enc, password: password_enc, label } = user
    const { error, data: password } = await decodeData(password_enc, label, req_ip)
    if (error) {
      return {
        error: error
      }
    }
    const username = decodeBase64(username_enc)
    // 3. 判断密码和用户是否存在
    const res = await User.findOne({
      where: {
        username: username,
        password: MD5(password)
      }
    })
    if (!res) {
      return {
        error: '用户名或密码错误'
      }
    }
    // 4. 更新密钥对的状态
    await Crypto.update({ is_valid: true }, { where: { label } })
    const payload = { data: res.id, req_ip: req_ip }
    return {
      user: res,
      token: token.sign(payload, appConfig.secret, { expiresIn: appConfig.expiresIn })
    }
  } catch (error) {
    throw error
  }
}

// 注册
async function register (params, req_ip) {
  try {
    const { username: username_enc, password, nickname, label } = params
    const username = decodeBase64(username_enc)
    // 1. 判断用户名是否存在
    const res = await User.findOne({ where: { username: username } })
    if (res) {
      return {
        error: {
          code: 500,
          msg: '该用户名已被占用！',
          data: '该用户名已被占用！'
        }
      }
    }
    // 2. 查询guest角色
    const role = await Role.findOne({ where: { name: 'guest' } })
    if (!role) {
      return {
        error: {
          code: 500,
          msg: 'guest角色不存在，请联系管理员创建guest角色！',
          data: 'guest角色不存在，请联系管理员创建guest角色！'
        }
      }
    }
    // 3. 对加密内容解密
    const { error, data: password_dec } = await decodeData(password, label, req_ip)
    if (error) {
      return {
        code: 500,
        msg: error,
        data: error
      }
    }
    // 4. 创建用户
    const user = await User.create({
      username: username,
      password: MD5(password_dec),
      nickname: nickname,
      avatar: 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif?imageView2/1/w/80/h/80'
    })
    // 批量插入user_role
    await sequelize.query(`insert into user_role (userId, roleId) values('${user.id}', '${role.id}')`)
    // 然后创建用户独立空间: 即文件目录
    const dir = path.join(__dirname, '../resource', user.id)
    fse.mkdirpSync(dir)
    return {
      data: {
        code: 200,
        msg: '账号注册成功！',
        data: '账号注册成功！'
      },
      user
    }
  } catch (error) {
    throw error
  }
}


function generateRandom(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min)
}

// 生成密钥对：公钥和私钥
async function generateCryptoKey(req_ip) {
  const bits = 1024, type = 'RSA-OAEP'
  // 1. 生成密钥对
  const keypair = pki.rsa.generateKeyPair({ bits: bits, workers: 2 })
  const publicKey = pki.publicKeyToRSAPublicKeyPem(keypair.publicKey, 72).replace(/\r/g, '')
  const privateKey = pki.privateKeyToPem(keypair.privateKey, 72).replace(/\r/g, '')
  const label = `${Date.now()}${generateRandom(100000, 10000)}`
  // 2. 保存到数据库
  await Crypto.create({
    public_key: publicKey,
    private_key: privateKey,
    label: label,
    type: type,
    bits: bits,
    generate_ip: req_ip,
    is_valid: false
  })
  return {
    public_key: publicKey,
    label: label
  }
}


module.exports =  {
  login,
  register,
  generateCryptoKey
}