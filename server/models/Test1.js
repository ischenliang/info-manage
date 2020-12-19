const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

// Icon 模型
const Test1Model = seq.define('test1', {
  id: {
    type: DataTypes.UUID,
    allowNull: false,
    primaryKey: true,
    defaultValue: Sequelize.UUIDV4,
    comment: 'uuid'
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '哈哈哈'
  }
}, {
  freezeTableName: true
})

const Test2Model = seq.define('test2', {
  id: {
    type: DataTypes.UUID,
    allowNull: false,
    primaryKey: true,
    defaultValue: Sequelize.UUIDV4,
    comment: 'uuid'
  },
  name: {
    type: DataTypes.STRING,
    allowNull: false,
    comment: '哈哈哈'
  }
}, {
  freezeTableName: true
})

// 这样建立中间表
Test1Model.belongsToMany(Test2Model, { through: 'test1Test2', as:'Test1Test2' })
Test2Model.belongsToMany(Test1Model, { through: 'test1Test2', as:'Test1Test2' })
// 关联表查询
// async function test () {
//   const test = await Test1Model.findAll({
//     include: {
//       model: Test2Model,
//       as: 'Test1Test2' // 这个as一定要和上面的as同名
//     }
//   })
//   console.log(test)
// }
// test()

module.exports = {
  Test1Model,
  Test2Model
}
