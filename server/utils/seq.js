const { Sequelize, } = require('sequelize')
const logger = require('../utils/log')
const config = require('../config/app.config')

const conf = {
  host: config.mysql.host,
  port: config.mysql.port,
  dialect: config.mysql.dialect,
  define: {
    timestamps: false
  },
  logging: sql => {
    logger.logger.info(sql)
  }
}
const seq = new Sequelize(config.mysql.database, config.mysql.user, config.mysql.password, conf)
// 测试连接是否成功
// seq.authenticate()
// .then(() => {
//   console.log('数据库连接成功')
// }).catch(() => {
//   console.log('数据库连接失败')
// })

// 根据 model 自动创建表
seq
  .sync()
  .then(() => {
    logger.logger.info('数据表创建成功')
  })
  .catch(error => {
    logger.logger.info('数据表创建失败：' + error.message)
  })
// 使用参考：https://www.cnblogs.com/amujoe/p/9983385.html
// 参考：https://www.sequelize.com.cn/core-concepts/getting-started

module.exports = seq