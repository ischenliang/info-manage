module.exports = {
  port: 3000, // 端口号
  secret: 'a1b2c3', // jwt加密密钥
  expiresIn: 60 * 60 * 24, // 60 * 60 * 24: 24小时 或者可以使用 1h == 60 * 60
  mysql: {
    host: '127.0.0.1', // 数据库ip
    port: '3306', // 数据库端口
    dialect: 'mysql', // 使用数据库类型，这里默认是mysql
    database: 'info', // 数据库名称
    user: 'root', // 数据库用户名
    password: '100259' // 数据库密码
  }
}