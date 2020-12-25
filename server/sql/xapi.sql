/*
 Navicat MySQL Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50715
 Source Host           : localhost:3306
 Source Schema         : xapi

 Target Server Type    : MySQL
 Target Server Version : 50715
 File Encoding         : 65001

 Date: 25/12/2020 14:06:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for icon
-- ----------------------------
DROP TABLE IF EXISTS `icon`;
CREATE TABLE `icon`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图标名称',
  `prefix` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'xapi' COMMENT '图标的前缀',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图标的code',
  `updatetime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2020-12-20 15:43:45' COMMENT '图标更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of icon
-- ----------------------------
INSERT INTO `icon` VALUES ('3f5e982b-caaf-47d3-9797-856ca40f6402', 'role', 'xapi', 'xapi-role', '2020-12-20 15:43:45');
INSERT INTO `icon` VALUES ('3f5e982b-caaf-47d3-9797-856ca40f6408', 'system', 'xapi', 'xapi-sys', '2020-12-20 15:43:45');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单路径',
  `pid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '上级菜单',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Layout' COMMENT '组件名称',
  `enable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '菜单是否启用',
  `visible` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否显示在菜单栏上',
  `active` char(36) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '激活菜单项',
  `order` int(11) NOT NULL DEFAULT 1 COMMENT '排序：值越大就越靠前',
  `type` int(11) NOT NULL DEFAULT 2 COMMENT '菜单类别：目录1，菜单2',
  `redirect` char(36) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '重定向：为了解决目录菜单时应该默认前往哪个子菜单',
  `updatetime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2020-12-20 15:43:45' COMMENT '重定向：为了解决目录菜单时应该默认前往哪个子菜单',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1d5dfef6-9938-4c33-b614-2dd7f187d51d', '系统管理', '/system', '', 'Layout', 0, 1, '', 1, 1, '', '2020-12-24 14:37:17');
INSERT INTO `menu` VALUES ('e561d111-fa1c-4bd5-a85f-64f9114312bd', '角色管理', '/system/role', '1d5dfef6-9938-4c33-b614-2dd7f187d51d', 'SystemRole', 0, 1, '', 1, 1, '', '2020-12-24 14:45:01');

-- ----------------------------
-- Table structure for menu_icon
-- ----------------------------
DROP TABLE IF EXISTS `menu_icon`;
CREATE TABLE `menu_icon`  (
  `menuId` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `iconId` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`menuId`, `iconId`) USING BTREE,
  INDEX `iconId`(`iconId`) USING BTREE,
  CONSTRAINT `menu_icon_ibfk_1` FOREIGN KEY (`menuId`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `menu_icon_ibfk_2` FOREIGN KEY (`iconId`) REFERENCES `icon` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu_icon
-- ----------------------------
INSERT INTO `menu_icon` VALUES ('e561d111-fa1c-4bd5-a85f-64f9114312bd', '3f5e982b-caaf-47d3-9797-856ca40f6402');
INSERT INTO `menu_icon` VALUES ('1d5dfef6-9938-4c33-b614-2dd7f187d51d', '3f5e982b-caaf-47d3-9797-856ca40f6408');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限名称',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限地址',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'get' COMMENT '权限类型',
  `basename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属类别：用户管理/角色管理等等',
  `updatetime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2020-12-15 14:49:40' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('258e6797-8ce1-45d5-8d8d-d8be3bc0b064', '权限删除', '/api/permission/delete', 'delete', '权限管理', '2020-12-16 16:48:02');
INSERT INTO `permission` VALUES ('79ab8a9b-8e10-4e56-be7f-31539afa69e5', '权限列表', '/api/permission/list', 'get', '权限管理', '2020-12-15 16:13:39');
INSERT INTO `permission` VALUES ('c55447c9-7fc2-4ca1-b532-47e0ac128c25', '权限更新', '/api/permission/update', 'put', '权限管理', '2020-12-15 16:13:05');
INSERT INTO `permission` VALUES ('dd73a87b-d5a2-4f2b-a726-50ef415e2670', '权限详情', '/api/permission/detail', 'get', '权限管理', '2020-12-15 16:27:50');
INSERT INTO `permission` VALUES ('e67fd388-3e94-4fc8-9573-a27efebe1d6e', '权限新增', '/api/permission/add', 'post', '权限管理', '2020-12-15 15:38:51');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色描述',
  `updatetime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2020-12-15 13:56:13' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '角色状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('01508269-6b98-4504-a6dd-b50cfdef9929', 'admin', '管理员', '2020-12-16 16:35:18', 1);
INSERT INTO `role` VALUES ('f8a1e00b-ebfe-4d21-a661-e85789664607', 'superadmin', '超级管理员', '2020-12-16 17:08:26', 1);

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu`  (
  `roleId` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `menuId` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`roleId`, `menuId`) USING BTREE,
  INDEX `menuId`(`menuId`) USING BTREE,
  CONSTRAINT `role_menu_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_menu_ibfk_2` FOREIGN KEY (`menuId`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission`  (
  `roleId` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `permissionId` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`roleId`, `permissionId`) USING BTREE,
  INDEX `permissionId`(`permissionId`) USING BTREE,
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permissionId`) REFERENCES `permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('01508269-6b98-4504-a6dd-b50cfdef9929', '258e6797-8ce1-45d5-8d8d-d8be3bc0b064');

-- ----------------------------
-- Table structure for system
-- ----------------------------
DROP TABLE IF EXISTS `system`;
CREATE TABLE `system`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `sitename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Xpi项目接口管理系统' COMMENT '系统名称：用来设置title',
  `domain` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'http://blog.itchenliang.club/' COMMENT '系统域名：不能为空，需要进行格式校验',
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'http://www.chenliang0829.cn:8081/public/images/logo1.png' COMMENT '系统logo：不能为空，需要进行格式校验',
  `ico` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'http://www.chenliang0829.cn:8081/public/images/favicon.ico' COMMENT '系统ico：不能为空，需要进行格式校验(选择本地文件上传或者url)',
  `notice` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '系统公告',
  `copyright` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Copyright © 2019-2020 itchenliang.club' COMMENT '系统版权',
  `beian` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '蜀ICP备19023554号-1' COMMENT '系统备案号',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'itchenliang@163.com' COMMENT '系统邮箱',
  `qq` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1825956830' COMMENT '联系QQ',
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键字，用于搜索引擎优化',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '系统描述',
  `filetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '.*' COMMENT '文件类型',
  `filelimit` int(11) NOT NULL DEFAULT 10240 COMMENT '最大文件上传',
  `code` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '统计代码',
  `note` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否开启便签功能 1：开启，0：关闭',
  `iconprefix` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'xapi' COMMENT '图标前缀',
  `iconurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '//at.alicdn.com/t/font_2246210_adlq9vrj0x7.css' COMMENT '图标样式url',
  `updatetime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2020-12-15 15:18:29' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system
-- ----------------------------
INSERT INTO `system` VALUES ('1d7c1a02-cb74-43c8-9652-9e1b946960b2', 'Xpi项目接口管理系统', 'http://blog.itchenliang.club/', 'http://www.chenliang0829.cn:8081/public/images/logo1.png', 'http://www.chenliang0829.cn:8081/public/images/favicon.ico', '不得在公共空间吸烟', 'Copyright © 2019-2020 itchenliang.club', '蜀ICP备19023554号-1', 'itchenliang@163.com', '1825956830', NULL, NULL, '.*', 10240, NULL, 1, 'xapi', '//at.alicdn.com/t/font_2246210_adlq9vrj0x7.css', '2020-12-15 15:18:29');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录密码',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '网友007' COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2712859483,1666841396&fm=26&gp=0.jpg' COMMENT '用户头像',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户性别',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户备注/用户签名',
  `updatetime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2020-12-15 13:46:05' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '用户状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('28986fd5-894f-4452-b23b-895b31187339', 'admin', 'admin', '超级管理员', 'https://dss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2712859483,1666841396&fm=26&gp=0.jpg', 'itchenliang@163.com', '男', '这是我的个人描述........', '2020-12-15 13:49:55', 1);

SET FOREIGN_KEY_CHECKS = 1;
