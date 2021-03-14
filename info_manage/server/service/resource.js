const util = require('../utils/util')
const moment = require('moment')
const path = require('path')
const fs = require('fs')
const fse = require('fs-extra')


/**
 * 新增资源:新增文件夹
 * 路径: path -> 上级目录
 * item: 需要新建的文件名
 * mkdirpSync()：目录存在也会创建成功
 * mkdirSync()：目录存在则报：EEXIST: file already exists, mkdir '指定目录'
 */
async function add (parent, item, uid) {
  try {
    const dir = path.join(__dirname, '../resource', uid, parent, item)
    fse.mkdirpSync(dir)
    const info = fs.statSync(dir)
    return {
      name: item,
      type: info.isDirectory() ? 'folder' : 'file',
      size: info.size,
      path: path.join('/', parent, item),
      extension: '',
      ctime: moment(info.ctimeMs).format('YYYY-MM-DD HH:mm:ss'),
      mtime: moment(info.mtimeMs).format('YYYY-MM-DD HH:mm:ss')
    }
  } catch (error) {
    throw error
  }
}

/**
 * 删除数据
 */
async function deleteById (parent, uid) {
  try {
    fse.removeSync(path.join(__dirname, '../resource', uid, parent))
    return '删除成功'
  } catch (error) {
    throw error
  }
}

/**
 * 更新文件
 */
async function update (parent, item, uid) {
  try {
    const oldPath = path.join(__dirname, '../resource', uid, parent)
    const newPath = path.join(__dirname, '../resource', uid, parent.substring(0, parent.lastIndexOf('/')), item)
    fse.renameSync(oldPath, newPath)
    const suffix = item.split('.')
    const info = fs.statSync(newPath)
    return {
      name: item,
      type: info.isDirectory() ? 'folder' : 'file',
      size: info.size,
      path: path.join('/', parent.substring(0, parent.lastIndexOf('/')), item),
      extension: suffix.length > 0 ? suffix.pop() : '',
      ctime: moment(info.ctimeMs).format('YYYY-MM-DD HH:mm:ss'),
      mtime: moment(info.mtimeMs).format('YYYY-MM-DD HH:mm:ss')
    }
  } catch (error) {
    throw error
  }
}

// 查询
async function detail (parent, uid) {
  try {
    const info = fs.statSync(path.join(__dirname, '../resource', uid, parent))
    const suffix = parent.substring(parent.lastIndexOf('/') + 1).split('.')
    return {
      name: parent.substring(parent.lastIndexOf('/') + 1),
      type: info.isDirectory() ? 'folder' : 'file',
      size: info.size,
      path: path.join('/', parent),
      extension: suffix.length > 1 ? suffix.pop() : '',
      ctime: moment(info.ctimeMs).format('YYYY-MM-DD HH:mm:ss'),
      mtime: moment(info.mtimeMs).format('YYYY-MM-DD HH:mm:ss')
    }
  } catch (error) {
    throw error
  }
}

/**
 * 查询列表
 * @param {*} query
 */
async function list (parent, uid) {
  try {
    const files = fse.readdirSync(path.join(__dirname, '../resource', uid, parent))
    const res = []
    files.forEach(item => {
      const info = fse.statSync(path.join(__dirname, '../resource', uid, parent, item))
      const suffix = item.split('.')
      res.push({
        name: item,
        type: info.isDirectory() ? 'folder' : 'file',
        size: info.size,
        path: (path.join('/', parent, item)).replace(/\\/g, '/'),
        extension: suffix.length > 1 ? suffix.pop() : '',
        ctime: moment(info.ctimeMs).format('YYYY-MM-DD HH:mm:ss'),
        mtime: moment(info.mtimeMs).format('YYYY-MM-DD HH:mm:ss')
      })
    })
    return res
  } catch (error) {
    throw error
  }
}

/**
 * 文件移动
 */
async function move (targetPath, filePaths, uid) {
  try {
    const res = []
    filePaths.forEach(item => {
      const oldPath = path.join(__dirname, '../resource', uid, item)
      const newPath = path.join(__dirname, '../resource', uid, targetPath, item.substring(item.lastIndexOf('/')))
      fse.moveSync(oldPath, newPath)
      const info = fse.statSync(newPath)
      const suffix = item.split('.')
      res.push({
        name: item.substring(item.lastIndexOf('/') + 1),
        type: info.isDirectory() ? 'folder' : 'file',
        size: info.size,
        path: path.join('/', targetPath, item.substring(item.lastIndexOf('/'))),
        extension: suffix.length > 1 ? suffix.pop() : '',
        ctime: moment(info.ctimeMs).format('YYYY-MM-DD HH:mm:ss'),
        mtime: moment(info.mtimeMs).format('YYYY-MM-DD HH:mm:ss')
      })
    })
    return res
  } catch (error) {
    throw error
  }
}

/**
 * 文件复制
 */
async function copy (targetPath, filelist, uid) {
  try {
    const res = []
    filelist.forEach(item => {
      const oldPath = path.join(__dirname, '../resource', uid, item)
      const newPath = path.join(__dirname, '../resource', uid, targetPath, item.substring(item.lastIndexOf('/')))
      fse.copySync(oldPath, newPath)
      const info = fse.statSync(newPath)
      const suffix = item.split('.')
      res.push({
        name: item.substring(item.lastIndexOf('/') + 1),
        type: info.isDirectory() ? 'folder' : 'file',
        size: info.size,
        path: path.join('/', targetPath, item.substring(item.lastIndexOf('/'))),
        extension: suffix.length > 1 ? suffix.pop() : '',
        ctime: moment(info.ctimeMs).format('YYYY-MM-DD HH:mm:ss'),
        mtime: moment(info.mtimeMs).format('YYYY-MM-DD HH:mm:ss')
      })
    })
    return res
  } catch (error) {
    throw error
  }
}

// 文件上传
async function upload (files, parent, uid) {
  try {
    // 需要判断是否上传的多个文件
    if (files.length) {
      const res = []
      files.forEach(item => {
        util.upload(path.join('/resource', uid, parent), item)
      })
    } else {
      util.upload(path.join('/resource', uid, parent), files)
    }
    return '上传成功'
  } catch (error) {
    throw error
  }
}

// 文件下载
async function download (targetPath, uid) {

}

module.exports =  {
  add,
  deleteById,
  update,
  detail,
  list,
  move,
  copy,
  upload,
  download 
}