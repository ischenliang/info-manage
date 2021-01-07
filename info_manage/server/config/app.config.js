module.exports = {
  port: 3000, // 端口号
  secret: 'a1b2c3', // jwt加密密钥
  expiresIn: 60 * 60 * 24, // 24小时 或者可以使用 1h == 60 * 60
  mysql: {
    host: '127.0.0.1',
    port: '3306',
    dialect: 'mysql',
    database: 'info',
    user: 'root',
    password: '100259'
  }
}