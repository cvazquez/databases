# DROP TABLE IF EXISTS cvazquezblog.`entrydiscussions`;

CREATE TABLE IF NOT EXISTS cvazquezblog.`entrydiscussions` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`entryId` MEDIUMINT(9) UNSIGNED NOT NULL,
	`entryDiscussionId` INT UNSIGNED NULL DEFAULT NULL COMMENT 'A reply to a comment',
	`userId` MEDIUMINT UNSIGNED NULL DEFAULT NULL,

	`firstName` VARCHAR(50) NOT NULL DEFAULT '',
	`lastName` VARCHAR(50) NOT NULL DEFAULT '',
	`email` VARCHAR(255) NOT NULL DEFAULT '',
	`content` TEXT NOT NULL DEFAULT '',

	`emailValidationString` VARCHAR(100) NOT NULL DEFAULT '',
	`rejectedAt` DATETIME NULL DEFAULT NULL,
	`approvedAt` DATETIME NULL DEFAULT NULL,

	`wantsReplies` TINYINT(1) NOT NULL DEFAULT '0',

	cfId char(36) NOT NULL,
	httpRefererExternal varchar(255) NOT NULL,
	httpRefererInternal varchar(255) NOT NULL,
	httpUserAgent varchar(255) NOT NULL,
	ipAddress VARBINARY(16) NULL DEFAULT NULL COMMENT 'A trigger checks for IPv4and6 and does conversion',
	pathInfo VARCHAR(512) NOT NULL,

	`createdAt` DATETIME NULL DEFAULT NULL,
	`createdBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`updatedAt` DATETIME NULL DEFAULT NULL,
	`updatedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`timestampAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	FOREIGN KEY (entryDiscussionId) REFERENCES entrydiscussions(id),
	FOREIGN KEY (entryId) REFERENCES entries(id),
	FOREIGN KEY (userId) REFERENCES users(id),

	INDEX `emailValidationStringIdx` (`emailValidationString`)

) COMMENT = "Comments for an entry entered by users"
  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

DROP TRIGGER IF EXISTS entrydiscussions_bi;

DELIMITER |
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
DELIMITER ;