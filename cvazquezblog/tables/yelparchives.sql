
# DROP TABLE IF EXISTS cvazquezblog.`yelparchives`;

CREATE TABLE cvazquezblog.`yelparchives` (
	`id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`userId` MEDIUMINT UNSIGNED NOT NULL,
	FOREIGN KEY (userId) REFERENCES users(id),
	`pageNumber` SMALLINT UNSIGNED NOT NULL,
	
	UNIQUE KEY (userId, pageNumber),
	
	`content` MEDIUMTEXT NOT NULL,

	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
	
  
) comment = "Raw dump of review pages"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;
  
  
grant insert, update on cvazquezblog.yelparchives to 'railo'@'localhost';