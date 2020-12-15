const { Sequelize, DataTypes } = require('sequelize')
const moment = require('moment')
const seq = require('../utils/seq')

// System 模型
const SystemModel = seq.define('system', {
  id: {
    type: DataTypes.UUID,
    allowNull: false,
    primaryKey: true,
    defaultValue: Sequelize.UUIDV4,
    comment: 'uuid'
  },
  sitename: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'Xpi项目接口管理系统',
    comment: '系统名称：用来设置title'
  },
  domain: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'http://blog.itchenliang.club/',
    comment: '系统域名：不能为空，需要进行格式校验'
  },
  logo: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'http://www.chenliang0829.cn:8081/public/images/logo1.png',
    comment: '系统logo：不能为空，需要进行格式校验'
  },
  ico: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'http://www.chenliang0829.cn:8081/public/images/favicon.ico',
    comment: '系统ico：不能为空，需要进行格式校验(选择本地文件上传或者url)'
  },
  notice: {
    type: DataTypes.TEXT,
    allowNull: true,
    defaultValue: '不得在公共空间吸烟',
    comment: '系统公告'
  },
  copyright: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'Copyright © 2019-2020 itchenliang.club',
    comment: '系统版权'
  },
  beian: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: '蜀ICP备19023554号-1',
    comment: '系统备案号'
  },
  email: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'itchenliang@163.com',
    comment: '系统邮箱'
  },
  qq: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: '1825956830',
    comment: '联系QQ'
  },
  keywords: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '关键字，用于搜索引擎优化'
  },
  description: {
    type: DataTypes.STRING,
    allowNull: true,
    comment: '系统描述'
  },
  filetype: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: '.*',
    comment: '文件类型'
  },
  filelimit: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 10240,
    comment: '最大文件上传'
  },
  code: {
    type: DataTypes.TEXT,
    allowNull: true,
    comment: '统计代码'
  },
  note: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true,
    comment: '是否开启便签功能 1：开启，0：关闭'
  },
  iconprefix: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: 'xapi',
    comment: '图标前缀'
  },
  iconurl: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: '//at.alicdn.com/t/font_2246210_adlq9vrj0x7.css',
    comment: '图标样式url'
  },
  updatetime: {
    type: DataTypes.STRING,
    allowNull: false,
    defaultValue: moment().format('YYYY-MM-DD HH:mm:ss'),
    comment: '更新时间'
  }
}, {
  freezeTableName: true
})

module.exports = {
  SystemModel
}
