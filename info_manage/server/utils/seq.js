const { Sequelize } = require('sequelize')
const config = require('../config/app.config')

const conf = {
  host: config.mysql.host,
  port: config.mysql.port,
  dialect: config.mysql.dialect,
  define: {
    timestamps: false // 不自动创建createAt和updateAt时间字段
  },
  logging: sql => { // 不让sql语句在命令行终端输出
  }
}
const seq = new Sequelize(config.mysql.database, config.mysql.user, config.mysql.password, conf)
// 测试连接是否成功
// seq.authenticate().then().catch()

// 根据 model 自动创建表
seq
  .sync({
    alter: true, // alter：为true时更新表字段
    force: false // force:为true时强制删除表
  })
  .then()
  .catch()

module.exports = seq