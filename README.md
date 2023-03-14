# 信息管理系统
![202303141144578.png](http://img.itchenliang.club/img/202303141144578.png)
![202303141145151.png](http://img.itchenliang.club/img/202303141145151.png)


## 概述
随着信息化时代的不断发展，我们每天都在产生各种信息化数据，数据量一旦过大，大家都会出现忘记账号和密码、某些文件忘记放哪里了等问题，故开发了这款**个人信息管理系统**，它是一款基于`koa2 + vue2.7 + vite3 +   mysql`技术实现的个人日常信息数据管理系统。

该系统通过页面权限和按钮权限实现了对不同角色呈现不同的页面和按钮功能，以此达到根据不同的用户的使用场景不同定制化配置页面和权限。


## 在线体验
**在线演示**
```yml
地址: http://info.itchenliang.club/
账号: guest
密码: guest
```


## 内置功能
### 文件管理
在日常生活中，会产生各种各样的文件，例如图片、文档等数据，特别是针对设计人员和宝妈，每天会产生各种各样的设计稿和婴儿成长记录照，但由于现在手机存储空间有限，久而久之就需要删除最初的数据，这样就会导致数据丢失。

文件管理功能目前支持: 
- 文件批量上传
- 文件夹上传
- 在线创建文件夹
- 在线下载网路图片
- 移动文件
- 下载文件
- 重命名文件
- 删除文件
![202303141048534.png](https://imgs.itchenliang.club/img/202303141048534.png)

### 项目管理
对于程序员而言，工作依赖，可能开发了无数个系统，但是时间久了就忘记了具体有哪些数据，包括一些在具体项目开发过程中的一些技巧记录和错误记录等数据记录。
> 项目管理功能：主要包括项目源代码备份、项目图集管理、项目文档管理、项目任务管理等功能

**项目管理**
> 在创建项目时会让用户提供一份zip或者其他格式源代码压缩包，并且对项目名称、项目描述、所部署地址、项目状态、项目标签等数据维护。如果需要下载项目源代码，可以项目管理下点击下载按钮即可下载。
![202303141053165.png](https://imgs.itchenliang.club/img/202303141053165.png)
![202303141101251.png](https://imgs.itchenliang.club/img/202303141101251.png)

**项目图集管理**
项目图集管理功能是用于在项目开发过程中的一些图片收集，比如原型图、设计稿或者参考素材等图片。
![202303141055342.png](https://imgs.itchenliang.club/img/202303141055342.png)

**项目文档管理**
项目文档管理功能主要是用于在日常开发中一些约束文档、需求文档、设计文档或者开发时遇到的问题和解决办法的记录。提供在线markdown工具在线创建和修改文档。
![202303141057388.png](https://imgs.itchenliang.club/img/202303141057388.png)
![202303141057583.png](https://imgs.itchenliang.club/img/202303141057583.png)

**项目任务管理**
项目任务管理功能是参考github的`issues`功能，主要是用于在项目开发过程中遇到的bug、bug的重要性和优先级或者在某一时刻有新的功能需求想法，都可以记录在此。
![202303141100194.png](https://imgs.itchenliang.club/img/202303141100194.png)
![202303141100345.png](https://imgs.itchenliang.club/img/202303141100345.png)
![202303141100491.png](https://imgs.itchenliang.club/img/202303141100491.png)

### 密码管理
密码管理主要是用于用户记录在各种社交或系统上的账号和密码管理，当今社会一个人持有无数个账号，经常忘记账号或密码。本系统开发的密码管理默认会将密码隐藏，用户需要点击"显示/隐藏"按钮查看或隐藏密码，同时为了账号和密码提供了"复制"按钮，点击"复制"按钮，默认会将数据复制到粘贴板中。
![202303141103003.png](https://imgs.itchenliang.club/img/202303141103003.png)
![202303141103246.png](https://imgs.itchenliang.club/img/202303141103246.png)

### 备忘录管理
备忘录管理主要是用于用户在日常中的一些小事儿的记录，类似于手机端的便签功能，支持"富文本和markdown"格式的工具。
![202303141105137.png](https://imgs.itchenliang.club/img/202303141105137.png)
![202303141106391.png](https://imgs.itchenliang.club/img/202303141106391.png)
![202303141106579.png](https://imgs.itchenliang.club/img/202303141106579.png)

### 收藏管理
收藏管理主要是用于用户记录日常中遇到的一些好用的系统或网站，便于后续快速查找。例如喜欢追剧但不愿花钱的人，就喜欢找各种在线影视网站免费追剧，那么每次可能需要在多个影视网站切换看，如果久了不使用就容易忘记。
![202303141109537.png](https://imgs.itchenliang.club/img/202303141109537.png)
![202303141110247.png](https://imgs.itchenliang.club/img/202303141110247.png)
![202303141110345.png](https://imgs.itchenliang.club/img/202303141110345.png)

### 账目管理
账目管理主要是用于某些用户有记账习惯，该功能主要是提供的记账功能，可以直观的查看到自己的每笔钱的去向，和每个月的收入和支出开销是否平衡。
![202303141112111.png](https://imgs.itchenliang.club/img/202303141112111.png)
![202303141112279.png](https://imgs.itchenliang.club/img/202303141112279.png)
![202303141112407.png](https://imgs.itchenliang.club/img/202303141112407.png)
![202303141112495.png](https://imgs.itchenliang.club/img/202303141112495.png)

### 角色管理
系统管理主要是用于管理员针对不同使用场景的用户创建特定的角色，可以对该角色进行菜单和接口权限配置。
![202303141113594.png](https://imgs.itchenliang.club/img/202303141113594.png)
![202303141114132.png](https://imgs.itchenliang.club/img/202303141114132.png)
![202303141114299.png](https://imgs.itchenliang.club/img/202303141114299.png)
![202303141114438.png](https://imgs.itchenliang.club/img/202303141114438.png)

### 用户管理
用户管理主要是用于管理对本系统的所有用户进行管理。
![2023031411153710.png](https://imgs.itchenliang.club/img/2023031411153710.png)
![202303141115561.png](https://imgs.itchenliang.club/img/202303141115561.png)

### 菜单管理
菜单管理主要是用于管理员对本系统的左侧菜单进行维护管理，有个前提在创建菜单时的`菜单组件`必须是已定义好的组件并输入组件名称。
![202303141117326.png](https://imgs.itchenliang.club/img/202303141117326.png)
![202303141117431.png](https://imgs.itchenliang.club/img/202303141117431.png)

### 接口管理
本系统为了针对不同使用场景的用户，将后台接口的权限抽离到数据库中进行管理，通过动态为不同角色配置指定的接口权限，进而控制页面上的按钮是否显示。
> 菜单管理：用于控制页面是否可看。  接口管理：用于控制页面上的按钮是否可看。
![202303141120281.png](https://imgs.itchenliang.club/img/202303141120281.png)
![202303141120379.png](https://imgs.itchenliang.club/img/202303141120379.png)
![2023031411204910.png](https://imgs.itchenliang.club/img/2023031411204910.png)

### 图表管理
图表管理主要是对页面上所有数据统计页面上的图表进行管理，所有数据统计页面上的图表均是来源此处管理的图表。
![202303141122081.png](https://imgs.itchenliang.club/img/202303141122081.png)
![202303141122245.png](https://imgs.itchenliang.club/img/202303141122245.png)

### 仪表盘管理
仪表盘管理是对页面上的数据统计页面的布局进行管理维护或者数据统计页面进行管理，类似于数据大盘管理。**支持拖拽布局排版**。
![202303141123336.png](https://imgs.itchenliang.club/img/202303141123336.png)
![202303141123565.png](https://imgs.itchenliang.club/img/202303141123565.png)
![202303141124088.png](https://imgs.itchenliang.club/img/202303141124088.png)
![202303141124499.png](https://imgs.itchenliang.club/img/202303141124499.png)

### 定时服务
定时服务功能主要是用于有些人经常忘记做一些事儿，通过定时任务就可以定时发邮件通知用户该做什么事儿了，例如打工人的考勤，上下班需要打卡，不打卡就会扣工资，那么通过定时服务，每天上下班时间就发送邮件通知该打卡了。
![202303141126534.png](https://imgs.itchenliang.club/img/202303141126534.png)
![202303141127052.png](https://imgs.itchenliang.club/img/202303141127052.png)
![202303141127204.png](https://imgs.itchenliang.club/img/202303141127204.png)

### 服务监控
用于检测当前服务的执行情况。
![202303141127535.png](https://imgs.itchenliang.club/img/202303141127535.png)

### 系统监控
用户监控当前服务的运行情况，服务器的版本、服务器的cpu数量和内存使用情况。
![202303141128042.png](https://imgs.itchenliang.club/img/202303141128042.png)

### 地图展示
该功能是系统提供的的一个小工具，用户用户查看地图数据，后续会添加地图搜索，路线规划等功能。对于爱运动、爱旅游的用户，可能需要通过路线规划来看具体自己最近的行程路线和总行程量。
![202303141129459.png](https://imgs.itchenliang.club/img/202303141129459.png)

### 站点收录
该功能是系统提供的一个小工具，方便用户将自己开发的网站推送给百度站长平台，这样后续通过百度搜索就可以能搜索到自己的系统。主动向百度搜索主动推送资源，让您的网站能够被百度搜索引擎收录.....
![202303141131243.png](https://imgs.itchenliang.club/img/202303141131243.png)


## 安装
### 安装步骤


## 功能特性和迭代计划（Roadmap）
- 项目管理-源码管理
  > 支持在线修改部分源代码
- 图表功能
  > 支持在线开发图表
- 项目管理
  > 支持多人开发项目，将项目任务派发给指定人完成。
- 地图管理
  > 支持导入路线数据，将导入的路线数据在地图上展示。
- 账目管理
  > 后续开发一款小程序，便于用户直接在手机端操作。
- autojs脚本
  > 后续看是否可以开发一款autojs自动化脚本，自动将用户手机端的短信、联系人、备忘录、通话记录、照片等数据自动备份导入系统。


## 联系我
Email: <a href="mailto:itchenliang@163.com">itchenliang@163.com</a>


## 捐赠/打赏
如果您认可我的作品，并且觉得对你有所帮助我愿意接受来自各方面的捐赠。
<table style="border: 1px solid hsla(210,18%,87%,1);border-collapse: collapse;width: 100%;">
  <tbody>
    <tr>
      <td>支付宝</td>
      <td>微信</td>
    </tr>
    <tr style="background: #f6f8fa;">
      <td style="width: 50%;">
        <img src="http://lc-dzncsgi3.cn-n1.lcfile.com/FnXBNkKfhnOYoLppJGSWQY6dUh1rnMHA/reward_alipay.jpg" />
      </td>
      <td style="width: 50%;">
        <img src="http://lc-dzncsgi3.cn-n1.lcfile.com/PAMB9Ah4luFLiVvwp6oVh6pelyPudsNK/reward_weixin.jpg" />
      </td>
    </tr>
  </tbody>
</table>