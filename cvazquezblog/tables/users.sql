
# DROP TABLE IF EXISTS cvazquezblog.`users`;

CREATE TABLE IF NOT EXISTS cvazquezblog.`users` (
	`id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`stateId` SMALLINT UNSIGNED NULL DEFAULT NULL,
	`cityId` MEDIUMINT UNSIGNED NULL DEFAULT NULL COMMENT 'Try to match free form field with id',

	`firstName` VARCHAR(50) NOT NULL DEFAULT '',
	`lastName` VARCHAR(50) NOT NULL DEFAULT '',
	`email` VARCHAR(255) NOT NULL DEFAULT '',

	`handle` VARCHAR(255) NOT NULL DEFAULT '',
	`passwd` VARCHAR(255) NOT NULL DEFAULT '',

	`websiteURL` VARCHAR(1024) NULL DEFAULT '',
	`city` VARCHAR(50) NULL DEFAULT '' COMMENT 'Free form field',

	cfId char(36) NOT NULL DEFAULT '',
	httpRefererExternal varchar(255) NOT NULL DEFAULT '',
	httpRefererInternal varchar(255) NOT NULL DEFAULT '',
	httpUserAgent varchar(255) NOT NULL DEFAULT '',
	ipAddress VARBINARY(16) NULL DEFAULT NULL COMMENT 'A trigger checks for IPv4and6 and does conversion',
	pathInfo VARCHAR(512) NOT NULL DEFAULT '',

	`createdAt` DATETIME NULL DEFAULT NULL,
	`createdBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`updatedAt` DATETIME NULL DEFAULT NULL,
	`updatedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`timestampAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	FOREIGN KEY (stateId) REFERENCES states(id),
	FOREIGN KEY (cityId) REFERENCES cities(id)

) COMMENT = "Users who commented on entries"
  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;


grant insert on cvazquezblog.users to 'railo'@'localhost';


DROP TRIGGER IF EXISTS users_bi;

DELIMITER |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER users_bi BEFORE INSERT
    ON users FOR EACH ROW

	BEGIN

	IF IS_IPV4(NEW.ipAddress) THEN
		SET NEW.ipAddress = INET_ATON(NEW.ipAddress);
	ELSEIF IS_IPV6(NEW.ipAddress) THEN
		SET NEW.ipAddress = INET6_ATON(NEW.ipAddress);
	ELSE
		SET NEW.ipAddress = NULL;
	END IF;

	IF NEW.stateId = 0 THEN
		SET NEW.stateId = NULL;
	END IF;

	IF NEW.cityId = 0 THEN
		SET NEW.cityId = NULL;
	END IF;

	SET NEW.firstName = trim(NEW.firstName);
	SET NEW.lastName = trim(NEW.lastName);
	SET NEW.email = trim(NEW.email);
	SET NEW.handle = trim(NEW.handle);
	SET NEW.passwd = trim(NEW.passwd);
	SET NEW.websiteURL = trim(NEW.websiteURL);
	SET NEW.city = trim(NEW.city);
	SET NEW.pathInfo = trim(NEW.pathInfo);

	END;
|
DELIMITER ;