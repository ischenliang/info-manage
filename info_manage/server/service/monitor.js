const process = require('process')

// 新增
async function server () {
  try {
    // 杀死进程(根据进程id)
    // process.kill(process.pid)
    return {
      runTime: process.uptime(),
      version: process.version,
      home: process.execPath,
      dir: process.cwd(),
      name: process.title,
      os: process.arch,
      platform: process.platform,
      pid: process.pid, // 进程 ID
      port: process.debugPort,
      memoryUsage: process.memoryUsage()
    }
  } catch (error) {
    throw error
  }
}

module.exports =  {
  server
}