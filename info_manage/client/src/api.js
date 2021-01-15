/* eslint-disable no-unused-vars */
import axios from 'axios'
const http = axios.create({
  baseURL: 'http://127.0.0.1:3000/api/'
})

// 定义所有的请求
const list = {
  /**
   * 角色管理
  */
  GetRoles: { method: 'get', url: '/role/list' }
}

export default (config) => {
  return new Promise((resolve, reject) => {
    if (!list[config.name]) {
      // eslint-disable-next-line prefer-promise-reject-errors
      reject('未定义接口：' + config.name)
    }

    const { method, url } = list[config.name]
    const requestConfig = {
      method,
      url,
      headers: config.headers ? config.headers : {}
    }

    if (method === 'get' || method === 'delete') {
      requestConfig.params = config.params
    }
    if (method === 'post' || method === 'put') {
      requestConfig.data = config.params
    }

    // 处理paths参数
    if (config.paths) {
      config.paths.map(item => {
        if (item) {
          requestConfig.url += '/' + item
        } else {
          // eslint-disable-next-line prefer-promise-reject-errors
          reject('paths：参数有误')
        }
      })
    }

    // 发送请求
    http(requestConfig).then(res => {
      if (res.data) {
        if (res.data.code === 200) {
          resolve(res.data.data)
        } else {
          reject(res.data.msg)
        }
      }
    }).catch(error => {
      reject(error)
    })
  })
}
