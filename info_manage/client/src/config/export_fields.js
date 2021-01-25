/**
 * 定义导出的数据字段信息
*/
export default {
  user: {
    username: 'username',
    password: 'password',
    avatar: 'avatar',
    nickname: 'nickname',
    status: 'status',
    ctime: 'ctime',
    remark: 'remark',
    role: {
      field: 'ur',
      callback: value => {
        const role = []
        value.forEach(item => {
          role.push(item.name)
        })
        return role.join('、')
      }
    }
  },
  role: {
    name: 'name',
    remark: 'remark',
    priority: 'priority',
    status: 'status',
    ctime: 'ctime',
    mtime: 'mtime'
  }
}
