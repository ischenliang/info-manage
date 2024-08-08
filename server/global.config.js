// 不需要认证的接口
const NOT_AUTH = ['/api/login', '/api/register', '/api/pke', '/api/test/download', '/api/resource/download', '/api/project/download', '/api/pimage/download', '/api/tool/dns', '/api/tool/baidu']
// 正则前缀
const REG_PREFIX = ['detail', 'deleteById', 'userMenu', 'userApi', 'roleApi', 'roleMenu', 'resetPwd', 'moveOrder', 'logs']

// 加密填充
const CRYPTO_PADDING = {
  prefix: 'info-',
  suffix: '-a1b2c3',
  token: 'x-custom-authorization'
}

module.exports = {
  NOT_AUTH,
  REG_PREFIX,
  CRYPTO_PADDING
}