const Crypto = require("../models/Crypto")
const { pki, util, md } = require('node-forge')
const { CRYPTO_PADDING } = require('../global.config')

async function decodeData (data, label, req_ip) {
  // 1. 获取label对应的私钥和秘钥对
  const crypto = await Crypto.findOne({ where: { label: label }, raw: true })
  if (crypto) {
    if (crypto.is_valid || crypto.generate_ip !== req_ip) {
      return {
        error: '该公钥已失效，请重试！'
      }
    }
    // 2. 对传输的内容进行解密(username：base64，password：RSA-OAEP)
    const { private_key } = crypto
    // 处理解密
    const privateKey = pki.privateKeyFromPem(private_key)
    const password_dec = privateKey.decrypt(util.decode64(data), 'RSA-OAEP', {
      md: md.sha256.create()
    })
    return {
      data: password_dec
    }
  }
  return { error: '该加密公钥不存在！' }
}

function decodeBase64 (data) {
  const { prefix, suffix } = CRYPTO_PADDING
  // username base64解码
  const data_dec = util.decode64(data)
  // username替换前后缀
  const result = data_dec.replace(prefix, '').replace(suffix, '')
  return result
}

module.exports = {
  decodeData,
  decodeBase64
}