# DROP TABLE IF EXISTS cvazquezblog.`pictureurls`;
 
CREATE TABLE cvazquezblog.`pictureurls` (
	`entryPictureId` MEDIUMINT UNSIGNED NOT NULL,
	`titleURL` VARCHAR(250) NOT NULL DEFAULT '',
	`isActive` TINYINT(1) NOT NULL DEFAULT 0,
		
	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
	
	PRIMARY KEY (entryPictureId, titleURL),
	
	FOREIGN KEY (entryPictureId) REFERENCES entrypictures(id)
  
) comment = "Masked URLs for Pictures"
  ENGINE=INNODB DEFAULT CHARSET=UTF8; 
  
  
  ALTER TABLE pictureurls ADD	FOREIGN KEY (entryPictureId) REFERENCES entrypictures(id);