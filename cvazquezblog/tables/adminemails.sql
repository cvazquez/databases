
CREATE TABLE `adminemails` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `type` enum("errors", "comments"),
  `firstName` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(150) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `createdBy` mediumint(8) unsigned DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `updatedBy` mediumint(8) unsigned DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `deletedBy` mediumint(8) unsigned DEFAULT NULL,
  `timestampAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='site emails';
