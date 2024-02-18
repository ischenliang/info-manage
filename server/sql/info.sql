/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 50715
 Source Host           : localhost:3306
 Source Schema         : info

 Target Server Type    : MySQL
 Target Server Version : 50715
 File Encoding         : 65001

 Date: 30/01/2024 08:59:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `type` tinyint(4) NOT NULL DEFAULT 1 COMMENT '账目类型: 1收入 0支出',
  `tag` json NOT NULL COMMENT '账目分类',
  `pay` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '支付宝' COMMENT '支付方式',
  `ptime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '支付时间',
  `location` json NOT NULL COMMENT '定位',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '账目备注',
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户',
  `template` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否为模板',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '更新时间',
  `money` float NOT NULL DEFAULT 0 COMMENT '付款金额',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of account
-- ----------------------------

-- ----------------------------
-- Table structure for account_tag
-- ----------------------------
DROP TABLE IF EXISTS `account_tag`;
CREATE TABLE `account_tag`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图标',
  `order` int(11) NOT NULL DEFAULT 1 COMMENT '顺序',
  `type` int(11) NOT NULL DEFAULT 1 COMMENT '类型：1收入/0支出',
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `account_tag_name`(`name`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `account_tag_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of account_tag
-- ----------------------------

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
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接口备注',
  `perms` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tid`(`tid`) USING BTREE,
  CONSTRAINT `api_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `api_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of api
-- ----------------------------
INSERT INTO `api` VALUES ('00117824-fe9b-437c-9e60-45a37705b938', '接口类别详情', '/api/apitype/detail/:id', 'GET', 'ffce7eda-2e27-4473-8fc1-d3a3f4caf39a', '2021-02-04 20:50:40', '2021-02-04 20:50:40', '接口类别详情', 'system:apitype:detail');
INSERT INTO `api` VALUES ('00779ef3-f25f-4ca9-b973-0d064c8a0455', '备忘录列表', '/api/memory/list', 'GET', '6208a687-fc34-4ecd-bdc5-d2a66927348c', '2021-02-20 22:00:10', '2021-02-20 22:00:10', '备忘录列表', 'system:memory:list');
INSERT INTO `api` VALUES ('01be6278-b671-414d-813b-51ee04d42aaa', '更新接口', '/api/api/update', 'PUT', '33a2b81a-65bf-4141-8576-d89bce803899', '2021-02-04 21:00:27', '2021-02-04 21:00:27', '更新接口', 'system:api:update');
INSERT INTO `api` VALUES ('024189a1-e925-456a-9fff-0a9bdb3e6796', '更新角色菜单权限', '/api/role/roleMenu/:id', 'POST', 'ada58122-a724-4f49-873c-bf96aa993418', '2021-02-04 22:30:21', '2021-02-04 22:30:28', '角色菜单', 'system:role:menu');
INSERT INTO `api` VALUES ('0252df87-1553-4669-a80d-34adc65858d8', '删除项目任务', '/api/pissue/deleteById/:id', 'DELETE', 'ab1be310-50c6-40f4-b6fc-d0e5cde8711c', '2021-04-01 17:03:55', '2021-04-01 17:03:55', '删除项目任务', 'system:pissue:delete');
INSERT INTO `api` VALUES ('0361a099-286b-4286-9842-fb4cceb4437f', '新增日志', '/api/log/add', 'POST', '48fd9ffb-92e6-44e9-a705-ed770777c2de', '2023-03-16 09:51:12', '2023-03-16 09:51:12', '', 'system:log:add');
INSERT INTO `api` VALUES ('0375e206-73e0-4c9e-b4cf-f4f01da71139', '密码详情', '/api/password/detail/:id', 'GET', '551c1a92-eef9-41c4-9ed8-e5fd41eea8c1', '2021-02-20 22:05:12', '2021-02-20 22:05:12', '密码详情', 'system:password:detail');
INSERT INTO `api` VALUES ('05a4a8d7-d292-4e9a-ad71-bcd5d4c82df9', '账目类别详情', '/api/accountTag/detail/:id', 'GET', '063ccfd0-1251-4952-9e70-70bf216bb830', '2021-02-07 13:49:39', '2021-02-07 13:49:39', '', 'system:accountTag:detail');
INSERT INTO `api` VALUES ('0a359501-f9fc-4dab-9bb9-13f84b9346dd', '新增项目图集', '/api/pimage/upload', 'POST', '1ba09b36-0be5-450a-b191-39648523181a', '2021-04-01 16:19:29', '2021-04-01 16:50:44', '', 'system:pimage:upload');
INSERT INTO `api` VALUES ('0c84eeba-af23-482d-9524-b91d9f0db86e', '任务日志', '/api/task/logs/:id', 'GET', '95591870-f1c9-424c-a6ef-3fb8f34e5ae7', '2021-03-22 11:20:04', '2023-03-16 12:45:33', '', 'system:task:log');
INSERT INTO `api` VALUES ('0d26ac8b-f908-4eb3-aaa0-c6b43d11740e', '进程监控', '/api/monitor/process', 'GET', '91cc47e2-2443-4686-a97e-f80e7dc4a91e', '2021-03-23 17:00:45', '2021-03-24 10:00:40', '监控当前程序执行的进程', 'system:monitor:server');
INSERT INTO `api` VALUES ('0f00e73b-8bce-400d-9d65-4c8f71025e6f', '删除账目', '/api/account/deleteById/:id', 'DELETE', '84c4ceb0-105b-4003-a2b5-aeb1d021ae1a', '2021-02-20 15:40:27', '2021-02-20 15:40:27', '删除账目', 'system:account:delete');
INSERT INTO `api` VALUES ('10256b33-d95a-4fc7-ad6c-e1d6ac6b4d96', '更新菜单', '/api/menu/update', 'PUT', 'b423bd85-4c99-4ae0-87ec-25de3589d022', '2021-02-04 21:35:04', '2021-02-04 21:35:04', '更新菜单', 'system:menu:update');
INSERT INTO `api` VALUES ('12a3c5eb-1bc7-4a2c-b50a-df3b7c9cbe7d', '备忘录详情', '/api/memory/detail/:id', 'GET', '6208a687-fc34-4ecd-bdc5-d2a66927348c', '2021-02-20 21:59:40', '2021-02-20 21:59:40', '备忘录详情', 'system:memory:detail');
INSERT INTO `api` VALUES ('15637fd5-c65d-4d8a-8e52-816c3ed368c1', '项目图集列表', '/api/pimage/list', 'GET', '1ba09b36-0be5-450a-b191-39648523181a', '2021-04-01 16:29:06', '2021-04-01 16:29:06', '项目图集列表', 'system:pimage:list');
INSERT INTO `api` VALUES ('170e0193-7b6b-4d95-a28f-486c92f2615b', '啊啊啊', '啊啊', 'GET', NULL, '2021-02-07 16:02:22', '2021-02-07 16:02:22', '', '啊啊');
INSERT INTO `api` VALUES ('1a67bb29-db31-43ef-88ca-b654c56de9e7', '收藏列表', '/api/collect/list', 'GET', '0e38a129-39be-4d97-9162-200c4a432cab', '2021-02-05 17:12:38', '2021-02-05 17:12:38', '', 'system:collect:list');
INSERT INTO `api` VALUES ('1e39ac41-bad5-414c-a17a-0c7c5a5e6b8c', '下载项目源代码', '/api/project/download', 'GET', '9b1e9c50-f4a7-4f0a-bb06-3010996b8c6d', '2021-04-01 14:12:43', '2021-04-01 14:12:43', '下载项目源代码', 'system:project:download');
INSERT INTO `api` VALUES ('1e852c7f-2051-4ec6-b194-36a2d1b59d7e', '新增资源', '/api/resource/add', 'POST', '6dce2757-df47-4c03-b4f1-1662dff2e9bc', '2021-02-21 16:39:42', '2021-02-21 16:39:42', '新增资源：新增文件夹', 'system:resource:add');
INSERT INTO `api` VALUES ('20c5cbf2-84f7-43a6-883b-69e7c7335a93', '更新账目类别', '/api/accountTag/update', 'PUT', '063ccfd0-1251-4952-9e70-70bf216bb830', '2021-02-07 13:43:53', '2021-02-07 13:43:53', '', 'system:accountTag:update');
INSERT INTO `api` VALUES ('25b23f76-4b3e-4945-8073-8d1165ca2b13', '上传资源', '/api/resource/upload', 'POST', '6dce2757-df47-4c03-b4f1-1662dff2e9bc', '2021-02-25 16:44:11', '2021-02-25 16:44:11', '上传资源', 'system:resource:upload');
INSERT INTO `api` VALUES ('261f356a-9761-46e4-b5b3-cb4a1d5fbd90', '账目类别上下移', '/api/accountTag/moveOrder/:id', 'GET', '063ccfd0-1251-4952-9e70-70bf216bb830', '2021-02-07 13:55:34', '2021-02-07 13:55:34', '账目类别上下移动排序：option(up/down)', 'system:accountTag:move');
INSERT INTO `api` VALUES ('27a0373c-161c-49b8-a7f9-37b90f040e1b', '更新账目', '/api/account/update', 'PUT', '84c4ceb0-105b-4003-a2b5-aeb1d021ae1a', '2021-02-20 15:57:22', '2021-02-20 15:57:22', '更新账目', 'system:account:update');
INSERT INTO `api` VALUES ('2ca8c52b-bea7-47c0-bd6f-34d54fd3282f', '保存网络图片', '/api/resource/saveImg', 'POST', '6dce2757-df47-4c03-b4f1-1662dff2e9bc', '2021-03-31 15:17:24', '2021-03-31 15:17:24', '', 'system:resource:saveImg');
INSERT INTO `api` VALUES ('31b3bab7-e8cf-46c1-afaf-cf3a351e203e', '删除菜单', '/api/menu/deleteById/:id', 'DELETE', 'b423bd85-4c99-4ae0-87ec-25de3589d022', '2021-02-04 21:35:32', '2021-02-04 21:35:32', '删除菜单', 'system:menu:delete');
INSERT INTO `api` VALUES ('3812bfc3-2a26-49dd-bb63-f1d263e33a92', '更新图表', '/api/chart/update', 'PUT', '28b70a7b-d6cc-4bcf-9732-73e2ab02c9cf', '2021-04-06 11:34:20', '2021-04-06 11:34:20', '更新图表', 'system:chart:update');
INSERT INTO `api` VALUES ('3bd465c9-01e9-45b0-9937-5a4fe0adeeba', '删除收藏', '/api/collect/deleteById/:id', 'DELETE', '0e38a129-39be-4d97-9162-200c4a432cab', '2021-02-05 17:11:20', '2021-02-05 17:11:20', '', 'system:collect:delete');
INSERT INTO `api` VALUES ('3c0b86d4-e402-487a-856c-cef073329c29', '新增角色', '/api/role/add', 'POST', 'ada58122-a724-4f49-873c-bf96aa993418', '2021-01-25 21:36:26', '2021-02-04 21:19:19', '新增角色接口', 'system:role:add');
INSERT INTO `api` VALUES ('3dad21a5-f0ee-45bc-979d-2dcfc3ebda5f', '下载项目图集', '/api/pimage/download', 'GET', '1ba09b36-0be5-450a-b191-39648523181a', '2021-04-01 16:29:39', '2021-04-01 16:29:39', '下载项目图集', 'system:pimage:download');
INSERT INTO `api` VALUES ('4083a29f-a997-451c-8e16-530b0ea49497', '更新项目图集', '/api/pimage/update', 'PUT', '1ba09b36-0be5-450a-b191-39648523181a', '2021-04-01 16:27:29', '2021-04-01 16:27:29', '更新项目图集', 'system:pimage:update');
INSERT INTO `api` VALUES ('445d4b9a-cfbf-4cca-9949-1e8d07e0c00f', '删除图表', '/api/chart/deleteById/:id', 'DELETE', '28b70a7b-d6cc-4bcf-9732-73e2ab02c9cf', '2021-04-06 11:34:51', '2021-04-06 11:34:51', '删除图表', 'system:chart:delete');
INSERT INTO `api` VALUES ('4aa6e8e0-36eb-4a1f-8e64-080d5e821227', '项目详情', '/api/project/detail/:id', 'GET', '9b1e9c50-f4a7-4f0a-bb06-3010996b8c6d', '2021-04-01 13:55:38', '2021-04-01 13:55:38', '项目详情', 'system:project:detail');
INSERT INTO `api` VALUES ('4e849fd8-15b7-4229-a075-76bbe5730f32', '接口类别新增', '/api/apitype/add', 'POST', 'ffce7eda-2e27-4473-8fc1-d3a3f4caf39a', '2021-01-28 21:50:03', '2021-02-04 21:17:37', '接口类别新增接口', 'system:apitype:add');
INSERT INTO `api` VALUES ('4ec56ea3-de06-45bb-84a1-d5028a658b92', '账目类别重排', '/api/accountTag/resetOrder', 'PUT', '063ccfd0-1251-4952-9e70-70bf216bb830', '2021-02-07 13:56:52', '2021-02-07 14:38:40', '账目类别所有的重新顺序', 'system:accountTag:reset');
INSERT INTO `api` VALUES ('4f83f8ed-f5d2-4150-b9a6-70d19482d285', '收藏类别详情', '/api/ctype/detail/:id', 'GET', 'cde78003-7d41-447e-a67a-385b206c7992', '2021-02-05 16:23:52', '2021-02-05 16:23:52', '', 'system:ctype:detail');
INSERT INTO `api` VALUES ('51d780e1-e650-46fe-91bb-ebf9e707a0fc', '新增项目文档', '/api/pdocument/add', 'POST', 'a16f621b-537a-41ad-9b91-3161d21ac3fd', '2021-04-01 20:00:45', '2021-04-01 20:00:45', '新增项目文档', 'system:pdocument:add');
INSERT INTO `api` VALUES ('52468b7e-6133-4067-89d3-553deba71fbe', '更新收藏', '/api/collect/update', 'PUT', '0e38a129-39be-4d97-9162-200c4a432cab', '2021-02-05 17:11:46', '2021-02-05 17:11:46', '', 'system:collect:update');
INSERT INTO `api` VALUES ('52c0c717-844f-4f57-bf9a-775f1f46b687', '账目列表', '/api/account/list', 'GET', '84c4ceb0-105b-4003-a2b5-aeb1d021ae1a', '2021-02-20 16:58:58', '2021-02-20 16:58:58', '账目列表', 'system:account:list');
INSERT INTO `api` VALUES ('538874b8-9237-4ec5-b1b3-1df00498f932', 'aa', 'aa', 'GET', NULL, '2021-02-07 16:40:36', '2021-02-07 16:40:36', 'aa', 'aa');
INSERT INTO `api` VALUES ('55203038-11cf-42c3-a42e-85cd95ce358e', '项目列表', '/api/project/list', 'GET', '9b1e9c50-f4a7-4f0a-bb06-3010996b8c6d', '2021-04-01 14:04:28', '2021-04-01 14:04:28', '项目列表', 'system:project:list');
INSERT INTO `api` VALUES ('596c78fb-88c7-4979-8dea-4d25d55120ec', '更新收藏类别', '/api/ctype/update', 'PUT', 'cde78003-7d41-447e-a67a-385b206c7992', '2021-02-05 16:20:46', '2021-02-05 16:20:46', '', 'system:ctype:update');
INSERT INTO `api` VALUES ('5a3f5f67-e89a-4e9e-a483-41997ecd333c', '用户详情', '/api/user/detail/:id', 'GET', 'f3e590f4-f6dd-47e4-b229-1e615f3445bd', '2021-02-04 21:54:47', '2021-02-04 21:54:47', '用户详情', 'system:user:detail');
INSERT INTO `api` VALUES ('5e379be1-116a-48e2-98e6-2baa2ba51c6d', '仪表盘列表', '/api/dash/list', 'GET', '49c92b87-f5fa-41a5-876c-96cfaec60428', '2021-04-06 14:09:01', '2021-04-06 14:09:01', '仪表盘列表', 'system:dash:list');
INSERT INTO `api` VALUES ('62711d38-9990-417d-bc6b-64f761b8cffe', '新增收藏', '/api/collect/add', 'POST', '0e38a129-39be-4d97-9162-200c4a432cab', '2021-02-05 17:09:42', '2021-02-05 17:09:42', '', 'system:collect:add');
INSERT INTO `api` VALUES ('65df3992-1c01-4a69-9a6c-694c4f262dba', '删除接口', '/api/api/deleteById/:id', 'DELETE', '33a2b81a-65bf-4141-8576-d89bce803899', '2021-02-04 21:29:15', '2021-02-04 21:29:15', '删除接口', 'system:api:delete');
INSERT INTO `api` VALUES ('6a20a4ec-e45f-4f2d-aade-e150ba5a6973', '项目文档列表', '/api/pdocument/list', 'GET', 'a16f621b-537a-41ad-9b91-3161d21ac3fd', '2021-04-01 20:03:11', '2021-04-01 20:03:11', '项目文档列表', 'system:pdocument:list');
INSERT INTO `api` VALUES ('6b1c0c99-0b1f-49c3-9070-a31d54012d22', '角色详情', '/api/role/detail/:id', 'GET', 'ada58122-a724-4f49-873c-bf96aa993418', '2021-01-25 21:42:28', '2021-02-04 21:19:08', '角色详情接口：id -> 角色id', 'system:role:detail');
INSERT INTO `api` VALUES ('6bba50f5-a535-45c3-895c-eef33e803baf', '新增账目', '/api/account/add', 'POST', '84c4ceb0-105b-4003-a2b5-aeb1d021ae1a', '2021-02-20 15:20:54', '2021-02-20 15:21:05', '新增账目类别', 'system:account:add');
INSERT INTO `api` VALUES ('6ebc29f4-998e-480b-be8c-4d2d3f7d0b8e', '资源复制', '/api/resource/copy', 'POST', '6dce2757-df47-4c03-b4f1-1662dff2e9bc', '2021-02-23 20:14:43', '2021-02-23 20:14:43', '将指定资源复制到指定目录', 'system:resource:copy');
INSERT INTO `api` VALUES ('6ee59a05-23f7-4a2d-ac78-209b687b03ee', '新增账目', '/api/account/add', 'POST', NULL, '2021-02-07 15:37:46', '2021-02-07 15:37:46', '新增账目', 'system:account:add');
INSERT INTO `api` VALUES ('6f2be000-bfb8-49a8-8255-5aab975701f2', '删除仪表盘', '/api/dash/deleteById/:id', 'DELETE', '49c92b87-f5fa-41a5-876c-96cfaec60428', '2021-04-06 14:07:51', '2021-04-06 14:07:51', '删除仪表盘', 'system:dash:delete');
INSERT INTO `api` VALUES ('6fd4e43e-88b7-429b-b00f-6dc8e4081d12', '新增备忘录', '/api/memory/add', 'POST', '6208a687-fc34-4ecd-bdc5-d2a66927348c', '2021-02-20 21:54:58', '2021-02-20 21:54:58', '新增备忘录', 'system:memory:add');
INSERT INTO `api` VALUES ('6fd7c193-2944-41e0-a000-f93887faa12e', 'aaa', 'aaa', 'GET', NULL, '2021-02-07 16:36:52', '2021-02-07 16:36:52', 'aaa', 'aaa');
INSERT INTO `api` VALUES ('7023d845-a03f-4dfb-900c-09b5108688fd', '更新用户', '/api/user/update', 'PUT', 'f3e590f4-f6dd-47e4-b229-1e615f3445bd', '2021-02-04 21:37:23', '2021-02-04 21:37:23', '更新用户', 'system:user:update');
INSERT INTO `api` VALUES ('73368dbe-ec16-4667-84ec-200caec1c99e', '定时任务列表', '/api/task/list', 'GET', '95591870-f1c9-424c-a6ef-3fb8f34e5ae7', '2021-03-14 16:38:27', '2021-03-14 16:38:27', '任务列表', 'system:task:list');
INSERT INTO `api` VALUES ('747dde5a-ea5d-4c11-b1bf-fe5293a0f119', '菜单列表', '/api/menu/list', 'GET', 'b423bd85-4c99-4ae0-87ec-25de3589d022', '2021-01-28 21:43:02', '2021-02-04 21:17:58', '菜单列表接口', 'system:menu:list');
INSERT INTO `api` VALUES ('749012aa-c8d0-4e47-a4d0-c506c8b9a293', '更新用户头像', '/api/user/uploadAvatar/:id', 'PUT', 'f3e590f4-f6dd-47e4-b229-1e615f3445bd', '2021-02-04 21:56:07', '2021-02-04 21:56:07', '更新用户头像', 'system:user:avatar');
INSERT INTO `api` VALUES ('75c988d2-591e-4938-9411-47e75de0af2f', '日志列表', '/api/log/list', 'GET', '48fd9ffb-92e6-44e9-a705-ed770777c2de', '2023-03-16 09:42:59', '2023-03-16 09:44:56', '', 'system:log:list');
INSERT INTO `api` VALUES ('7854c1bc-b7d0-4084-8c51-a291d97e27fe', '更新项目任务', '/api/pissue/update', 'PUT', 'ab1be310-50c6-40f4-b6fc-d0e5cde8711c', '2021-04-01 17:02:45', '2021-04-01 17:02:45', '更新项目任务', 'system:pissue:update');
INSERT INTO `api` VALUES ('78b25291-4e59-49b7-b5a3-eee775b9fb59', '收藏类别列表', '/api/ctype/list', 'GET', 'cde78003-7d41-447e-a67a-385b206c7992', '2021-02-05 16:28:59', '2021-02-05 16:28:59', '', 'system:ctype:list');
INSERT INTO `api` VALUES ('7a033480-00aa-487f-8a68-3faf5ba27c99', '删除用户', '/api/user/deleteById/:id', 'DELETE', 'f3e590f4-f6dd-47e4-b229-1e615f3445bd', '2021-02-04 21:36:50', '2021-02-04 21:36:50', '删除用户', 'system:user:delete');
INSERT INTO `api` VALUES ('7aac0e60-e8dd-4605-b71b-746ba3ff0910', '项目任务详情', '/api/pissue/detail/:id', 'GET', 'ab1be310-50c6-40f4-b6fc-d0e5cde8711c', '2021-04-01 17:04:23', '2021-04-01 17:04:38', '项目任务详情', 'system:pissue:detail');
INSERT INTO `api` VALUES ('7cd1a0f3-415c-4614-bc5e-d8f587636955', '任务详情', '/api/task/detail/:id', 'GET', '95591870-f1c9-424c-a6ef-3fb8f34e5ae7', '2021-03-14 16:18:03', '2021-03-14 16:18:03', '任务详情', 'system:task:detail');
INSERT INTO `api` VALUES ('7f6c0770-f68f-40c8-b8d5-8e66defd1402', '用户权限', '/api/user/userApi/:id', 'GET', 'f3e590f4-f6dd-47e4-b229-1e615f3445bd', '2021-02-04 17:18:06', '2021-02-04 21:17:03', '用户所属角色的权限集合：即用户能够访问访问哪些接口，并且主要目的是用来实现按钮级别的权限控制。', 'system:user:api');
INSERT INTO `api` VALUES ('82785d39-b4bc-4c3a-aa95-e70e29fc52b7', '密码列表', '/api/password/list', 'GET', '551c1a92-eef9-41c4-9ed8-e5fd41eea8c1', '2021-02-20 22:05:36', '2021-02-20 22:05:36', '密码列表', 'system:password:list');
INSERT INTO `api` VALUES ('83cec468-1850-40fc-8f6c-bd67556c4946', '项目任务列表', '/api/pissue/list', 'GET', 'ab1be310-50c6-40f4-b6fc-d0e5cde8711c', '2021-04-01 17:05:03', '2021-04-01 17:05:03', '项目任务列表', 'system:pissue:list');
INSERT INTO `api` VALUES ('84626b8b-739f-4a65-8c99-7095a3fb4a65', 'aa', 'aa', 'GET', NULL, '2021-02-07 16:54:53', '2021-02-07 16:54:53', 'aa', 'aa');
INSERT INTO `api` VALUES ('846de02a-1888-4cf6-95aa-624b11888baf', '获取仪表盘', '/api/dash/getByIdentify', 'GET', '49c92b87-f5fa-41a5-876c-96cfaec60428', '2021-06-29 10:46:08', '2021-06-29 10:46:08', '根据标识来获取仪表盘的详情，传参：?identify=identify', 'system:dash:identify');
INSERT INTO `api` VALUES ('88f2695a-e0f1-4fc3-a5e9-f2397aee6779', '用户列表', '/api/user/list', 'GET', 'f3e590f4-f6dd-47e4-b229-1e615f3445bd', '2021-01-28 21:43:19', '2021-02-04 21:17:47', '用户列表接口', 'system:user:list');
INSERT INTO `api` VALUES ('89ab3aa1-8ae4-4b1e-b334-48018c555cc8', '删除日志', '/api/log/deleteById/:id', 'DELETE', '48fd9ffb-92e6-44e9-a705-ed770777c2de', '2023-03-16 09:43:27', '2023-03-16 09:44:51', '', 'system:log:delete');
INSERT INTO `api` VALUES ('8b15ceb3-5fcc-4e8b-9b46-1c8625dfae54', '删除备忘录', '/api/memory/deleteById/:id', 'DELETE', '6208a687-fc34-4ecd-bdc5-d2a66927348c', '2021-02-20 21:55:31', '2021-02-20 21:55:31', '删除备忘录', 'system:memory:delete');
INSERT INTO `api` VALUES ('8cdd5790-e72e-496a-93a7-1926a97dbee6', 'dns查询', '/api/tool/dnsservice', 'GET', '9c60b083-2808-47dc-9cfb-1a8b6c15d24b', '2021-04-16 10:51:14', '2021-04-16 10:51:14', '根据ip和端口查询主机名称和端口所对应的服务名称', 'system:tool:dnsservice');
INSERT INTO `api` VALUES ('8e1e8261-d76c-4f60-b919-c8b269dff0cd', '用户菜单', '/api/user/userMenu/:id', 'GET', 'f3e590f4-f6dd-47e4-b229-1e615f3445bd', '2021-02-04 15:36:45', '2021-02-04 21:17:12', '用户所属角色菜单', 'system:user:menu');
INSERT INTO `api` VALUES ('911c55ac-c7c9-4e81-a091-2fc6a4f5c65b', '删除资源', '/api/resource/delete', 'DELETE', '6dce2757-df47-4c03-b4f1-1662dff2e9bc', '2021-02-21 20:19:24', '2021-02-26 16:56:57', '删除资源：删除数据库数据同时删除本地数据', 'system:resource:delete');
INSERT INTO `api` VALUES ('9d624a51-b580-4bcb-a979-ec0d09ac3e04', '菜单新增', '/api/menu/add', 'POST', 'b423bd85-4c99-4ae0-87ec-25de3589d022', '2021-01-28 21:50:22', '2021-02-04 21:17:26', '菜单新增接口', 'system:menu:add');
INSERT INTO `api` VALUES ('9d8f76fd-d3f9-42e3-9a0a-95de005d766c', '更新接口类别', '/api/apitype/update', 'PUT', 'ffce7eda-2e27-4473-8fc1-d3a3f4caf39a', '2021-02-04 21:11:10', '2021-02-04 21:11:10', '', 'system:apitype:update');
INSERT INTO `api` VALUES ('9dc63664-8e8e-4858-893a-88f44cc69eb0', '移动资源', '/api/resource/move', 'POST', '6dce2757-df47-4c03-b4f1-1662dff2e9bc', '2021-02-23 20:13:33', '2021-02-23 20:13:33', '移动文件/文件夹到指定目录', 'system:resource:move');
INSERT INTO `api` VALUES ('9e3e3a88-6f82-4400-8733-01c6e5450b49', '新增图表', '/api/chart/add', 'POST', '28b70a7b-d6cc-4bcf-9732-73e2ab02c9cf', '2021-04-06 11:33:51', '2021-04-06 11:33:51', '新增图表', 'system:chart:add');
INSERT INTO `api` VALUES ('a0c808cd-645e-4846-b948-23f0ba9c9e97', '百度收录', '/api/tool/baidu', 'POST', '9c60b083-2808-47dc-9cfb-1a8b6c15d24b', '2021-04-15 19:47:14', '2021-04-15 19:47:14', '', 'system:tool:baidu');
INSERT INTO `api` VALUES ('a1ad3463-72e6-4eab-b9c8-33e8b4dbe188', '更新任务', '/api/task/update', 'PUT', '95591870-f1c9-424c-a6ef-3fb8f34e5ae7', '2021-03-14 16:21:51', '2021-03-14 16:23:52', '', 'system:task:update');
INSERT INTO `api` VALUES ('a2ca708f-0e3b-4fdc-b685-fa4e16ed5f9c', '删除账目类别', '/api/accountTag/deleteById/:id', 'DELETE', '063ccfd0-1251-4952-9e70-70bf216bb830', '2021-02-07 13:49:09', '2021-02-07 13:49:09', '', 'system:accountTag:delete');
INSERT INTO `api` VALUES ('a69a03a1-4846-4c8b-95ef-c40e019ff5aa', '新增账目类别', '/api/accountTag/add', 'POST', '063ccfd0-1251-4952-9e70-70bf216bb830', '2021-02-07 13:29:11', '2021-02-07 13:29:11', '注意：order由后台直接定义', 'system:accountTag:add');
INSERT INTO `api` VALUES ('aa64a19c-cb35-488f-99ff-f734f1e4a4f4', '新增密码', '/api/password/add', 'POST', '551c1a92-eef9-41c4-9ed8-e5fd41eea8c1', '2021-02-20 22:02:40', '2021-02-20 22:02:40', '新增密码', 'system:password:add');
INSERT INTO `api` VALUES ('aab52e11-a088-4712-b3e0-93351c992856', '登录密码验证', '/api/user/validPwd', 'POST', 'f3e590f4-f6dd-47e4-b229-1e615f3445bd', '2021-02-20 22:12:27', '2021-02-20 22:12:27', '用户登录密码验证：用于在查看密码时做密码验证', 'system:user:valid');
INSERT INTO `api` VALUES ('ac7126bc-753f-4e15-8b30-71c7397ac0c3', '项目图集详情', '/api/pimage/detail/:id', 'GET', '1ba09b36-0be5-450a-b191-39648523181a', '2021-04-01 16:28:42', '2021-04-01 16:28:42', '项目图集详情', 'system:pimage:detail');
INSERT INTO `api` VALUES ('ac754286-c776-45eb-8c58-e73895986881', '更新密码', '/api/password/update', 'PUT', '551c1a92-eef9-41c4-9ed8-e5fd41eea8c1', '2021-02-20 22:04:35', '2021-02-20 22:04:35', '更新密码', 'system:password:update');
INSERT INTO `api` VALUES ('ad91c81f-26bf-4fd2-a3df-1e05ff854965', '更新角色接口权限', '/api/role/roleApi/:id', 'POST', 'ada58122-a724-4f49-873c-bf96aa993418', '2021-02-04 20:52:43', '2021-02-04 21:16:50', '更新角色的接口权限', 'system:role:api');
INSERT INTO `api` VALUES ('afa06911-f513-48cd-b309-195096957d2f', '新增账目', '/asadsd', 'POST', NULL, '2021-02-07 15:44:08', '2021-02-07 15:44:08', 'asdasd', 'asdasd');
INSERT INTO `api` VALUES ('b049cb4b-a110-46f1-be54-853780160a16', '菜单详情', '/api/menu/detail/:id', 'GET', 'b423bd85-4c99-4ae0-87ec-25de3589d022', '2021-02-04 21:36:07', '2021-02-04 21:36:07', '菜单详情', 'system:menu:detail');
INSERT INTO `api` VALUES ('b59de409-6805-4ad9-8ce7-d7bcf26dfe6f', '更新角色', '/api/role/update', 'PUT', 'ada58122-a724-4f49-873c-bf96aa993418', '2021-01-28 20:06:32', '2021-02-04 21:18:34', '更新角色接口：将role整个对象传递到后台', 'system:role:update');
INSERT INTO `api` VALUES ('b66eb967-4ff7-4ad9-81f2-b0949d03e2ef', 'dns查询ips', '/api/tool/dnsips', 'GET', '9c60b083-2808-47dc-9cfb-1a8b6c15d24b', '2021-04-16 10:52:42', '2021-04-16 10:52:42', '根据域名查询绑定的ips', 'system:tool:dnsips');
INSERT INTO `api` VALUES ('ba33b149-d217-452c-8002-8c156a9082d7', '删除收藏类别', '/api/ctype/deleteById/:id', 'DELETE', 'cde78003-7d41-447e-a67a-385b206c7992', '2021-02-05 16:12:58', '2021-02-05 16:12:58', '删除收藏类别', 'system:ctype:delete');
INSERT INTO `api` VALUES ('ba5238b9-6493-4134-9f32-e21a717fcf5b', '接口详情', '/api/api/detail/:id', 'GET', '33a2b81a-65bf-4141-8576-d89bce803899', '2021-02-04 20:47:32', '2021-02-04 20:47:32', '接口详情', 'sysyem:api:detail');
INSERT INTO `api` VALUES ('bd38c453-24fa-4786-9075-3820055adaff', '删除角色', '/api/role/deleteById/:id', 'DELETE', 'ada58122-a724-4f49-873c-bf96aa993418', '2021-01-28 19:59:51', '2021-02-04 21:18:45', '删除角色接口：id -> 角色id', 'system:role:delete');
INSERT INTO `api` VALUES ('bf835f1f-4cd5-4b09-baee-5b9086cb1d12', '删除定时任务', '/api/task/deleteById/:id', 'DELETE', '95591870-f1c9-424c-a6ef-3fb8f34e5ae7', '2021-03-14 15:55:43', '2021-03-14 15:55:43', '删除任务', 'system:task:delete');
INSERT INTO `api` VALUES ('cc1ccd05-0cf0-4412-b9f3-98254da85a82', '新增项目任务', '/api/pissue/add', 'POST', 'ab1be310-50c6-40f4-b6fc-d0e5cde8711c', '2021-04-01 17:02:16', '2021-04-01 17:02:51', '新增项目任务', 'system:pissue:add');
INSERT INTO `api` VALUES ('cfcdbd3f-cfa9-454a-af51-bbb2de324f74', '资源详情', '/api/resource/info', 'GET', '6dce2757-df47-4c03-b4f1-1662dff2e9bc', '2021-02-21 20:23:09', '2021-02-26 16:42:25', '资源详情', 'system:resource:detail');
INSERT INTO `api` VALUES ('d2ead2a5-cc02-421b-8fec-b2858e22cc7d', '更新资源', '/api/resource/update', 'PUT', '6dce2757-df47-4c03-b4f1-1662dff2e9bc', '2021-02-21 20:20:32', '2021-03-31 14:38:31', '更新资源', 'system:resource:update');
INSERT INTO `api` VALUES ('d3810390-2298-43e7-b4e9-23f801c31340', '账目类别列表', '/api/accountTag/list', 'GET', '063ccfd0-1251-4952-9e70-70bf216bb830', '2021-02-07 13:50:12', '2021-02-07 13:50:12', '', 'system:accounTag:list');
INSERT INTO `api` VALUES ('d3899c5c-b90a-489b-b9cd-9294164ea689', '删除项目文档', '/api/pdocument/deleteById/:id', 'DELETE', 'a16f621b-537a-41ad-9b91-3161d21ac3fd', '2021-04-01 20:02:00', '2021-04-01 20:02:00', '删除项目文档', 'system:pdocument:delete');
INSERT INTO `api` VALUES ('d39df9ee-68f5-46fa-b7fe-11147ea91c01', '接口类别列表', '/api/apitype/list', 'GET', 'ffce7eda-2e27-4473-8fc1-d3a3f4caf39a', '2021-01-28 21:42:36', '2021-02-04 21:18:11', '接口类别列表接口', 'system:apitype:list');
INSERT INTO `api` VALUES ('d58a1365-3704-4c65-8691-cfbad89dc909', '项目文档详情', '/api/pdocument/detail/:id', 'GET', 'a16f621b-537a-41ad-9b91-3161d21ac3fd', '2021-04-01 20:02:43', '2021-04-01 20:02:43', '项目文档详情', 'system:pdocument:detail');
INSERT INTO `api` VALUES ('d92dd87a-a33c-4f51-ba62-6fad251339c8', '下载资源', '/api/resource/download', 'GET', '6dce2757-df47-4c03-b4f1-1662dff2e9bc', '2021-03-15 09:38:39', '2021-03-15 09:38:39', '下载资源', 'system:resource:download');
INSERT INTO `api` VALUES ('da031a73-814e-4874-9bde-c9c0df74195c', '删除项目图集', '/api/pimage/deleteById/:id', 'DELETE', '1ba09b36-0be5-450a-b191-39648523181a', '2021-04-01 16:28:07', '2021-04-01 16:28:07', '删除项目图集', 'system:pimage:delete');
INSERT INTO `api` VALUES ('dad80b3c-ec8d-4823-8a3b-152f88a54e70', '更新仪表盘', '/api/dash/update', 'PUT', '49c92b87-f5fa-41a5-876c-96cfaec60428', '2021-04-06 14:07:11', '2021-04-06 14:07:11', '更新仪表盘', 'system:dash:update');
INSERT INTO `api` VALUES ('dc08bcef-6810-4653-9214-001cb11e2f4c', '图表列表', '/api/chart/list', 'GET', '28b70a7b-d6cc-4bcf-9732-73e2ab02c9cf', '2021-04-06 11:35:45', '2021-04-06 11:35:45', '图表列表', 'system:chart:list');
INSERT INTO `api` VALUES ('ded17f76-230c-4f7d-af87-e04ce13e10a2', '账目详情', '/api/account/detail/:id', 'GET', '84c4ceb0-105b-4003-a2b5-aeb1d021ae1a', '2021-02-20 16:25:04', '2021-02-20 16:25:04', '账目详情', 'system:account:detail');
INSERT INTO `api` VALUES ('defc8fc5-ca70-4949-bde1-87672bbbc61a', '更新备忘录', '/api/memory/update', 'PUT', '6208a687-fc34-4ecd-bdc5-d2a66927348c', '2021-02-20 21:56:13', '2021-02-20 21:56:13', '更新备忘录', 'system:memory:update');
INSERT INTO `api` VALUES ('df489f88-1642-417b-b533-8ffb766ed9d7', '资源列表', '/api/resource/list', 'GET', '6dce2757-df47-4c03-b4f1-1662dff2e9bc', '2021-02-21 20:23:45', '2021-02-21 20:23:45', '资源列表', 'system:resource:list');
INSERT INTO `api` VALUES ('e1dbc6e2-7618-48d3-9e78-df4a0f2063c0', '新增仪表盘', '/api/dash/add', 'POST', '49c92b87-f5fa-41a5-876c-96cfaec60428', '2021-04-06 14:06:34', '2021-04-06 14:06:34', '新增仪表盘', 'system:dash:add');
INSERT INTO `api` VALUES ('e4ab0323-a5e5-4e9c-8708-df9993e8add6', '收藏详情', '/api/collect/detail/:id', 'GET', '0e38a129-39be-4d97-9162-200c4a432cab', '2021-02-05 17:12:14', '2021-02-05 17:12:14', '', 'system:collect:detail');
INSERT INTO `api` VALUES ('e54a0ef0-ca83-4e09-9870-afbb1d33c252', '图表详情', '/api/chart/detail/:id', 'GET', '28b70a7b-d6cc-4bcf-9732-73e2ab02c9cf', '2021-04-06 11:35:15', '2021-04-06 11:35:15', '图表详情', 'system:chart:detail');
INSERT INTO `api` VALUES ('e5fe7b95-26b1-49ca-870c-a188428b5d9d', 'aa', 'aa', 'GET', NULL, '2021-02-07 16:56:11', '2021-02-07 16:56:11', '', 'aa');
INSERT INTO `api` VALUES ('e7340757-a4b6-42e0-83f5-a3a6e8fbdd67', '更新项目文档', '/api/pdocument/update', 'PUT', 'a16f621b-537a-41ad-9b91-3161d21ac3fd', '2021-04-01 20:01:23', '2021-04-01 20:01:23', '更新项目文档', 'system:pdocument:update');
INSERT INTO `api` VALUES ('e8334fba-a1f3-4488-8611-de71b111fc23', '接口列表', '/api/api/list', 'GET', '33a2b81a-65bf-4141-8576-d89bce803899', '2021-01-28 20:12:52', '2021-02-04 21:18:22', '接口管理接口：page、size、sort、order、search、type、tid', 'system:api:list');
INSERT INTO `api` VALUES ('e8d61597-f770-4675-8027-6039673504b1', '用户新增', '/api/user/add', 'POST', 'f3e590f4-f6dd-47e4-b229-1e615f3445bd', '2021-01-28 21:50:43', '2021-02-04 21:16:30', '用户新增接口', 'system:user:add');
INSERT INTO `api` VALUES ('e90658e6-9909-4219-a2b2-461ea68b7ad4', '删除密码', '/api/password/deleteById/:id', 'DELETE', '551c1a92-eef9-41c4-9ed8-e5fd41eea8c1', '2021-02-20 22:03:25', '2021-02-20 22:03:25', '删除密码', 'system:password:delete');
INSERT INTO `api` VALUES ('e95868f3-deef-4848-9722-6dca2a96760d', '新增收藏类别', '/api/ctype/add', 'POST', 'cde78003-7d41-447e-a67a-385b206c7992', '2021-02-05 14:48:49', '2021-02-05 14:48:49', '新增收藏类别', 'system:ctype:add');
INSERT INTO `api` VALUES ('ea179d82-c575-4963-9e63-f36bca11bcd2', '新增项目', '/api/project/add', 'POST', '9b1e9c50-f4a7-4f0a-bb06-3010996b8c6d', '2021-04-01 11:30:41', '2021-04-01 11:30:41', '新增项目', 'system:project:add');
INSERT INTO `api` VALUES ('ef73142d-ed20-411b-96be-32a03582a4a9', '新增定时任务', '/api/task/add', 'POST', '95591870-f1c9-424c-a6ef-3fb8f34e5ae7', '2021-03-14 15:14:30', '2021-03-14 15:14:30', '', 'system:task:add');
INSERT INTO `api` VALUES ('f168201c-50d9-4bb8-a46d-1b3e058de818', '服务监控', '/api/monitor/server', 'GET', '91cc47e2-2443-4686-a97e-f80e7dc4a91e', '2021-03-24 10:01:44', '2021-03-24 10:01:44', '', 'system:monitor:server');
INSERT INTO `api` VALUES ('f3350893-74c8-4049-9f31-a30f0942b530', '更新项目', '/api/project/update', 'PUT', '9b1e9c50-f4a7-4f0a-bb06-3010996b8c6d', '2021-04-01 12:01:58', '2021-04-01 12:01:58', '更新项目', 'system:project:update');
INSERT INTO `api` VALUES ('f5d4bb07-af58-4ccd-93bb-b248dd3035dd', '删除接口类别', '/api/apitype/deleteById/:id', 'DELETE', 'ffce7eda-2e27-4473-8fc1-d3a3f4caf39a', '2021-02-04 21:11:37', '2021-02-04 21:11:37', '', 'system:apitype:delete');
INSERT INTO `api` VALUES ('f7414800-9b6c-49a4-bcc5-6004b5813906', '角色列表', '/api/role/list', 'GET', 'ada58122-a724-4f49-873c-bf96aa993418', '2021-01-28 19:57:46', '2021-02-04 21:18:55', '角色列表接口(筛选条件：search、status、page、size)', 'system:role:list');
INSERT INTO `api` VALUES ('fb3e3587-c0b6-4322-bb2c-7d707f18dea1', '接口新增', '/api/api/add', 'POST', '33a2b81a-65bf-4141-8576-d89bce803899', '2021-01-28 21:51:19', '2021-02-04 21:16:18', '接口新增接口', 'system:api:add');
INSERT INTO `api` VALUES ('fb56e170-071a-476e-8102-ba6ae84443c7', '仪表盘详情', '/api/dash/detail/:id', 'GET', '49c92b87-f5fa-41a5-876c-96cfaec60428', '2021-04-06 14:08:15', '2021-04-06 14:08:15', '仪表盘详情', 'system:dash:detail');
INSERT INTO `api` VALUES ('fb6d4cb8-f596-4de0-b8aa-919338d3732f', 'dns查询ip', '/api/tool/dnsip', 'GET', '9c60b083-2808-47dc-9cfb-1a8b6c15d24b', '2021-04-15 14:51:33', '2021-04-16 10:51:52', '根据给定的域名查询对应的ip地址', 'system:tool:dnsip');
INSERT INTO `api` VALUES ('fbdf9f01-ec47-49a9-adbb-e914d2638c4c', '新增账目', '/api/account/add', 'POST', NULL, '2021-02-07 15:43:11', '2021-02-07 15:43:11', '', 'system:account:add');
INSERT INTO `api` VALUES ('fe1913ca-0ae9-4f5c-a15b-59220cc06752', '删除项目', '/api/project/deleteById/:id', 'DELETE', '9b1e9c50-f4a7-4f0a-bb06-3010996b8c6d', '2021-04-01 13:52:46', '2021-04-01 13:52:46', '删除项目', 'system:project:delete');

-- ----------------------------
-- Table structure for api_type
-- ----------------------------
DROP TABLE IF EXISTS `api_type`;
CREATE TABLE `api_type`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '分类状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类备注',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of api_type
-- ----------------------------
INSERT INTO `api_type` VALUES ('063ccfd0-1251-4952-9e70-70bf216bb830', '账目类别管理', 1, '注意：在新增用户时就应该在数据库中批量添加统一的账目类别', '2021-02-07 11:48:55', '2021-02-07 11:48:55');
INSERT INTO `api_type` VALUES ('0e38a129-39be-4d97-9162-200c4a432cab', '收藏管理', 1, '收藏管理', '2021-02-05 17:01:18', '2021-02-07 17:06:20');
INSERT INTO `api_type` VALUES ('1ba09b36-0be5-450a-b191-39648523181a', '项目图集管理', 1, '项目图集管理', '2021-04-01 16:19:02', '2021-04-01 16:19:02');
INSERT INTO `api_type` VALUES ('28b70a7b-d6cc-4bcf-9732-73e2ab02c9cf', '图表管理', 1, '图表管理', '2021-04-06 11:32:41', '2021-04-06 11:33:18');
INSERT INTO `api_type` VALUES ('33a2b81a-65bf-4141-8576-d89bce803899', '接口管理', 1, '接口管理类别', '2021-01-25 21:07:32', '2021-01-25 21:08:02');
INSERT INTO `api_type` VALUES ('48fd9ffb-92e6-44e9-a705-ed770777c2de', '日志管理', 1, '日志管理类别', '2023-03-16 09:44:45', '2023-03-16 09:44:45');
INSERT INTO `api_type` VALUES ('49c92b87-f5fa-41a5-876c-96cfaec60428', '仪表盘管理', 1, '仪表盘管理', '2021-04-06 14:05:57', '2021-04-06 14:05:57');
INSERT INTO `api_type` VALUES ('551c1a92-eef9-41c4-9ed8-e5fd41eea8c1', '密码管理', 1, '密码管理', '2021-02-20 22:01:14', '2021-02-20 22:01:14');
INSERT INTO `api_type` VALUES ('6208a687-fc34-4ecd-bdc5-d2a66927348c', '备忘录管理', 1, '备忘录管理', '2021-02-20 21:53:40', '2021-02-20 21:53:40');
INSERT INTO `api_type` VALUES ('6dce2757-df47-4c03-b4f1-1662dff2e9bc', '资源管理', 1, '资源管理', '2021-02-21 16:38:54', '2021-02-21 16:38:54');
INSERT INTO `api_type` VALUES ('84c4ceb0-105b-4003-a2b5-aeb1d021ae1a', '账目管理', 1, '账目管理', '2021-02-20 15:19:58', '2021-02-20 15:20:22');
INSERT INTO `api_type` VALUES ('91cc47e2-2443-4686-a97e-f80e7dc4a91e', '监控管理', 1, '监控管理', '2021-03-23 17:00:00', '2021-03-23 17:00:13');
INSERT INTO `api_type` VALUES ('95591870-f1c9-424c-a6ef-3fb8f34e5ae7', '定时任务管理', 1, '定时任务', '2021-03-14 15:14:00', '2021-03-23 10:10:35');
INSERT INTO `api_type` VALUES ('9b1e9c50-f4a7-4f0a-bb06-3010996b8c6d', '项目管理', 1, '项目管理', '2021-04-01 11:26:47', '2021-04-01 11:26:52');
INSERT INTO `api_type` VALUES ('9c60b083-2808-47dc-9cfb-1a8b6c15d24b', '工具管理', 1, '工具管理', '2021-04-15 14:51:05', '2021-04-15 14:51:05');
INSERT INTO `api_type` VALUES ('a16f621b-537a-41ad-9b91-3161d21ac3fd', '项目文档管理', 1, '项目文档管理', '2021-04-01 19:59:38', '2021-04-01 19:59:38');
INSERT INTO `api_type` VALUES ('ab1be310-50c6-40f4-b6fc-d0e5cde8711c', '项目任务管理', 1, '项目任务管理', '2021-04-01 17:01:40', '2021-04-01 17:01:40');
INSERT INTO `api_type` VALUES ('ada58122-a724-4f49-873c-bf96aa993418', '角色管理', 1, '角色管理类别备注', '2021-01-25 21:04:50', '2021-01-25 21:06:26');
INSERT INTO `api_type` VALUES ('b423bd85-4c99-4ae0-87ec-25de3589d022', '菜单管理', 1, '菜单管理类别', '2021-01-25 21:07:23', '2021-01-25 21:07:23');
INSERT INTO `api_type` VALUES ('cde78003-7d41-447e-a67a-385b206c7992', '收藏类别管理', 1, '收藏类别管理', '2021-02-05 14:48:14', '2021-02-05 14:48:14');
INSERT INTO `api_type` VALUES ('f3e590f4-f6dd-47e4-b229-1e615f3445bd', '用户管理', 1, '用户管理类别', '2021-01-25 21:07:15', '2021-01-25 21:07:15');
INSERT INTO `api_type` VALUES ('ffce7eda-2e27-4473-8fc1-d3a3f4caf39a', '接口类别管理', 1, '接口类别管理类别', '2021-01-25 21:08:47', '2021-01-26 20:27:42');

-- ----------------------------
-- Table structure for chart
-- ----------------------------
DROP TABLE IF EXISTS `chart`;
CREATE TABLE `chart`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '组件地址',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chart
-- ----------------------------
INSERT INTO `chart` VALUES ('195ad4d5-334d-4332-8f56-a379179c9b0a', '督办提醒', '', 'cChart11', '2021-08-10 11:36:56', '2021-08-10 11:36:56');
INSERT INTO `chart` VALUES ('21d62492-fb7b-4773-adb6-38c38e989ed3', '快捷操作', '', 'cChart3', '2021-08-10 11:13:45', '2021-08-10 11:13:45');
INSERT INTO `chart` VALUES ('373b5778-85c0-4130-bd7c-a0f06d3dacea', '我参与的会议', '', 'cChart12', '2021-08-10 11:37:10', '2021-08-10 11:37:10');
INSERT INTO `chart` VALUES ('3c7bcff0-2990-4814-8441-abed46c0ba55', '我督办的公文', '', 'cChart7', '2021-08-10 11:27:13', '2021-08-10 11:27:13');
INSERT INTO `chart` VALUES ('63d39989-5b0a-436e-b7d4-1f67fdc0c091', '待办事项', '', 'cChart10', '2021-08-10 11:36:40', '2021-08-10 11:36:40');
INSERT INTO `chart` VALUES ('6807d274-421c-408b-a424-2186ed348850', 'test图表2', '传递参数：title(图表title)', 'cChart2', '2021-08-10 11:07:59', '2021-08-10 11:07:59');
INSERT INTO `chart` VALUES ('6fd00f06-da53-4c05-b4ce-6b9a93475714', '我的日程', '', 'cChart9', '2021-08-10 11:36:24', '2021-08-10 11:36:24');
INSERT INTO `chart` VALUES ('779f355e-633b-49ff-acec-7ad99364ea8d', '公告栏', '', 'cChart4', '2021-08-10 11:20:05', '2021-08-10 11:20:05');
INSERT INTO `chart` VALUES ('98d7464b-9325-46c2-9591-9f8633389b6c', '代办公文', '', 'cChart6', '2021-08-10 11:24:50', '2021-08-10 11:24:50');
INSERT INTO `chart` VALUES ('9c360e31-4bf0-4ec7-a3f9-e5e0f06e9a8c', 'test图表', '传递参数：title(图表title)、theme(图表主题)\n', 'cChart1', '2021-08-10 10:27:35', '2021-08-10 10:27:35');
INSERT INTO `chart` VALUES ('9ca92a35-8e6a-4130-9016-ecbffd907944', '常用APP', '', 'cChart5', '2021-08-10 11:22:54', '2021-08-10 11:22:54');
INSERT INTO `chart` VALUES ('b82c7934-f137-4f40-8e0e-15bd62ef49b6', '待我执行的任务', '', 'cChart13', '2021-08-10 11:37:24', '2021-08-10 11:37:24');
INSERT INTO `chart` VALUES ('f5165f1c-24aa-4ee4-98b6-0ec26f487e08', '常用流程', '', 'cChart8', '2021-08-10 11:36:10', '2021-08-10 11:36:10');
INSERT INTO `chart` VALUES ('fa72deb9-5db5-4dd4-a88c-fab29c272943', '待办流程', '', 'cChart14', '2021-08-10 11:37:36', '2021-08-10 11:37:36');

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收藏名称',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收藏地址',
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收藏logo',
  `repository` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收藏仓库/首页',
  `tag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '收藏标签:使用,分隔',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '收藏备注',
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户id(关联User表)',
  `tid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '收藏类型id(关联collect_type表)',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `tid`(`tid`) USING BTREE,
  CONSTRAINT `collect_ibfk_1097` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `collect_ibfk_1098` FOREIGN KEY (`tid`) REFERENCES `collect_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collect
