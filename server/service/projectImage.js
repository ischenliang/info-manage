const { Project, ProjectImage } = require('../models/Middle')
const { Op } = require("sequelize")
const sequelize = require('../utils/seq')
const moment = require('moment')
const util = require('../utils/util')
const path = require('path')
const fse = require('fs-extra')

// 新增
async function add (file, obj) {
  obj.name = '临时名称'
  obj.path = '//temp'
  obj.ctime = moment().format('YYYY-MM-DD HH:mm:ss')
  obj.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
  try {
    const res = await ProjectImage.create(obj)
    const result = util.upload(path.join('/project/image'), file, res.id)
    await ProjectImage.update({
      path: result.path,
      name: result.name
    }, {
      where: {
        id: res.id
      }
    })
    return await ProjectImage.findOne({
      where: {
        id: res.id
      }
    })
  } catch (error) {
    throw error
  }
}

// 删除
/**
 * @param {*} id
 */
async function deleteById (id) {
  try {
    const res = await ProjectImage.findOne({
      where: {
        id
      }
    })
    fse.removeSync(path.join(__dirname, '../project/image', res.name))
    return await ProjectImage.destroy({
      where: {
        id
      }
    })
  } catch (error) {
    throw error
  }
}

// 修改
async function update (file, obj) {
  try {
    if (file) {
      // 这里更新文件
      util.upload(path.join('/project/image'), file, obj.id)
    }
    obj.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
    return await ProjectImage.update(obj, {
      where: {
        id: obj.id
      }
    })
  } catch (error) {
    throw error
  }
}

// 查询
async function detail (id) {
  try {
    const res = await ProjectImage.findOne({
      where: {
        id
      }
    })
    res.path = 'data:image/png;base64,' + fse.readFileSync(path.join(__dirname, '../', res.path), 'base64')
    return res
  } catch (error) {
    throw error
  }
}

/**
 * 查询列表
 * @param {*} query
 *  pid: 项目id
 *  search: 搜索 默认%%
 */
async function list (query) {
  try {
    const { count, rows } = await ProjectImage.findAndCountAll({
      where: {
        [Op.or]: [
          { name:  { [Op.like]: query.search ? `%${query.search}%` :　'%%' } },
          { path:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
        ],
        pid: query.pid
      },
      order: [
        [query.sort ? query.sort : 'mtime', query.order ? query.order : 'desc']
      ],
      raw: true
    })
    rows.forEach(item => {
      item.path = 'data:image/png;base64,' + fse.readFileSync(path.join(__dirname, '../', item.path), 'base64')
    })
    return {
      total: count,
      data: rows
    }
  } catch (error) {
    throw error
  }
}


module.exports =  {
  add,
  deleteById,
  update,
  detail,
  list
}