CREATE TABLE IF NOT EXISTS cvazquezblog.`categoryurls` (
	`categoryId` SMALLINT(9) UNSIGNED NOT NULL,
	`name` VARCHAR(255) NOT NULL DEFAULT '',
	PRIMARY KEY (categoryId, name),

	`isActive` TINYINT(1) NOT NULL DEFAULT 0,

	`createdAt` DATETIME NULL DEFAULT NULL,
	`createdBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`updatedAt` DATETIME NULL DEFAULT NULL,
	`updatedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`timestampAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  	FOREIGN KEY (categoryId) REFERENCES categories(id),
  	UNIQUE INDEX nameIdx (name)
) COMMENT = "User friendly URLs for a category"
  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;


DROP TRIGGER IF EXISTS categoryurls_bi;

DELIMITER |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER categoryurls_bi BEFORE INSERT
    ON categoryurls FOR EACH ROW

	BEGIN

	SET NEW.name = trim(NEW.name);

	END;
|
DELIMITER ;

GRANT SELECT, TRIGGER, UPDATE ON `cvazquezblog`.`categoryurls` TO 'blog_trig_user'@'127.0.0.1';
GRANT SELECT, TRIGGER, UPDATE ON `cvazquezblog`.`categoryurls` TO 'blog_trig_user'@'localhost';

TRIGGER command denied to user 'blog_trig_user'@'localhost' for table 'categoryurls'

/*
INSERT IGNORE INTO categoryurls (categoryId, name, isActive, createdAt)
SELECT id,
convert(PREG_REPLACE('/[ \t\.]+/', '-',
	PREG_REPLACE('/[^A-Za-z0-9 \t\.]+/', '' , trim(categories.name))
)
USING UTF8) ,
 1, now()
FROM categories
WHERE deletedAt IS NULL
ORDER BY id;
*/