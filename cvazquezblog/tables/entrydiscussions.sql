# DROP TABLE IF EXISTS cvazquezblog.`entrydiscussions`;

CREATE TABLE cvazquezblog.`entrydiscussions` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`entryId` MEDIUMINT(9) UNSIGNED NOT NULL,
	`entryDiscussionId` INT UNSIGNED NULL DEFAULT NULL COMMENT 'A reply to a comment',
	`userId` MEDIUMINT UNSIGNED NULL DEFAULT NULL,

	`firstName` VARCHAR(50) NOT NULL DEFAULT '',
	`lastName` VARCHAR(50) NOT NULL DEFAULT '',
	`email` VARCHAR(255) NOT NULL DEFAULT '',
	`content` TEXT NOT NULL DEFAULT '',
	
	`emailValidationString` VARCHAR(100) NOT NULL DEFAULT '',
	`rejectedAt` datetime NULL DEFAULT NULL,
	`approvedAt` datetime NULL DEFAULT NULL,

	`wantsReplies` TINYINT(1) NOT NULL DEFAULT '0',

	cfId char(36) NOT NULL,
	httpRefererExternal varchar(255) NOT NULL,
	httpRefererInternal varchar(255) NOT NULL,
	httpUserAgent varchar(255) NOT NULL,
	ipAddress VARBINARY(16) NULL DEFAULT NULL COMMENT 'A trigger checks for IPv4and6 and does conversion', 
	pathInfo VARCHAR(512) NOT NULL,

	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
	
	FOREIGN KEY (entryDiscussionId) REFERENCES entrydiscussions(id),
	FOREIGN KEY (entryId) REFERENCES entries(id),
	FOREIGN KEY (userId) REFERENCES users(id),
	
	INDEX `emailValidationStringIdx` (`emailValidationString`)
  
) comment = "Comments for an entry entered by users"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;

DROP TRIGGER IF EXISTS entrydiscussions_bi;

delimiter |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER entrydiscussions_bi BEFORE INSERT
    ON entrydiscussions FOR EACH ROW
	
	BEGIN

	IF IS_IPV4(NEW.ipAddress) THEN
		SET NEW.ipAddress = INET_ATON(NEW.ipAddress);
	ELSEIF IS_IPV6(NEW.ipAddress) THEN
		SET NEW.ipAddress = INET6_ATON(NEW.ipAddress);
	ELSE 
	SET NEW.ipAddress = NULL;
	END IF;
	
	IF NEW.entryDiscussionId = 0 THEN
		SET NEW.entryDiscussionId = NULL;
	END IF;
	
	IF NEW.userId = 0 THEN
		SET NEW.userId = NULL;
	END IF;
	
	SET NEW.firstName = trim(NEW.firstName);
	SET NEW.lastName = trim(NEW.lastName);
	SET NEW.email = trim(NEW.email);
	SET NEW.content = trim(NEW.content);
	SET NEW.emailValidationString = trim(NEW.emailValidationString);
	SET NEW.pathInfo = trim(NEW.pathInfo);

	END;
|
delimiter ;
