#SET FOREIGN_KEY_CHECKS = 0;

#DROP TABLE IF EXISTS flickrsets;

CREATE TABLE flickrsets
(
	`id` BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	`flickrCollectionId` VARCHAR(50) NOT NULL DEFAULT '',

	`title` VARCHAR(100) NOT NULL DEFAULT '',
	`description` TEXT NOT NULL,

	`createdAt` DATETIME NULL DEFAULT NULL,
	`createdBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`updatedAt` DATETIME NULL DEFAULT NULL,
	`updatedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`timestampAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,


	UNIQUE KEY (id, flickrCollectionId),
	FOREIGN KEY (flickrCollectionId) REFERENCES flickrcollections(id)

) COMMENT = "A cache of flickrSetId images of a set"
  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

 GRANT SELECT, INSERT, DELETE ON cvazquezblog.flickrsets TO nodeuser@localhost;