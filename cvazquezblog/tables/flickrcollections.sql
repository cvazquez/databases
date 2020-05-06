#SET FOREIGN_KEY_CHECKS = 0;

#DROP TABLE IF EXISTS flickrcollections;
#TRUNCATE TABLE flickrcollections;

CREATE TABLE flickrcollections
(
	id VARCHAR(50) NOT NULL DEFAULT '' PRIMARY KEY,

	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
	
) comment = "Flickr Collections for this Blog"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;