-- MySQL dump 10.13  Distrib 5.7.15, for Win64 (x86_64)
--
-- Host: localhost    Database: info
-- ------------------------------------------------------
-- Server version	5.7.15-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `api`
--

DROP TABLE IF EXISTS `api`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api` (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) NOT NULL COMMENT '权限名称',
  `path` varchar(255) NOT NULL COMMENT '权限地址',
  `type` varchar(255) NOT NULL DEFAULT 'get' COMMENT '权限类型',
  `tid` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'api_type表关联',
  `ctime` varchar(255) NOT NULL DEFAULT '2021-01-25 17:21:27' COMMENT '创建时间',
  `mtime` varchar(255) NOT NULL DEFAULT '2021-01-25 17:21:27' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `tid` (`tid`),
  CONSTRAINT `api_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `api_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api`
--

LOCK TABLES `api` WRITE;
/*!40000 ALTER TABLE `api` DISABLE KEYS */;
/*!40000 ALTER TABLE `api` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_type`
--

DROP TABLE IF EXISTS `api_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_type` (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) NOT NULL COMMENT '分类名称',
  `ctime` varchar(255) NOT NULL DEFAULT '2021-01-25 17:21:27' COMMENT '创建时间',
  `mtime` varchar(255) NOT NULL DEFAULT '2021-01-25 17:21:27' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_type`
--

LOCK TABLES `api_type` WRITE;
/*!40000 ALTER TABLE `api_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icon`
--

DROP TABLE IF EXISTS `icon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icon` (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `pid` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '图标项目id',
  `name` varchar(255) NOT NULL COMMENT '图标名称',
  `code` varchar(255) NOT NULL COMMENT '图标的code',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '图标状态',
  `ctime` varchar(255) NOT NULL DEFAULT '2021-01-25 17:21:27' COMMENT '创建时间',
  `mtime` varchar(255) NOT NULL DEFAULT '2021-01-25 17:21:27' COMMENT '图标更新时间',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  CONSTRAINT `icon_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `icon_project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icon`
--

LOCK TABLES `icon` WRITE;
/*!40000 ALTER TABLE `icon` DISABLE KEYS */;
/*!40000 ALTER TABLE `icon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icon_project`
--

DROP TABLE IF EXISTS `icon_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icon_project` (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) NOT NULL COMMENT '项目名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '项目备注',
  `family` varchar(255) NOT NULL DEFAULT 'iconfont' COMMENT 'FontFamily',
  `prefix` varchar(255) NOT NULL DEFAULT 'icon' COMMENT '图标前缀',
  `url` varchar(255) NOT NULL DEFAULT 'http://at.alicdn.com/t/font_2246210_dg83mt99oye.css' COMMENT '样式文件存放位置',
  `uid` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '项目所有者',
  `ctime` varchar(255) NOT NULL DEFAULT '2021-01-25 17:21:27' COMMENT '创建时间',
  `mtime` varchar(255) NOT NULL DEFAULT '2021-01-25 17:21:27' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icon_project`
--

LOCK TABLES `icon_project` WRITE;
/*!40000 ALTER TABLE `icon_project` DISABLE KEYS */;
INSERT INTO `icon_project` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51c1','个人信息管理系统','个人信息管理系统，主要是在系统内使用，有管理员进行维护','infoicon','info-','//at.alicdn.com/t/font_2246210_dg83mt99oye.css',NULL,'2020-01-14 17:09:24','2020-01-14 17:09:24');
/*!40000 ALTER TABLE `icon_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) NOT NULL COMMENT '菜单名称',
  `pid` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '上级菜单id',
  `order` int(11) NOT NULL DEFAULT '1' COMMENT '菜单排序',
  `path` varchar(255) NOT NULL COMMENT '菜单路由',
  `component` varchar(255) NOT NULL DEFAULT '/Layout' COMMENT '组件路径',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '菜单类型：目录1，菜单2',
  `is_frame` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否外链',
  `visible` tinyint(1) NOT NULL DEFAULT '1' COMMENT '菜单显示',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '菜单状态',
  `icon` varchar(255) NOT NULL COMMENT '菜单图标',
  `remark` varchar(255) DEFAULT NULL COMMENT '菜单备注',
  `ctime` varchar(255) NOT NULL DEFAULT '2021-01-25 17:21:27' COMMENT '菜单创建时间',
  `mtime` varchar(255) NOT NULL DEFAULT '2021-01-25 17:21:27' COMMENT '菜单更新时间',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `menu` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES ('0627e686-bee7-4eac-8bb4-1821985d0502','账目管理',NULL,1,'/account','/Layout',1,0,1,1,'el-icon-s-marketing','账目管理：多自己的每一笔开销做记录(可以提供可一个快捷的提交入口：手机端)','2021-01-20 15:33:33','2021-01-20 15:36:49'),('0b078aed-3592-4a1e-af9c-07c84be7acd3','信息管理',NULL,1,'/info','/Layout',1,0,1,1,'el-icon-user','信息管理：包括密码管理、就学信息管理、就业信息以及基本信息管理','2021-01-20 15:47:31','2021-01-25 16:27:00'),('15a8fdd0-9bff-4376-9fa4-c58addf7b215','标签列表','18c7421f-a78a-4b16-8563-14a0fadda20b',1,'/memory/tag','/memeory/tag/List',2,0,1,1,'el-icon-collection-tag','备忘录管理 - 标签管理','2021-01-20 09:31:51','2021-01-20 09:31:51'),('18c7421f-a78a-4b16-8563-14a0fadda20b','备忘录管理',NULL,1,'/memory','/Layout',1,0,1,1,'el-icon-notebook-1','备忘录管理','2021-01-15 10:11:07','2021-01-20 13:39:03'),('1c2eb570-fe5c-48d8-b677-37ccc8428a25','资源管理',NULL,1,'/resource','/Layout',1,0,1,1,'el-icon-folder-opened','资源管理：对个人文件进行管理(应该在创建用户的时候就根据返回的用户id创建文件夹)','2021-01-20 14:33:09','2021-01-25 11:33:11'),('5c4ed5b3-2d09-4154-863a-b513e2fd0f25','就业信息','0b078aed-3592-4a1e-af9c-07c84be7acd3',1,'/info/job','/info/job/List',2,0,1,1,'el-icon-camera','就业信息管理：主要是对自己一生中所做过的工作或者待过的公司做记录。','2021-01-20 15:56:37','2021-01-20 15:56:37'),('775df3c0-be89-48f6-95b7-5b7316b5933b','密码管理','0b078aed-3592-4a1e-af9c-07c84be7acd3',1,'/info/pwd','/info/pwd/List',2,0,1,1,'el-icon-lock','密码管理：网站名称(软件名称)：QQ\n网站地址：https://www.zhihu.com/\n账号：1825956830\n密码：***************\n支付密码：***********\n用户id：谁的密码','2021-01-20 15:51:29','2021-01-20 15:51:29'),('7a6ec4a9-fb85-435e-be71-048b39bd73a8','项目管理',NULL,1,'/project','/Layout',1,0,1,1,'el-icon-s-grid','','2021-01-20 15:41:35','2021-01-20 15:41:35'),('7d61ea41-2a32-46ab-93c0-6fbd361a267d','基本信息管理','0b078aed-3592-4a1e-af9c-07c84be7acd3',1,'/info/base','/info/Base',2,0,1,1,'el-icon-s-comment','基本信息管理：包括通讯地址、手机号、QQ号、身份证号等等','2021-01-20 16:03:01','2021-01-20 16:03:01'),('899e5c7f-d59c-41ef-9074-ce3b68878452','定时任务管理',NULL,1,'/schedule','/Layout',1,0,1,1,'el-icon-date','定时任务管理：包括定时器管理和计划任务管理','2021-01-20 14:36:38','2021-01-25 11:33:10'),('8b575593-19bc-4376-9594-26fc2c10e783','就学信息管理','0b078aed-3592-4a1e-af9c-07c84be7acd3',1,'/info/school','/info/school/List',2,0,1,1,'el-icon-picture','就学信息管理：即是对从小学到工作期间所待过的的学校进行记录','2021-01-20 15:54:33','2021-01-20 15:57:48'),('8eb724a8-6f43-4b1c-b07e-49341c168533','菜单管理','d6aa09e9-a1b7-47fb-b073-311e873af633',1,'/system/menu','/system/menu/List',2,0,1,1,'el-icon-menu','系统管理 - 菜单管理','2021-01-20 09:31:51','2021-01-20 09:31:51'),('9da30eb2-b254-4bef-b7b5-8cac3f1e7bae','类型管理','a5794519-fefa-4254-8dc6-b5efc3e7ddf5',1,'/collect/type','/collect/type/List',2,0,1,1,'el-icon-collection-tag','收藏类型管理：语言文档和规范/可视化工具等等','2021-01-20 15:18:41','2021-01-20 15:18:41'),('a3136729-f426-49e4-87d2-79497d5e72e0','角色管理','d6aa09e9-a1b7-47fb-b073-311e873af633',1,'/system/role','/system/role/List',2,0,1,1,'el-icon-user-solid','系统管理 - 角色管理','2021-01-20 09:31:51','2021-01-20 13:48:20'),('a5794519-fefa-4254-8dc6-b5efc3e7ddf5','收藏管理',NULL,1,'/collect','/Layout',1,0,1,1,'el-icon-collection','收藏管理：可以提供可一个快捷的提交入口：手机端','2021-01-20 09:31:51','2021-01-20 15:38:28'),('bc262ac5-d198-4fcc-8fdc-7459bdc538ad','用户管理','d6aa09e9-a1b7-47fb-b073-311e873af633',1,'/system/user','/system/user/List',2,0,1,1,'el-icon-user','系统管理 - 用户管理','2021-01-15 10:10:02','2021-01-20 13:31:14'),('d65d5584-9b6b-48cd-9a52-2155bb80ccf8','代办事项',NULL,1,'/todo','/Layout',1,0,1,1,'el-icon-tickets','代办事务/日程安排管理','2021-01-20 15:05:14','2021-01-25 11:33:09'),('d6aa09e9-a1b7-47fb-b073-311e873af633','系统管理',NULL,1,'/system','/Layout',1,0,1,1,'el-icon-setting','系统管理','2021-01-15 10:10:02','2021-01-20 13:36:27'),('dabc4f36-9240-4851-a642-0cb546926e1c','权限管理','d6aa09e9-a1b7-47fb-b073-311e873af633',1,'/system/permission/:id','/system/permission/List',2,0,0,1,'el-icon-lock','系统管理 - 权限管理','2021-01-20 09:31:51','2021-01-25 11:34:52'),('dc9e5156-b5b1-4fff-af29-88a7222e8616','备忘录列表','18c7421f-a78a-4b16-8563-14a0fadda20b',1,'/memory/list','/memory/memory/List',2,0,1,1,'el-icon-s-order','备忘录管理 - 备忘录管理','2021-01-20 09:31:51','2021-01-20 14:02:54'),('e41df809-1468-4d74-b03f-1a4947495b4e','收藏列表','a5794519-fefa-4254-8dc6-b5efc3e7ddf5',1,'/collect/list','/collect/List',2,0,1,1,'el-icon-s-order','收藏列表','2021-01-20 09:31:51','2021-01-20 15:19:21'),('fdf1ab35-dab2-402f-911a-9e9eb2cfadd4','接口管理','d6aa09e9-a1b7-47fb-b073-311e873af633',1,'/system/api','/system/api/List',2,0,1,1,'el-icon-lock','系统管理 - 接口管理','2021-01-25 11:34:41','2021-01-25 11:34:41');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `name` varchar(255) NOT NULL COMMENT '角色名称',
  `priority` int(11) NOT NULL DEFAULT '1' COMMENT '角色排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '角色状态',
  `remark` varchar(255) DEFAULT '' COMMENT '角色备注',
  `ctime` varchar(255) NOT NULL DEFAULT '2021-01-25 17:21:27' COMMENT '创建时间',
  `mtime` varchar(255) NOT NULL DEFAULT '2021-01-25 17:21:27' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  UNIQUE KEY `name_3` (`name`),
  UNIQUE KEY `name_4` (`name`),
  UNIQUE KEY `name_5` (`name`),
  UNIQUE KEY `name_6` (`name`),
  UNIQUE KEY `name_7` (`name`),
  UNIQUE KEY `name_8` (`name`),
  UNIQUE KEY `name_9` (`name`),
  UNIQUE KEY `name_10` (`name`),
  UNIQUE KEY `name_11` (`name`),
  UNIQUE KEY `name_12` (`name`),
  UNIQUE KEY `name_13` (`name`),
  UNIQUE KEY `name_14` (`name`),
  UNIQUE KEY `name_15` (`name`),
  UNIQUE KEY `name_16` (`name`),
  UNIQUE KEY `name_17` (`name`),
  UNIQUE KEY `name_18` (`name`),
  UNIQUE KEY `name_19` (`name`),
  UNIQUE KEY `name_20` (`name`),
  UNIQUE KEY `name_21` (`name`),
  UNIQUE KEY `name_22` (`name`),
  UNIQUE KEY `name_23` (`name`),
  UNIQUE KEY `name_24` (`name`),
  UNIQUE KEY `name_25` (`name`),
  UNIQUE KEY `name_26` (`name`),
  UNIQUE KEY `name_27` (`name`),
  UNIQUE KEY `name_28` (`name`),
  UNIQUE KEY `name_29` (`name`),
  UNIQUE KEY `name_30` (`name`),
  UNIQUE KEY `name_31` (`name`),
  UNIQUE KEY `name_32` (`name`),
  UNIQUE KEY `name_33` (`name`),
  UNIQUE KEY `name_34` (`name`),
  UNIQUE KEY `name_35` (`name`),
  UNIQUE KEY `name_36` (`name`),
  UNIQUE KEY `name_37` (`name`),
  UNIQUE KEY `name_38` (`name`),
  UNIQUE KEY `name_39` (`name`),
  UNIQUE KEY `name_40` (`name`),
  UNIQUE KEY `name_41` (`name`),
  UNIQUE KEY `name_42` (`name`),
  UNIQUE KEY `name_43` (`name`),
  UNIQUE KEY `name_44` (`name`),
  UNIQUE KEY `name_45` (`name`),
  UNIQUE KEY `name_46` (`name`),
  UNIQUE KEY `name_47` (`name`),
  UNIQUE KEY `name_48` (`name`),
  UNIQUE KEY `name_49` (`name`),
  UNIQUE KEY `name_50` (`name`),
  UNIQUE KEY `name_51` (`name`),
  UNIQUE KEY `name_52` (`name`),
  UNIQUE KEY `name_53` (`name`),
  UNIQUE KEY `name_54` (`name`),
  UNIQUE KEY `name_55` (`name`),
  UNIQUE KEY `name_56` (`name`),
  UNIQUE KEY `name_57` (`name`),
  UNIQUE KEY `name_58` (`name`),
  UNIQUE KEY `name_59` (`name`),
  UNIQUE KEY `name_60` (`name`),
  UNIQUE KEY `name_61` (`name`),
  UNIQUE KEY `name_62` (`name`),
  UNIQUE KEY `name_63` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca','user',1,1,'普通用户','2021-01-13 09:47:18','2021-01-13 09:47:18'),('c2167a10-362c-4296-89bf-51bb20284b16','test',1,1,'测试','2021-01-20 14:11:43','2021-01-20 14:11:43'),('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78','admin',1,1,'管理员','2021-01-12 17:29:44','2021-01-12 17:29:44');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_menu`
--

DROP TABLE IF EXISTS `role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_menu` (
  `roleId` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `menuId` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`roleId`,`menuId`),
  KEY `menuId` (`menuId`),
  CONSTRAINT `role_menu_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_menu_ibfk_2` FOREIGN KEY (`menuId`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_menu`
--

LOCK TABLES `role_menu` WRITE;
/*!40000 ALTER TABLE `role_menu` DISABLE KEYS */;
INSERT INTO `role_menu` VALUES ('c2167a10-362c-4296-89bf-51bb20284b16','0627e686-bee7-4eac-8bb4-1821985d0502'),('c2167a10-362c-4296-89bf-51bb20284b16','0b078aed-3592-4a1e-af9c-07c84be7acd3'),('c2167a10-362c-4296-89bf-51bb20284b16','15a8fdd0-9bff-4376-9fa4-c58addf7b215'),('c2167a10-362c-4296-89bf-51bb20284b16','18c7421f-a78a-4b16-8563-14a0fadda20b'),('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78','18c7421f-a78a-4b16-8563-14a0fadda20b'),('c2167a10-362c-4296-89bf-51bb20284b16','1c2eb570-fe5c-48d8-b677-37ccc8428a25'),('c2167a10-362c-4296-89bf-51bb20284b16','5c4ed5b3-2d09-4154-863a-b513e2fd0f25'),('c2167a10-362c-4296-89bf-51bb20284b16','775df3c0-be89-48f6-95b7-5b7316b5933b'),('c2167a10-362c-4296-89bf-51bb20284b16','7a6ec4a9-fb85-435e-be71-048b39bd73a8'),('c2167a10-362c-4296-89bf-51bb20284b16','7d61ea41-2a32-46ab-93c0-6fbd361a267d'),('c2167a10-362c-4296-89bf-51bb20284b16','899e5c7f-d59c-41ef-9074-ce3b68878452'),('c2167a10-362c-4296-89bf-51bb20284b16','8b575593-19bc-4376-9594-26fc2c10e783'),('c2167a10-362c-4296-89bf-51bb20284b16','8eb724a8-6f43-4b1c-b07e-49341c168533'),('c2167a10-362c-4296-89bf-51bb20284b16','9da30eb2-b254-4bef-b7b5-8cac3f1e7bae'),('c2167a10-362c-4296-89bf-51bb20284b16','a3136729-f426-49e4-87d2-79497d5e72e0'),('c2167a10-362c-4296-89bf-51bb20284b16','a5794519-fefa-4254-8dc6-b5efc3e7ddf5'),('c2167a10-362c-4296-89bf-51bb20284b16','bc262ac5-d198-4fcc-8fdc-7459bdc538ad'),('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78','bc262ac5-d198-4fcc-8fdc-7459bdc538ad'),('c2167a10-362c-4296-89bf-51bb20284b16','d65d5584-9b6b-48cd-9a52-2155bb80ccf8'),('c2167a10-362c-4296-89bf-51bb20284b16','d6aa09e9-a1b7-47fb-b073-311e873af633'),('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78','d6aa09e9-a1b7-47fb-b073-311e873af633'),('c2167a10-362c-4296-89bf-51bb20284b16','dabc4f36-9240-4851-a642-0cb546926e1c'),('c2167a10-362c-4296-89bf-51bb20284b16','dc9e5156-b5b1-4fff-af29-88a7222e8616'),('c2167a10-362c-4296-89bf-51bb20284b16','e41df809-1468-4d74-b03f-1a4947495b4e'),('c2167a10-362c-4296-89bf-51bb20284b16','fdf1ab35-dab2-402f-911a-9e9eb2cfadd4');
/*!40000 ALTER TABLE `role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'uuid',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `nickname` varchar(255) NOT NULL DEFAULT '用户007' COMMENT '用户昵称',
  `remark` varchar(255) DEFAULT '' COMMENT '用户备注',
  `ctime` varchar(255) NOT NULL DEFAULT '2021-01-25 17:21:27' COMMENT '用户创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态',
  `avatar` varchar(255) NOT NULL DEFAULT 'http://vue.ruoyi.vip/static/img/profile.473f5971.jpg' COMMENT '用户头像',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('26192b0d-9281-4363-b8c5-e05a29bef677','duli','96e79218965eb72c92a549dd5a330112','Yrainy','杜丽','2021-01-13 15:38:02',1,'http://localhost:3000/avatar/26192b0d-9281-4363-b8c5-e05a29bef677.jpg'),('646714df-7985-456a-81d1-f050c712347c','test','96e79218965eb72c92a549dd5a330112','用户007','测试用户','2021-01-25 16:07:22',1,'http://localhost:3000/avatar/26192b0d-9281-4363-b8c5-e05a29bef677.jpg'),('9f9ead70-8320-41d5-9c32-822262866390','admin','21232f297a57a5a743894a0e4a801fc3','管理员','管理员','2021-01-25 13:24:46',1,'http://localhost:3000/avatar/26192b0d-9281-4363-b8c5-e05a29bef677.jpg'),('cc5bd852-5928-4c5a-9c93-d8e15c678c26','itchenliang','96e79218965eb72c92a549dd5a330112','奶油味拥抱','陈亮','2021-01-25 13:03:06',1,'http://www.chenliang0829.cn:8081/upload/202003221513517685885258838558.jpg');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `userId` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `roleId` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`userId`,`roleId`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES ('26192b0d-9281-4363-b8c5-e05a29bef677','23dad3eb-f42a-47bd-be47-4a377b4f51ca'),('cc5bd852-5928-4c5a-9c93-d8e15c678c26','23dad3eb-f42a-47bd-be47-4a377b4f51ca'),('26192b0d-9281-4363-b8c5-e05a29bef677','c2167a10-362c-4296-89bf-51bb20284b16'),('646714df-7985-456a-81d1-f050c712347c','c2167a10-362c-4296-89bf-51bb20284b16'),('9f9ead70-8320-41d5-9c32-822262866390','da0269f8-b0fe-4a69-ab0a-d8f3d870fb78');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-25 17:32:31
