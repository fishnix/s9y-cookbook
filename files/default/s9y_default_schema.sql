-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: test_kitchen_ci
-- ------------------------------------------------------
-- Server version	5.1.73-log

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
-- Table structure for table `serendipity_access`
--

DROP TABLE IF EXISTS `serendipity_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_access` (
  `groupid` int(10) unsigned NOT NULL DEFAULT '0',
  `artifact_id` int(10) unsigned NOT NULL DEFAULT '0',
  `artifact_type` varchar(64) NOT NULL DEFAULT '',
  `artifact_mode` varchar(64) NOT NULL DEFAULT '',
  `artifact_index` varchar(64) NOT NULL DEFAULT '',
  KEY `accessgroup_idx` (`groupid`),
  KEY `accessgroupT_idx` (`artifact_id`,`artifact_type`,`artifact_mode`),
  KEY `accessforeign_idx` (`artifact_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_access`
--

LOCK TABLES `serendipity_access` WRITE;
/*!40000 ALTER TABLE `serendipity_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `serendipity_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_authorgroups`
--

DROP TABLE IF EXISTS `serendipity_authorgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_authorgroups` (
  `groupid` int(10) unsigned NOT NULL DEFAULT '0',
  `authorid` int(10) unsigned NOT NULL DEFAULT '0',
  KEY `authorgroup_idxA` (`groupid`),
  KEY `authorgroup_idxB` (`authorid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_authorgroups`
--

LOCK TABLES `serendipity_authorgroups` WRITE;
/*!40000 ALTER TABLE `serendipity_authorgroups` DISABLE KEYS */;
INSERT INTO `serendipity_authorgroups` VALUES (3,1);
/*!40000 ALTER TABLE `serendipity_authorgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_authors`
--

DROP TABLE IF EXISTS `serendipity_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_authors` (
  `realname` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(32) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `authorid` int(11) NOT NULL AUTO_INCREMENT,
  `mail_comments` int(1) DEFAULT '1',
  `mail_trackbacks` int(1) DEFAULT '1',
  `email` varchar(128) NOT NULL DEFAULT '',
  `userlevel` int(4) unsigned NOT NULL DEFAULT '0',
  `right_publish` int(1) DEFAULT '1',
  `hashtype` int(1) DEFAULT '0',
  PRIMARY KEY (`authorid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_authors`
--

LOCK TABLES `serendipity_authors` WRITE;
/*!40000 ALTER TABLE `serendipity_authors` DISABLE KEYS */;
INSERT INTO `serendipity_authors` VALUES ('Admin User','admin','42459f07825bc7a538f60b767f0f39e41a2d728e',1,1,1,'admin@example.com',255,1,1);
/*!40000 ALTER TABLE `serendipity_authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_category`
--

DROP TABLE IF EXISTS `serendipity_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_category` (
  `categoryid` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) DEFAULT NULL,
  `category_icon` varchar(255) DEFAULT NULL,
  `category_description` text,
  `authorid` int(11) DEFAULT NULL,
  `category_left` int(11) DEFAULT '0',
  `category_right` int(11) DEFAULT '0',
  `parentid` int(11) NOT NULL DEFAULT '0',
  `sort_order` int(11) DEFAULT NULL,
  `hide_sub` int(1) DEFAULT NULL,
  PRIMARY KEY (`categoryid`),
  KEY `categorya_idx` (`authorid`),
  KEY `categoryp_idx` (`parentid`),
  KEY `categorylr_idx` (`category_left`,`category_right`),
  KEY `categoryso_idx` (`sort_order`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_category`
--

LOCK TABLES `serendipity_category` WRITE;
/*!40000 ALTER TABLE `serendipity_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `serendipity_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_comments`
--

DROP TABLE IF EXISTS `serendipity_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entry_id` int(10) unsigned NOT NULL DEFAULT '0',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `timestamp` int(10) unsigned DEFAULT NULL,
  `title` varchar(150) DEFAULT NULL,
  `author` varchar(80) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `ip` varchar(64) DEFAULT NULL,
  `body` longtext,
  `type` varchar(100) DEFAULT 'regular',
  `subscribed` enum('true','false') NOT NULL DEFAULT 'true',
  `status` varchar(50) NOT NULL,
  `referer` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `commentry_idx` (`entry_id`),
  KEY `commpentry_idx` (`parent_id`),
  KEY `commtype_idx` (`type`),
  KEY `commstat_idx` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_comments`
--

LOCK TABLES `serendipity_comments` WRITE;
/*!40000 ALTER TABLE `serendipity_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `serendipity_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_config`
--

DROP TABLE IF EXISTS `serendipity_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_config` (
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `authorid` int(11) DEFAULT '0',
  KEY `configauthorid_idx` (`authorid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_config`
--

LOCK TABLES `serendipity_config` WRITE;
/*!40000 ALTER TABLE `serendipity_config` DISABLE KEYS */;
INSERT INTO `serendipity_config` VALUES ('hashkey','1406077146',0),('template','bulletproof',0),('dbNames','1',0),('serendipityPath','/var/www/vhost/test.kitchen.ci/',0),('uploadPath','uploads/',0),('serendipityHTTPPath','/',0),('templatePath','templates/',0),('uploadHTTPPath','uploads/',0),('defaultBaseURL','http://test.kitchen.ci:8080/',0),('autodetect_baseURL','',0),('indexFile','index.php',0),('permalinkStructure','archives/%id%-%title%.html',0),('permalinkAuthorStructure','authors/%id%-%realname%',0),('permalinkCategoryStructure','categories/%id%-%name%',0),('permalinkFeedCategoryStructure','feeds/categories/%id%-%name%.rss',0),('permalinkFeedAuthorStructure','feeds/authors/%id%-%realname%.rss',0),('permalinkArchivesPath','archives',0),('permalinkArchivePath','archive',0),('permalinkCategoriesPath','categories',0),('permalinkAuthorsPath','authors',0),('permalinkUnsubscribePath','unsubscribe',0),('permalinkDeletePath','delete',0),('permalinkApprovePath','approve',0),('permalinkFeedsPath','feeds',0),('permalinkPluginPath','plugin',0),('permalinkAdminPath','admin',0),('permalinkSearchPath','search',0),('permalinkCommentsPath','comments',0),('blogTitle','My S9y Blog',0),('blogDescription','My little place on the web...',0),('blogMail','',0),('allowSubscriptions','true',0),('allowSubscriptionsOptIn','1',0),('useCommentTokens','',0),('lang','en',0),('charset','UTF-8/',0),('calendar','gregorian',0),('lang_content_negotiation','',0),('enablePluginACL','',0),('fetchLimit','15',0),('RSSfetchLimit','15',0),('archiveSortStable','',0),('searchsort','timestamp',0),('enforce_RFC2616','',0),('useGzip','',0),('wysiwyg','false',0),('enablePopup','',0),('embed','false',0),('top_as_links','',0),('trackReferrer','1',0),('blockReferer',';',0),('rewrite','none',0),('useServerOffset','1',0),('serverOffsetHours','0',0),('showFutureEntries','',0),('enableACL','1',0),('magick','',0),('convert','/usr/bin/convert',0),('thumbSuffix','serendipityThumb',0),('thumbSize','110',0),('thumbConstraint','largest',0),('maxFileSize','',0),('maxImgWidth','',0),('maxImgHeight','',0),('onTheFlySynch','1',0),('dynamicResize','',0),('mediaExif','1',0),('mediaProperties','DPI:IMAGE;RUN_LENGTH:VIDEO:AUDIO;DATE;COPYRIGHT;TITLE;COMMENT1:MULTI;COMMENT2:MULTI;ALT',0),('mediaKeywords','',0),('@serendipity_categories_plugin:270956a750dffec13295a91f4f89f744/title','Categories',0),('@serendipity_categories_plugin:270956a750dffec13295a91f4f89f744/authorid','all',0),('@serendipity_categories_plugin:270956a750dffec13295a91f4f89f744/sort_order','category_name',0),('@serendipity_categories_plugin:270956a750dffec13295a91f4f89f744/sort_method','ASC',0),('@serendipity_categories_plugin:270956a750dffec13295a91f4f89f744/allow_select','1',0),('@serendipity_categories_plugin:270956a750dffec13295a91f4f89f744/show_count','',0),('@serendipity_categories_plugin:270956a750dffec13295a91f4f89f744/parent_base','all',0),('@serendipity_categories_plugin:270956a750dffec13295a91f4f89f744/hide_parent','',0),('@serendipity_categories_plugin:270956a750dffec13295a91f4f89f744/hide_parallel','',0),('@serendipity_syndication_plugin:6ed4a67d11d36367c42b92d45fb2c5e7/title','Syndicate This Blog',0),('@serendipity_syndication_plugin:6ed4a67d11d36367c42b92d45fb2c5e7/feed_name','',0),('@serendipity_syndication_plugin:6ed4a67d11d36367c42b92d45fb2c5e7/comment_name','',0),('@serendipity_syndication_plugin:6ed4a67d11d36367c42b92d45fb2c5e7/big_img','',0),('serendipity_event_nl2br:3118ce10a7de12049796f2c9dd6e9cab/check_markup','true',0),('serendipity_event_nl2br:3118ce10a7de12049796f2c9dd6e9cab/p_tags','false',0),('serendipity_event_nl2br:3118ce10a7de12049796f2c9dd6e9cab/isobr','true',0),('serendipity_event_nl2br:3118ce10a7de12049796f2c9dd6e9cab/clean_tags','false',0);
/*!40000 ALTER TABLE `serendipity_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_entries`
--

DROP TABLE IF EXISTS `serendipity_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `timestamp` int(10) unsigned DEFAULT NULL,
  `body` longtext,
  `comments` int(4) unsigned DEFAULT '0',
  `trackbacks` int(4) unsigned DEFAULT '0',
  `extended` longtext,
  `exflag` int(1) DEFAULT NULL,
  `author` varchar(20) DEFAULT NULL,
  `authorid` int(11) DEFAULT NULL,
  `isdraft` enum('true','false') NOT NULL DEFAULT 'true',
  `allow_comments` enum('true','false') NOT NULL DEFAULT 'true',
  `last_modified` int(10) unsigned DEFAULT NULL,
  `moderate_comments` enum('true','false') NOT NULL DEFAULT 'true',
  PRIMARY KEY (`id`),
  KEY `date_idx` (`timestamp`),
  KEY `mod_idx` (`last_modified`),
  KEY `edraft_idx` (`isdraft`),
  KEY `eauthor_idx` (`authorid`),
  FULLTEXT KEY `entry_idx` (`title`,`body`,`extended`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_entries`
--

LOCK TABLES `serendipity_entries` WRITE;
/*!40000 ALTER TABLE `serendipity_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `serendipity_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_entrycat`
--

DROP TABLE IF EXISTS `serendipity_entrycat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_entrycat` (
  `entryid` int(11) NOT NULL,
  `categoryid` int(11) NOT NULL,
  UNIQUE KEY `entryid_idx` (`entryid`,`categoryid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_entrycat`
--

LOCK TABLES `serendipity_entrycat` WRITE;
/*!40000 ALTER TABLE `serendipity_entrycat` DISABLE KEYS */;
/*!40000 ALTER TABLE `serendipity_entrycat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_entryproperties`
--

DROP TABLE IF EXISTS `serendipity_entryproperties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_entryproperties` (
  `entryid` int(11) NOT NULL,
  `property` varchar(255) NOT NULL,
  `value` longtext,
  UNIQUE KEY `prop_idx` (`entryid`,`property`),
  KEY `entrypropid_idx` (`entryid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_entryproperties`
--

LOCK TABLES `serendipity_entryproperties` WRITE;
/*!40000 ALTER TABLE `serendipity_entryproperties` DISABLE KEYS */;
/*!40000 ALTER TABLE `serendipity_entryproperties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_exits`
--

DROP TABLE IF EXISTS `serendipity_exits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_exits` (
  `entry_id` int(11) NOT NULL DEFAULT '0',
  `day` date NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  `scheme` varchar(5) DEFAULT NULL,
  `host` varchar(128) NOT NULL,
  `port` varchar(5) DEFAULT NULL,
  `path` varchar(255) NOT NULL DEFAULT '',
  `query` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`host`,`path`,`day`,`entry_id`),
  KEY `exits_idx` (`entry_id`,`day`,`host`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_exits`
--

LOCK TABLES `serendipity_exits` WRITE;
/*!40000 ALTER TABLE `serendipity_exits` DISABLE KEYS */;
/*!40000 ALTER TABLE `serendipity_exits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_groupconfig`
--

DROP TABLE IF EXISTS `serendipity_groupconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_groupconfig` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `property` varchar(128) DEFAULT NULL,
  `value` varchar(32) DEFAULT NULL,
  KEY `groupid_idx` (`id`),
  KEY `groupprop_idx` (`id`,`property`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_groupconfig`
--

LOCK TABLES `serendipity_groupconfig` WRITE;
/*!40000 ALTER TABLE `serendipity_groupconfig` DISABLE KEYS */;
INSERT INTO `serendipity_groupconfig` VALUES (1,'userlevel','0'),(1,'personalConfiguration','true'),(1,'personalConfigurationUserlevel','false'),(1,'personalConfigurationNoCreate','false'),(1,'personalConfigurationRightPublish','false'),(1,'siteConfiguration','false'),(1,'blogConfiguration','false'),(1,'adminEntries','true'),(1,'adminEntriesMaintainOthers','false'),(1,'adminImport','false'),(1,'adminCategories','true'),(1,'adminCategoriesMaintainOthers','false'),(1,'adminCategoriesDelete','false'),(1,'adminUsers','false'),(1,'adminUsersDelete','false'),(1,'adminUsersEditUserlevel','false'),(1,'adminUsersMaintainSame','false'),(1,'adminUsersMaintainOthers','false'),(1,'adminUsersCreateNew','false'),(1,'adminUsersGroups','false'),(1,'adminPlugins','false'),(1,'adminPluginsMaintainOthers','false'),(1,'adminImages','true'),(1,'adminImagesDirectories','false'),(1,'adminImagesAdd','true'),(1,'adminImagesDelete','true'),(1,'adminImagesMaintainOthers','false'),(1,'adminImagesViewOthers','true'),(1,'adminImagesView','true'),(1,'adminImagesSync','false'),(1,'adminComments','false'),(1,'adminTemplates','false'),(1,'hiddenGroup','false'),(2,'userlevel','1'),(2,'personalConfiguration','true'),(2,'personalConfigurationUserlevel','true'),(2,'personalConfigurationNoCreate','true'),(2,'personalConfigurationRightPublish','true'),(2,'siteConfiguration','false'),(2,'blogConfiguration','true'),(2,'adminEntries','true'),(2,'adminEntriesMaintainOthers','true'),(2,'adminImport','true'),(2,'adminCategories','true'),(2,'adminCategoriesMaintainOthers','true'),(2,'adminCategoriesDelete','true'),(2,'adminUsers','true'),(2,'adminUsersDelete','true'),(2,'adminUsersEditUserlevel','true'),(2,'adminUsersMaintainSame','true'),(2,'adminUsersMaintainOthers','false'),(2,'adminUsersCreateNew','true'),(2,'adminUsersGroups','true'),(2,'adminPlugins','true'),(2,'adminPluginsMaintainOthers','false'),(2,'adminImages','true'),(2,'adminImagesDirectories','true'),(2,'adminImagesAdd','true'),(2,'adminImagesDelete','true'),(2,'adminImagesMaintainOthers','true'),(2,'adminImagesViewOthers','true'),(2,'adminImagesView','true'),(2,'adminImagesSync','true'),(2,'adminComments','true'),(2,'adminTemplates','true'),(2,'hiddenGroup','false'),(3,'userlevel','255'),(3,'personalConfiguration','true'),(3,'personalConfigurationUserlevel','true'),(3,'personalConfigurationNoCreate','true'),(3,'personalConfigurationRightPublish','true'),(3,'siteConfiguration','true'),(3,'blogConfiguration','true'),(3,'adminEntries','true'),(3,'adminEntriesMaintainOthers','true'),(3,'adminImport','true'),(3,'adminCategories','true'),(3,'adminCategoriesMaintainOthers','true'),(3,'adminCategoriesDelete','true'),(3,'adminUsers','true'),(3,'adminUsersDelete','true'),(3,'adminUsersEditUserlevel','true'),(3,'adminUsersMaintainSame','true'),(3,'adminUsersMaintainOthers','true'),(3,'adminUsersCreateNew','true'),(3,'adminUsersGroups','true'),(3,'adminPlugins','true'),(3,'adminPluginsMaintainOthers','true'),(3,'adminImages','true'),(3,'adminImagesDirectories','true'),(3,'adminImagesAdd','true'),(3,'adminImagesDelete','true'),(3,'adminImagesMaintainOthers','true'),(3,'adminImagesViewOthers','true'),(3,'adminImagesView','true'),(3,'adminImagesSync','true'),(3,'adminComments','true'),(3,'adminTemplates','true'),(3,'hiddenGroup','false');
/*!40000 ALTER TABLE `serendipity_groupconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_groups`
--

DROP TABLE IF EXISTS `serendipity_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_groups`
--

LOCK TABLES `serendipity_groups` WRITE;
/*!40000 ALTER TABLE `serendipity_groups` DISABLE KEYS */;
INSERT INTO `serendipity_groups` VALUES (1,'USERLEVEL_EDITOR_DESC'),(2,'USERLEVEL_CHIEF_DESC'),(3,'USERLEVEL_ADMIN_DESC');
/*!40000 ALTER TABLE `serendipity_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_images`
--

DROP TABLE IF EXISTS `serendipity_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `extension` varchar(5) NOT NULL DEFAULT '',
  `mime` varchar(255) NOT NULL DEFAULT '',
  `size` int(11) NOT NULL DEFAULT '0',
  `dimensions_width` int(11) NOT NULL DEFAULT '0',
  `dimensions_height` int(11) NOT NULL DEFAULT '0',
  `date` int(11) NOT NULL DEFAULT '0',
  `thumbnail_name` varchar(255) NOT NULL DEFAULT '',
  `authorid` int(11) DEFAULT '0',
  `path` text,
  `hotlink` int(1) DEFAULT NULL,
  `realname` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `imagesauthorid_idx` (`authorid`),
  FULLTEXT KEY `pathkey_idx` (`path`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_images`
--

LOCK TABLES `serendipity_images` WRITE;
/*!40000 ALTER TABLE `serendipity_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `serendipity_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_mediaproperties`
--

DROP TABLE IF EXISTS `serendipity_mediaproperties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_mediaproperties` (
  `mediaid` int(11) NOT NULL,
  `property` varchar(128) NOT NULL,
  `property_group` varchar(50) NOT NULL DEFAULT '',
  `property_subgroup` varchar(50) NOT NULL DEFAULT '',
  `value` text,
  UNIQUE KEY `media_idx` (`mediaid`,`property`,`property_group`,`property_subgroup`),
  KEY `mediapropid_idx` (`mediaid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_mediaproperties`
--

LOCK TABLES `serendipity_mediaproperties` WRITE;
/*!40000 ALTER TABLE `serendipity_mediaproperties` DISABLE KEYS */;
/*!40000 ALTER TABLE `serendipity_mediaproperties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_options`
--

DROP TABLE IF EXISTS `serendipity_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_options` (
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `okey` varchar(64) NOT NULL DEFAULT '',
  KEY `options_idx` (`okey`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_options`
--

LOCK TABLES `serendipity_options` WRITE;
/*!40000 ALTER TABLE `serendipity_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `serendipity_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_permalinks`
--

DROP TABLE IF EXISTS `serendipity_permalinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_permalinks` (
  `permalink` varchar(255) NOT NULL DEFAULT '',
  `entry_id` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(200) NOT NULL DEFAULT '',
  `data` text,
  KEY `pl_idx` (`permalink`),
  KEY `ple_idx` (`entry_id`),
  KEY `plt_idx` (`type`),
  KEY `plcomb_idx` (`permalink`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_permalinks`
--

LOCK TABLES `serendipity_permalinks` WRITE;
/*!40000 ALTER TABLE `serendipity_permalinks` DISABLE KEYS */;
INSERT INTO `serendipity_permalinks` VALUES ('authors/1-Admin-User',1,'author',NULL);
/*!40000 ALTER TABLE `serendipity_permalinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_plugincategories`
--

DROP TABLE IF EXISTS `serendipity_plugincategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_plugincategories` (
  `class_name` varchar(250) DEFAULT NULL,
  `category` varchar(250) DEFAULT NULL,
  KEY `plugincat_idx` (`class_name`,`category`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_plugincategories`
--

LOCK TABLES `serendipity_plugincategories` WRITE;
/*!40000 ALTER TABLE `serendipity_plugincategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `serendipity_plugincategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_pluginlist`
--

DROP TABLE IF EXISTS `serendipity_pluginlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_pluginlist` (
  `plugin_file` varchar(255) NOT NULL DEFAULT '',
  `class_name` varchar(255) NOT NULL DEFAULT '',
  `plugin_class` varchar(255) NOT NULL DEFAULT '',
  `pluginPath` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `version` varchar(12) NOT NULL DEFAULT '',
  `upgrade_version` varchar(12) NOT NULL DEFAULT '',
  `plugintype` varchar(255) NOT NULL DEFAULT '',
  `pluginlocation` varchar(255) NOT NULL DEFAULT '',
  `stackable` int(1) NOT NULL DEFAULT '0',
  `author` varchar(255) NOT NULL DEFAULT '',
  `requirements` text NOT NULL,
  `website` varchar(255) NOT NULL DEFAULT '',
  `last_modified` int(11) NOT NULL DEFAULT '0',
  KEY `pluginlist_f_idx` (`plugin_file`),
  KEY `pluginlist_cn_idx` (`class_name`),
  KEY `pluginlist_pt_idx` (`plugintype`),
  KEY `pluginlist_pl_idx` (`pluginlocation`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_pluginlist`
--

LOCK TABLES `serendipity_pluginlist` WRITE;
/*!40000 ALTER TABLE `serendipity_pluginlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `serendipity_pluginlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_plugins`
--

DROP TABLE IF EXISTS `serendipity_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_plugins` (
  `name` varchar(128) NOT NULL,
  `placement` varchar(6) NOT NULL DEFAULT 'right',
  `sort_order` int(4) NOT NULL DEFAULT '0',
  `authorid` int(11) DEFAULT '0',
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `pluginauthorid_idx` (`authorid`),
  KEY `pluginplace_idx` (`placement`),
  KEY `pluginretr_idx` (`placement`,`sort_order`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_plugins`
--

LOCK TABLES `serendipity_plugins` WRITE;
/*!40000 ALTER TABLE `serendipity_plugins` DISABLE KEYS */;
INSERT INTO `serendipity_plugins` VALUES ('@serendipity_calendar_plugin:8578b150fa2f91d2e702dc0a2bd4cce8','right',1,0,''),('@serendipity_quicksearch_plugin:580e6bd0c785bc7dde377efe287be0e7','right',2,0,''),('@serendipity_archives_plugin:f0f5514e94760c66548088050a179538','right',3,0,''),('@serendipity_categories_plugin:270956a750dffec13295a91f4f89f744','right',4,0,''),('@serendipity_syndication_plugin:6ed4a67d11d36367c42b92d45fb2c5e7','right',5,0,''),('@serendipity_superuser_plugin:8c64c53d1425111dc52497447b41607e','right',6,0,''),('@serendipity_plug_plugin:546eae53df8c6260eaae3ff3238ce60d','right',7,0,''),('serendipity_event_s9ymarkup:4364fff6e2da037298f4a0b66e0d8e58','event',1,0,''),('serendipity_event_emoticate:fb22ebc1065c07bbc6d7e0a00cd0eb74','event',2,0,''),('serendipity_event_nl2br:3118ce10a7de12049796f2c9dd6e9cab','event',3,0,''),('serendipity_event_spamblock:a5b5b9ec4de39962fab26eaa6fcf1135','event',4,0,'');
/*!40000 ALTER TABLE `serendipity_plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_references`
--

DROP TABLE IF EXISTS `serendipity_references`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_references` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entry_id` int(10) unsigned NOT NULL DEFAULT '0',
  `link` text,
  `name` text,
  `type` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `refentry_idx` (`entry_id`),
  KEY `reftype_idx` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_references`
--

LOCK TABLES `serendipity_references` WRITE;
/*!40000 ALTER TABLE `serendipity_references` DISABLE KEYS */;
/*!40000 ALTER TABLE `serendipity_references` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_referrers`
--

DROP TABLE IF EXISTS `serendipity_referrers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_referrers` (
  `entry_id` int(11) NOT NULL DEFAULT '0',
  `day` date NOT NULL,
  `count` int(11) NOT NULL DEFAULT '0',
  `scheme` varchar(5) DEFAULT NULL,
  `host` varchar(128) NOT NULL,
  `port` varchar(5) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `query` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`host`,`day`,`entry_id`),
  KEY `referrers_idx` (`entry_id`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_referrers`
--

LOCK TABLES `serendipity_referrers` WRITE;
/*!40000 ALTER TABLE `serendipity_referrers` DISABLE KEYS */;
/*!40000 ALTER TABLE `serendipity_referrers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serendipity_suppress`
--

DROP TABLE IF EXISTS `serendipity_suppress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serendipity_suppress` (
  `ip` varchar(64) DEFAULT NULL,
  `scheme` varchar(5) DEFAULT NULL,
  `host` varchar(128) DEFAULT NULL,
  `port` varchar(5) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `query` varchar(255) DEFAULT NULL,
  `last` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `url_idx` (`host`,`ip`),
  KEY `urllast_idx` (`last`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serendipity_suppress`
--

LOCK TABLES `serendipity_suppress` WRITE;
/*!40000 ALTER TABLE `serendipity_suppress` DISABLE KEYS */;
/*!40000 ALTER TABLE `serendipity_suppress` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-07-23  1:00:38
