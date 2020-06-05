CREATE TABLE IF NOT EXISTS cvazquezblog.`entryurls` (
	`entryId` MEDIUMINT(9) UNSIGNED NOT NULL,
	`titleURL` VARCHAR(255) NOT NULL DEFAULT '',
	PRIMARY KEY (entryId, titleURL),

	`isActive` TINYINT(1) NOT NULL DEFAULT 0,

	`createdAt` DATETIME NULL DEFAULT NULL,
	`createdBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`updatedAt` DATETIME NULL DEFAULT NULL,
	`updatedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`timestampAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  	FOREIGN KEY (entryId) REFERENCES entries(id),
  	UNIQUE INDEX titleURLIdx (titleURL)
) COMMENT = "User friendly URLs for an entry"
  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;


DROP TRIGGER IF EXISTS entryurls_bi;

DELIMITER |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER entryurls_bi BEFORE INSERT
    ON entryurls FOR EACH ROW

	BEGIN

	SET NEW.titleURL = trim(NEW.titleURL);

	END;
|
DELIMITER ;


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