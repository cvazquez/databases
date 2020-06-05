DROP TABLE IF EXISTS seriesurls;

CREATE TABLE IF NOT EXISTS cvazquezblog.`seriesurls` (
	`seriesId` MEDIUMINT UNSIGNED NOT NULL,
	`nameURL` VARCHAR(255) NOT NULL DEFAULT '',
	PRIMARY KEY (seriesId, nameURL),

	`isActive` TINYINT NOT NULL DEFAULT 0,

	`createdAt` DATETIME NULL DEFAULT now(),
	`createdBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`updatedAt` DATETIME NULL DEFAULT NULL,
	`updatedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`timestampAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  	FOREIGN KEY (seriesId) REFERENCES series(id),
  	UNIQUE INDEX nameURLIdx (nameURL)
) COMMENT = "User friendly URLs for a series"
  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

DROP TRIGGER IF EXISTS seriesurls_bi;

DELIMITER |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER seriesurls_bi BEFORE INSERT
    ON seriesurls FOR EACH ROW

	BEGIN

	SET NEW.nameURL = trim(NEW.nameURL);

	END;
|
DELIMITER ;


INSERT INTO seriesurls (seriesId, nameURL, isActive, createdAt)
SELECT	id,
		CreateTitleURL(series.name),
		1,
		now()
FROM series
WHERE deletedAt IS NULL
ORDER BY id;


GRANT SELECT, UPDATE, INSERT, TRIGGER ON `cvazquezblog`.`seriesurls` TO 'blog_trig_user'@'localhost'