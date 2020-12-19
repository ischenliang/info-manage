const router = require('koa-router')()
router.prefix('/api/role')
const { add, deleteById, update, detail, list } = require('../service/RoleService')


// 新增角色
router.post('/add', async(ctx, next) => {
  try {
    ctx.body = {
      code: 200,
      msg: '新增成功',
      data: await add(ctx.request.body)
    }
  } catch (error) {
    throw error
  }
})

// 删除角色
router.delete('/delete/:id', async(ctx, next) => {
  try {
    ctx.body = {
      code: 200,
      msg: '删除成功',
      data: await deleteById(ctx.request.params.id)
    }
  } catch (error) {
    throw error
  }
})

// 修改角色
router.put('/update', async(ctx, next) => {
  try {
    ctx.body = {
      code: 200,
      msg: '更新成功',
      data: await update(ctx.request.body)
    }
  } catch (error) {
    throw error
  }
})

// 获取角色详情
router.get('/detail/:id', async(ctx, next) => {
  try {
    ctx.body = {
      code: 200,
      msg: '查询成功',
      data: await detail(ctx.request.params.id)
    }
  } catch (error) {
    throw error
  }
})


// 角色列表
/**
 * query参数：
 *  page: 页码
 *  size: 每页显示数量
 *  search: 搜索条件
*/
router.get('/list', async(ctx, next) => {
  try {
    ctx.body = {
      code: 200,
      msg: '查询成功',
      data: await list()
    }
  } catch (error) {
    throw error
  }
})
// 角色菜单更新
/**
 * 实现方式：先将数据库里面的删除，然后再重新添加
 * 参数：
 *  id：角色id -> params
 *  mIds: 菜单ids -> body
*/
router.put('/updateMenu', async(ctx, next) => {
  ctx.body = '更新角色菜单'
})

// 角色权限更新
/**
 * 实现方式：先将数据库里面的删除，然后再重新添加
 * 参数：
 *  id：角色id -> params
 *  pIds: 权限ids -> body
*/
router.put('/updatePermission', async(ctx, next) => {
  ctx.body = '更新角色权限'
})


module.exports = router