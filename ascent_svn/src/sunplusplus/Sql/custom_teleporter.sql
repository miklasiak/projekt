/*
MySQL Data Transfer
Source Host: localhost
Source Database: weed backup
Target Host: localhost
Target Database: weed backup
Date: 28.09.2008 11:03:48
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for custom_teleporter
-- ----------------------------
CREATE TABLE `custom_teleporter` (
  `creature` mediumint(8) unsigned NOT NULL,
  `parent` smallint(6) NOT NULL default '-1',
  `menuid` smallint(6) NOT NULL,
  `icon` tinyint(1) NOT NULL default '0',
  `gossip` varchar(128) collate latin1_general_ci NOT NULL,
  `map` mediumint(8) unsigned default NULL,
  `position_x` float(14,7) default NULL,
  `position_y` float(14,7) default NULL,
  `position_z` float(14,7) default NULL,
  `minlevel` tinyint(3) unsigned default '0',
  `maxlevel` tinyint(3) unsigned default '0',
  `team` tinyint(1) default '-1',
  PRIMARY KEY  (`creature`,`menuid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;