CREATE TABLE cvazquezblog.`entrycategories` (
    `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	
	`entryId` MEDIUMINT(9) UNSIGNED NOT NULL AUTO_INCREMENT,
	`categoryId`  SMALLINT(9) UNSIGNED NOT NULL DEFAULT NULL,

	UNIQUE KEY (entryId, categoryId),
	
	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
	
	FOREIGN KEY (entryId) REFERENCES entries(id),
	FOREIGN KEY (categoryId) REFERENCES categories(id)
  
) comment = "Maps 1 or more categories to an entry"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;
  
  alter table entrycategories
  add unique index (entryId, categoryId);
  
  alter table entrycategories add
	FOREIGN KEY (entryId) REFERENCES entries(id),
add	FOREIGN KEY (categoryId) REFERENCES categories(id),
add  `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY first;



