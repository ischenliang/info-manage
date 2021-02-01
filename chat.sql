/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50715
Source Host           : localhost:3306
Source Database       : chat

Target Server Type    : MYSQL
Target Server Version : 50715
File Encoding         : 65001

Date: 2020-08-14 16:07:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for friends
-- ----------------------------
DROP TABLE IF EXISTS `friends`;
CREATE TABLE `friends` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` varchar(255) NOT NULL COMMENT '朋友id',
  `uid` varchar(255) NOT NULL COMMENT '自己id',
  `nickname` varchar(255) DEFAULT NULL COMMENT '备注',
  `fgid` int(11) NOT NULL COMMENT '分组id',
  `type` tinyint(255) DEFAULT NULL COMMENT '好友添加方式',
  `createtime` varchar(255) DEFAULT NULL COMMENT '添加好友时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of friends
-- ----------------------------

-- ----------------------------
-- Table structure for friends_group
-- ----------------------------
DROP TABLE IF EXISTS `friends_group`;
CREATE TABLE `friends_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) NOT NULL COMMENT '用户id',
  `name` varchar(255) DEFAULT NULL COMMENT '分组名称',
  `createtime` varchar(255) DEFAULT NULL COMMENT '分组创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of friends_group
-- ----------------------------

-- ----------------------------
-- Table structure for group
-- ----------------------------
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
  `id` varchar(255) NOT NULL COMMENT '群号(类似QQ的长度为9位的UUID)',
  `name` varchar(255) DEFAULT NULL COMMENT '群名称',
  `createtime` varchar(255) DEFAULT NULL COMMENT '群创建时间',
  `adminid` varchar(255) NOT NULL COMMENT '群主id',
  `avatar` varchar(255) DEFAULT NULL COMMENT '群头像',
  `intro` varchar(255) DEFAULT NULL COMMENT '群介绍',
  `type` tinyint(4) DEFAULT NULL COMMENT '进群方式',
  `qrcode` varchar(255) DEFAULT NULL COMMENT '群二维码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of group
-- ----------------------------

-- ----------------------------
-- Table structure for group_message
-- ----------------------------
DROP TABLE IF EXISTS `group_message`;
CREATE TABLE `group_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` longtext COMMENT '消息内容',
  `gid` varchar(255) NOT NULL COMMENT '群号',
  `uid` varchar(255) NOT NULL COMMENT '发送人id',
  `nickname` varchar(255) NOT NULL COMMENT '发送人昵称',
  `createtime` varchar(255) DEFAULT NULL COMMENT '发送时间',
  `type` tinyint(4) DEFAULT NULL COMMENT '消息类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of group_message
-- ----------------------------

-- ----------------------------
-- Table structure for group_message_user
-- ----------------------------
DROP TABLE IF EXISTS `group_message_user`;
CREATE TABLE `group_message_user` (
  `id` int(11) NOT NULL,
  `gmid` int(11) NOT NULL COMMENT '群消息id',
  `uid` varchar(255) NOT NULL COMMENT '接收者id',
  `createtime` varchar(255) DEFAULT NULL COMMENT '发送时间',
  `status` tinyint(4) NOT NULL COMMENT '消息状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of group_message_user
-- ----------------------------

-- ----------------------------
-- Table structure for group_user
-- ----------------------------
DROP TABLE IF EXISTS `group_user`;
CREATE TABLE `group_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gid` varchar(255) NOT NULL COMMENT '群id',
  `uid` varchar(255) NOT NULL COMMENT '用户id',
  `createtime` varchar(255) DEFAULT NULL COMMENT '进群时间',
  `nickname` varchar(255) DEFAULT NULL COMMENT '群昵称',
  `level` int(11) DEFAULT NULL COMMENT '用户群等级',
  `post` varchar(255) DEFAULT NULL COMMENT '用户所属职位',
  `type` tinyint(4) DEFAULT NULL COMMENT '进群方式',
  `status` tinyint(4) DEFAULT NULL COMMENT '消息接收类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of group_user
-- ----------------------------

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` varchar(255) NOT NULL COMMENT '发送人id(from)',
  `tid` varchar(255) NOT NULL COMMENT '接收人id(to)',
  `type` tinyint(4) DEFAULT NULL COMMENT '消息类型',
  `createtime` varchar(255) DEFAULT NULL COMMENT '发送时间',
  `status` tinyint(4) DEFAULT NULL COMMENT '消息状态',
  `message` longtext COMMENT '消息内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '角色名称',
  `description` varchar(255) DEFAULT NULL COMMENT '角色描述',
  `menu` text COMMENT '菜单访问权限',
  `permission` text COMMENT '访问权限',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'admin', '管理员', null, null);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` varchar(255) NOT NULL COMMENT '用户id(类似qq的UUID)',
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `signid` int(11) NOT NULL COMMENT '签名表id',
  `gender` varchar(255) DEFAULT NULL,
  `birth` varchar(255) DEFAULT NULL,
  `intro` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `usid` int(11) NOT NULL COMMENT '用户状态表id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) NOT NULL COMMENT '用户id',
  `rid` int(11) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------

-- ----------------------------
-- Table structure for user_sign
-- ----------------------------
DROP TABLE IF EXISTS `user_sign`;
CREATE TABLE `user_sign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) NOT NULL COMMENT '签名内容',
  `createtime` varchar(255) NOT NULL COMMENT '签名时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_sign
-- ----------------------------

-- ----------------------------
-- Table structure for user_status
-- ----------------------------
DROP TABLE IF EXISTS `user_status`;
CREATE TABLE `user_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '状态名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_status
-- ----------------------------
