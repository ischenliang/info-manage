const router = require('koa-router')()
router.prefix('/api/permission')
const { add, deleteById, update, detail, findAll } = require('../service/PermissionService')


// 新增权限
router.post('/add', async(ctx, next) => {
  try {
    ctx.body = await add(ctx.request.body)
  } catch (error) {
    throw error
  }
})

// 删除权限
router.delete('/delete/:id', async(ctx, next) => {
  try {
    ctx.body = await deleteById(ctx.request.params.id)
  } catch (error) {
    throw error
  }
})

// 更新权限
router.put('/update', async(ctx, next) => {
  try {
    ctx.body = await update(ctx.request.body)
  } catch (error) {
    throw error
  }
})

// 更新权限
router.get('/detail/:id', async(ctx, next) => {
  try {
    ctx.body = await detail(ctx.request.params.id)
  } catch (error) {
    throw error
  }
})

// 权限列表
/**
 * query参数：
 *  type: 权限类型(get/post/put/delete)
 *  page: 当前所在页
 *  size: 每页显示数量
 *  order: 排序方式(asc/desc)
 *  sort: 排序字段
 *  start: 开始时间
 *  end: 结束时间
 *  basename: 权限basename(权限管理/用户管理/角色管理)
*/
router.get('/list', async(ctx, next) => {
  try {
    ctx.body = await findAll(ctx.request.query)
  } catch (error) {
    throw error
  }
})

module.exports = router