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

module.exports = {
  Test1Model,
  Test2Model
}
