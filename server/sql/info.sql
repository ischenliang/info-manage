/*
 Navicat MySQL Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50715
 Source Host           : localhost:3306
 Source Schema         : info

 Target Server Type    : MySQL
 Target Server Version : 50715
 File Encoding         : 65001

 Date: 28/01/2021 21:51:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for api
-- ----------------------------
DROP TABLE IF EXISTS `api`;
CREATE TABLE `api`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限名称',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限地址',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'GET' COMMENT '权限类型',
  `tid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'api_type表关联',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-01-28 21:48:37' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-01-28 21:48:37' COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接口备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tid`(`tid`) USING BTREE,
  CONSTRAINT `api_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `api_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of api
-- ----------------------------
INSERT INTO `api` VALUES ('3c0b86d4-e402-487a-856c-cef073329c29', '新增角色', '/api/role/add', 'POST', 'ada58122-a724-4f49-873c-bf96aa993418', '2021-01-25 21:36:26', '2021-01-28 19:58:03', '新增角色接口');
INSERT INTO `api` VALUES ('4e849fd8-15b7-4229-a075-76bbe5730f32', '接口类别新增', '/apitype/add', 'POST', 'ffce7eda-2e27-4473-8fc1-d3a3f4caf39a', '2021-01-28 21:50:03', '2021-01-28 21:50:03', '接口类别新增接口');
INSERT INTO `api` VALUES ('6b1c0c99-0b1f-49c3-9070-a31d54012d22', '角色详情', '/api/role/detail/:id', 'GET', 'ada58122-a724-4f49-873c-bf96aa993418', '2021-01-25 21:42:28', '2021-01-28 20:00:14', '角色详情接口：id -> 角色id');
INSERT INTO `api` VALUES ('747dde5a-ea5d-4c11-b1bf-fe5293a0f119', '菜单列表', '/menu/list', 'GET', 'b423bd85-4c99-4ae0-87ec-25de3589d022', '2021-01-28 21:43:02', '2021-01-28 21:43:02', '菜单列表接口');
INSERT INTO `api` VALUES ('88f2695a-e0f1-4fc3-a5e9-f2397aee6779', '用户列表', '/user/list', 'GET', 'f3e590f4-f6dd-47e4-b229-1e615f3445bd', '2021-01-28 21:43:19', '2021-01-28 21:43:19', '用户列表接口');
INSERT INTO `api` VALUES ('9d624a51-b580-4bcb-a979-ec0d09ac3e04', '菜单新增', '/menu/add', 'POST', 'b423bd85-4c99-4ae0-87ec-25de3589d022', '2021-01-28 21:50:22', '2021-01-28 21:50:22', '菜单新增接口');
INSERT INTO `api` VALUES ('b59de409-6805-4ad9-8ce7-d7bcf26dfe6f', '更新角色', '/role/update', 'PUT', 'ada58122-a724-4f49-873c-bf96aa993418', '2021-01-28 20:06:32', '2021-01-28 20:15:47', '更新角色接口：将role整个对象传递到后台');
INSERT INTO `api` VALUES ('bd38c453-24fa-4786-9075-3820055adaff', '删除角色', '/role/deleteById/:id', 'DELETE', 'ada58122-a724-4f49-873c-bf96aa993418', '2021-01-28 19:59:51', '2021-01-28 19:59:51', '删除角色接口：id -> 角色id');
INSERT INTO `api` VALUES ('d39df9ee-68f5-46fa-b7fe-11147ea91c01', '接口类别列表', '/apitype/list', 'GET', 'ffce7eda-2e27-4473-8fc1-d3a3f4caf39a', '2021-01-28 21:42:36', '2021-01-28 21:42:36', '接口类别列表接口');
INSERT INTO `api` VALUES ('e8334fba-a1f3-4488-8611-de71b111fc23', '接口列表', '/api/list', 'GET', '33a2b81a-65bf-4141-8576-d89bce803899', '2021-01-28 20:12:52', '2021-01-28 20:12:52', '接口管理接口：page、size、sort、order、search、type、tid');
INSERT INTO `api` VALUES ('e8d61597-f770-4675-8027-6039673504b1', '用户新增', '/user/add', 'POST', 'f3e590f4-f6dd-47e4-b229-1e615f3445bd', '2021-01-28 21:50:43', '2021-01-28 21:50:43', '用户新增接口');
INSERT INTO `api` VALUES ('f7414800-9b6c-49a4-bcc5-6004b5813906', '角色列表', '/role/list', 'GET', 'ada58122-a724-4f49-873c-bf96aa993418', '2021-01-28 19:57:46', '2021-01-28 19:58:53', '角色列表接口(筛选条件：search、status、page、size)');
INSERT INTO `api` VALUES ('fb3e3587-c0b6-4322-bb2c-7d707f18dea1', '接口新增', '/api/add', 'POST', '33a2b81a-65bf-4141-8576-d89bce803899', '2021-01-28 21:51:19', '2021-01-28 21:51:19', '接口新增接口');

-- ----------------------------
-- Table structure for api_type
-- ----------------------------
DROP TABLE IF EXISTS `api_type`;
CREATE TABLE `api_type`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '分类状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类备注',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-01-28 21:48:37' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-01-28 21:48:37' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of api_type
-- ----------------------------
INSERT INTO `api_type` VALUES ('33a2b81a-65bf-4141-8576-d89bce803899', '接口管理', 1, '接口管理类别', '2021-01-25 21:07:32', '2021-01-25 21:08:02');
INSERT INTO `api_type` VALUES ('ada58122-a724-4f49-873c-bf96aa993418', '角色管理', 1, '角色管理类别备注', '2021-01-25 21:04:50', '2021-01-25 21:06:26');
INSERT INTO `api_type` VALUES ('b423bd85-4c99-4ae0-87ec-25de3589d022', '菜单管理', 1, '菜单管理类别', '2021-01-25 21:07:23', '2021-01-25 21:07:23');
INSERT INTO `api_type` VALUES ('f3e590f4-f6dd-47e4-b229-1e615f3445bd', '用户管理', 1, '用户管理类别', '2021-01-25 21:07:15', '2021-01-25 21:07:15');
INSERT INTO `api_type` VALUES ('ffce7eda-2e27-4473-8fc1-d3a3f4caf39a', '接口类别管理', 1, '接口类别管理类别', '2021-01-25 21:08:47', '2021-01-26 20:27:42');

-- ----------------------------
-- Table structure for icon
-- ----------------------------
DROP TABLE IF EXISTS `icon`;
CREATE TABLE `icon`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `pid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '图标项目id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图标名称',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图标的code',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '图标状态',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-01-28 21:48:37' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-01-28 21:48:37' COMMENT '图标更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  CONSTRAINT `icon_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `icon_project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of icon
-- ----------------------------

-- ----------------------------
-- Table structure for icon_project
-- ----------------------------
DROP TABLE IF EXISTS `icon_project`;
CREATE TABLE `icon_project`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '项目名称',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目备注',
  `family` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'iconfont' COMMENT 'FontFamily',
  `prefix` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'icon' COMMENT '图标前缀',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'http://at.alicdn.com/t/font_2246210_dg83mt99oye.css' COMMENT '样式文件存放位置',
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '项目所有者',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-01-28 21:48:37' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-01-28 21:48:37' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of icon_project
-- ----------------------------
INSERT INTO `icon_project` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51c1', '个人信息管理系统', '个人信息管理系统，主要是在系统内使用，有管理员进行维护', 'infoicon', 'info-', '//at.alicdn.com/t/font_2246210_dg83mt99oye.css', NULL, '2020-01-14 17:09:24', '2020-01-14 17:09:24');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `pid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '上级菜单id',
  `order` int(11) NOT NULL DEFAULT 1 COMMENT '菜单排序',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单路由',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '/Layout' COMMENT '组件路径',
  `type` int(11) NOT NULL DEFAULT 1 COMMENT '菜单类型：目录1，菜单2',
  `is_frame` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否外链',
  `visible` tinyint(1) NOT NULL DEFAULT 1 COMMENT '菜单显示',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '菜单状态',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单图标',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单备注',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-01-28 21:48:37' COMMENT '菜单创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-01-28 21:48:37' COMMENT '菜单更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `menu` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('0627e686-bee7-4eac-8bb4-1821985d0502', '账目管理', NULL, 1, '/account', '/Layout', 1, 0, 1, 1, 'el-icon-s-marketing', '账目管理：多自己的每一笔开销做记录(可以提供可一个快捷的提交入口：手机端)', '2021-01-20 15:33:33', '2021-01-20 15:36:49');
INSERT INTO `menu` VALUES ('0b078aed-3592-4a1e-af9c-07c84be7acd3', '信息管理', NULL, 1, '/info', '/Layout', 1, 0, 1, 1, 'el-icon-user', '信息管理：包括密码管理、就学信息管理、就业信息以及基本信息管理', '2021-01-20 15:47:31', '2021-01-25 16:27:00');
INSERT INTO `menu` VALUES ('15a8fdd0-9bff-4376-9fa4-c58addf7b215', '标签列表', '18c7421f-a78a-4b16-8563-14a0fadda20b', 1, '/memory/tag', '/memeory/tag/List', 2, 0, 1, 1, 'el-icon-collection-tag', '备忘录管理 - 标签管理', '2021-01-20 09:31:51', '2021-01-20 09:31:51');
INSERT INTO `menu` VALUES ('18c7421f-a78a-4b16-8563-14a0fadda20b', '备忘录管理', NULL, 1, '/memory', '/Layout', 1, 0, 1, 1, 'el-icon-notebook-1', '备忘录管理', '2021-01-15 10:11:07', '2021-01-20 13:39:03');
INSERT INTO `menu` VALUES ('1c2eb570-fe5c-48d8-b677-37ccc8428a25', '资源管理', NULL, 1, '/resource', '/Layout', 1, 0, 1, 1, 'el-icon-folder-opened', '资源管理：对个人文件进行管理(应该在创建用户的时候就根据返回的用户id创建文件夹)', '2021-01-20 14:33:09', '2021-01-25 11:33:11');
INSERT INTO `menu` VALUES ('5c4ed5b3-2d09-4154-863a-b513e2fd0f25', '就业信息', '0b078aed-3592-4a1e-af9c-07c84be7acd3', 1, '/info/job', '/info/job/List', 2, 0, 1, 1, 'el-icon-camera', '就业信息管理：主要是对自己一生中所做过的工作或者待过的公司做记录。', '2021-01-20 15:56:37', '2021-01-20 15:56:37');
INSERT INTO `menu` VALUES ('775df3c0-be89-48f6-95b7-5b7316b5933b', '密码管理', '0b078aed-3592-4a1e-af9c-07c84be7acd3', 1, '/info/pwd', '/info/pwd/List', 2, 0, 1, 1, 'el-icon-lock', '密码管理：网站名称(软件名称)：QQ\n网站地址：https://www.zhihu.com/\n账号：1825956830\n密码：***************\n支付密码：***********\n用户id：谁的密码', '2021-01-20 15:51:29', '2021-01-20 15:51:29');
INSERT INTO `menu` VALUES ('7a6ec4a9-fb85-435e-be71-048b39bd73a8', '项目管理', NULL, 1, '/project', '/Layout', 1, 0, 1, 1, 'el-icon-s-grid', '', '2021-01-20 15:41:35', '2021-01-20 15:41:35');
INSERT INTO `menu` VALUES ('7d61ea41-2a32-46ab-93c0-6fbd361a267d', '基本信息管理', '0b078aed-3592-4a1e-af9c-07c84be7acd3', 1, '/info/base', '/info/Base', 2, 0, 1, 1, 'el-icon-s-comment', '基本信息管理：包括通讯地址、手机号、QQ号、身份证号等等', '2021-01-20 16:03:01', '2021-01-20 16:03:01');
INSERT INTO `menu` VALUES ('899e5c7f-d59c-41ef-9074-ce3b68878452', '定时任务管理', NULL, 1, '/schedule', '/Layout', 1, 0, 1, 1, 'el-icon-date', '定时任务管理：包括定时器管理和计划任务管理', '2021-01-20 14:36:38', '2021-01-25 11:33:10');
INSERT INTO `menu` VALUES ('8b575593-19bc-4376-9594-26fc2c10e783', '就学信息管理', '0b078aed-3592-4a1e-af9c-07c84be7acd3', 1, '/info/school', '/info/school/List', 2, 0, 1, 1, 'el-icon-picture', '就学信息管理：即是对从小学到工作期间所待过的的学校进行记录', '2021-01-20 15:54:33', '2021-01-20 15:57:48');
INSERT INTO `menu` VALUES ('8eb724a8-6f43-4b1c-b07e-49341c168533', '菜单管理', 'd6aa09e9-a1b7-47fb-b073-311e873af633', 1, '/system/menu', '/system/menu/List', 2, 0, 1, 1, 'el-icon-menu', '系统管理 - 菜单管理', '2021-01-20 09:31:51', '2021-01-20 09:31:51');
INSERT INTO `menu` VALUES ('99b48ff5-5dea-4317-8c13-d3d0e5cbd411', '接口类别管理', 'fdf1ab35-dab2-402f-911a-9e9eb2cfadd4', 1, '/system/api/type', '/system/api/Type', 2, 0, 1, 1, 'el-icon-s-operation', '系统管理 - 接口管理 - 接口类别管理', '2021-01-26 13:39:10', '2021-01-26 13:39:10');
INSERT INTO `menu` VALUES ('9da30eb2-b254-4bef-b7b5-8cac3f1e7bae', '类型管理', 'a5794519-fefa-4254-8dc6-b5efc3e7ddf5', 1, '/collect/type', '/collect/type/List', 2, 0, 1, 1, 'el-icon-collection-tag', '收藏类型管理：语言文档和规范/可视化工具等等', '2021-01-20 15:18:41', '2021-01-20 15:18:41');
INSERT INTO `menu` VALUES ('a3136729-f426-49e4-87d2-79497d5e72e0', '角色管理', 'd6aa09e9-a1b7-47fb-b073-311e873af633', 1, '/system/role', '/system/role/List', 2, 0, 1, 1, 'el-icon-user-solid', '系统管理 - 角色管理', '2021-01-20 09:31:51', '2021-01-20 13:48:20');
INSERT INTO `menu` VALUES ('a5794519-fefa-4254-8dc6-b5efc3e7ddf5', '收藏管理', NULL, 1, '/collect', '/Layout', 1, 0, 1, 1, 'el-icon-collection', '收藏管理：可以提供可一个快捷的提交入口：手机端', '2021-01-20 09:31:51', '2021-01-20 15:38:28');
INSERT INTO `menu` VALUES ('bc262ac5-d198-4fcc-8fdc-7459bdc538ad', '用户管理', 'd6aa09e9-a1b7-47fb-b073-311e873af633', 1, '/system/user', '/system/user/List', 2, 0, 1, 1, 'el-icon-user', '系统管理 - 用户管理', '2021-01-15 10:10:02', '2021-01-26 13:40:42');
INSERT INTO `menu` VALUES ('d65d5584-9b6b-48cd-9a52-2155bb80ccf8', '代办事项', NULL, 1, '/todo', '/Layout', 1, 0, 1, 1, 'el-icon-tickets', '代办事务/日程安排管理', '2021-01-20 15:05:14', '2021-01-25 11:33:09');
INSERT INTO `menu` VALUES ('d6aa09e9-a1b7-47fb-b073-311e873af633', '系统管理', NULL, 1, '/system', '/Layout', 1, 0, 1, 1, 'el-icon-setting', '系统管理', '2021-01-15 10:10:02', '2021-01-20 13:36:27');
INSERT INTO `menu` VALUES ('dabc4f36-9240-4851-a642-0cb546926e1c', '权限管理', 'd6aa09e9-a1b7-47fb-b073-311e873af633', 1, '/system/permission/:id', '/system/permission/List', 2, 0, 0, 1, 'el-icon-lock', '系统管理 - 权限管理', '2021-01-20 09:31:51', '2021-01-25 11:34:52');
INSERT INTO `menu` VALUES ('dae77345-b33c-4284-9cab-f63e8627f0c0', '接口列表', 'fdf1ab35-dab2-402f-911a-9e9eb2cfadd4', 1, '/system/api/list', '/system/api/List', 2, 0, 1, 1, 'el-icon-s-order', '系统管理 - 接口管理 - 接口列表', '2021-01-26 13:51:18', '2021-01-26 13:51:18');
INSERT INTO `menu` VALUES ('dc9e5156-b5b1-4fff-af29-88a7222e8616', '备忘录列表', '18c7421f-a78a-4b16-8563-14a0fadda20b', 1, '/memory/list', '/memory/memory/List', 2, 0, 1, 1, 'el-icon-s-order', '备忘录管理 - 备忘录管理', '2021-01-20 09:31:51', '2021-01-20 14:02:54');
INSERT INTO `menu` VALUES ('e41df809-1468-4d74-b03f-1a4947495b4e', '收藏列表', 'a5794519-fefa-4254-8dc6-b5efc3e7ddf5', 1, '/collect/list', '/collect/List', 2, 0, 1, 1, 'el-icon-s-order', '收藏列表', '2021-01-20 09:31:51', '2021-01-20 15:19:21');
INSERT INTO `menu` VALUES ('fdf1ab35-dab2-402f-911a-9e9eb2cfadd4', '接口管理', 'd6aa09e9-a1b7-47fb-b073-311e873af633', 1, '/system/api', '/Index', 1, 0, 1, 1, 'el-icon-lock', '系统管理 - 接口管理(还需要做进一步更改，现在没有查询出三级的菜单)', '2021-01-25 11:34:41', '2021-01-26 13:52:59');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `priority` int(11) NOT NULL DEFAULT 1 COMMENT '角色排序',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '角色状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '角色备注',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-01-28 21:48:37' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-01-28 21:48:37' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `name_2`(`name`) USING BTREE,
  UNIQUE INDEX `name_3`(`name`) USING BTREE,
  UNIQUE INDEX `name_4`(`name`) USING BTREE,
  UNIQUE INDEX `name_5`(`name`) USING BTREE,
  UNIQUE INDEX `name_6`(`name`) USING BTREE,
  UNIQUE INDEX `name_7`(`name`) USING BTREE,
  UNIQUE INDEX `name_8`(`name`) USING BTREE,
  UNIQUE INDEX `name_9`(`name`) USING BTREE,
  UNIQUE INDEX `name_10`(`name`) USING BTREE,
  UNIQUE INDEX `name_11`(`name`) USING BTREE,
  UNIQUE INDEX `name_12`(`name`) USING BTREE,
  UNIQUE INDEX `name_13`(`name`) USING BTREE,
  UNIQUE INDEX `name_14`(`name`) USING BTREE,
  UNIQUE INDEX `name_15`(`name`) USING BTREE,
  UNIQUE INDEX `name_16`(`name`) USING BTREE,
  UNIQUE INDEX `name_17`(`name`) USING BTREE,
  UNIQUE INDEX `name_18`(`name`) USING BTREE,
  UNIQUE INDEX `name_19`(`name`) USING BTREE,
  UNIQUE INDEX `name_20`(`name`) USING BTREE,
  UNIQUE INDEX `name_21`(`name`) USING BTREE,
  UNIQUE INDEX `name_22`(`name`) USING BTREE,
  UNIQUE INDEX `name_23`(`name`) USING BTREE,
  UNIQUE INDEX `name_24`(`name`) USING BTREE,
  UNIQUE INDEX `name_25`(`name`) USING BTREE,
  UNIQUE INDEX `name_26`(`name`) USING BTREE,
  UNIQUE INDEX `name_27`(`name`) USING BTREE,
  UNIQUE INDEX `name_28`(`name`) USING BTREE,
  UNIQUE INDEX `name_29`(`name`) USING BTREE,
  UNIQUE INDEX `name_30`(`name`) USING BTREE,
  UNIQUE INDEX `name_31`(`name`) USING BTREE,
  UNIQUE INDEX `name_32`(`name`) USING BTREE,
  UNIQUE INDEX `name_33`(`name`) USING BTREE,
  UNIQUE INDEX `name_34`(`name`) USING BTREE,
  UNIQUE INDEX `name_35`(`name`) USING BTREE,
  UNIQUE INDEX `name_36`(`name`) USING BTREE,
  UNIQUE INDEX `name_37`(`name`) USING BTREE,
  UNIQUE INDEX `name_38`(`name`) USING BTREE,
  UNIQUE INDEX `name_39`(`name`) USING BTREE,
  UNIQUE INDEX `name_40`(`name`) USING BTREE,
  UNIQUE INDEX `name_41`(`name`) USING BTREE,
  UNIQUE INDEX `name_42`(`name`) USING BTREE,
  UNIQUE INDEX `name_43`(`name`) USING BTREE,
  UNIQUE INDEX `name_44`(`name`) USING BTREE,
  UNIQUE INDEX `name_45`(`name`) USING BTREE,
  UNIQUE INDEX `name_46`(`name`) USING BTREE,
  UNIQUE INDEX `name_47`(`name`) USING BTREE,
  UNIQUE INDEX `name_48`(`name`) USING BTREE,
  UNIQUE INDEX `name_49`(`name`) USING BTREE,
  UNIQUE INDEX `name_50`(`name`) USING BTREE,
  UNIQUE INDEX `name_51`(`name`) USING BTREE,
  UNIQUE INDEX `name_52`(`name`) USING BTREE,
  UNIQUE INDEX `name_53`(`name`) USING BTREE,
  UNIQUE INDEX `name_54`(`name`) USING BTREE,
  UNIQUE INDEX `name_55`(`name`) USING BTREE,
  UNIQUE INDEX `name_56`(`name`) USING BTREE,
  UNIQUE INDEX `name_57`(`name`) USING BTREE,
  UNIQUE INDEX `name_58`(`name`) USING BTREE,
  UNIQUE INDEX `name_59`(`name`) USING BTREE,
  UNIQUE INDEX `name_60`(`name`) USING BTREE,
  UNIQUE INDEX `name_61`(`name`) USING BTREE,
  UNIQUE INDEX `name_62`(`name`) USING BTREE,
  UNIQUE INDEX `name_63`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'user', 1, 1, '普通用户', '2021-01-13 09:47:18', '2021-01-13 09:47:18');
INSERT INTO `role` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'test', 1, 1, '测试', '2021-01-20 14:11:43', '2021-01-20 14:11:43');
INSERT INTO `role` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'admin', 1, 1, '管理员', '2021-01-12 17:29:44', '2021-01-12 17:29:44');

-- ----------------------------
-- Table structure for role_api
-- ----------------------------
DROP TABLE IF EXISTS `role_api`;
CREATE TABLE `role_api`  (
  `roleId` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `apiId` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`roleId`, `apiId`) USING BTREE,
  INDEX `apiId`(`apiId`) USING BTREE,
  CONSTRAINT `role_api_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_api_ibfk_2` FOREIGN KEY (`apiId`) REFERENCES `api` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_api
-- ----------------------------
INSERT INTO `role_api` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '3c0b86d4-e402-487a-856c-cef073329c29');
INSERT INTO `role_api` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '4e849fd8-15b7-4229-a075-76bbe5730f32');
INSERT INTO `role_api` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '6b1c0c99-0b1f-49c3-9070-a31d54012d22');
INSERT INTO `role_api` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '747dde5a-ea5d-4c11-b1bf-fe5293a0f119');
INSERT INTO `role_api` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '88f2695a-e0f1-4fc3-a5e9-f2397aee6779');
INSERT INTO `role_api` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '9d624a51-b580-4bcb-a979-ec0d09ac3e04');
INSERT INTO `role_api` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'b59de409-6805-4ad9-8ce7-d7bcf26dfe6f');
INSERT INTO `role_api` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'bd38c453-24fa-4786-9075-3820055adaff');
INSERT INTO `role_api` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'd39df9ee-68f5-46fa-b7fe-11147ea91c01');
INSERT INTO `role_api` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'e8334fba-a1f3-4488-8611-de71b111fc23');
INSERT INTO `role_api` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'e8d61597-f770-4675-8027-6039673504b1');
INSERT INTO `role_api` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'f7414800-9b6c-49a4-bcc5-6004b5813906');
INSERT INTO `role_api` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'fb3e3587-c0b6-4322-bb2c-7d707f18dea1');

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
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '0627e686-bee7-4eac-8bb4-1821985d0502');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '0627e686-bee7-4eac-8bb4-1821985d0502');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '0627e686-bee7-4eac-8bb4-1821985d0502');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '0b078aed-3592-4a1e-af9c-07c84be7acd3');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '0b078aed-3592-4a1e-af9c-07c84be7acd3');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '0b078aed-3592-4a1e-af9c-07c84be7acd3');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '15a8fdd0-9bff-4376-9fa4-c58addf7b215');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '15a8fdd0-9bff-4376-9fa4-c58addf7b215');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '15a8fdd0-9bff-4376-9fa4-c58addf7b215');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '18c7421f-a78a-4b16-8563-14a0fadda20b');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '18c7421f-a78a-4b16-8563-14a0fadda20b');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '18c7421f-a78a-4b16-8563-14a0fadda20b');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '1c2eb570-fe5c-48d8-b677-37ccc8428a25');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '1c2eb570-fe5c-48d8-b677-37ccc8428a25');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '1c2eb570-fe5c-48d8-b677-37ccc8428a25');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '5c4ed5b3-2d09-4154-863a-b513e2fd0f25');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '5c4ed5b3-2d09-4154-863a-b513e2fd0f25');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '5c4ed5b3-2d09-4154-863a-b513e2fd0f25');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '775df3c0-be89-48f6-95b7-5b7316b5933b');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '775df3c0-be89-48f6-95b7-5b7316b5933b');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '775df3c0-be89-48f6-95b7-5b7316b5933b');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '7a6ec4a9-fb85-435e-be71-048b39bd73a8');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '7a6ec4a9-fb85-435e-be71-048b39bd73a8');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '7a6ec4a9-fb85-435e-be71-048b39bd73a8');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '7d61ea41-2a32-46ab-93c0-6fbd361a267d');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '7d61ea41-2a32-46ab-93c0-6fbd361a267d');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '7d61ea41-2a32-46ab-93c0-6fbd361a267d');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '899e5c7f-d59c-41ef-9074-ce3b68878452');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '899e5c7f-d59c-41ef-9074-ce3b68878452');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '8b575593-19bc-4376-9594-26fc2c10e783');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '8b575593-19bc-4376-9594-26fc2c10e783');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '8b575593-19bc-4376-9594-26fc2c10e783');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '8eb724a8-6f43-4b1c-b07e-49341c168533');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '8eb724a8-6f43-4b1c-b07e-49341c168533');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '99b48ff5-5dea-4317-8c13-d3d0e5cbd411');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '9da30eb2-b254-4bef-b7b5-8cac3f1e7bae');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', '9da30eb2-b254-4bef-b7b5-8cac3f1e7bae');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '9da30eb2-b254-4bef-b7b5-8cac3f1e7bae');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'a3136729-f426-49e4-87d2-79497d5e72e0');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'a3136729-f426-49e4-87d2-79497d5e72e0');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'a5794519-fefa-4254-8dc6-b5efc3e7ddf5');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'a5794519-fefa-4254-8dc6-b5efc3e7ddf5');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'a5794519-fefa-4254-8dc6-b5efc3e7ddf5');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'bc262ac5-d198-4fcc-8fdc-7459bdc538ad');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'bc262ac5-d198-4fcc-8fdc-7459bdc538ad');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'd65d5584-9b6b-48cd-9a52-2155bb80ccf8');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'd65d5584-9b6b-48cd-9a52-2155bb80ccf8');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'd65d5584-9b6b-48cd-9a52-2155bb80ccf8');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'd6aa09e9-a1b7-47fb-b073-311e873af633');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'd6aa09e9-a1b7-47fb-b073-311e873af633');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'dabc4f36-9240-4851-a642-0cb546926e1c');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'dabc4f36-9240-4851-a642-0cb546926e1c');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'dae77345-b33c-4284-9cab-f63e8627f0c0');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'dc9e5156-b5b1-4fff-af29-88a7222e8616');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'dc9e5156-b5b1-4fff-af29-88a7222e8616');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'dc9e5156-b5b1-4fff-af29-88a7222e8616');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'e41df809-1468-4d74-b03f-1a4947495b4e');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'e41df809-1468-4d74-b03f-1a4947495b4e');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'e41df809-1468-4d74-b03f-1a4947495b4e');
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16', 'fdf1ab35-dab2-402f-911a-9e9eb2cfadd4');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'fdf1ab35-dab2-402f-911a-9e9eb2cfadd4');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '用户007' COMMENT '用户昵称',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户备注',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-01-28 21:48:37' COMMENT '用户创建时间',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '用户状态',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'http://vue.ruoyi.vip/static/img/profile.473f5971.jpg' COMMENT '用户头像',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('26192b0d-9281-4363-b8c5-e05a29bef677', 'duli', '96e79218965eb72c92a549dd5a330112', 'Yrainy', '杜丽', '2021-01-13 15:38:02', 1, 'http://localhost:3000/avatar/26192b0d-9281-4363-b8c5-e05a29bef677.jpg');
INSERT INTO `user` VALUES ('646714df-7985-456a-81d1-f050c712347c', 'test', '96e79218965eb72c92a549dd5a330112', '用户007', '测试用户', '2021-01-25 16:07:22', 1, 'http://localhost:3000/avatar/26192b0d-9281-4363-b8c5-e05a29bef677.jpg');
INSERT INTO `user` VALUES ('9f9ead70-8320-41d5-9c32-822262866390', 'admin', '21232f297a57a5a743894a0e4a801fc3', '管理员', '管理员', '2021-01-25 13:24:46', 1, 'http://localhost:3000/avatar/26192b0d-9281-4363-b8c5-e05a29bef677.jpg');
INSERT INTO `user` VALUES ('cc5bd852-5928-4c5a-9c93-d8e15c678c26', 'itchenliang', '96e79218965eb72c92a549dd5a330112', '奶油味拥抱', '陈亮', '2021-01-25 13:03:06', 1, 'http://www.chenliang0829.cn:8081/upload/202003221513517685885258838558.jpg');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `userId` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `roleId` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`userId`, `roleId`) USING BTREE,
  INDEX `roleId`(`roleId`) USING BTREE,
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('26192b0d-9281-4363-b8c5-e05a29bef677', '23dad3eb-f42a-47bd-be47-4a377b4f51ca');
INSERT INTO `user_role` VALUES ('cc5bd852-5928-4c5a-9c93-d8e15c678c26', '23dad3eb-f42a-47bd-be47-4a377b4f51ca');
INSERT INTO `user_role` VALUES ('26192b0d-9281-4363-b8c5-e05a29bef677', 'c2167a10-362c-4296-89bf-51bb20284b16');
INSERT INTO `user_role` VALUES ('646714df-7985-456a-81d1-f050c712347c', 'c2167a10-362c-4296-89bf-51bb20284b16');
INSERT INTO `user_role` VALUES ('9f9ead70-8320-41d5-9c32-822262866390', 'da0269f8-b0fe-4a69-ab0a-d8f3d870fb78');

SET FOREIGN_KEY_CHECKS = 1;
