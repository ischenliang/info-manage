// 瞎子啊
router.get('/download', async(ctx, next) => {
  try {
    // ctx.verifyParams({
    //   path: { type: 'string', required: true }
    // })
    // const dir = path.join(__dirname, '../tmp/test.zip')
    // ctx.attachment(dir)
    // await send(ctx, dir)

    // const dir = path.join(__dirname, '../tmp/example.zip')
    // const stream = fs.createWriteStream(dir)
    // const zip = archiver('zip', {
    //   zlib: { level: 9 }
    // })
    // zip.pipe(stream)
    // // zip.directory('../project')
    // zip.append('哈哈哈哈哈', { name: 'file.txt' })
    // await zip.finalize()
    // ctx.attachment('../tmp/example.zip')
    // await send(ctx, '../tmp/example.zip')

    // ctx.attachment('tmp/example.zip')
    // await send(ctx, 'tmp/example.zip')

    const dir = path.join(__dirname, '../tmp/example.zip')
    const stream = fs.createWriteStream(dir)
    const zip = archiver('zip', {
      zlib: { level: 9 }
    })
    zip.pipe(stream)
    // 第一个参数：文件存放的路径
    // 第二个参数：将文件输出到压缩包的那个目录下
    zip.directory('project', 'haha') // 不需要处理，会自动处理
    // zip.append('哈哈哈哈哈', { name: 'file.txt' })
    // zip.append('呵呵呵呵呵', { name: 'file2.txt' })
    await zip.finalize()
    ctx.attachment('example.zip')
    await send(ctx, '/tmp/example.zip', { root: path.join(__dirname, '..') })
  } catch (error) {
    ctx.throw(error.status, error)
  }
})