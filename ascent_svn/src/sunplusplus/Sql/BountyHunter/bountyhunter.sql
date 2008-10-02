/*
MySQL Data Transfer
Source Host: 192.168.1.3
Source Database: funtastic_world
Target Host: 192.168.1.3
Target Database: funtastic_world
Date: 17.09.2008 21:00:40
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for bountyhunter
-- ----------------------------
CREATE TABLE `bountyhunter` (
  `id` int(11) NOT NULL auto_increment,
  `client` int(11) NOT NULL,
  `target` int(11) NOT NULL,
  `bounty` int(11) NOT NULL,
  `start` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `finish` timestamp NOT NULL default '0000-00-00 00:00:00',
  `contractor` int(11) NOT NULL default '0',
  `level` int(11) NOT NULL default '0',
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `bountyhunter` VALUES ('4', '172', '303', '2000000', '2008-09-14 13:32:00', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `bountyhunter` VALUES ('5', '58', '75', '3000000', '2008-09-14 14:26:32', '0000-00-00 00:00:00', '0', '0');
