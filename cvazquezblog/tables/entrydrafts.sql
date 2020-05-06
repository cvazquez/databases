CREATE TABLE cvazquezblog.`entrydrafts` (
	`id` MEDIUMINT(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`entryId` MEDIUMINT UNSIGNED NULL DEFAULT NULL,

	`content` TEXT NOT NULL,
	
	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  
  	FOREIGN KEY (entryId) REFERENCES entries(id)
) comment = "Saves Blog entries as a draft"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;
  


GRANT SELECT, UPDATE, INSERT ON `cvazquezblog`.`entrydrafts` TO railo@localhost;
