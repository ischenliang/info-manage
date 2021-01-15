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
  `ctime` varchar(255) NOT NULL DEFAULT '2021-01-15 13:53:23' COMMENT '创建时间',
  `mtime` varchar(255) NOT NULL DEFAULT '2021-01-15 13:53:23' COMMENT '图标更新时间',
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
  `ctime` varchar(255) NOT NULL DEFAULT '2021-01-15 13:53:23' COMMENT '创建时间',
  `mtime` varchar(255) NOT NULL DEFAULT '2021-01-15 13:53:23' COMMENT '更新时间',
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
  `ctime` varchar(255) NOT NULL DEFAULT '2021-01-15 13:53:23' COMMENT '菜单创建时间',
  `mtime` varchar(255) NOT NULL DEFAULT '2021-01-15 13:53:23' COMMENT '菜单更新时间',
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
INSERT INTO `menu` VALUES ('18c7421f-a78a-4b16-8563-14a0fadda20b','备忘录管理',NULL,1,'/memory','Layout',1,0,1,1,'xapi-memory','备忘录管理','2021-01-15 10:11:07','2021-01-15 10:11:07'),('bc262ac5-d198-4fcc-8fdc-7459bdc538ad','用户管理','d6aa09e9-a1b7-47fb-b073-311e873af633',1,'/system/user','system/user/Index',2,0,1,1,'xapi-user','系统管理 - 用户管理','2021-01-15 10:10:02','2021-01-15 10:10:02'),('d6aa09e9-a1b7-47fb-b073-311e873af633','系统管理',NULL,1,'/system','Layout',1,0,1,1,'xapi-system','系统管理','2021-01-15 10:10:02','2021-01-15 10:10:02');
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
  `ctime` varchar(255) NOT NULL DEFAULT '2021-01-15 13:53:23' COMMENT '创建时间',
  `mtime` varchar(255) NOT NULL DEFAULT '2021-01-15 13:53:23' COMMENT '修改时间',
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
INSERT INTO `role` VALUES ('23dad3eb-f42a-47bd-be47-4a377b4f51ca','user',1,1,'普通用户','2021-01-13 09:47:18','2021-01-13 09:47:18'),('9d5e37ac-a6ce-4df6-bc6e-332e7944cb2c','test',2,1,'测试更新','2021-01-13 14:21:40','2021-01-13 14:29:10'),('a994e44c-42fa-4451-bae1-991db73fcd53','系统管理',1,1,'系统管理目录','2021-01-14 17:26:39','2021-01-14 17:26:39'),('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78','admin',1,1,'管理员','2021-01-12 17:29:44','2021-01-12 17:29:44');
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
INSERT INTO `role_menu` VALUES ('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78','18c7421f-a78a-4b16-8563-14a0fadda20b'),('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78','bc262ac5-d198-4fcc-8fdc-7459bdc538ad'),('da0269f8-b0fe-4a69-ab0a-d8f3d870fb78','d6aa09e9-a1b7-47fb-b073-311e873af633');
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
  `ctime` varchar(255) NOT NULL DEFAULT '2021-01-15 13:53:23' COMMENT '用户创建时间',
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
INSERT INTO `user` VALUES ('26192b0d-9281-4363-b8c5-e05a29bef677','duli','9db06bcff9248837f86d1a6bcf41c9e7','用户007','yarmily','2021-01-13 15:38:02',1,'http://localhost:3000/avatar/26192b0d-9281-4363-b8c5-e05a29bef677.jpg');
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
INSERT INTO `user_role` VALUES ('26192b0d-9281-4363-b8c5-e05a29bef677','23dad3eb-f42a-47bd-be47-4a377b4f51ca'),('26192b0d-9281-4363-b8c5-e05a29bef677','da0269f8-b0fe-4a69-ab0a-d8f3d870fb78');
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

-- Dump completed on 2021-01-15 17:29:25
