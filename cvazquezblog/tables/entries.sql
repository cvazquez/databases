CREATE TABLE IF NOT EXISTS cvazquezblog.`entries` (
	`id` MEDIUMINT(9) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`entryId` MEDIUMINT UNSIGNED NULL DEFAULT NULL COMMENT 'Page sequences',
	`title` VARCHAR(250) NOT NULL DEFAULT '',
	`teaser` VARCHAR(512) NOT NULL DEFAULT '',
	`content` TEXT NOT NULL,
	`metaDescription` VARCHAR(1024) NOT NULL DEFAULT '',
	`metaKeyWords` VARCHAR(1024) NOT NULL DEFAULT '',
	`publishAt` DATETIME NULL DEFAULT NULL,

	`createdAt` DATETIME NULL DEFAULT NULL,
	`createdBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`updatedAt` DATETIME NULL DEFAULT NULL,
	`updatedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`deletedAt` DATETIME NULL DEFAULT NULL,
	`deletedBy` MEDIUMINT UNSIGNED NULL DEFAULT NULL,
	`timestampAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  	FOREIGN KEY (entryId) REFERENCES entries(id),
  	FULLTEXT INDEX titleContentFullIdx (title,content)
) COMMENT = "Blog entries"
  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

ALTER TABLE `cvazquezblog`.`entries`
add FULLTEXT INDEX titleContentFullIdx (title,content);


DROP TRIGGER IF EXISTS entries_bi;

DELIMITER |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER entries_bi BEFORE INSERT
    ON entries FOR EACH ROW

	BEGIN

	IF NEW.entryId = 0 THEN
		SET NEW.entryId = NULL;
	END IF;

	SET NEW.title = trim(NEW.title);
	SET NEW.teaser = trim(NEW.teaser);
	SET NEW.content = trim(NEW.content);
	SET NEW.metaDescription = trim(NEW.metaDescription);
	SET NEW.metaKeyWords = trim(NEW.metaKeyWords);

	END
|
DELIMITER ;


DROP TRIGGER IF EXISTS entries_ai;

DELIMITER |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER entries_ai AFTER INSERT
    ON entries FOR EACH ROW

	BEGIN

	INSERT INTO entryurls (entryId, titleURL, isActive, createdAt, createdBy)
	SELECT NEW.id, CreateTitleURL(NEW.title), 1, now(), NEW.createdBy;

	END;
|
DELIMITER ;


DROP TRIGGER IF EXISTS entries_au;

DELIMITER |
CREATE
    DEFINER = blog_trig_user@localhost
    TRIGGER entries_au AFTER UPDATE
    ON entries FOR EACH ROW

	BEGIN

	DECLARE titleExists TINYINT DEFAULT 0;

	/* Check if the title has been updated. */
	IF (NEW.title <> OLD.title) THEN

		/* Check if the updated title already exists from the past and re-active it */
		SELECT count(*) INTO titleExists
		FROM entryurls
		WHERE entryId = OLD.id AND titleURL = NEW.title;

		SET @updated_title = CreateTitleURL(NEW.title);

		IF (titleExists > 0) THEN
			/* The title existed in the past, so reactivate it and deactivate others for this entry id */
			UPDATE entryurls
			SET isActive = 1,
				updatedAt = now(),
				updatedBy = NEW.updatedBy,
				deletedAt = NULL,
				deletedBy = NULL
			WHERE entryId = OLD.id AND titleURL = @updated_title AND isActive = 0;

		ELSE
			/* The title doesn't exist. Create it new */
			INSERT IGNORE INTO entryurls (entryId, titleURL, isActive, createdAt, createdBy)
			SELECT OLD.id, CreateTitleURL(NEW.title), 1, now(), NEW.createdBy;
		END IF;

		/* Deactivate the previous active title */
		UPDATE entryurls
			SET isActive = 0,
				updatedAt = now(),
				updatedBy = NEW.updatedBy,
				deletedAt = now(),
				deletedBy = NEW.updatedBy
			WHERE entryId = OLD.id AND titleURL <> @updated_title AND isActive = 1;
	END IF;



	END;
|
DELIMITER ;
GRANT EXECUTE ON FUNCTION cvazquezblog.CreateTitleURL  TO 'blog_trig_user'@'localhost';
GRANT SELECT, UPDATE, INSERT, TRIGGER ON `cvazquezblog`.`entryurls` TO 'blog_trig_user'@'localhost';

GRANT SELECT, UPDATE, TRIGGER ON cvazquezblog.entries to 'blog_trig_user'@'localhost';
