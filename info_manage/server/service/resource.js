const { Resource, Account } = require('../models/Middle')
const { Op } = require("sequelize")
const sequelize = require('../utils/seq')
const util = require('../utils/util')
const moment = require('moment')
const fs = require('fs')
// 删除文件/非空文件夹/空文件夹
const rimraf = require('rimraf')
const path = require('path')
const fse = require('fs-extra')


/**
 * 新增资源
 * 还需要先判断是否传pid
 * 传入：需要单独做操作
 * 没传：执行后续步骤
 * 1. 根据用户id查找该文件夹是否存在
 *    不存在：新增一个文件夹(名称为用户id)，到第二步
 *    存在：到第二步
 * 2. 判断新增文件夹名是否存在
 *    存在：跳过
 *    不存在：则新增
 * 3. 将数据存储到数据库中
 */
async function add (resource) {
  try {
    let dir = ''
    if (resource.pid) {
      const tmp = await Resource.findOne({
        where: {
          id: resource.pid,
          uid: resource.uid
        },
        raw: true
      })
      if (tmp === null) {
        dir = path.join(__dirname, '../resource/', resource.uid, resource.name)
        resource.pid = null
      } else {
        dir = path.join(__dirname, '..', tmp.path, resource.name)
      }
      if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true })
        resource.path = dir.replace(path.join(__dirname, '..'), '')
        resource.is_dir = true
        resource.ctime = moment().format('YYYY-MM-DD HH:mm:ss')
        resource.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
        return await Resource.create(resource)
      }
      throw new Error(`${resource.name} 目录已存在`)
    } else {
      dir = path.join(__dirname, '../resource/', resource.uid, resource.name)
      // 判断文件/文件夹已存在
      // 不存在：创建目录，设置recursive: true 会按照层次依次创建目录
      if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true })
        resource.path = dir.replace(path.join(__dirname, '..'), '')
        resource.is_dir = true
        resource.ctime = moment().format('YYYY-MM-DD HH:mm:ss')
        resource.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
        return await Resource.create(resource)
      }
      throw new Error(`${resource.name} 目录已存在`)
    }
  } catch (error) {
    throw error
  }
}

/**
 * 删除数据
 * 1. 根据id查询数据信息
 */
async function deleteById (id, uid) {
  try {
    // 1. 根据id和用户id获取数据
    const resource = await Resource.findOne({
      where: {
        id,
        uid
      },
      raw: true
    })
    // 排除没有数据的时候
    if (!resource) util.sendError(404, '资源Not Found')
    // 删除本地文件数据
    // 然后删除数据库数据：包括删除当前这条数据以及所有子数据
    rimraf.sync(path.join(__dirname, '..', resource.path))
    await Resource.destroy({
      where: {
        pid: resource.id,
        uid
      }
    })
    await Resource.destroy({
      where: {
        id,
        uid
      }
    })
    return resource
  } catch (error) {
    throw error
  }
}

/**
 * 更新
 * 1. 更新本地文件
 * 2. 更新数据库数据
 */
async function update (resource, uid) {
  try {
    resource.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
    const oldPath = path.join(__dirname, '..', resource.path)
    const newPath = path.join(__dirname, '..', resource.path.substring(0, resource.path.lastIndexOf('\\')), resource.name)
    resource.path = newPath.replace(path.join(__dirname, '..'), '')
    fs.renameSync(oldPath, newPath)
    return await Resource.update(resource, {
      where: {
        id: resource.id,
        uid
      }
    })
  } catch (error) {
    throw error
  }
}

// 查询
async function detail (id, uid) {
  try {
    return await Resource.findOne({
      where: {
        id,
        uid
      }
    })
  } catch (error) {
    throw error
  }
}

/**
 * 查询列表
 * @param {*} query
 *  size: 每页显示数量 默认10
 *  page：当前所在页码 默认0
 *  sort：排序字段 默认ctime
 *  order：排序方式 默认desc
 *  search: 搜索 默认%%
 *  type: 支付/收入
 *  pay：支付方式
 *  template：是否模板
 *  start：开始时间
 *  end：结束时间
 */
