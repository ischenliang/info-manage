const path = require('path')
const fs = require('fs')
// 新增资源
// /resource/storage/{id}?path=/
async function storages (query) {
  try {
    const res = []
    const dirs = await fs.readdirSync('public/resource')
    dirs.forEach(async item => {
      console.log(await fs.statSync('public/resource/' + item))
      res.push({  })
    })
    return 0
  } catch (error) {
    throw error
  }
}


module.exports =  {
  storages
}