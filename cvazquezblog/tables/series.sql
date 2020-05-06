CREATE TABLE cvazquezblog.`series` (
	`id` MEDIUMINT(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`name` VARCHAR(255) NOT NULL DEFAULT '',
	
	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
	
	UNIQUE INDEX nameIdx (name)
  
) comment = "A series of related entries"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;

DROP TRIGGER IF EXISTS entryurls_bi;

delimiter |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER series_bi BEFORE INSERT
    ON series FOR EACH ROW
	
	BEGIN

	SET NEW.name = trim(NEW.name);

	END;
|
delimiter ;

GRANT SELECT, UPDATE, TRIGGER ON series TO 'blog_trig_user'@'127.0.0.1';