const crypto = require('crypto')
const fs = require('fs')
const path = require('path')

module.exports = {
  // md5加密
  MD5: (data) => {
    return crypto.createHash('md5').update(String(data)).digest('hex')
  },
  // 上传头像:在前端上传时先将图片裁剪....
  uploadAvatar: (origin, file, uid) => {
    // 获取文件后缀
    const suffix = file.name.split('.').pop()
    // 文件路径: 文件存放目录 + 用户名称.后缀
    let filePath = path.join(__dirname, '../public/avatar',  `${uid}.${suffix}`)
    // 创建可读流
    const render = fs.createReadStream(file.path)
    // 文件目录
    const fileDir = path.join(__dirname, '../public/avatar')
    // 判断文件目录是否存在
    if (!fs.existsSync(fileDir)) {
      // 不存在：新建
      fs.mkdirSync(fileDir, error => {
        throw error
      })
    }
    // 创建写入流
    // 参考：
    //  http://nodejs.cn/api/fs.html#fs_fs_createwritestream_path_options
    //  http://nodejs.cn/api/fs.html#fs_file_system_flags
    const upStream = fs.createWriteStream(filePath) // 默认会覆盖文件
    // 将文件写入到指定的位置
    render.pipe(upStream)
    return origin + '/avatar/' + `${uid}.${suffix}`
  },
  // 上传文件
  upload: (bpath, file) => {
    // 获取文件后缀
    const suffix = file.name.split('.').pop()
    // 文件路径: 文件存放目录 + 用户名称.后缀
    let filePath = path.join(__dirname, '..', bpath,  file.name)
    // 创建可读流
    const render = fs.createReadStream(file.path)
    // 默认会覆盖文件
    const upStream = fs.createWriteStream(filePath)
    // 将文件写入到指定的位置
    render.pipe(upStream)
    return {
      name: file.name,
      size: file.size,
      path: bpath + '\\' + file.name,
      extension: suffix
    }
  },
  // 判断文件是否存在
  exists: (path) => {
    return fs.existsSync(path.join(__dirname, '../resource/', resource.uid))
  },
  sendError (code, msg) {
    const error = new Error(msg)
    error.status = code
    throw error
  }
}