

select length("bf8d8f7b-8035-4295-a080-194e8f893858");

CREATE TABLE logvisits
(
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	
	/*`controller`
	`action`
	`paramId` MEDIUMINT UNSIGNED NOT NULL,
	*/
	
	cfId char(36) NOT NULL,
	httpRefererExternal varchar(255) NOT NULL,
	httpRefererInternal varchar(255) NOT NULL,
	httpUserAgent varchar(255) NOT NULL,
	ipAddress VARBINARY(16) NULL DEFAULT NULL COMMENT 'A trigger checks for IPv4and6 and does conversion', 
	pathInfo VARCHAR(512) NOT NULL,

  `createdAt` datetime DEFAULT NULL,
  `createdBy` mediumint(8) unsigned DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `updatedBy` mediumint(8) unsigned DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `deletedBy` mediumint(8) unsigned DEFAULT NULL,
  `timestampAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE logvisitdata
(
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`logVisitId` INT UNSIGNED NOT NULL,
	
	name varchar(100) NOT NULL,
	value	varchar(1024) NOT NULL,

  `createdAt` datetime DEFAULT NULL,
  `createdBy` mediumint(8) unsigned DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `updatedBy` mediumint(8) unsigned DEFAULT NULL,
  `deletedAt` datetime DEFAULT NULL,
  `deletedBy` mediumint(8) unsigned DEFAULT NULL,
  `timestampAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	FOREIGN KEY (logVisitId) REFERENCES logvisits(id)
);


DROP TRIGGER logvisits_bi;

delimiter |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER logvisits_bi BEFORE INSERT
    ON logvisits FOR EACH ROW
	
	BEGIN

	IF IS_IPV4(NEW.ipAddress) THEN
		SET NEW.ipAddress = INET_ATON(NEW.ipAddress);
	ELSEIF IS_IPV6(NEW.ipAddress) THEN
		SET NEW.ipAddress = INET6_ATON(NEW.ipAddress);
	ELSE 
		SET NEW.ipAddress = NULL;
	END IF;
	
	SET NEW.name = trim(NEW.name);
	SET NEW.value = trim(NEW.value);

	END;
|

delimiter ;