-- ----------------------------

-- ----------------------------
-- Table structure for collect_type
-- ----------------------------
DROP TABLE IF EXISTS `collect_type`;
CREATE TABLE `collect_type`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '分类状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类备注',
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户id',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collect_type
-- ----------------------------

-- ----------------------------
-- Table structure for dashboard
-- ----------------------------
DROP TABLE IF EXISTS `dashboard`;
CREATE TABLE `dashboard`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `identify` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '唯一标识',
  `layout` json NOT NULL COMMENT '布局配置',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `dashboard_identify`(`identify`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dashboard
-- ----------------------------
INSERT INTO `dashboard` VALUES ('b53a8e33-3ba1-47d7-aabd-e3c4c4896169', '账目管理数据统计', '账目管理数据统计', 'account', '\"{\\\"width\\\":1628,\\\"draggable\\\":true,\\\"resizable\\\":true,\\\"colNum\\\":48,\\\"rowHeight\\\":50,\\\"margin\\\":[15,15],\\\"isMirrored\\\":false,\\\"layout\\\":[{\\\"x\\\":24,\\\"y\\\":6,\\\"w\\\":24,\\\"h\\\":6,\\\"i\\\":11,\\\"className\\\":\\\"active\\\",\\\"url\\\":{\\\"id\\\":\\\"9c360e31-4bf0-4ec7-a3f9-e5e0f06e9a8c\\\",\\\"name\\\":\\\"cChart1\\\",\\\"params\\\":\\\"\\\"},\\\"moved\\\":false},{\\\"x\\\":0,\\\"y\\\":6,\\\"w\\\":24,\\\"h\\\":6,\\\"i\\\":10,\\\"className\\\":\\\"\\\",\\\"url\\\":{\\\"id\\\":\\\"6807d274-421c-408b-a424-2186ed348850\\\",\\\"name\\\":\\\"cChart2\\\",\\\"params\\\":\\\"\\\"},\\\"moved\\\":false},{\\\"x\\\":24,\\\"y\\\":0,\\\"w\\\":24,\\\"h\\\":6,\\\"i\\\":9,\\\"className\\\":\\\"\\\",\\\"url\\\":{\\\"id\\\":\\\"6807d274-421c-408b-a424-2186ed348850\\\",\\\"name\\\":\\\"cChart2\\\",\\\"params\\\":\\\"\\\"},\\\"moved\\\":false},{\\\"x\\\":0,\\\"y\\\":0,\\\"w\\\":24,\\\"h\\\":6,\\\"i\\\":8,\\\"className\\\":\\\"\\\",\\\"url\\\":{\\\"id\\\":\\\"9c360e31-4bf0-4ec7-a3f9-e5e0f06e9a8c\\\",\\\"name\\\":\\\"cChart1\\\",\\\"params\\\":\\\"\\\"},\\\"moved\\\":false}]}\"', '2021-04-15 22:25:54', '2021-04-15 22:25:54');
INSERT INTO `dashboard` VALUES ('c8e089b9-9b59-49e9-8060-76c63759f008', '首页', '该仪表盘主要是用于记录当前用户在本系统上的数据统计', 'home', '\"{\\\"width\\\":1680,\\\"draggable\\\":true,\\\"resizable\\\":true,\\\"colNum\\\":48,\\\"rowHeight\\\":50,\\\"margin\\\":[10,10],\\\"isMirrored\\\":false,\\\"layout\\\":[{\\\"x\\\":0,\\\"y\\\":5,\\\"w\\\":25,\\\"h\\\":6,\\\"i\\\":28,\\\"className\\\":\\\"\\\",\\\"url\\\":{\\\"id\\\":\\\"9c360e31-4bf0-4ec7-a3f9-e5e0f06e9a8c\\\",\\\"name\\\":\\\"cChart1\\\",\\\"params\\\":\\\"\\\"},\\\"moved\\\":false},{\\\"x\\\":25,\\\"y\\\":5,\\\"w\\\":23,\\\"h\\\":9,\\\"i\\\":27,\\\"className\\\":\\\"\\\",\\\"url\\\":{\\\"id\\\":\\\"373b5778-85c0-4130-bd7c-a0f06d3dacea\\\",\\\"name\\\":\\\"cChart12\\\",\\\"params\\\":\\\"\\\"},\\\"moved\\\":false},{\\\"x\\\":0,\\\"y\\\":11,\\\"w\\\":25,\\\"h\\\":9,\\\"i\\\":25,\\\"className\\\":\\\"\\\",\\\"url\\\":{\\\"id\\\":\\\"6fd00f06-da53-4c05-b4ce-6b9a93475714\\\",\\\"name\\\":\\\"cChart9\\\",\\\"params\\\":\\\"\\\"},\\\"moved\\\":false},{\\\"x\\\":0,\\\"y\\\":0,\\\"w\\\":25,\\\"h\\\":5,\\\"i\\\":24,\\\"className\\\":\\\"\\\",\\\"url\\\":{\\\"id\\\":\\\"195ad4d5-334d-4332-8f56-a379179c9b0a\\\",\\\"name\\\":\\\"cChart11\\\",\\\"params\\\":\\\"\\\"},\\\"moved\\\":false},{\\\"x\\\":25,\\\"y\\\":0,\\\"w\\\":23,\\\"h\\\":5,\\\"i\\\":22,\\\"className\\\":\\\"\\\",\\\"url\\\":{\\\"id\\\":\\\"63d39989-5b0a-436e-b7d4-1f67fdc0c091\\\",\\\"name\\\":\\\"cChart10\\\",\\\"params\\\":\\\"\\\"},\\\"moved\\\":false},{\\\"x\\\":14,\\\"y\\\":25,\\\"w\\\":34,\\\"h\\\":5,\\\"i\\\":21,\\\"className\\\":\\\"\\\",\\\"url\\\":{\\\"id\\\":\\\"3c7bcff0-2990-4814-8441-abed46c0ba55\\\",\\\"name\\\":\\\"cChart7\\\",\\\"params\\\":\\\"\\\"},\\\"moved\\\":false},{\\\"x\\\":25,\\\"y\\\":14,\\\"w\\\":23,\\\"h\\\":6,\\\"i\\\":20,\\\"className\\\":\\\"\\\",\\\"url\\\":{\\\"id\\\":\\\"fa72deb9-5db5-4dd4-a88c-fab29c272943\\\",\\\"name\\\":\\\"cChart14\\\",\\\"params\\\":\\\"\\\"},\\\"moved\\\":false},{\\\"x\\\":0,\\\"y\\\":20,\\\"w\\\":48,\\\"h\\\":5,\\\"i\\\":18,\\\"className\\\":\\\"\\\",\\\"url\\\":{\\\"id\\\":\\\"21d62492-fb7b-4773-adb6-38c38e989ed3\\\",\\\"name\\\":\\\"cChart3\\\",\\\"params\\\":\\\"\\\"},\\\"moved\\\":false},{\\\"x\\\":0,\\\"y\\\":25,\\\"w\\\":14,\\\"h\\\":5,\\\"i\\\":16,\\\"className\\\":\\\"active\\\",\\\"url\\\":{\\\"id\\\":\\\"9ca92a35-8e6a-4130-9016-ecbffd907944\\\",\\\"name\\\":\\\"cChart5\\\",\\\"params\\\":\\\"\\\"},\\\"moved\\\":false}]}\"', '2021-04-06 15:48:44', '2021-04-06 15:48:44');

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
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-05-17 14:11:16' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-05-17 14:11:16' COMMENT '图标更新时间',
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
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-05-17 14:11:16' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-05-17 14:11:16' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of icon_project
-- ----------------------------
INSERT INTO `icon_project` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51c1', '个人信息管理系统', '个人信息管理系统，主要是在系统内使用，有管理员进行维护', 'infoicon', 'info-', '//at.alicdn.com/t/font_2246210_dg83mt99oye.css', NULL, '2020-01-14 17:09:24', '2020-01-14 17:09:24');

-- ----------------------------
-- Table structure for logs
-- ----------------------------
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '日志id',
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作用户',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作信息',
  `client_info` json NULL COMMENT '客户端信息',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作类型',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logs
-- ----------------------------
INSERT INTO `logs` VALUES ('23b8c801-f004-4d68-92ea-2ff0fdbdb731', '9f9ead70-8320-41d5-9c32-822262866390', 'admin', '登录成功', '{\"ip\": \"127.0.0.1\", \"city\": \"\", \"adcode\": \"\", \"province\": \"\", \"rectangle\": {\"x\": \"\", \"y\": \"\"}}', '登录系统', '2024-01-30 08:55:51');
INSERT INTO `logs` VALUES ('5a3c64ae-8e65-4f93-b320-0d3ab8f61760', '9f9ead70-8320-41d5-9c32-822262866390', 'admin', '登录成功', '{\"ip\": \"127.0.0.1\", \"city\": \"\", \"adcode\": \"\", \"province\": \"\", \"rectangle\": {\"x\": \"\", \"y\": \"\"}}', '登录系统', '2024-01-30 08:59:00');

-- ----------------------------
-- Table structure for memory
-- ----------------------------
DROP TABLE IF EXISTS `memory`;
CREATE TABLE `memory`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '备忘录名称',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '备忘录内容(html)',
  `tag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '备忘录标签',
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '更新时间',
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '备忘录内容',
  `priority` float NOT NULL DEFAULT 0 COMMENT '重要性',
  `type` int(11) NOT NULL DEFAULT 1 COMMENT '1: 富文本 2：markdown',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `memory_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of memory
-- ----------------------------

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
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '菜单创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '菜单更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `menu` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('01cf1b9c-b18a-4f63-82b9-d74bc85a6345', '定时任务', 'fa77a36c-7a7d-4cde-88a6-df299513885e', 1, '/monitor/job', 'Index', 1, 0, 1, 1, 'el-icon-date', '', '2021-03-18 15:45:37', '2021-03-19 16:47:40');
INSERT INTO `menu` VALUES ('05f05171-2473-422c-90ed-dbd5970a09d9', '备忘录详情', 'ac325c62-5473-44db-81a3-61dc9c83a39c', 1, '/info/memory/detail/:id', 'MemoryDetail', 2, 0, 0, 1, 'el-icon-upload2', '', '2021-03-18 15:41:41', '2021-03-18 21:43:20');
INSERT INTO `menu` VALUES ('0905e23f-3e45-4e05-90de-92a3080637dd', '授权管理', 'd6aa09e9-a1b7-47fb-b073-311e873af633', 7, '/system/permission/:id', 'SystemPermission', 2, 0, 0, 1, 'el-icon-document-checked', '角色授权管理', '2021-03-18 15:19:50', '2021-04-07 09:21:13');
INSERT INTO `menu` VALUES ('0b078aed-3592-4a1e-af9c-07c84be7acd3', '信息管理', NULL, 2, '/info', 'Layout', 1, 0, 1, 1, 'el-icon-takeaway-box', '信息管理：包括密码管理、就学信息管理、就业信息以及基本信息管理', '2021-01-20 15:47:31', '2021-04-07 09:34:18');
INSERT INTO `menu` VALUES ('0fd0c748-9cfd-42e3-ab31-8714966e054d', '收藏管理', '0b078aed-3592-4a1e-af9c-07c84be7acd3', 5, '/info/collect', 'CollectList', 2, 0, 1, 1, 'el-icon-collection', '', '2021-03-18 15:51:11', '2021-03-22 15:43:33');
INSERT INTO `menu` VALUES ('19268e0c-930d-449d-9658-3038041049c8', '首页', 'c9c254a7-ddc7-4a05-b1c2-c08293638dec', 1, '/home', 'Home', 2, 0, 1, 1, 'el-icon-s-home', '首页.....', '2021-04-07 09:36:13', '2021-04-07 09:36:13');
INSERT INTO `menu` VALUES ('2896ee43-3191-4309-a322-5d3c063ae92c', '新增备忘录', 'ac325c62-5473-44db-81a3-61dc9c83a39c', 1, '/info/memory/add', 'MemoryAdd', 2, 0, 0, 1, 'el-icon-location-information', '', '2021-03-18 15:40:00', '2021-03-29 11:25:23');
INSERT INTO `menu` VALUES ('2a1ef27c-2c0e-4a1a-ae91-56032fe3220c', '站点收录', '7effd89e-98a7-48ae-bf3d-c0f065b53643', 4, '/system/include', 'ToolInclude', 2, 0, 1, 1, 'el-icon-location-information', '百度站长录入链接', '2021-04-01 10:35:15', '2021-04-07 09:25:29');
INSERT INTO `menu` VALUES ('31c32158-65cc-46d4-a7f1-76c00345f685', '更新项目', '7094f8ef-1079-4e3e-a49b-615ef7abcd4b', 6, '/info/project/edit/:id', 'ProjectDialog', 2, 0, 0, 1, 'el-icon-s-check', '更新项目', '2021-04-07 09:47:15', '2021-04-07 10:04:28');
INSERT INTO `menu` VALUES ('3c1a1682-4278-4ea2-8a4f-7e0680ad532d', '地图展示', '7effd89e-98a7-48ae-bf3d-c0f065b53643', 3, '/tool/map', 'ToolMap', 2, 0, 1, 1, 'el-icon-data-line', '', '2021-03-24 11:33:20', '2021-04-14 17:06:48');
INSERT INTO `menu` VALUES ('48cc1099-b411-4a3c-bdc2-82f6f6fd3504', '文件上传', '62885d55-7388-42d4-ae1c-c085c49da3a7', 1, '/info/resource/upload', 'ResourceUpload', 2, 0, 0, 1, 'el-icon-upload', '', '2021-03-18 15:35:08', '2021-03-18 20:08:35');
INSERT INTO `menu` VALUES ('5ee44613-3e0d-41fd-971e-d2f14caae2c1', '项目列表', '7094f8ef-1079-4e3e-a49b-615ef7abcd4b', 1, '/info/project/list', 'ProjectList', 2, 0, 1, 1, 'el-icon-tickets', '项目列表', '2021-04-07 09:45:30', '2021-04-07 09:45:30');
INSERT INTO `menu` VALUES ('60a886d7-a715-422b-b7a1-d2a16cd642af', '服务监控', 'fa77a36c-7a7d-4cde-88a6-df299513885e', 2, '/monitor/server', 'MonitorServer', 2, 0, 1, 1, 'el-icon-service', '', '2021-03-18 15:46:11', '2021-04-07 09:35:14');
INSERT INTO `menu` VALUES ('6121f732-a635-429e-a71c-f434573d012c', '仪表盘布局', 'a08baf3f-3229-4c15-961d-bb25de1184fe', 2, '/system/dash/layout/:id', 'SystemDashLayout', 2, 0, 0, 1, 'el-icon-takeaway-box', '更新仪表盘', '2021-04-06 15:01:42', '2021-04-06 15:23:37');
INSERT INTO `menu` VALUES ('619ba5b2-fae1-4581-9491-1dcd8299b1d4', '图表管理', 'd6aa09e9-a1b7-47fb-b073-311e873af633', 5, '/syste/chart', 'SystemChart', 2, 0, 1, 1, 'el-icon-s-data', '图表管理', '2021-04-01 10:32:32', '2021-04-07 09:21:01');
INSERT INTO `menu` VALUES ('62885d55-7388-42d4-ae1c-c085c49da3a7', '文件管理', '0b078aed-3592-4a1e-af9c-07c84be7acd3', 1, '/info/resource', 'Index', 1, 0, 1, 1, 'el-icon-folder', '', '2021-03-18 15:31:17', '2021-03-22 15:40:58');
INSERT INTO `menu` VALUES ('7094f8ef-1079-4e3e-a49b-615ef7abcd4b', '项目管理', '0b078aed-3592-4a1e-af9c-07c84be7acd3', 2, '/info/project', 'Index', 2, 0, 1, 1, 'el-icon-s-grid', '', '2021-03-18 15:43:00', '2021-04-07 09:44:19');
INSERT INTO `menu` VALUES ('7af760e6-bcbd-4059-8013-46bd0ac34c43', '日志管理', 'd6aa09e9-a1b7-47fb-b073-311e873af633', 1, '/system/log', 'SystemLog', 1, 0, 1, 1, 'el-icon-location-information', '', '2023-03-16 09:40:18', '2023-03-16 12:15:58');
INSERT INTO `menu` VALUES ('7effd89e-98a7-48ae-bf3d-c0f065b53643', '系统工具', NULL, 5, '/tool', 'Layout', 1, 0, 1, 1, 'el-icon-s-cooperation', '', '2021-03-24 11:19:20', '2021-09-22 17:16:35');
INSERT INTO `menu` VALUES ('87017e19-8944-43cf-b4c1-977d35ce369a', '项目图集', '7094f8ef-1079-4e3e-a49b-615ef7abcd4b', 2, '/info/project/image/:id', 'ProjectImage', 2, 0, 0, 1, 'el-icon-picture', '项目图集', '2021-04-07 09:50:57', '2021-04-07 10:03:57');
INSERT INTO `menu` VALUES ('8eb724a8-6f43-4b1c-b07e-49341c168533', '菜单管理', 'd6aa09e9-a1b7-47fb-b073-311e873af633', 3, '/system/menu', 'SystemMenu', 2, 0, 1, 1, 'el-icon-menu', '系统管理 - 菜单管理', '2021-01-20 09:31:51', '2021-04-07 09:20:43');
INSERT INTO `menu` VALUES ('907301ae-ee2a-49da-a0f3-aaf862d1f5fb', '项目文档', '7094f8ef-1079-4e3e-a49b-615ef7abcd4b', 3, '/info/project/document/:id', 'ProjectDocument', 2, 0, 0, 1, 'el-icon-document', '项目文档', '2021-04-07 09:53:43', '2021-04-07 10:04:05');
INSERT INTO `menu` VALUES ('9c88d4bb-257c-45ee-a991-1397ba41c703', '更新备忘录', 'ac325c62-5473-44db-81a3-61dc9c83a39c', 1, '/info/memory/edit/:id', 'MemoryEdit', 2, 0, 0, 1, 'el-icon-date', '', '2021-03-18 15:40:55', '2021-03-29 11:25:31');
INSERT INTO `menu` VALUES ('9ed4a91e-b01f-4aee-b672-98b6c5ff8a95', 'DNS工具', '7effd89e-98a7-48ae-bf3d-c0f065b53643', 1, '/tool/dns', 'ToolDns', 2, 0, 1, 1, 'el-icon-takeaway-box', '', '2021-03-24 11:22:27', '2021-03-24 11:38:51');
INSERT INTO `menu` VALUES ('a08baf3f-3229-4c15-961d-bb25de1184fe', '仪表盘管理', 'd6aa09e9-a1b7-47fb-b073-311e873af633', 6, '/system/dash', 'Index', 1, 0, 1, 1, 'el-icon-s-grid', '仪表盘管理', '2021-04-01 10:31:11', '2021-04-06 14:58:54');
INSERT INTO `menu` VALUES ('a3136729-f426-49e4-87d2-79497d5e72e0', '角色管理', 'd6aa09e9-a1b7-47fb-b073-311e873af633', 1, '/system/role', 'SystemRole', 2, 0, 1, 1, 'el-icon-user-solid', '系统管理 - 角色管理', '2021-01-20 09:31:51', '2021-04-07 09:20:20');
INSERT INTO `menu` VALUES ('ab5ef7e1-64e5-4cb3-9e5f-a8fc7ad6b1bb', '任务日志', '01cf1b9c-b18a-4f63-82b9-d74bc85a6345', 1, '/monitor/job/log/:id', 'MonitorJobLog', 2, 0, 0, 1, 'el-icon-tickets', '', '2021-03-19 16:53:03', '2021-03-19 16:53:03');
INSERT INTO `menu` VALUES ('ac325c62-5473-44db-81a3-61dc9c83a39c', '备忘录管理', '0b078aed-3592-4a1e-af9c-07c84be7acd3', 4, '/info/memory', 'Index', 1, 0, 1, 1, 'el-icon-document', '', '2021-03-18 15:38:20', '2021-03-22 15:41:12');
INSERT INTO `menu` VALUES ('b38badcd-e38e-4483-99ea-f7a706806593', '更新任务', '01cf1b9c-b18a-4f63-82b9-d74bc85a6345', 1, '/monitor/job/edit/:id', 'MonitorJobDialog', 2, 0, 0, 1, 'el-icon-share', '', '2021-03-19 16:52:05', '2021-03-19 16:52:05');
INSERT INTO `menu` VALUES ('b59167e5-43e8-482a-a3f7-22e20ce81716', '新增项目', '7094f8ef-1079-4e3e-a49b-615ef7abcd4b', 5, '/info/project/add', 'ProjectDialog', 2, 0, 0, 1, 'el-icon-camera-solid', '新增项目', '2021-04-07 09:46:27', '2021-04-07 10:04:21');
INSERT INTO `menu` VALUES ('b71342a7-2448-451e-a08e-bafb1165a1c7', '文件列表', '62885d55-7388-42d4-ae1c-c085c49da3a7', 1, '/info/resource/list', 'ResourceList', 2, 0, 1, 1, 'el-icon-folder', '', '2021-03-18 15:32:21', '2021-03-18 20:12:59');
INSERT INTO `menu` VALUES ('bc262ac5-d198-4fcc-8fdc-7459bdc538ad', '用户管理', 'd6aa09e9-a1b7-47fb-b073-311e873af633', 2, '/system/user', 'SystemUser', 2, 0, 1, 1, 'el-icon-user', '系统管理 - 用户管理', '2021-01-15 10:10:02', '2021-04-07 09:20:32');
INSERT INTO `menu` VALUES ('c2a86202-2026-47ce-9c5d-431631ea5978', '项目任务', '7094f8ef-1079-4e3e-a49b-615ef7abcd4b', 4, '/info/project/issues/:id', 'ProjectIssues', 2, 0, 0, 1, 'el-icon-collection-tag', '项目任务', '2021-04-07 09:56:48', '2021-04-07 10:06:52');
INSERT INTO `menu` VALUES ('c9c254a7-ddc7-4a05-b1c2-c08293638dec', '首页', NULL, 1, '/', 'Layout', 1, 0, 1, 1, 'el-icon-s-home', '首页', '2021-04-07 09:33:13', '2021-04-07 09:33:13');
INSERT INTO `menu` VALUES ('c9ee88dd-7880-474a-b3ab-84f25d8b8620', '仪表盘列表', 'a08baf3f-3229-4c15-961d-bb25de1184fe', 4, '/system/dash/list', 'SystemDashList', 2, 0, 1, 1, 'el-icon-s-marketing', '仪表盘列表', '2021-04-06 14:59:54', '2021-04-06 15:06:21');
INSERT INTO `menu` VALUES ('d0aeec63-0e3b-4c21-82f0-f679dca848db', '新增任务', '01cf1b9c-b18a-4f63-82b9-d74bc85a6345', 1, '/monitor/job/add', 'MonitorJobDialog', 2, 0, 0, 1, 'el-icon-s-data', '', '2021-03-19 16:50:15', '2021-03-19 16:50:36');
INSERT INTO `menu` VALUES ('d6aa09e9-a1b7-47fb-b073-311e873af633', '系统管理', NULL, 3, '/system', 'Layout', 1, 0, 1, 1, 'el-icon-setting', '系统管理', '2021-01-15 10:10:02', '2021-04-07 09:34:29');
INSERT INTO `menu` VALUES ('d6cf74bb-09c4-4fe3-a69d-c48287634bff', '密码管理', '0b078aed-3592-4a1e-af9c-07c84be7acd3', 3, '/info/password', 'PasswordList', 2, 0, 1, 1, 'el-icon-lock', '', '2021-03-18 15:36:40', '2021-03-22 15:41:18');
INSERT INTO `menu` VALUES ('da12c8fa-ecfc-4529-b5c3-caf0b3ebcfe9', '系统监控', 'fa77a36c-7a7d-4cde-88a6-df299513885e', 3, '/monitor/system', 'MonitorSystem', 2, 0, 1, 1, 'el-icon-data-line', '', '2021-03-18 15:47:25', '2021-04-07 09:35:20');
INSERT INTO `menu` VALUES ('e07658e7-bf05-4f8c-9d31-fc1e2bb46580', '账目管理', '0b078aed-3592-4a1e-af9c-07c84be7acd3', 5, '/info/account', 'AccountList', 2, 0, 1, 1, 'el-icon-s-marketing', '', '2021-03-18 15:37:32', '2021-03-22 15:41:25');
INSERT INTO `menu` VALUES ('e660aaeb-94de-46f7-a941-bed746d42141', '备忘录列表', 'ac325c62-5473-44db-81a3-61dc9c83a39c', 1, '/info/memory/list', 'MemoryList', 2, 0, 1, 1, 'el-icon-document', '', '2021-03-18 15:39:23', '2021-03-18 20:16:24');
INSERT INTO `menu` VALUES ('f2356217-8f8f-49bc-ab66-cf6791d23c7f', '表单构建', '7effd89e-98a7-48ae-bf3d-c0f065b53643', 2, '/tool/build', 'ToolForm', 2, 0, 1, 0, 'el-icon-date', '', '2021-03-24 11:26:40', '2021-04-26 20:21:16');
INSERT INTO `menu` VALUES ('fa0a0bef-ebb7-44ae-860a-1fef98d9e69a', '任务列表', '01cf1b9c-b18a-4f63-82b9-d74bc85a6345', 1, '/monitor/job/list', 'MonitorJob', 2, 0, 1, 1, 'el-icon-date', '', '2021-03-19 16:49:09', '2021-03-30 14:22:21');
INSERT INTO `menu` VALUES ('fa77a36c-7a7d-4cde-88a6-df299513885e', '系统监控', NULL, 4, '/monitor', 'Layout', 1, 0, 1, 1, 'el-icon-video-camera-solid', '', '2021-03-18 15:29:37', '2021-04-07 09:34:35');
INSERT INTO `menu` VALUES ('fdf1ab35-dab2-402f-911a-9e9eb2cfadd4', '接口管理', 'd6aa09e9-a1b7-47fb-b073-311e873af633', 4, '/system/api', 'SystemApi', 2, 0, 1, 1, 'el-icon-lock', '系统管理 - 接口管理(还需要做进一步更改，现在没有查询出三级的菜单)', '2021-01-25 11:34:41', '2021-04-07 09:20:52');

-- ----------------------------
-- Table structure for password
-- ----------------------------
DROP TABLE IF EXISTS `password`;
CREATE TABLE `password`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '网址',
  `type` int(11) NOT NULL DEFAULT 1 COMMENT '类型：1网站/0软件',
  `account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `password_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password
-- ----------------------------

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `type` int(11) NOT NULL DEFAULT 1 COMMENT '类型：2内部项目/3外包项目/1个人项目',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '1开始/2暂停/3关闭',
  `tag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '技术标签',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '源代码存放位置',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部署地址',
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project
-- ----------------------------

-- ----------------------------
-- Table structure for project_document
-- ----------------------------
DROP TABLE IF EXISTS `project_document`;
CREATE TABLE `project_document`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '文档内容',
  `pid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '所对应项目',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '更新时间',
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '文档文本',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  CONSTRAINT `project_document_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_document
-- ----------------------------

-- ----------------------------
-- Table structure for project_image
-- ----------------------------
DROP TABLE IF EXISTS `project_image`;
CREATE TABLE `project_image`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片存放位置',
  `pid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '所对应项目',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  CONSTRAINT `project_image_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_image
-- ----------------------------

-- ----------------------------
-- Table structure for project_issue
-- ----------------------------
DROP TABLE IF EXISTS `project_issue`;
CREATE TABLE `project_issue`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `pid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '所对应项目',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '更新时间',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  `tag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签',
  `priority` int(11) NOT NULL DEFAULT 1 COMMENT '优先级',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '状态：1',
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  CONSTRAINT `project_issue_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_issue
-- ----------------------------

-- ----------------------------
-- Table structure for resource
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件名称',
  `is_dir` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否目录',
  `size` bigint(20) NULL DEFAULT 0 COMMENT '文件大小',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件位置',
  `extension` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件扩展名',
  `share` json NOT NULL COMMENT '文件共享',
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户',
  `pid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '上级菜单id',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-02-25 21:09:58' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2021-02-25 21:09:58' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  CONSTRAINT `resource_ibfk_175` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resource_ibfk_176` FOREIGN KEY (`pid`) REFERENCES `resource` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resource
-- ----------------------------

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
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '修改时间',
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
INSERT INTO `role` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'guest', 1, 1, 'guest', '2021-08-25 13:40:46', '2021-08-25 13:40:46');
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
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '00117824-fe9b-437c-9e60-45a37705b938');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '00117824-fe9b-437c-9e60-45a37705b938');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '00117824-fe9b-437c-9e60-45a37705b938');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '00779ef3-f25f-4ca9-b973-0d064c8a0455');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '00779ef3-f25f-4ca9-b973-0d064c8a0455');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '00779ef3-f25f-4ca9-b973-0d064c8a0455');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '01be6278-b671-414d-813b-51ee04d42aaa');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '01be6278-b671-414d-813b-51ee04d42aaa');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '024189a1-e925-456a-9fff-0a9bdb3e6796');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '024189a1-e925-456a-9fff-0a9bdb3e6796');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '0252df87-1553-4669-a80d-34adc65858d8');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '0252df87-1553-4669-a80d-34adc65858d8');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '0252df87-1553-4669-a80d-34adc65858d8');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '0361a099-286b-4286-9842-fb4cceb4437f');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '0375e206-73e0-4c9e-b4cf-f4f01da71139');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '0375e206-73e0-4c9e-b4cf-f4f01da71139');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '0375e206-73e0-4c9e-b4cf-f4f01da71139');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '05a4a8d7-d292-4e9a-ad71-bcd5d4c82df9');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '05a4a8d7-d292-4e9a-ad71-bcd5d4c82df9');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '05a4a8d7-d292-4e9a-ad71-bcd5d4c82df9');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '0a359501-f9fc-4dab-9bb9-13f84b9346dd');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '0a359501-f9fc-4dab-9bb9-13f84b9346dd');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '0a359501-f9fc-4dab-9bb9-13f84b9346dd');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '0c84eeba-af23-482d-9524-b91d9f0db86e');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '0c84eeba-af23-482d-9524-b91d9f0db86e');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '0c84eeba-af23-482d-9524-b91d9f0db86e');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '0d26ac8b-f908-4eb3-aaa0-c6b43d11740e');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '0d26ac8b-f908-4eb3-aaa0-c6b43d11740e');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '0d26ac8b-f908-4eb3-aaa0-c6b43d11740e');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '0f00e73b-8bce-400d-9d65-4c8f71025e6f');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '0f00e73b-8bce-400d-9d65-4c8f71025e6f');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '0f00e73b-8bce-400d-9d65-4c8f71025e6f');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '10256b33-d95a-4fc7-ad6c-e1d6ac6b4d96');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '10256b33-d95a-4fc7-ad6c-e1d6ac6b4d96');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '12a3c5eb-1bc7-4a2c-b50a-df3b7c9cbe7d');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '12a3c5eb-1bc7-4a2c-b50a-df3b7c9cbe7d');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '12a3c5eb-1bc7-4a2c-b50a-df3b7c9cbe7d');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '15637fd5-c65d-4d8a-8e52-816c3ed368c1');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '15637fd5-c65d-4d8a-8e52-816c3ed368c1');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '15637fd5-c65d-4d8a-8e52-816c3ed368c1');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '1a67bb29-db31-43ef-88ca-b654c56de9e7');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '1a67bb29-db31-43ef-88ca-b654c56de9e7');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '1a67bb29-db31-43ef-88ca-b654c56de9e7');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '1e39ac41-bad5-414c-a17a-0c7c5a5e6b8c');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '1e39ac41-bad5-414c-a17a-0c7c5a5e6b8c');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '1e39ac41-bad5-414c-a17a-0c7c5a5e6b8c');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '1e852c7f-2051-4ec6-b194-36a2d1b59d7e');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '1e852c7f-2051-4ec6-b194-36a2d1b59d7e');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '1e852c7f-2051-4ec6-b194-36a2d1b59d7e');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '20c5cbf2-84f7-43a6-883b-69e7c7335a93');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '20c5cbf2-84f7-43a6-883b-69e7c7335a93');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '20c5cbf2-84f7-43a6-883b-69e7c7335a93');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '25b23f76-4b3e-4945-8073-8d1165ca2b13');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '25b23f76-4b3e-4945-8073-8d1165ca2b13');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '25b23f76-4b3e-4945-8073-8d1165ca2b13');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '261f356a-9761-46e4-b5b3-cb4a1d5fbd90');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '261f356a-9761-46e4-b5b3-cb4a1d5fbd90');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '261f356a-9761-46e4-b5b3-cb4a1d5fbd90');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '27a0373c-161c-49b8-a7f9-37b90f040e1b');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '27a0373c-161c-49b8-a7f9-37b90f040e1b');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '27a0373c-161c-49b8-a7f9-37b90f040e1b');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '2ca8c52b-bea7-47c0-bd6f-34d54fd3282f');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '2ca8c52b-bea7-47c0-bd6f-34d54fd3282f');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '2ca8c52b-bea7-47c0-bd6f-34d54fd3282f');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '31b3bab7-e8cf-46c1-afaf-cf3a351e203e');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '31b3bab7-e8cf-46c1-afaf-cf3a351e203e');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '3812bfc3-2a26-49dd-bb63-f1d263e33a92');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '3812bfc3-2a26-49dd-bb63-f1d263e33a92');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '3bd465c9-01e9-45b0-9937-5a4fe0adeeba');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '3bd465c9-01e9-45b0-9937-5a4fe0adeeba');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '3bd465c9-01e9-45b0-9937-5a4fe0adeeba');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '3c0b86d4-e402-487a-856c-cef073329c29');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '3c0b86d4-e402-487a-856c-cef073329c29');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '3dad21a5-f0ee-45bc-979d-2dcfc3ebda5f');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '3dad21a5-f0ee-45bc-979d-2dcfc3ebda5f');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '3dad21a5-f0ee-45bc-979d-2dcfc3ebda5f');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '4083a29f-a997-451c-8e16-530b0ea49497');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '4083a29f-a997-451c-8e16-530b0ea49497');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '4083a29f-a997-451c-8e16-530b0ea49497');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '445d4b9a-cfbf-4cca-9949-1e8d07e0c00f');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '4aa6e8e0-36eb-4a1f-8e64-080d5e821227');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '4aa6e8e0-36eb-4a1f-8e64-080d5e821227');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '4aa6e8e0-36eb-4a1f-8e64-080d5e821227');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '4e849fd8-15b7-4229-a075-76bbe5730f32');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '4e849fd8-15b7-4229-a075-76bbe5730f32');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '4e849fd8-15b7-4229-a075-76bbe5730f32');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '4ec56ea3-de06-45bb-84a1-d5028a658b92');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '4ec56ea3-de06-45bb-84a1-d5028a658b92');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '4ec56ea3-de06-45bb-84a1-d5028a658b92');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '4f83f8ed-f5d2-4150-b9a6-70d19482d285');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '4f83f8ed-f5d2-4150-b9a6-70d19482d285');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '4f83f8ed-f5d2-4150-b9a6-70d19482d285');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '51d780e1-e650-46fe-91bb-ebf9e707a0fc');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '51d780e1-e650-46fe-91bb-ebf9e707a0fc');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '51d780e1-e650-46fe-91bb-ebf9e707a0fc');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '52468b7e-6133-4067-89d3-553deba71fbe');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '52468b7e-6133-4067-89d3-553deba71fbe');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '52468b7e-6133-4067-89d3-553deba71fbe');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '52c0c717-844f-4f57-bf9a-775f1f46b687');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '52c0c717-844f-4f57-bf9a-775f1f46b687');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '52c0c717-844f-4f57-bf9a-775f1f46b687');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '55203038-11cf-42c3-a42e-85cd95ce358e');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '55203038-11cf-42c3-a42e-85cd95ce358e');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '55203038-11cf-42c3-a42e-85cd95ce358e');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '596c78fb-88c7-4979-8dea-4d25d55120ec');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '596c78fb-88c7-4979-8dea-4d25d55120ec');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '596c78fb-88c7-4979-8dea-4d25d55120ec');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '5a3f5f67-e89a-4e9e-a483-41997ecd333c');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '5a3f5f67-e89a-4e9e-a483-41997ecd333c');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '5a3f5f67-e89a-4e9e-a483-41997ecd333c');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '5e379be1-116a-48e2-98e6-2baa2ba51c6d');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '5e379be1-116a-48e2-98e6-2baa2ba51c6d');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '5e379be1-116a-48e2-98e6-2baa2ba51c6d');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '62711d38-9990-417d-bc6b-64f761b8cffe');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '62711d38-9990-417d-bc6b-64f761b8cffe');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '62711d38-9990-417d-bc6b-64f761b8cffe');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '65df3992-1c01-4a69-9a6c-694c4f262dba');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '65df3992-1c01-4a69-9a6c-694c4f262dba');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '6a20a4ec-e45f-4f2d-aade-e150ba5a6973');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '6a20a4ec-e45f-4f2d-aade-e150ba5a6973');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '6a20a4ec-e45f-4f2d-aade-e150ba5a6973');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '6b1c0c99-0b1f-49c3-9070-a31d54012d22');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '6b1c0c99-0b1f-49c3-9070-a31d54012d22');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '6bba50f5-a535-45c3-895c-eef33e803baf');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '6bba50f5-a535-45c3-895c-eef33e803baf');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '6bba50f5-a535-45c3-895c-eef33e803baf');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '6ebc29f4-998e-480b-be8c-4d2d3f7d0b8e');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '6ebc29f4-998e-480b-be8c-4d2d3f7d0b8e');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '6ebc29f4-998e-480b-be8c-4d2d3f7d0b8e');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '6f2be000-bfb8-49a8-8255-5aab975701f2');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '6fd4e43e-88b7-429b-b00f-6dc8e4081d12');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '6fd4e43e-88b7-429b-b00f-6dc8e4081d12');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '6fd4e43e-88b7-429b-b00f-6dc8e4081d12');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '7023d845-a03f-4dfb-900c-09b5108688fd');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '7023d845-a03f-4dfb-900c-09b5108688fd');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '7023d845-a03f-4dfb-900c-09b5108688fd');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '73368dbe-ec16-4667-84ec-200caec1c99e');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '73368dbe-ec16-4667-84ec-200caec1c99e');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '73368dbe-ec16-4667-84ec-200caec1c99e');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '747dde5a-ea5d-4c11-b1bf-fe5293a0f119');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '747dde5a-ea5d-4c11-b1bf-fe5293a0f119');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '749012aa-c8d0-4e47-a4d0-c506c8b9a293');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '749012aa-c8d0-4e47-a4d0-c506c8b9a293');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '749012aa-c8d0-4e47-a4d0-c506c8b9a293');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '75c988d2-591e-4938-9411-47e75de0af2f');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '75c988d2-591e-4938-9411-47e75de0af2f');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '7854c1bc-b7d0-4084-8c51-a291d97e27fe');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '7854c1bc-b7d0-4084-8c51-a291d97e27fe');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '7854c1bc-b7d0-4084-8c51-a291d97e27fe');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '78b25291-4e59-49b7-b5a3-eee775b9fb59');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '78b25291-4e59-49b7-b5a3-eee775b9fb59');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '78b25291-4e59-49b7-b5a3-eee775b9fb59');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '7a033480-00aa-487f-8a68-3faf5ba27c99');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '7a033480-00aa-487f-8a68-3faf5ba27c99');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '7aac0e60-e8dd-4605-b71b-746ba3ff0910');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '7aac0e60-e8dd-4605-b71b-746ba3ff0910');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '7aac0e60-e8dd-4605-b71b-746ba3ff0910');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '7cd1a0f3-415c-4614-bc5e-d8f587636955');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '7cd1a0f3-415c-4614-bc5e-d8f587636955');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '7cd1a0f3-415c-4614-bc5e-d8f587636955');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '7f6c0770-f68f-40c8-b8d5-8e66defd1402');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '7f6c0770-f68f-40c8-b8d5-8e66defd1402');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '7f6c0770-f68f-40c8-b8d5-8e66defd1402');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '82785d39-b4bc-4c3a-aa95-e70e29fc52b7');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '82785d39-b4bc-4c3a-aa95-e70e29fc52b7');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '82785d39-b4bc-4c3a-aa95-e70e29fc52b7');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '83cec468-1850-40fc-8f6c-bd67556c4946');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '83cec468-1850-40fc-8f6c-bd67556c4946');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '83cec468-1850-40fc-8f6c-bd67556c4946');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '846de02a-1888-4cf6-95aa-624b11888baf');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '846de02a-1888-4cf6-95aa-624b11888baf');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '846de02a-1888-4cf6-95aa-624b11888baf');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '88f2695a-e0f1-4fc3-a5e9-f2397aee6779');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '88f2695a-e0f1-4fc3-a5e9-f2397aee6779');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '89ab3aa1-8ae4-4b1e-b334-48018c555cc8');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '8b15ceb3-5fcc-4e8b-9b46-1c8625dfae54');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '8b15ceb3-5fcc-4e8b-9b46-1c8625dfae54');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '8b15ceb3-5fcc-4e8b-9b46-1c8625dfae54');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '8cdd5790-e72e-496a-93a7-1926a97dbee6');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '8cdd5790-e72e-496a-93a7-1926a97dbee6');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '8cdd5790-e72e-496a-93a7-1926a97dbee6');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '8e1e8261-d76c-4f60-b919-c8b269dff0cd');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '8e1e8261-d76c-4f60-b919-c8b269dff0cd');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '8e1e8261-d76c-4f60-b919-c8b269dff0cd');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '911c55ac-c7c9-4e81-a091-2fc6a4f5c65b');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '911c55ac-c7c9-4e81-a091-2fc6a4f5c65b');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '911c55ac-c7c9-4e81-a091-2fc6a4f5c65b');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '9d624a51-b580-4bcb-a979-ec0d09ac3e04');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '9d624a51-b580-4bcb-a979-ec0d09ac3e04');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '9d8f76fd-d3f9-42e3-9a0a-95de005d766c');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '9d8f76fd-d3f9-42e3-9a0a-95de005d766c');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '9d8f76fd-d3f9-42e3-9a0a-95de005d766c');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '9dc63664-8e8e-4858-893a-88f44cc69eb0');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '9dc63664-8e8e-4858-893a-88f44cc69eb0');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '9dc63664-8e8e-4858-893a-88f44cc69eb0');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '9e3e3a88-6f82-4400-8733-01c6e5450b49');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '9e3e3a88-6f82-4400-8733-01c6e5450b49');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'a0c808cd-645e-4846-b948-23f0ba9c9e97');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'a0c808cd-645e-4846-b948-23f0ba9c9e97');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'a0c808cd-645e-4846-b948-23f0ba9c9e97');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'a1ad3463-72e6-4eab-b9c8-33e8b4dbe188');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'a1ad3463-72e6-4eab-b9c8-33e8b4dbe188');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'a1ad3463-72e6-4eab-b9c8-33e8b4dbe188');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'a2ca708f-0e3b-4fdc-b685-fa4e16ed5f9c');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'a2ca708f-0e3b-4fdc-b685-fa4e16ed5f9c');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'a2ca708f-0e3b-4fdc-b685-fa4e16ed5f9c');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'a69a03a1-4846-4c8b-95ef-c40e019ff5aa');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'a69a03a1-4846-4c8b-95ef-c40e019ff5aa');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'a69a03a1-4846-4c8b-95ef-c40e019ff5aa');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'aa64a19c-cb35-488f-99ff-f734f1e4a4f4');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'aa64a19c-cb35-488f-99ff-f734f1e4a4f4');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'aa64a19c-cb35-488f-99ff-f734f1e4a4f4');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'aab52e11-a088-4712-b3e0-93351c992856');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'aab52e11-a088-4712-b3e0-93351c992856');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'aab52e11-a088-4712-b3e0-93351c992856');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'ac7126bc-753f-4e15-8b30-71c7397ac0c3');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'ac7126bc-753f-4e15-8b30-71c7397ac0c3');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'ac7126bc-753f-4e15-8b30-71c7397ac0c3');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'ac754286-c776-45eb-8c58-e73895986881');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'ac754286-c776-45eb-8c58-e73895986881');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'ac754286-c776-45eb-8c58-e73895986881');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'ad91c81f-26bf-4fd2-a3df-1e05ff854965');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'ad91c81f-26bf-4fd2-a3df-1e05ff854965');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'b049cb4b-a110-46f1-be54-853780160a16');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'b049cb4b-a110-46f1-be54-853780160a16');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'b59de409-6805-4ad9-8ce7-d7bcf26dfe6f');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'b59de409-6805-4ad9-8ce7-d7bcf26dfe6f');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'b66eb967-4ff7-4ad9-81f2-b0949d03e2ef');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'b66eb967-4ff7-4ad9-81f2-b0949d03e2ef');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'b66eb967-4ff7-4ad9-81f2-b0949d03e2ef');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'ba33b149-d217-452c-8002-8c156a9082d7');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'ba33b149-d217-452c-8002-8c156a9082d7');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'ba33b149-d217-452c-8002-8c156a9082d7');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'ba5238b9-6493-4134-9f32-e21a717fcf5b');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'ba5238b9-6493-4134-9f32-e21a717fcf5b');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'bd38c453-24fa-4786-9075-3820055adaff');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'bd38c453-24fa-4786-9075-3820055adaff');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'bf835f1f-4cd5-4b09-baee-5b9086cb1d12');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'bf835f1f-4cd5-4b09-baee-5b9086cb1d12');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'bf835f1f-4cd5-4b09-baee-5b9086cb1d12');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'cc1ccd05-0cf0-4412-b9f3-98254da85a82');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'cc1ccd05-0cf0-4412-b9f3-98254da85a82');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'cc1ccd05-0cf0-4412-b9f3-98254da85a82');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'cfcdbd3f-cfa9-454a-af51-bbb2de324f74');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'cfcdbd3f-cfa9-454a-af51-bbb2de324f74');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'cfcdbd3f-cfa9-454a-af51-bbb2de324f74');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'd2ead2a5-cc02-421b-8fec-b2858e22cc7d');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'd2ead2a5-cc02-421b-8fec-b2858e22cc7d');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'd2ead2a5-cc02-421b-8fec-b2858e22cc7d');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'd3810390-2298-43e7-b4e9-23f801c31340');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'd3810390-2298-43e7-b4e9-23f801c31340');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'd3810390-2298-43e7-b4e9-23f801c31340');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'd3899c5c-b90a-489b-b9cd-9294164ea689');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'd3899c5c-b90a-489b-b9cd-9294164ea689');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'd3899c5c-b90a-489b-b9cd-9294164ea689');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'd39df9ee-68f5-46fa-b7fe-11147ea91c01');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'd39df9ee-68f5-46fa-b7fe-11147ea91c01');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'd39df9ee-68f5-46fa-b7fe-11147ea91c01');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'd58a1365-3704-4c65-8691-cfbad89dc909');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'd58a1365-3704-4c65-8691-cfbad89dc909');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'd58a1365-3704-4c65-8691-cfbad89dc909');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'd92dd87a-a33c-4f51-ba62-6fad251339c8');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'd92dd87a-a33c-4f51-ba62-6fad251339c8');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'd92dd87a-a33c-4f51-ba62-6fad251339c8');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'da031a73-814e-4874-9bde-c9c0df74195c');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'da031a73-814e-4874-9bde-c9c0df74195c');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'da031a73-814e-4874-9bde-c9c0df74195c');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'dad80b3c-ec8d-4823-8a3b-152f88a54e70');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'dc08bcef-6810-4653-9214-001cb11e2f4c');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'dc08bcef-6810-4653-9214-001cb11e2f4c');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'dc08bcef-6810-4653-9214-001cb11e2f4c');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'ded17f76-230c-4f7d-af87-e04ce13e10a2');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'ded17f76-230c-4f7d-af87-e04ce13e10a2');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'ded17f76-230c-4f7d-af87-e04ce13e10a2');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'defc8fc5-ca70-4949-bde1-87672bbbc61a');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'defc8fc5-ca70-4949-bde1-87672bbbc61a');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'defc8fc5-ca70-4949-bde1-87672bbbc61a');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'df489f88-1642-417b-b533-8ffb766ed9d7');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'df489f88-1642-417b-b533-8ffb766ed9d7');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'df489f88-1642-417b-b533-8ffb766ed9d7');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'e1dbc6e2-7618-48d3-9e78-df4a0f2063c0');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'e1dbc6e2-7618-48d3-9e78-df4a0f2063c0');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'e1dbc6e2-7618-48d3-9e78-df4a0f2063c0');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'e4ab0323-a5e5-4e9c-8708-df9993e8add6');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'e4ab0323-a5e5-4e9c-8708-df9993e8add6');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'e4ab0323-a5e5-4e9c-8708-df9993e8add6');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'e54a0ef0-ca83-4e09-9870-afbb1d33c252');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'e54a0ef0-ca83-4e09-9870-afbb1d33c252');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'e54a0ef0-ca83-4e09-9870-afbb1d33c252');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'e7340757-a4b6-42e0-83f5-a3a6e8fbdd67');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'e7340757-a4b6-42e0-83f5-a3a6e8fbdd67');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'e7340757-a4b6-42e0-83f5-a3a6e8fbdd67');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'e8334fba-a1f3-4488-8611-de71b111fc23');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'e8334fba-a1f3-4488-8611-de71b111fc23');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'e8d61597-f770-4675-8027-6039673504b1');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'e8d61597-f770-4675-8027-6039673504b1');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'e90658e6-9909-4219-a2b2-461ea68b7ad4');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'e90658e6-9909-4219-a2b2-461ea68b7ad4');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'e90658e6-9909-4219-a2b2-461ea68b7ad4');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'e95868f3-deef-4848-9722-6dca2a96760d');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'e95868f3-deef-4848-9722-6dca2a96760d');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'e95868f3-deef-4848-9722-6dca2a96760d');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'ea179d82-c575-4963-9e63-f36bca11bcd2');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'ea179d82-c575-4963-9e63-f36bca11bcd2');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'ea179d82-c575-4963-9e63-f36bca11bcd2');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'ef73142d-ed20-411b-96be-32a03582a4a9');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'ef73142d-ed20-411b-96be-32a03582a4a9');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'ef73142d-ed20-411b-96be-32a03582a4a9');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'f168201c-50d9-4bb8-a46d-1b3e058de818');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'f168201c-50d9-4bb8-a46d-1b3e058de818');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'f168201c-50d9-4bb8-a46d-1b3e058de818');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'f3350893-74c8-4049-9f31-a30f0942b530');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'f3350893-74c8-4049-9f31-a30f0942b530');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'f3350893-74c8-4049-9f31-a30f0942b530');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'f5d4bb07-af58-4ccd-93bb-b248dd3035dd');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'f5d4bb07-af58-4ccd-93bb-b248dd3035dd');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'f5d4bb07-af58-4ccd-93bb-b248dd3035dd');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'f7414800-9b6c-49a4-bcc5-6004b5813906');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'f7414800-9b6c-49a4-bcc5-6004b5813906');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'fb3e3587-c0b6-4322-bb2c-7d707f18dea1');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'fb3e3587-c0b6-4322-bb2c-7d707f18dea1');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'fb56e170-071a-476e-8102-ba6ae84443c7');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'fb56e170-071a-476e-8102-ba6ae84443c7');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'fb56e170-071a-476e-8102-ba6ae84443c7');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'fb6d4cb8-f596-4de0-b8aa-919338d3732f');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'fb6d4cb8-f596-4de0-b8aa-919338d3732f');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'fb6d4cb8-f596-4de0-b8aa-919338d3732f');
INSERT INTO `role_api` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'fe1913ca-0ae9-4f5c-a15b-59220cc06752');
INSERT INTO `role_api` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'fe1913ca-0ae9-4f5c-a15b-59220cc06752');
INSERT INTO `role_api` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'fe1913ca-0ae9-4f5c-a15b-59220cc06752');

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
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '01cf1b9c-b18a-4f63-82b9-d74bc85a6345');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '01cf1b9c-b18a-4f63-82b9-d74bc85a6345');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '01cf1b9c-b18a-4f63-82b9-d74bc85a6345');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '05f05171-2473-422c-90ed-dbd5970a09d9');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '05f05171-2473-422c-90ed-dbd5970a09d9');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '05f05171-2473-422c-90ed-dbd5970a09d9');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '0905e23f-3e45-4e05-90de-92a3080637dd');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '0b078aed-3592-4a1e-af9c-07c84be7acd3');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '0b078aed-3592-4a1e-af9c-07c84be7acd3');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '0b078aed-3592-4a1e-af9c-07c84be7acd3');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '0fd0c748-9cfd-42e3-ab31-8714966e054d');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '0fd0c748-9cfd-42e3-ab31-8714966e054d');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '0fd0c748-9cfd-42e3-ab31-8714966e054d');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '19268e0c-930d-449d-9658-3038041049c8');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '19268e0c-930d-449d-9658-3038041049c8');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '19268e0c-930d-449d-9658-3038041049c8');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '2896ee43-3191-4309-a322-5d3c063ae92c');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '2896ee43-3191-4309-a322-5d3c063ae92c');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '2896ee43-3191-4309-a322-5d3c063ae92c');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '2a1ef27c-2c0e-4a1a-ae91-56032fe3220c');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '2a1ef27c-2c0e-4a1a-ae91-56032fe3220c');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '2a1ef27c-2c0e-4a1a-ae91-56032fe3220c');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '31c32158-65cc-46d4-a7f1-76c00345f685');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '31c32158-65cc-46d4-a7f1-76c00345f685');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '31c32158-65cc-46d4-a7f1-76c00345f685');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '3c1a1682-4278-4ea2-8a4f-7e0680ad532d');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '3c1a1682-4278-4ea2-8a4f-7e0680ad532d');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '3c1a1682-4278-4ea2-8a4f-7e0680ad532d');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '48cc1099-b411-4a3c-bdc2-82f6f6fd3504');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '48cc1099-b411-4a3c-bdc2-82f6f6fd3504');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '48cc1099-b411-4a3c-bdc2-82f6f6fd3504');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '5ee44613-3e0d-41fd-971e-d2f14caae2c1');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '5ee44613-3e0d-41fd-971e-d2f14caae2c1');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '5ee44613-3e0d-41fd-971e-d2f14caae2c1');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '60a886d7-a715-422b-b7a1-d2a16cd642af');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '60a886d7-a715-422b-b7a1-d2a16cd642af');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '60a886d7-a715-422b-b7a1-d2a16cd642af');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '6121f732-a635-429e-a71c-f434573d012c');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '6121f732-a635-429e-a71c-f434573d012c');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '6121f732-a635-429e-a71c-f434573d012c');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '619ba5b2-fae1-4581-9491-1dcd8299b1d4');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '619ba5b2-fae1-4581-9491-1dcd8299b1d4');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '619ba5b2-fae1-4581-9491-1dcd8299b1d4');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '62885d55-7388-42d4-ae1c-c085c49da3a7');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '62885d55-7388-42d4-ae1c-c085c49da3a7');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '62885d55-7388-42d4-ae1c-c085c49da3a7');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '7094f8ef-1079-4e3e-a49b-615ef7abcd4b');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '7094f8ef-1079-4e3e-a49b-615ef7abcd4b');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '7094f8ef-1079-4e3e-a49b-615ef7abcd4b');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '7af760e6-bcbd-4059-8013-46bd0ac34c43');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '7af760e6-bcbd-4059-8013-46bd0ac34c43');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '7af760e6-bcbd-4059-8013-46bd0ac34c43');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '7effd89e-98a7-48ae-bf3d-c0f065b53643');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '7effd89e-98a7-48ae-bf3d-c0f065b53643');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '7effd89e-98a7-48ae-bf3d-c0f065b53643');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '87017e19-8944-43cf-b4c1-977d35ce369a');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '87017e19-8944-43cf-b4c1-977d35ce369a');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '87017e19-8944-43cf-b4c1-977d35ce369a');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '8eb724a8-6f43-4b1c-b07e-49341c168533');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '907301ae-ee2a-49da-a0f3-aaf862d1f5fb');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '907301ae-ee2a-49da-a0f3-aaf862d1f5fb');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '907301ae-ee2a-49da-a0f3-aaf862d1f5fb');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', '9c88d4bb-257c-45ee-a991-1397ba41c703');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', '9c88d4bb-257c-45ee-a991-1397ba41c703');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '9c88d4bb-257c-45ee-a991-1397ba41c703');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', '9ed4a91e-b01f-4aee-b672-98b6c5ff8a95');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'a08baf3f-3229-4c15-961d-bb25de1184fe');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'a08baf3f-3229-4c15-961d-bb25de1184fe');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'a08baf3f-3229-4c15-961d-bb25de1184fe');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'a3136729-f426-49e4-87d2-79497d5e72e0');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'ab5ef7e1-64e5-4cb3-9e5f-a8fc7ad6b1bb');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'ab5ef7e1-64e5-4cb3-9e5f-a8fc7ad6b1bb');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'ab5ef7e1-64e5-4cb3-9e5f-a8fc7ad6b1bb');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'ac325c62-5473-44db-81a3-61dc9c83a39c');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'ac325c62-5473-44db-81a3-61dc9c83a39c');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'ac325c62-5473-44db-81a3-61dc9c83a39c');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'b38badcd-e38e-4483-99ea-f7a706806593');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'b38badcd-e38e-4483-99ea-f7a706806593');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'b38badcd-e38e-4483-99ea-f7a706806593');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'b59167e5-43e8-482a-a3f7-22e20ce81716');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'b59167e5-43e8-482a-a3f7-22e20ce81716');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'b59167e5-43e8-482a-a3f7-22e20ce81716');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'b71342a7-2448-451e-a08e-bafb1165a1c7');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'b71342a7-2448-451e-a08e-bafb1165a1c7');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'b71342a7-2448-451e-a08e-bafb1165a1c7');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'bc262ac5-d198-4fcc-8fdc-7459bdc538ad');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'c2a86202-2026-47ce-9c5d-431631ea5978');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'c2a86202-2026-47ce-9c5d-431631ea5978');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'c2a86202-2026-47ce-9c5d-431631ea5978');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'c9c254a7-ddc7-4a05-b1c2-c08293638dec');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'c9c254a7-ddc7-4a05-b1c2-c08293638dec');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'c9c254a7-ddc7-4a05-b1c2-c08293638dec');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'c9ee88dd-7880-474a-b3ab-84f25d8b8620');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'c9ee88dd-7880-474a-b3ab-84f25d8b8620');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'c9ee88dd-7880-474a-b3ab-84f25d8b8620');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'd0aeec63-0e3b-4c21-82f0-f679dca848db');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'd0aeec63-0e3b-4c21-82f0-f679dca848db');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'd0aeec63-0e3b-4c21-82f0-f679dca848db');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'd6aa09e9-a1b7-47fb-b073-311e873af633');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'd6aa09e9-a1b7-47fb-b073-311e873af633');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'd6aa09e9-a1b7-47fb-b073-311e873af633');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'd6cf74bb-09c4-4fe3-a69d-c48287634bff');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'd6cf74bb-09c4-4fe3-a69d-c48287634bff');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'd6cf74bb-09c4-4fe3-a69d-c48287634bff');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'da12c8fa-ecfc-4529-b5c3-caf0b3ebcfe9');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'da12c8fa-ecfc-4529-b5c3-caf0b3ebcfe9');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'e07658e7-bf05-4f8c-9d31-fc1e2bb46580');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'e07658e7-bf05-4f8c-9d31-fc1e2bb46580');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'e07658e7-bf05-4f8c-9d31-fc1e2bb46580');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'e660aaeb-94de-46f7-a941-bed746d42141');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'e660aaeb-94de-46f7-a941-bed746d42141');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'e660aaeb-94de-46f7-a941-bed746d42141');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'fa0a0bef-ebb7-44ae-860a-1fef98d9e69a');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'fa0a0bef-ebb7-44ae-860a-1fef98d9e69a');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'fa0a0bef-ebb7-44ae-860a-1fef98d9e69a');
INSERT INTO `role_menu` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca', 'fa77a36c-7a7d-4cde-88a6-df299513885e');
INSERT INTO `role_menu` VALUES ('970337ea-65ce-48ce-9f15-6b5049e3c3e3', 'fa77a36c-7a7d-4cde-88a6-df299513885e');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'fa77a36c-7a7d-4cde-88a6-df299513885e');
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78', 'fdf1ab35-dab2-402f-911a-9e9eb2cfadd4');

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task`  (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `invoke_target` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用方法',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'cron表达式',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'cron表达式',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收件邮箱',
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '创建时间',
  `mtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '图标更新时间',
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `task_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task
-- ----------------------------

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
  `ctime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2024-01-30 08:55:14' COMMENT '用户创建时间',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '用户状态',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'http://vue.ruoyi.vip/static/img/profile.473f5971.jpg' COMMENT '用户头像',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('5db5e584-8158-45e2-98a2-dc0b04f7a643', 'guest', '084e0343a0486ff05530df6c705c8bb4', '游客', '', '2021-08-25 13:49:30', 1, 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif?imageView2/1/w/80/h/80');
INSERT INTO `user` VALUES ('9f9ead70-8320-41d5-9c32-822262866390', 'admin', '21232f297a57a5a743894a0e4a801fc3', '管理员', '管理员', '2021-01-25 13:24:46', 1, 'http://picture.itchenliang.club/static/png/%E6%98%9F%E5%BA%A7_%E6%B0%B4%E7%93%B6%E5%BA%A7-8977c992.png');

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
INSERT INTO `user_role` VALUES ('5db5e584-8158-45e2-98a2-dc0b04f7a643', '970337ea-65ce-48ce-9f15-6b5049e3c3e3');
INSERT INTO `user_role` VALUES ('9f9ead70-8320-41d5-9c32-822262866390', 'da0269f8-b0fe-4a69-ab0a-d8f3d870fb78');

SET FOREIGN_KEY_CHECKS = 1;
