/*
 Navicat MySQL Data Transfer

 Source Server         : 192.168.151.2-MYSQL
 Source Server Type    : MySQL
 Source Server Version : 50729
 Source Host           : localhost:3306
 Source Schema         : crm

 Target Server Type    : MySQL
 Target Server Version : 50729
 File Encoding         : 65001

 Date: 17/03/2021 14:23:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_activity
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity`;
CREATE TABLE `tbl_activity` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `startDate` char(10) DEFAULT NULL,
  `endDate` char(10) DEFAULT NULL,
  `cost` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_activity
-- ----------------------------
BEGIN;
INSERT INTO `tbl_activity` VALUES ('13321d00af6142fcb463bb530a69f3e0', '06f5fc056eac41558a964f96daa7f27c', '今天不上班', '2020-10-19', '2020-10-27', '很多', '今天不上班 爽翻', '2020-10-26 14:51:06', '李四', '2021-01-05 10:10:06', '李四');
INSERT INTO `tbl_activity` VALUES ('350a81565c7a440086347cddb1fa5b84', '06f5fc056eac41558a964f96daa7f27c', '码农搬砖4', '2020-10-01', '2020-11-04', '1', '1', '2020-10-13 12:29:50', '李四', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('37d248a8eeb94684bc3c3eb962a05f7d', '40f6cdea0bd34aceb77492a1656d9fb3', '码农搬砖2', '2020-10-01', '2020-10-06', '1', '1', '2020-10-13 12:29:28', '李四', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('3d8a9f2b7ad0437c92bd445a971c48a5', '06f5fc056eac41558a964f96daa7f27c', '我修改了，springmvc真好用', '2020-11-29', '2020-11-29', '1', '1', '2020-11-29 13:59:59', '李四', '2020-12-04 19:49:52', '李四');
INSERT INTO `tbl_activity` VALUES ('3f7621afd1f941528c29bee170888d70', '06f5fc056eac41558a964f96daa7f27c', 'springmvc真好用', '2021-01-12', '2020-11-09', '哈哈哈', '啊哈哈啊', '2020-11-29 14:01:57', '李四', '2021-01-01 11:11:32', '李四');
INSERT INTO `tbl_activity` VALUES ('4b031aa3b03f49dca3bc668078824669', '40f6cdea0bd34aceb77492a1656d9fb3', '我要试试springmvc', '2020-11-12', '2020-11-26', '不要钱', '哈哈哈', '2020-11-29 13:45:57', '李四', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('5e274915d91348eabdd08dabf6a4020e', '06f5fc056eac41558a964f96daa7f27c', '今天不上学', '2020-10-26', '2020-10-27', '0', '今天不上学 爽翻', '2020-10-26 14:49:26', '李四', '2021-01-05 10:10:29', '李四');
INSERT INTO `tbl_activity` VALUES ('6cca4ffc1e484861b9f4d9c74c12c437', '06f5fc056eac41558a964f96daa7f27c', '码农', '2020-10-08', '2020-10-20', '0', '哈哈', '2020-10-14 08:45:13', '李四', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('74a960f9239846b8b31373015aa42217', '06f5fc056eac41558a964f96daa7f27c', '码农搬砖1', '2020-10-01', '2020-10-02', '没钱', '难受呀马飞', '2020-10-11 21:12:06', '李四', '2020-10-12 11:04:45', '李四');
INSERT INTO `tbl_activity` VALUES ('ce96338201b74fe6b97ab9dda2c6d3ed', '40f6cdea0bd34aceb77492a1656d9fb3', '码农搬砖3', '2020-10-07', '2020-10-06', '1', '1', '2020-10-13 12:29:40', '李四', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for tbl_activity_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity_remark`;
CREATE TABLE `tbl_activity_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL COMMENT '0±íÊ¾Î´ÐÞ¸Ä£¬1±íÊ¾ÒÑÐÞ¸Ä',
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_activity_remark
-- ----------------------------
BEGIN;
INSERT INTO `tbl_activity_remark` VALUES ('0189bf7980a1487ea06f1a329a664e8c', 'hahaha笑死我了', '2020-10-13 11:23:29', '李四', '2020-10-13 11:24:02', '李四', '1', '74a960f9239846b8b31373015aa42217');
INSERT INTO `tbl_activity_remark` VALUES ('74a960f9239846b8b31373015aa42251', '备注1(属于码农搬砖)\n     本码农专注搬砖十余年!!', '2020-10-11 20:12:06', '李四', '2020-10-13 11:23:53', '李四', '1', '74a960f9239846b8b31373015aa42217');
INSERT INTO `tbl_activity_remark` VALUES ('76960f3953cc458cb73ddcf5ba898181', '嘻嘻', '2020-10-14 09:31:09', '李四', NULL, NULL, '0', '6cca4ffc1e484861b9f4d9c74c12c437');
INSERT INTO `tbl_activity_remark` VALUES ('8294e930cabf47b99878a0fc934ef14b', '这是详细信息中的留言栏', '2020-10-14 09:31:50', '李四', NULL, NULL, '0', '6cca4ffc1e484861b9f4d9c74c12c437');
INSERT INTO `tbl_activity_remark` VALUES ('8e585dd518334c359f0bee576905ece0', '芜湖', '2020-11-25 09:22:38', '李四', NULL, NULL, '0', '13321d00af6142fcb463bb530a69f3e0');
INSERT INTO `tbl_activity_remark` VALUES ('b676ea77f2ae4ee8816f02977de51b4d', '嘻嘻', '2020-12-13 21:52:16', '李四', NULL, NULL, '0', '3f7621afd1f941528c29bee170888d70');
INSERT INTO `tbl_activity_remark` VALUES ('d531abcefc434d2895b15bddab45db71', '有性格，我喜欢', '2020-10-26 16:17:44', '李四', NULL, NULL, '0', '13321d00af6142fcb463bb530a69f3e0');
INSERT INTO `tbl_activity_remark` VALUES ('deb538bc5da8477ea771a0dcf51509e0', '芜湖', '2020-12-13 21:54:07', '李四', '2021-01-02 09:52:13', '李四', '1', '3d8a9f2b7ad0437c92bd445a971c48a5');
INSERT INTO `tbl_activity_remark` VALUES ('e8080d22034c4740b852a854ecf2600c', '芜湖起飞!!', '2020-12-13 22:26:54', '李四', '2021-01-16 21:16:25', '李四', '1', '3f7621afd1f941528c29bee170888d70');
INSERT INTO `tbl_activity_remark` VALUES ('ea29c512463d4106aa00e33636c84387', '啊', '2020-11-25 09:23:40', '李四', NULL, NULL, '0', '13321d00af6142fcb463bb530a69f3e0');
INSERT INTO `tbl_activity_remark` VALUES ('eb1ade7d57934ee0b77b46cac7f9d2ce', '起飞', '2020-12-13 22:24:10', '李四', '2021-01-02 09:52:28', '李四', '1', '3d8a9f2b7ad0437c92bd445a971c48a5');
COMMIT;

-- ----------------------------
-- Table structure for tbl_clue
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue`;
CREATE TABLE `tbl_clue` (
  `id` char(32) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `owner` char(32) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue
-- ----------------------------
BEGIN;
INSERT INTO `tbl_clue` VALUES ('056d76686389440f946edfeb5789e88e', '冲哥', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', '字节跳动', '屌丝', '12312@qq.com', '66666666', 'www.zjtd.com', '18188888888', '将来联系', '内部研讨会', '李四', '2020-12-21 00:24:21', NULL, NULL, '线索描述', '联系纪要', '2020-12-31', '详细地址');
INSERT INTO `tbl_clue` VALUES ('1bda69ea396944a6a5f75e9f866de2dc', '王建林', '先生', '06f5fc056eac41558a964f96daa7f27c', '万达集团', 'CEO', '77777777@qq.com', '66666666', 'www.lisi.com', '18188888888', '已联系', '内部研讨会', '李四', '2021-01-01 11:19:46', '李四', '2021-01-05 23:11:46', '万达集团董事长', '万达集团，永远的神!', '2021-01-02', '万达');
INSERT INTO `tbl_clue` VALUES ('24f042e542d44c43a0b7c50948zzxxz1', '马化腾', '博士', '40f6cdea0bd34aceb77492a1656d9fb3', '腾讯', 'CEO', '1014742342', '67956412', 'http://www.qq.com', '15523855585', '丢失线索', '销售邮件', NULL, NULL, NULL, NULL, '一个神佬', '要多多巴结', '2020-10-29', '重庆市江北区');
COMMIT;

-- ----------------------------
-- Table structure for tbl_clue_activity_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_activity_relation`;
CREATE TABLE `tbl_clue_activity_relation` (
  `id` char(32) NOT NULL,
  `clueId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_clue_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_remark`;
CREATE TABLE `tbl_clue_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `clueId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_contacts
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts`;
CREATE TABLE `tbl_contacts` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `birth` char(10) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts
-- ----------------------------
BEGIN;
INSERT INTO `tbl_contacts` VALUES ('96b1d539d4a440849776d9acc107c83b', '06f5fc056eac41558a964f96daa7f27c', '销售邮件', '4e33c9a89a304cd7835aa6c19449d524', '王力欧', '教授', '775829060@qq.com', '18130282003', 'BOSS', '2021-01-05', '李四', '2021-01-03 21:08:31', NULL, NULL, '一个大佬', '要多多联系', '2020-10-29', '重庆市渝北区');
COMMIT;

-- ----------------------------
-- Table structure for tbl_contacts_activity_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_activity_relation`;
CREATE TABLE `tbl_contacts_activity_relation` (
  `id` char(32) NOT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts_activity_relation
-- ----------------------------
BEGIN;
INSERT INTO `tbl_contacts_activity_relation` VALUES ('0077abf54ece40b99e35703ef834de15', '96b1d539d4a440849776d9acc107c83b', '74a960f9239846b8b31373015aa42217');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('245ef9a64eee4915aa7a6b167c4279d6', '96b1d539d4a440849776d9acc107c83b', 'ce96338201b74fe6b97ab9dda2c6d3ed');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('379e5f144dce49288b2e00d91d305b9f', '96b1d539d4a440849776d9acc107c83b', '350a81565c7a440086347cddb1fa5b84');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('a2ef7d93f28b425692080315dc4dd81b', '96b1d539d4a440849776d9acc107c83b', '37d248a8eeb94684bc3c3eb962a05f7d');
COMMIT;

-- ----------------------------
-- Table structure for tbl_contacts_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_remark`;
CREATE TABLE `tbl_contacts_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts_remark
-- ----------------------------
BEGIN;
INSERT INTO `tbl_contacts_remark` VALUES ('1dd914670f5e4e8e920b00a077b48a74', '1', '李四', '2021-01-03 21:08:31', NULL, NULL, '0', '96b1d539d4a440849776d9acc107c83b');
INSERT INTO `tbl_contacts_remark` VALUES ('7f5a523d5a40457fb223608c62278f68', '2', '李四', '2021-01-03 21:08:31', NULL, NULL, '0', '96b1d539d4a440849776d9acc107c83b');
INSERT INTO `tbl_contacts_remark` VALUES ('90e1b02176c442129efa2de68d7f28e2', '4', '李四', '2021-01-03 21:08:31', NULL, NULL, '0', '96b1d539d4a440849776d9acc107c83b');
INSERT INTO `tbl_contacts_remark` VALUES ('93eb58c6f66447af9194fc9a2899e285', '3', '李四', '2021-01-03 21:08:31', NULL, NULL, '0', '96b1d539d4a440849776d9acc107c83b');
COMMIT;

-- ----------------------------
-- Table structure for tbl_customer
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer`;
CREATE TABLE `tbl_customer` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_customer
-- ----------------------------
BEGIN;
INSERT INTO `tbl_customer` VALUES ('4e33c9a89a304cd7835aa6c19449d110', '06f5fc056eac41558a964f96daa7f27c', '百变', 'http://www.baibian.com', '66661111', '张三', '2020-09-10 11:09:31', NULL, NULL, '123', '2019-10-29', '一个大佬', '重庆市渝北区');
INSERT INTO `tbl_customer` VALUES ('4e33c9a89a304cd7835aa6c19449d111', '06f5fc056eac41558a964f96daa7f27c', '百天', 'http://www.baitian.com', '66662222', '张三', '2020-01-03 21:08:31', NULL, NULL, '123', '2018-10-29', '一个大佬', '重庆市渝北区');
INSERT INTO `tbl_customer` VALUES ('4e33c9a89a304cd7835aa6c19449d112', '06f5fc056eac41558a964f96daa7f27c', '百峰', 'http://www.baifeng.com', '66663333', '张三', '2020-01-10 11:09:31', NULL, NULL, '123', '2017-10-29', '一个大佬', '重庆市渝北区');
INSERT INTO `tbl_customer` VALUES ('4e33c9a89a304cd7835aa6c19449d524', '06f5fc056eac41558a964f96daa7f27c', '百度', 'http://www.baidu.com', '66664444', '李四', '2021-01-03 21:08:31', NULL, NULL, '要多多联系', '2020-10-29', '一个大佬', '重庆市渝北区');
INSERT INTO `tbl_customer` VALUES ('6889957d7b5d4a17906fb3ff37eaa4ed', '06f5fc056eac41558a964f96daa7f27c', '谷歌', 'http://www.google.com', '66665555', '李四', '2021-01-04 21:18:51', NULL, NULL, '123', '2021-02-18', '一个大佬', NULL);
COMMIT;

-- ----------------------------
-- Table structure for tbl_customer_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer_remark`;
CREATE TABLE `tbl_customer_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_customer_remark
-- ----------------------------
BEGIN;
INSERT INTO `tbl_customer_remark` VALUES ('0fcabdb522c7490fb57b762ce234ae9d', '3', '李四', '2021-01-03 21:08:31', NULL, NULL, '0', '4e33c9a89a304cd7835aa6c19449d524');
INSERT INTO `tbl_customer_remark` VALUES ('22d6de95adf742848409798f46fc53a7', '2', '李四', '2021-01-03 21:08:31', NULL, NULL, '0', '4e33c9a89a304cd7835aa6c19449d524');
INSERT INTO `tbl_customer_remark` VALUES ('9a6ee5470d1b4a81af6139faab2ca9a6', '1', '李四', '2021-01-03 21:08:31', NULL, NULL, '0', '4e33c9a89a304cd7835aa6c19449d524');
INSERT INTO `tbl_customer_remark` VALUES ('c42ed31b90c947f48aa327670490effd', '4', '李四', '2021-01-03 21:08:31', NULL, NULL, '0', '4e33c9a89a304cd7835aa6c19449d524');
COMMIT;

-- ----------------------------
-- Table structure for tbl_dic_type
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_type`;
CREATE TABLE `tbl_dic_type` (
  `code` varchar(255) NOT NULL COMMENT '±àÂëÊÇÖ÷¼ü£¬²»ÄÜÎª¿Õ£¬²»ÄÜº¬ÓÐÖÐÎÄ¡£',
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dic_type
-- ----------------------------
BEGIN;
INSERT INTO `tbl_dic_type` VALUES ('appellation', '称呼', '');
INSERT INTO `tbl_dic_type` VALUES ('clueState', '线索状态', '');
INSERT INTO `tbl_dic_type` VALUES ('returnPriority', '回访优先级', '');
INSERT INTO `tbl_dic_type` VALUES ('returnState', '回访状态', '');
INSERT INTO `tbl_dic_type` VALUES ('source', '来源', '');
INSERT INTO `tbl_dic_type` VALUES ('stage', '阶段', '');
INSERT INTO `tbl_dic_type` VALUES ('transactionType', '交易类型', '');
COMMIT;

-- ----------------------------
-- Table structure for tbl_dic_value
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_value`;
CREATE TABLE `tbl_dic_value` (
  `id` char(32) NOT NULL COMMENT 'Ö÷¼ü£¬²ÉÓÃUUID',
  `value` varchar(255) DEFAULT NULL COMMENT '²»ÄÜÎª¿Õ£¬²¢ÇÒÒªÇóÍ¬Ò»¸ö×ÖµäÀàÐÍÏÂ×ÖµäÖµ²»ÄÜÖØ¸´£¬¾ßÓÐÎ¨Ò»ÐÔ¡£',
  `text` varchar(255) DEFAULT NULL COMMENT '¿ÉÒÔÎª¿Õ',
  `orderNo` varchar(255) DEFAULT NULL COMMENT '¿ÉÒÔÎª¿Õ£¬µ«²»Îª¿ÕµÄÊ±ºò£¬ÒªÇó±ØÐëÊÇÕýÕûÊý',
  `typeCode` varchar(255) DEFAULT NULL COMMENT 'Íâ¼ü',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dic_value
-- ----------------------------
BEGIN;
INSERT INTO `tbl_dic_value` VALUES ('06e3cbdf10a44eca8511dddfc6896c55', '虚假线索', '虚假线索', '4', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('0fe33840c6d84bf78df55d49b169a894', '销售邮件', '销售邮件', '8', 'source');
INSERT INTO `tbl_dic_value` VALUES ('12302fd42bd349c1bb768b19600e6b20', '交易会', '交易会', '11', 'source');
INSERT INTO `tbl_dic_value` VALUES ('1615f0bb3e604552a86cde9a2ad45bea', '最高', '最高', '2', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('176039d2a90e4b1a81c5ab8707268636', '教授', '教授', '5', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('1e0bd307e6ee425599327447f8387285', '将来联系', '将来联系', '2', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2173663b40b949ce928db92607b5fe57', '丢失线索', '丢失线索', '5', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2876690b7e744333b7f1867102f91153', '未启动', '未启动', '1', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('29805c804dd94974b568cfc9017b2e4c', '07成交', '07成交', '7', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('310e6a49bd8a4962b3f95a1d92eb76f4', '试图联系', '试图联系', '1', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('31539e7ed8c848fc913e1c2c93d76fd1', '博士', '博士', '4', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('37ef211719134b009e10b7108194cf46', '01资质审查', '01资质审查', '1', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('391807b5324d4f16bd58c882750ee632', '08丢失的线索', '08丢失的线索', '8', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('3a39605d67da48f2a3ef52e19d243953', '聊天', '聊天', '14', 'source');
INSERT INTO `tbl_dic_value` VALUES ('474ab93e2e114816abf3ffc596b19131', '低', '低', '3', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('48512bfed26145d4a38d3616e2d2cf79', '广告', '广告', '1', 'source');
INSERT INTO `tbl_dic_value` VALUES ('4d03a42898684135809d380597ed3268', '合作伙伴研讨会', '合作伙伴研讨会', '9', 'source');
INSERT INTO `tbl_dic_value` VALUES ('59795c49896947e1ab61b7312bd0597c', '先生', '先生', '1', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('5c6e9e10ca414bd499c07b886f86202a', '高', '高', '1', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('67165c27076e4c8599f42de57850e39c', '夫人', '夫人', '2', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('68a1b1e814d5497a999b8f1298ace62b', '09因竞争丢失关闭', '09因竞争丢失关闭', '9', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('6b86f215e69f4dbd8a2daa22efccf0cf', 'web调研', 'web调研', '13', 'source');
INSERT INTO `tbl_dic_value` VALUES ('72f13af8f5d34134b5b3f42c5d477510', '合作伙伴', '合作伙伴', '6', 'source');
INSERT INTO `tbl_dic_value` VALUES ('7c07db3146794c60bf975749952176df', '未联系', '未联系', '6', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('86c56aca9eef49058145ec20d5466c17', '内部研讨会', '内部研讨会', '10', 'source');
INSERT INTO `tbl_dic_value` VALUES ('9095bda1f9c34f098d5b92fb870eba17', '进行中', '进行中', '3', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('954b410341e7433faa468d3c4f7cf0d2', '已有业务', '已有业务', '1', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('966170ead6fa481284b7d21f90364984', '已联系', '已联系', '3', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('96b03f65dec748caa3f0b6284b19ef2f', '推迟', '推迟', '2', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('97d1128f70294f0aac49e996ced28c8a', '新业务', '新业务', '2', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('9ca96290352c40688de6596596565c12', '完成', '完成', '4', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('9e6d6e15232549af853e22e703f3e015', '需要条件', '需要条件', '7', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('9ff57750fac04f15b10ce1bbb5bb8bab', '02需求分析', '02需求分析', '2', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('a70dc4b4523040c696f4421462be8b2f', '等待某人', '等待某人', '5', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('a83e75ced129421dbf11fab1f05cf8b4', '推销电话', '推销电话', '2', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ab8472aab5de4ae9b388b2f1409441c1', '常规', '常规', '5', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('ab8c2a3dc05f4e3dbc7a0405f721b040', '05提案/报价', '05提案/报价', '5', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('b924d911426f4bc5ae3876038bc7e0ad', 'web下载', 'web下载', '12', 'source');
INSERT INTO `tbl_dic_value` VALUES ('c13ad8f9e2f74d5aa84697bb243be3bb', '03价值建议', '03价值建议', '3', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('c83c0be184bc40708fd7b361b6f36345', '最低', '最低', '4', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('db867ea866bc44678ac20c8a4a8bfefb', '员工介绍', '员工介绍', '3', 'source');
INSERT INTO `tbl_dic_value` VALUES ('e44be1d99158476e8e44778ed36f4355', '04确定决策者', '04确定决策者', '4', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('e5f383d2622b4fc0959f4fe131dafc80', '女士', '女士', '3', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('e81577d9458f4e4192a44650a3a3692b', '06谈判/复审', '06谈判/复审', '6', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('fb65d7fdb9c6483db02713e6bc05dd19', '在线商场', '在线商场', '5', 'source');
INSERT INTO `tbl_dic_value` VALUES ('fd677cc3b5d047d994e16f6ece4d3d45', '公开媒介', '公开媒介', '7', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ff802a03ccea4ded8731427055681d48', '外部介绍', '外部介绍', '4', 'source');
COMMIT;

-- ----------------------------
-- Table structure for tbl_tran
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran`;
CREATE TABLE `tbl_tran` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran
-- ----------------------------
BEGIN;
INSERT INTO `tbl_tran` VALUES ('bb9a3804545c4658b1b5bf3e1f9acd10', NULL, NULL, NULL, NULL, NULL, '01资质审查', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_tran` VALUES ('bb9a3804545c4658b1b5bf3e1f9acd11', NULL, NULL, NULL, NULL, NULL, '04确定决策者', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_tran` VALUES ('bb9a3804545c4658b1b5bf3e1f9acd12', NULL, NULL, NULL, NULL, NULL, '05提案/报价', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_tran` VALUES ('bb9a3804545c4658b1b5bf3e1f9acd13', NULL, NULL, NULL, NULL, NULL, '03价值建议', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_tran` VALUES ('bb9a3804545c4658b1b5bf3e1f9acdd4', '06f5fc056eac41558a964f96daa7f27c', '10000', '交易123', '2021-01-04', '4e33c9a89a304cd7835aa6c19449d110', '03价值建议', '已有业务', '在线商场', '74a960f9239846b8b31373015aa42217', '96b1d539d4a440849776d9acc107c83b', '李四', '2021-01-04 21:16:37', '李四', '2021-01-17 11:42:05', '123', '234', '2021-02-04');
INSERT INTO `tbl_tran` VALUES ('bbc37d1f3c4c4e418014de7b18d66a41', '06f5fc056eac41558a964f96daa7f27c', '1000000', '一百万大交易', '2021-01-04', '6889957d7b5d4a17906fb3ff37eaa4ed', '04确定决策者', '已有业务', '在线商场', '74a960f9239846b8b31373015aa42217', '96b1d539d4a440849776d9acc107c83b', '李四', '2021-01-04 21:18:51', '李四', '2021-02-01 11:48:29', '123', '123', '2021-02-18');
COMMIT;

-- ----------------------------
-- Table structure for tbl_tran_history
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_history`;
CREATE TABLE `tbl_tran_history` (
  `id` char(32) NOT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran_history
-- ----------------------------
BEGIN;
INSERT INTO `tbl_tran_history` VALUES ('05721b3e258c4471bc449acc60764628', '03价值建议', '10000', '2021-01-04', '2021-01-17 11:42:05', '李四', 'bb9a3804545c4658b1b5bf3e1f9acdd4');
INSERT INTO `tbl_tran_history` VALUES ('2f19ee51d0654332a69c3e00a2830817', '08丢失的线索', '1000000', '2021-01-04', '2021-01-19 19:51:33', '李四', 'bbc37d1f3c4c4e418014de7b18d66a41');
INSERT INTO `tbl_tran_history` VALUES ('707c8e5fdbe04faf97c043c927a79a4c', '02需求分析', '1000000', '2021-01-04', '2021-01-17 11:42:09', '李四', 'bbc37d1f3c4c4e418014de7b18d66a41');
INSERT INTO `tbl_tran_history` VALUES ('7439e1db6f91474f9c99f33886a87020', '04确定决策者', '1000000', '2021-01-04', '2021-02-01 11:48:25', '李四', 'bbc37d1f3c4c4e418014de7b18d66a41');
INSERT INTO `tbl_tran_history` VALUES ('96c8784d501a430bb4b22715bb22b8e4', '04确定决策者', '1000000', '2021-01-04', '2021-02-01 11:48:22', '李四', 'bbc37d1f3c4c4e418014de7b18d66a41');
INSERT INTO `tbl_tran_history` VALUES ('a07466b9ae264c9abb762675d092b6ef', '08丢失的线索', '1000000', '2021-01-04', '2021-02-01 11:48:24', '李四', 'bbc37d1f3c4c4e418014de7b18d66a41');
INSERT INTO `tbl_tran_history` VALUES ('b26125bab86849a28ad809f31bf756d3', '04确定决策者', '1000000', '2021-01-04', '2021-02-01 11:48:29', '李四', 'bbc37d1f3c4c4e418014de7b18d66a41');
INSERT INTO `tbl_tran_history` VALUES ('be4c8e2ed4004f8cba04d11c0ebc6ff0', '08丢失的线索', '1000000', '2021-01-04', '2021-02-01 11:48:28', '李四', 'bbc37d1f3c4c4e418014de7b18d66a41');
INSERT INTO `tbl_tran_history` VALUES ('dd1e828464894465916a4f4f226bfcd3', '03价值建议', '1000000', '2021-01-04', '2021-01-19 19:51:34', '李四', 'bbc37d1f3c4c4e418014de7b18d66a41');
INSERT INTO `tbl_tran_history` VALUES ('f4f7d05948354fb18c32592e1da1d343', '07成交', '1000000', '2021-01-04', '2021-01-19 19:51:32', '李四', 'bbc37d1f3c4c4e418014de7b18d66a41');
COMMIT;

-- ----------------------------
-- Table structure for tbl_tran_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_remark`;
CREATE TABLE `tbl_tran_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tbl_user
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `id` char(32) NOT NULL COMMENT 'uuid\r\n            ',
  `loginAct` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `loginPwd` varchar(255) DEFAULT NULL COMMENT '密码不能采用明文存储，采用密文，MD5加密之后的数据',
  `email` varchar(255) DEFAULT NULL,
  `expireTime` char(19) DEFAULT NULL COMMENT '失效时间为空的时候表示永不失效，失效时间为2018-10-10 10:10:10，则表示在该时间之前该账户可用。',
  `lockState` char(1) DEFAULT NULL COMMENT '锁定状态为空时表示启用，为0时表示锁定，为1时表示启用。',
  `deptno` char(4) DEFAULT NULL,
  `allowIps` varchar(255) DEFAULT NULL COMMENT '允许访问的IP为空时表示IP地址永不受限，允许访问的IP可以是一个，也可以是多个，当多个IP地址的时候，采用半角逗号分隔。允许IP是192.168.100.2，表示该用户只能在IP地址为192.168.100.2的机器上使用。',
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
BEGIN;
INSERT INTO `tbl_user` VALUES ('06f5fc056eac41558a964f96daa7f27c', 'ls', '李四', '202cb962ac59075b964b07152d234b70', 'ls@163.com', '2022-11-27 21:50:05', '1', 'A001', '192.168.1.1', '2018-11-22 12:11:40', '李四', NULL, NULL);
INSERT INTO `tbl_user` VALUES ('40f6cdea0bd34aceb77492a1656d9fb3', 'zs', '张三', '202cb962ac59075b964b07152d234b70', 'zs@qq.com', '2018-11-30 23:50:55', '1', 'A001', '192.168.1.1,192.168.1.2,127.0.0.1', '2018-11-22 11:37:34', '张三', NULL, NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
