#DROP TABLE IF EXISTS adminsettings;

CREATE TABLE IF NOT EXISTS cvazquezblog.`adminsettings` (
	`id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`name` varchar(30) NOT NULL DEFAULT '',
	`value` varchar(255) NOT NULL DEFAULT '',

	`createdAt` DATETIME NULL DEFAULT NULL,
	`createdBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`updatedAt` DATETIME NULL DEFAULT NULL,
	`updatedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`timestampAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	UNIQUE KEY (name, value)

) COMMENT = "Website settings"
  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

# See data/secrets for records

INSERT INTO adminsettings (name, value, createdAt)
VALUES ("flickrAPIKey", "yourFlickrApiKey", NOW());

INSERT INTO `adminsettings` (`name`, `value`, `createdAt`)
VALUES ('flikrAPISecret', 'yourFlickrApiSecret', now());

INSERT INTO adminsettings (name, value, createdAt)
VALUES ("flickrUserId", "YourFlickrUserId", NOW());