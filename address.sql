/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : e-shop

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2017-12-21 14:16:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `address`
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `userid` int(10) DEFAULT NULL,
  `telephone` char(20) DEFAULT NULL,
  `name` char(10) DEFAULT NULL,
  `area` char(100) DEFAULT NULL,
  `street` char(100) DEFAULT NULL,
  `fulladdress` char(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('44', '64', '222222', '111111', '222222', '222222', '2222222');
INSERT INTO `address` VALUES ('45', '64', '15612016600', '3333', '33333', '333', '333333');
INSERT INTO `address` VALUES ('49', '52', '11', '111', '11', '11', '111');
INSERT INTO `address` VALUES ('53', '70', '111', '111', '11111', '111', '111');
INSERT INTO `address` VALUES ('54', '70', '2222', '2222', '222', '22', '22');

-- ----------------------------
-- Table structure for `cartbean`
-- ----------------------------
DROP TABLE IF EXISTS `cartbean`;
CREATE TABLE `cartbean` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cartbean
-- ----------------------------
INSERT INTO `cartbean` VALUES ('5');
INSERT INTO `cartbean` VALUES ('6');
INSERT INTO `cartbean` VALUES ('7');
INSERT INTO `cartbean` VALUES ('9');
INSERT INTO `cartbean` VALUES ('10');
INSERT INTO `cartbean` VALUES ('11');

-- ----------------------------
-- Table structure for `food`
-- ----------------------------
DROP TABLE IF EXISTS `food`;
CREATE TABLE `food` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` char(50) DEFAULT NULL,
  `detail` char(255) DEFAULT NULL,
  `price` double(10,2) DEFAULT NULL,
  `imgurl` char(50) DEFAULT NULL,
  `typeid` int(10) DEFAULT NULL,
  `state` char(20) DEFAULT NULL,
  `sale` char(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `typeid` (`typeid`),
  CONSTRAINT `food_ibfk_1` FOREIGN KEY (`typeid`) REFERENCES `type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of food
-- ----------------------------
INSERT INTO `food` VALUES ('1', '商品名1', '阿斯蒂芬', '2.22', 'images/p1.jpg', '1', 'new', '1');
INSERT INTO `food` VALUES ('2', '商品名2', '啊啊士大夫', '25.89', 'images/p2.jpg', '1', '', '0');
INSERT INTO `food` VALUES ('3', '商品名3', '商品详情3商品详情3商品详情3商品详情3商品详情3商品详情3商品详情3商品详情3商品详情3商品详情3商品详情3商品详情3商品详情3商品详情3商品详情3商品详情3商品详情3商品详情3商品详情3商品详情3', '25.89', 'images/p3.jpg', '2', 'hot', '0');
INSERT INTO `food` VALUES ('4', '商品名4', '商品详情4商品详情4商品详情4商品详情4商品详情4商品详情4商品详情4商品详情4商品详情4商品详情4商品详情4商品详情4商品详情4商品详情4商品详情4商品详情4商品详情4商品详情4商品详情4商品详情4', '25.89', 'images/p4.jpg', '2', 'hot', '0');
INSERT INTO `food` VALUES ('5', '商品名5', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p5.jpg', '3', 'hot', '1');
INSERT INTO `food` VALUES ('6', '商品名6', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p6.jpg', '3', '', '0');
INSERT INTO `food` VALUES ('7', '商品名7', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p1.jpg', '1', 'new', '0');
INSERT INTO `food` VALUES ('8', '商品名8', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p2.jpg', '1', '', '0');
INSERT INTO `food` VALUES ('9', '商品名9', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p3.jpg', '2', null, '0');
INSERT INTO `food` VALUES ('10', '商品名10', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p4.jpg', '2', null, '1');
INSERT INTO `food` VALUES ('11', '商品名11', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p5.jpg', '3', null, '1');
INSERT INTO `food` VALUES ('12', '商品名12', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p6.jpg', '3', 'hot', '1');
INSERT INTO `food` VALUES ('15', '商品名15', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p3.jpg', '2', null, '0');
INSERT INTO `food` VALUES ('16', '商品名16', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p4.jpg', '2', null, '0');
INSERT INTO `food` VALUES ('17', '商品名17', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p5.jpg', '3', null, '1');
INSERT INTO `food` VALUES ('18', '商品名18', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p6.jpg', '3', null, '1');
INSERT INTO `food` VALUES ('19', '商品名19', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p1.jpg', '1', null, '1');
INSERT INTO `food` VALUES ('20', '商品名20', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p2.jpg', '1', null, '1');
INSERT INTO `food` VALUES ('21', '商品名21', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p3.jpg', '2', null, '1');
INSERT INTO `food` VALUES ('22', '商品名22', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p4.jpg', '2', null, '1');
INSERT INTO `food` VALUES ('23', '商品名23', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p5.jpg', '3', null, '1');
INSERT INTO `food` VALUES ('24', '商品名24', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p6.jpg', '3', 'hot', '1');
INSERT INTO `food` VALUES ('25', '商品名25', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p6.jpg', '1', null, '1');
INSERT INTO `food` VALUES ('26', '商品名26', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p6.jpg', '1', null, '1');
INSERT INTO `food` VALUES ('27', '商品名27', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p6.jpg', '1', null, '0');
INSERT INTO `food` VALUES ('28', '商品名28', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p4.jpg', '1', null, '0');
INSERT INTO `food` VALUES ('29', '商品名29', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p5.jpg', '2', 'hot', '1');
INSERT INTO `food` VALUES ('30', '商品名30', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p4.jpg', '2', null, '0');
INSERT INTO `food` VALUES ('31', '商品名31', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p4.jpg', '2', null, '0');
INSERT INTO `food` VALUES ('32', '商品名32', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p1.jpg', '2', null, '1');
INSERT INTO `food` VALUES ('33', '商品名33', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p4.jpg', '3', 'hot', '1');
INSERT INTO `food` VALUES ('34', '商品名34', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p5.jpg', '3', null, '1');
INSERT INTO `food` VALUES ('35', '商品名35', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p1.jpg', '3', null, '1');
INSERT INTO `food` VALUES ('36', '商品名36', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.83', 'images/p4.jpg', '4', null, '1');
INSERT INTO `food` VALUES ('37', '商品名37', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p5.jpg', '4', 'hot', '1');
INSERT INTO `food` VALUES ('38', '商品名38', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p4.jpg', '4', null, '1');
INSERT INTO `food` VALUES ('40', '商品名40', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p1.jpg', '4', 'new', '1');
INSERT INTO `food` VALUES ('41', '商品名41', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p5.jpg', '2', 'hot', '1');
INSERT INTO `food` VALUES ('42', '商品名42', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p1.jpg', '2', null, '1');
INSERT INTO `food` VALUES ('43', '商品名43', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p4.jpg', '3', null, '1');
INSERT INTO `food` VALUES ('47', '商品名47', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p1.jpg', '1', 'new', '1');
INSERT INTO `food` VALUES ('48', '商品名48', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p5.jpg', '1', null, '1');
INSERT INTO `food` VALUES ('51', '商品名51', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p5.jpg', '2', 'new', '1');
INSERT INTO `food` VALUES ('52', '商品名52', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p4.jpg', '2', null, '1');
INSERT INTO `food` VALUES ('53', '商品名53', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p6.jpg', '3', null, '1');
INSERT INTO `food` VALUES ('54', '商品名54', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p5.jpg', '3', null, '1');
INSERT INTO `food` VALUES ('58', '商品名58', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p5.jpg', '3', 'new', '1');
INSERT INTO `food` VALUES ('59', '商品名59', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p6.jpg', '3', 'new', '1');
INSERT INTO `food` VALUES ('60', '商品名60', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p1.jpg', '4', null, '0');
INSERT INTO `food` VALUES ('65', '商品名65', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p1.jpg', '3', 'new', '1');
INSERT INTO `food` VALUES ('66', '商品名66', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p6.jpg', '3', null, '0');
INSERT INTO `food` VALUES ('67', '商品名67', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p5.jpg', '3', null, '0');
INSERT INTO `food` VALUES ('68', '商品名68', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p4.jpg', '1', null, '0');
INSERT INTO `food` VALUES ('69', '商品名69', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p6.jpg', '1', null, '0');
INSERT INTO `food` VALUES ('70', '商品名70', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p1.jpg', '1', null, '0');
INSERT INTO `food` VALUES ('71', '商品名71', '这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情这是商品详情', '25.89', 'images/p5.jpg', '1', null, '0');

-- ----------------------------
-- Table structure for `foodcart`
-- ----------------------------
DROP TABLE IF EXISTS `foodcart`;
CREATE TABLE `foodcart` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `foodid` int(10) DEFAULT NULL,
  `cartbeanid` int(10) DEFAULT NULL,
  `foodcount` int(10) DEFAULT NULL,
  `text` char(100) DEFAULT NULL,
  `sum` double(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `foodid` (`foodid`),
  KEY `cartbeanid` (`cartbeanid`),
  CONSTRAINT `foodcart_ibfk_1` FOREIGN KEY (`foodid`) REFERENCES `food` (`id`),
  CONSTRAINT `foodcart_ibfk_2` FOREIGN KEY (`cartbeanid`) REFERENCES `cartbean` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of foodcart
-- ----------------------------

-- ----------------------------
-- Table structure for `orderdetail`
-- ----------------------------
DROP TABLE IF EXISTS `orderdetail`;
CREATE TABLE `orderdetail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `orderid` int(10) DEFAULT NULL,
  `foodid` int(10) DEFAULT NULL,
  `count` int(10) DEFAULT NULL,
  `text` char(100) DEFAULT NULL,
  `sum` double(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orderid` (`orderid`),
  KEY `orderdetail_ibfk_2` (`foodid`),
  CONSTRAINT `orderdetail_ibfk_1` FOREIGN KEY (`orderid`) REFERENCES `orders` (`id`),
  CONSTRAINT `orderdetail_ibfk_2` FOREIGN KEY (`foodid`) REFERENCES `food` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderdetail
-- ----------------------------
INSERT INTO `orderdetail` VALUES ('114', '86', '1', '1', '', '25.89');
INSERT INTO `orderdetail` VALUES ('115', '87', '1', '1', '', '25.89');
INSERT INTO `orderdetail` VALUES ('116', '88', '1', '1', '', '25.89');
INSERT INTO `orderdetail` VALUES ('117', '89', '2', '1', '', '25.89');
INSERT INTO `orderdetail` VALUES ('118', '90', '1', '1', '', '25.89');
INSERT INTO `orderdetail` VALUES ('128', '87', '3', '2', '', '0.00');
INSERT INTO `orderdetail` VALUES ('168', '100', '1', '1', '', '25.80');
INSERT INTO `orderdetail` VALUES ('169', '101', '1', '1', '', '25.80');
INSERT INTO `orderdetail` VALUES ('170', '102', '5', '1', '', '25.89');
INSERT INTO `orderdetail` VALUES ('171', '103', '5', '5', '', '129.45');
INSERT INTO `orderdetail` VALUES ('174', '105', '1', '1', '', '25.80');

-- ----------------------------
-- Table structure for `orders`
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `userid` int(10) DEFAULT NULL,
  `time` date DEFAULT NULL,
  `state` char(10) DEFAULT NULL,
  `total` double(10,2) DEFAULT NULL,
  `telephone` char(20) DEFAULT NULL,
  `name` char(10) DEFAULT NULL,
  `area` char(100) DEFAULT NULL,
  `street` char(100) DEFAULT NULL,
  `fulladdress` char(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('86', '64', '2017-12-13', 'fail', '25.89', '222222', '111111', '222222', '222222', '2222222');
INSERT INTO `orders` VALUES ('87', '52', '2017-12-13', 'norepay', '77.67', '11', '111', '11', '11', '111');
INSERT INTO `orders` VALUES ('88', '52', '2017-12-13', 'nopay', '25.89', '11', '111', '11', '11', '111');
INSERT INTO `orders` VALUES ('89', '52', '2017-12-13', 'nopay', '25.89', '11', '111', '11', '11', '111');
INSERT INTO `orders` VALUES ('90', '52', '2017-12-13', 'nopay', '25.89', '11', '111', '11', '11', '111');
INSERT INTO `orders` VALUES ('100', '64', '2017-12-20', 'nopay', '25.80', '222222', '111111', '222222', '222222', '2222222');
INSERT INTO `orders` VALUES ('101', '64', '2017-12-20', 'senddone', '25.80', '222222', '111111', '222222', '222222', '2222222');
INSERT INTO `orders` VALUES ('102', '64', '2017-12-20', 'nopay', '25.89', '222222', '111111', '222222', '222222', '2222222');
INSERT INTO `orders` VALUES ('103', '64', '2017-12-20', 'nopay', '129.45', '222222', '111111', '222222', '222222', '2222222');
INSERT INTO `orders` VALUES ('105', '70', '2017-12-20', 'pay', '25.80', '2222', '2222', '222', '22', '22');

-- ----------------------------
-- Table structure for `type`
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` char(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of type
-- ----------------------------
INSERT INTO `type` VALUES ('1', '商品类型1');
INSERT INTO `type` VALUES ('2', '商品类型2');
INSERT INTO `type` VALUES ('3', '商品类型3');
INSERT INTO `type` VALUES ('4', '商品类型4');
INSERT INTO `type` VALUES ('8', '商品类型5');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `addressid` int(10) DEFAULT NULL,
  `cartbeanid` int(10) DEFAULT NULL,
  `username` char(10) DEFAULT NULL,
  `password` char(10) DEFAULT NULL,
  `role` char(10) DEFAULT NULL,
  `imgurl` char(100) DEFAULT NULL,
  `status` int(5) DEFAULT NULL,
  `activationcode` char(10) DEFAULT NULL,
  `email` char(20) DEFAULT NULL,
  `time` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `addressid` (`addressid`),
  KEY `cartbeanid` (`cartbeanid`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`addressid`) REFERENCES `address` (`id`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`cartbeanid`) REFERENCES `cartbean` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('52', '49', '6', '111', '111', '用户', 'images\\张刘洋.jpg', '1', '428176', '2222222222222222222', '2017-11-23');
INSERT INTO `user` VALUES ('64', '44', '5', '222', '222', '用户', 'images\\头像.jpg', '1', '414894', '222222222', '2017-11-28');
INSERT INTO `user` VALUES ('65', null, '7', '333', '333', '用户', 'images\\头像.png', '1', '209813', '2222222', '2017-12-01');
INSERT INTO `user` VALUES ('66', null, null, '444', '444', '管理员', null, '1', null, null, null);
INSERT INTO `user` VALUES ('70', '54', '11', '555', '555555', '用户', 'images\\头像.jpg', '1', '785246', '1668522243@qq.com', '2017-12-20');
