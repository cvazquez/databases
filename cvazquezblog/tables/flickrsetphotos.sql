#DROP TABLE IF EXISTS flickrsetphotos;

#/images/Cañon-Del-Colca.jpg
#ReWriteRule ^/images/([a-z0-9\-_]+)\.jpg /blog/PictureRedirect/$1 [L,NC]

CREATE TABLE flickrsetphotos
(
	`id` BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	`flickrSetId` BIGINT UNSIGNED NOT NULL,
	`orderId` SMALLINT UNSIGNED NULL DEFAULT NULL,

	`title` VARCHAR(255) NOT NULL DEFAULT '',
	`description` TEXT NULL DEFAULT NULL,
	
	`squareURL` VARCHAR(100) NOT NULL DEFAULT '',
	`squareWidth` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
	`squareHeight` SMALLINT UNSIGNED NOT NULL DEFAULT 0,

	`mediumURL` VARCHAR(100) NOT NULL DEFAULT '',
	`mediumWidth` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
	mediumHeight SMALLINT UNSIGNED NOT NULL DEFAULT 0,

	largeURL VARCHAR(100) NOT NULL DEFAULT '',
	largeWidth SMALLINT UNSIGNED NOT NULL DEFAULT 0,
	largeHeight SMALLINT UNSIGNED NOT NULL DEFAULT 0,
	
	`takenAt` DATETIME NULL DEFAULT NULL,

	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,

	FOREIGN KEY (flickrSetId) REFERENCES flickrsets(id)
	
) comment = "A cache of flickrSetId images of a set"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;

 
GRANT INSERT, DELETE, UPDATE ON `cvazquezblog`.`flickrsetphotos` TO 'railo'@'localhost';