async function list (query, uid) {
  try {
    const limit = query.size ? parseInt(query.size) : 10
    const pid = query.pid ? query.pid : null
    const { count, rows } = await Resource.findAndCountAll({
      where: {
        [Op.or]: [
          { name:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { path:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { ctime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } },
          { mtime:  { [Op.like]: query.search ?  `%${query.search}%` : '%%' } }
        ],
        pid,
        uid
      },
      order: [
        [query.sort ? query.sort : 'ctime', query.order ? query.order : 'desc']
      ],
      limit: limit,
      offset: query.page ? (parseInt(query.page) - 1) * limit : 0
    })
    return {
      total: count,
      data: rows
    }
  } catch (error) {
    throw error
  }
}

/**
 * 移动到
 * 原理：实际上和文件重名是一样的道理，所以就是用文件重名方法实现文件移动
 * id：移动到指定的文件/文件夹
 * filelist：需要移动的文件/文件夹 []
 */
async function move (id, filelist, uid) {
  try {
    // 需要移动的文件列表
    const list = await Resource.findAll({
      where: {
        id: {
          [Op.in]: filelist
        },
        uid
      },
      raw: true
    })
    const target = await Resource.findOne({
      where: {
        id,
        uid
      },
      raw: true
    })
    // target.path：newPath
    // item.path：oldPath
    list.forEach(async item => {
      // 移动
      const oldPath = path.join(__dirname, '..', item.path)
      const newPath = path.join(__dirname, '..', target.path, item.name)
      fs.renameSync(oldPath, newPath)
      // 更新数据库
      item.path = newPath.replace(path.join(__dirname, '..'), '')
      item.pid = id
      item.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
      await Resource.update(item, {
        where: {
          id: item.id,
          uid
        }
      })
    })
    return await Resource.findAll({
      where: {
        id: {
          [Op.in]: filelist
        },
        uid
      }
    })
  } catch (error) {
    throw error
  }
}

/**
 * 复制到
 * 将指定文件/文件夹复制到指定目录
 * 1. 复制文件
 * id：移动到指定的文件/文件夹
 * filelist：需要移动的文件/文件夹 []
 * 2. 数据库新增数据
 */
async function copy (id, filelist, uid) {
  // 需要移动的文件列表
  const list = await Resource.findAll({
    where: {
      id: {
        [Op.in]: filelist
      },
      uid
    },
    raw: true
  })
  const target = await Resource.findOne({
    where: {
      id,
      uid
    },
    raw: true
  })
  list.forEach(async item => {
    // item：当前需要复制的元素
    // id：当前需要移动到的父级id
    // path：当前需要移动到的父级位置
    await recursion(item, target.id, target.path)
    // 新增数据：需要判断嵌套的数据
  })
  return list
}
/**
 * @param {*} data 数据
 * @param {*} pid 上级目录id
 * @param {*} ppath 上级目录位置
 * 思路：
 *  1. 创建第一层数据
 *  2. 更具查询pid为当前这项id的数据
 *  3. 判断查询的数据是否有
 *    有：遍历递归
 *    无：
 */
async function recursion (data, pid, ppath) {
  // 先复制第一层同时数据库里创建数据
  const oldResource = JSON.parse(JSON.stringify(data))
  const newResource = await setResource(data, pid, ppath)
  fse.copySync(path.join(__dirname, '..', oldResource.path), path.join(__dirname, '..', newResource.path))
  const list = await Resource.findAll({
    where: {
      pid: oldResource.id
    },
    raw: true
  })
  if (list.length) {
    list.forEach(async item => {
      const oldPath = path.join(__dirname, '..', item.path)
      const newPath = path.join(__dirname, '..', newResource.path, item.name)
      fse.copySync(oldPath, newPath)
      // 是目录，重新递归
      if (item.is_dir === 1) {
        recursion(item, newResource.id, newResource.path)
      } else {
        // 不是目录创建目录
        await setResource(item, newResource.id, newResource.path)
      }
    })
  }
}
// 递归复制
async function setResource (resource, pid, ppath) {
  delete resource.id
  resource.pid = pid
  resource.path = ppath + '\\' + resource.name
  resource.ctime = moment().format('YYYY-MM-DD HH:mm:ss')
  resource.mtime = moment().format('YYYY-MM-DD HH:mm:ss')
  const newResource =  await Resource.create(resource)
  return await Resource.findOne({
    where: {
      id: newResource.id
    },
    raw: true
  })
}

// 文件上传
async function upload (files, pid, uid) {
  const parent = await Resource.findOne({
    where: {
      id: pid,
      uid
    },
    raw: true
  })
  files.forEach(item => {
    console.log(util.upload(parent.path, item))
  })
  return 'asdasd'
}


module.exports =  {
  add,
  deleteById,
  update,
  detail,
  list,
  move,
  copy,
  upload
}