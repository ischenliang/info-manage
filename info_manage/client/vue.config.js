module.exports = {
  // 配置webapck
  configureWebpack: {
    resolve: {
      // 配置路径解析时的别名
      alias: { // @指向src的绝对路径
        views: '@/views/',
        components: '@/components/',
        assets: '@/assets'
      }
    },
    externals: '/static'
  },
  transpileDependencies: [
    'element-ui'
  ],
  publicPath: process.env.NODE_ENV === 'production' ? '/' : '/'
}
