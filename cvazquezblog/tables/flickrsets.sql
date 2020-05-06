#SET FOREIGN_KEY_CHECKS = 0;

#DROP TABLE IF EXISTS flickrsets;

CREATE TABLE flickrsets
(
	`id` BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	`flickrCollectionId` VARCHAR(50) NOT NULL DEFAULT '',

	`title` VARCHAR(100) NOT NULL DEFAULT '',	
	`description` TEXT NOT NULL,

	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,


	UNIQUE KEY (id, flickrCollectionId),
	FOREIGN KEY (flickrCollectionId) REFERENCES flickrcollections(id)
	
) comment = "A cache of flickrSetId images of a set"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;
 
 GRANT INSERT, DELETE ON cvazquezblog.flickrsets TO railo@localhost;
 
 
 show grants for railo@localhost;
 #SHOW WARNINGS