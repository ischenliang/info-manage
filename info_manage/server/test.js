// const fs = require('fs')
const fs = require('fs-extra')
const path = require('path')

try {
  // 文件/目录移动
  // fs.renameSync(path.join(__dirname, '/public/style.css'), path.join(__dirname, '/resource/aaa/style.css'))

  // 文件/目录复制
  // fs.copyFileSync(path.join(__dirname, '/public/test'), path.join(__dirname, '/resource/aaa'))

  // fs-extra
  // 复制文件/目录
  // fs.copySync(path.join(__dirname, '/public/test'), path.join(__dirname, '/resource/aaa'))
  fs.removeSync(path.join(__dirname, '/public/test'))
} catch (error) {
  console.log(error) 
}

