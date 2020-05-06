#DROP TABLE IF EXISTS adminsettings;

CREATE TABLE cvazquezblog.`adminsettings` (
	`id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`name` varchar(30) NOT NULL DEFAULT '',
	`value` varchar(255) NOT NULL DEFAULT '',
	
	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
	
	UNIQUE KEY (name, value)
	
) comment = "Website settings"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;
  
# See data/secrets for records

INSERT INTO adminsettings (name, value, createdAt) 
VALUES ("flickrAPIKey", "yourFlickrApiKey", NOW());

INSERT INTO `adminsettings` (`name`, `value`, `createdAt`) 
VALUES ('flikrAPISecret', 'yourFlickrApiSecret', now());

INSERT INTO adminsettings (name, value, createdAt) 
VALUES ("flickrUserId", "YourFlickrUserId", NOW());