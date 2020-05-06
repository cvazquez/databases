#DROP TABLE IF EXISTS cvazquezblog.`seriesentries`;

CREATE TABLE cvazquezblog.`seriesentries` (
	`seriesId` MEDIUMINT(9) UNSIGNED NOT NULL,
	`entryId` MEDIUMINT(9) UNSIGNED NOT NULL,
	`sequence` TINYINT UNSIGNED NULL DEFAULT NULL,
	
	PRIMARY KEY (seriesId, entryId, sequence),
		
	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
	
	FOREIGN KEY (seriesId) REFERENCES series(id),
	FOREIGN KEY (entryId) REFERENCES entries(id)
  
) comment = "Map entries to a series of related entries"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;


DROP TRIGGER IF EXISTS seriesentries_bi;

delimiter |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER seriesentries_bi BEFORE INSERT
    ON seriesentries FOR EACH ROW
	
	BEGIN

	IF sequence = 0 THEN
		SET NEW.sequence = NULL;
	END IF;

	END;
|
delimiter ;