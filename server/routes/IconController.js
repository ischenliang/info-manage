const router = require('koa-router')()
router.prefix('/api/icon')
const { add, deleteById, update, detail, list } = require('../service/IconService')


// 新增图标
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

// 删除图标
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

// 修改图标
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

// 获取图标详情
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


// 图标列表
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
      data: await list(ctx.request.query)
    }
  } catch (error) {
    throw error
  }
})

module.exports = router