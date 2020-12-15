const path = require('path');
const log4js = require('koa-log4');

// 参考：https://www.cnblogs.com/Joans/p/9647601.html
log4js.configure({
  appenders: {
    access: {
      type: 'file',
      encoding: 'utf-8',
      filename: path.join('logs/', 'access.log') //生成文件名
    },
    application: {
      type: 'file',
      encoding: 'utf-8',
      filename: path.join('logs/', 'application.log')
    },
    out: {
      type: 'console'
    }
  },
  categories: {
    default: { appenders: [ 'out' ], level: 'info' },
    access: { appenders: [ 'access' ], level: 'info' },
    application: { appenders: [ 'application' ], level: 'info'}
  }
});

exports.accessLogger = () => log4js.koaLogger(log4js.getLogger('access')); //记录所有访问级别的日志
exports.logger = log4js.getLogger('application');  //记录所有应用级别的日志