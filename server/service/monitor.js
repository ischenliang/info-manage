const process = require('process')
const os = require('os')

// 新增
async function node () {
  try {
    // 杀死进程(根据进程id)
    // process.kill(process.pid)
    return {
      runTime: process.uptime(), // 当前 Node.js 进程已运行的时长（以秒为单位）
      version: process.version, // Node.js 版本
      home: process.execPath, // 可执行文件的绝对路径(安装目录)
      dir: process.cwd(), // 当前工作目录
      name: process.title, // 当前进程标题
      os: process.arch, // 操作系统的 CPU 架构
      platform: process.platform, // 操作系统平台
      pid: process.pid, // 进程 ID
      port: process.debugPort, // Node.js 调试器使用的端口
      memoryUsage: process.memoryUsage() // 描述 Node.js 进程的内存使用情况（以字节为单位）
    }
  } catch (error) {
    throw error
  }
}

// 新增
async function server () {
  try {
    return {
      os: os.arch(), // 操作系统的 CPU 架构
      cpu: os.cpus(), // 逻辑 CPU 内核的信息
      endianness: os.endianness(), // 编译 Node.js 二进制文件的 CPU 的字节序,'BE' 用于大端字节序， 'LE' 用于小端字节序
      freemem: os.freemem(), // 空闲的系统内存量（以字节为单位）
      totalmem: os.totalmem(), // 系统的内存总量（以字节为单位）
      home: os.homedir(), // 用户的主目录
      hostname: os.hostname(), // 操作系统的主机名
      platform: os.platform(), // 操作系统平台
      version: os.release(), // 操作系统版本
      tmpdir: os.tmpdir(), // 操作系统临时目录
      name: os.type(), // 操作系统名字
      runTime: os.uptime(), // 系统的正常运行时间（以秒为单位）
      ip: os.networkInterfaces()['以太网'].filter(item => item.family === 'IPv4')[0].address // 分配了网络地址的网络接口
    }
  } catch (error) {
    throw error
  }
}


module.exports =  {
  server,
  node
}