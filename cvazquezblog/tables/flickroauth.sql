-- DROP TABLE IF EXISTS flickroauth;

create table flickroauth
(
	`id` MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`userNSid` VARCHAR(50) NOT NULL,
	`fullName` VARCHAR(50) NOT NULL,
	`userName` VARCHAR(50) NOT NULL,
	`oauthToken` VARCHAR(50) NOT NULL,
	`oauthTokenSecret` VARCHAR(20) NOT NULL,

	`createdAt` datetime NULL DEFAULT now(),
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
)	comment = "FLickr oAuth Access Tokens for API access"
	ENGINE=INNODB DEFAULT CHARSET=UTF8;

	-- 'utf8' is currently an alias for the character set UTF8MB3, but will be an alias for UTF8MB4 in a future release. Please consider using UTF8MB4 in order to be unambiguous.