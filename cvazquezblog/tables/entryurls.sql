CREATE TABLE cvazquezblog.`entryurls` (
	`entryId` MEDIUMINT(9) UNSIGNED NOT NULL,
	`titleURL` VARCHAR(255) NOT NULL DEFAULT '',
	PRIMARY KEY (entryId, titleURL),
	
	`isActive` TINYINT(1) NOT NULL DEFAULT 0,
	
	`createdAt` datetime NULL DEFAULT NULL,
	`createdBy` mediumint unsigned NULL DEFAULT NULL,
	`updatedAt` datetime NULL DEFAULT NULL,
	`updatedBy` mediumint unsigned NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` mediumint unsigned NULL DEFAULT NULL,
	`timestampAt` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  
  	FOREIGN KEY (entryId) REFERENCES entries(id),
  	UNIQUE INDEX titleURLIdx (titleURL)
) comment = "User friendly URLs for an entry"
  ENGINE=INNODB DEFAULT CHARSET=UTF8;


DROP TRIGGER IF EXISTS entryurls_bi;

delimiter |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER entryurls_bi BEFORE INSERT
    ON entryurls FOR EACH ROW
	
	BEGIN

	SET NEW.titleURL = trim(NEW.titleURL);

	END;
|
delimiter ;


# http://www.mysqludf.org/lib_mysqludf_preg/
# \s isn't working
INSERT INTO entryurls (entryId, titleURL, isActive, createdAt)
SELECT id, 
convert(PREG_REPLACE('/[ \t\.]+/', '-',
	PREG_REPLACE('/[^A-Za-z0-9 \t\.]+/', '' , trim(entries.title))
)
USING UTF8) ,
 1, now()
FROM entries
WHERE deletedAt IS NULL
ORDER BY id;


GRANT SELECT, UPDATE, INSERT, TRIGGER ON `cvazquezblog`.`entryurls` TO 'blog_trig_user'@'localhost'